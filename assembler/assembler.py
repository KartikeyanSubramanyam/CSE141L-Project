import re
import argparse

argParser = argparse.ArgumentParser()
argParser.add_argument("input_file")
argParser.add_argument("output_file")
args = argParser.parse_args()

BRANCH_EXTEND = 3

def main():
    input_contents = read_file(args.input_file)
    lexed_contents, line_nums = file_lexer(input_contents)
    machine_codes  = file_parser(lexed_contents, line_nums)
    write_file(args.output_file, machine_codes)

def read_file(file_name):
    # do file i/o here to read in the assembly code
    iFile = open(file_name, "r")
    file_contents = iFile.read().split("\n")
    return file_contents

def write_file(file_name, file_contents):
    # do file i/o here to write out the machine code
    oFile = open(file_name, "w")
    for index in range(len(file_contents)):
        oFile.write(file_contents[index])
        if index != len(file_contents) - 1:
            oFile.write("\n")

def file_lexer(fileLines):
    # the goal is to tokenize each line of the file
    lexed_tokens = []
    line_nums = []
    line_num = 1
    for line in fileLines:
        lexed_tokens.append(instruction_lexer(line))
        line_nums.append(line_num)
        line_num += 1
    return lexed_tokens, line_nums

def instruction_lexer(line):
    # separate each instruction into tokens
    hashtag = line.find("#")
    if hashtag > -1:
        cleaned_line = line[:hashtag]
    else:
        cleaned_line = line
    tokens = re.split(',| ', cleaned_line)
    return [t.strip() for t in tokens if t != '']

def file_parser(tokenized_lines, line_nums):
    machine_codes = [] # list of 9-bit machine codes
    branch_labels = {}

    index = 0
    while index < len(tokenized_lines):
        if len(tokenized_lines[index]) == 0:
            del tokenized_lines[index]
            index -= 1
            continue

        for token in tokenized_lines[index]:
            colon = token.find(":")
            if colon > -1 and len(token) > 1:
                tokenized_lines[index].remove(token)
                if len(tokenized_lines[index]) == 0:
                    del tokenized_lines[index]
                num_nops = pad_nops(tokenized_lines, index)
                index += num_nops
                branch_labels[token[:colon]] = index
        
        index += 1

    for line in tokenized_lines:
        machine_codes.append(instruction_parser(line, branch_labels, 1))
        
    return machine_codes

def pad_nops(tokenized_lines, index):
    multiples_of = (2**BRANCH_EXTEND)
    num_nops = multiples_of - (index % multiples_of)
    if num_nops == multiples_of:
        num_nops = 0
    for i in range(num_nops):
        tokenized_lines.insert(index, ["nop"])
    return num_nops

# parses the instruction tokens to produce a 9-bit machine code
def instruction_parser(instruction_tokens, branch_labels, line_num):
    machine_code = list("000000000")
    op = instruction_tokens[0]
    args = instruction_tokens[1:]

    if op == "mov":
        machine_code[0] = '0'
        machine_code[1:5] = register_code(args[0], line_num)
        machine_code[5:9] = register_code(args[1], line_num)
    elif op == "b":
        machine_code[0:3] = '100'
        immed = args[0]
        dollar = immed.find("$")
        if dollar > -1:
            immed_int = branch_labels[immed[dollar + 1:]] >> BRANCH_EXTEND
            immed = str(immed_int)
        machine_code[3:]  = get_immediate(immed, 0, 2**6-1, 6, line_num)
    elif op == "li":
        machine_code[0:3] = '101'
        machine_code[3:]  = get_immediate(args[0], 0, 2**6-1, 6, line_num)
    elif op == "lsl":
        machine_code[0:4] = '1100'
        if check_register(args[0], ["rX", "rY", "rZ", "rW"], line_num):
            machine_code[4:6] = register_code(args[0], line_num)[-2:]
        if len(args) > 1:
            machine_code[6:]  = get_immediate(args[1], 1, 7, 3, line_num)
        else:
            machine_code[6:]  = "000"
    elif op == "lsr":
        machine_code[0:4] = '1101'
        if check_register(args[0], ["rX", "rY", "rZ", "rW"], line_num):
            machine_code[4:6] = register_code(args[0], line_num)[-2:]
        if len(args) > 1:
            machine_code[6:] = get_immediate(args[1], 1, 7, 3, line_num)
        else:
            machine_code[6:] = "000"
    elif op == "lb":
        machine_code[0:6] = '111100'
        if check_register(args[0], ['r' + str(i) for i in range(8)], line_num):
            machine_code[6:] = register_code(args[0], line_num)[-3:]
    elif op == "sb":
        machine_code[0:6] = '111101'
        if check_register(args[0], ['r' + str(i) for i in range(8)], line_num):
            machine_code[6:] = register_code(args[0], line_num)[-3:]
    elif op[0:3] == "sbf":
        machine_code[0:6] = '111011'
        flags = ["ne", "eq", "lt", "le", "jp"]
        try:
            ind = flags.index(op[3:])
        except ValueError:
            print("Error on line {}: no such instruction \'{}\' exists".format(line_num, op))
        machine_code[6:] = format(ind, '03b')
    elif op == "and":
        machine_code[0:7] = '1110010'
        if check_register(args[0], ["rX", "rY", "rZ", "rW"], line_num):
            machine_code[7:] = register_code(args[0], line_num)[-2:]
    elif op == "or":
        machine_code[0:7] = '1110011'
        if check_register(args[0], ["rX", "rY", "rZ", "rW"], line_num):
            machine_code[7:] = register_code(args[0], line_num)[-2:]
    elif op == "not":
        machine_code[0:7] = '1110100'
        if check_register(args[0], ["rX", "rY", "rZ", "rW"], line_num):
            machine_code[7:] = register_code(args[0], line_num)[-2:]
    elif op == "xor":
        machine_code[0:7] = '1110101'
        if check_register(args[0], ["rX", "rY", "rZ", "rW"], line_num):
            machine_code[7:] = register_code(args[0], line_num)[-2:]
    elif op == "add":
        machine_code[0:7] = '1110000'
        if check_register(args[0], ["rX", "rY", "rZ", "rW"], line_num):
            machine_code[7:] = register_code(args[0], line_num)[-2:]
    elif op == "sub":
        machine_code[0:7] = '1110001'
        if check_register(args[0], ["rX", "rY", "rZ", "rW"], line_num):
            machine_code[7:] = register_code(args[0], line_num)[-2:]
    elif op == "nop":
        machine_code = '111111110'
    elif op == "done":
        machine_code = "111111111"
    else:
        print("Error on line {}: no such instruction \'{}\' exists".format(line_num, op))
    return ''.join(machine_code)

# checks if the input register is within the list of valid registers
# if not, throws an error
def check_register(register, valid_registers, line_num):
    for reg in valid_registers:
        if register.upper() == reg.upper():
            return True
    
    print("Error on line {}: invalid register \'{}\' exists".format(line_num, register))
    return False

# converts a string representation of a register into a 4-bit binary representation
# throws an error when encountering a non-existent register name (e.g. "rF")
def register_code(register, line_num):
    reg_num = ord(register.upper()[1])
    if reg_num >= ord('0') and reg_num <= ord('7'):
        return format(reg_num - ord('0'), '04b')
    elif reg_num >= ord('X') and reg_num <= ord('Z'):
        return format(reg_num - ord('X') + 8, '04b')
    elif reg_num == ord('W'):
        return format(11, '04b')
    elif reg_num >= ord('A') and reg_num <= ord('C'):
        return format(reg_num - ord('A') + 12, '04b')
    elif reg_num == ord('M'):
        return format(15, '04b')
    else:
        print("Error on line {}: no such register \'{}\' exists".format(line_num, register))
        return -1

# checks if the input immediate is within bounds, then formats into binary
# if not within bounds, throws an error
def get_immediate(immediate, min, max, size, line_num):
    immed_int = int(immediate)
    if immed_int >= min and immed_int <= max:
        return format(immed_int, '0'+str(size)+'b')
    else:
        print("Error on line {}: invalid immediate \'{}\'".format(line_num, immediate))
        return -1


main()
