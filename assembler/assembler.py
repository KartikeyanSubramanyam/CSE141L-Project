
def main():
    pass

def read_file(file_name):
    # do file i/o here to read in the assembly code
    pass

def file_lexer(fileLines):
    # the goal is to tokenize each line of the file
    lexed_tokens = []
    for line in fileLines:
        instruction_lexer(line);

def instruction_lexer(line):
    return ["placeholder", "r0", "r0"]

def parser(tokenized_lines):
    machine_code = []

    for line in tokenized_lines:
        pass


def instruction_parser(instruction_tokens):
    machine_code = "000000000"
    operation = instruction_tokens[0]
    arguments = instruction_tokens[1:]

    if operation == "mov":
        pass
    elif operation == "b":
        pass
    elif operation == "li":
        pass
    elif operation == "lsl":
        pass
    elif operation == "lsr":
        pass
    elif operation == "lb":
        pass
    elif operation == "sb":
        pass
    elif operation[0:3] == "sbf":
        pass
    elif operation == "and":
        pass
    elif operation == "or":
        pass
    elif operation == "not":
        pass
    elif operation == "xor":
        pass
    elif operation == "add":
        pass
    elif operation == "sub":
        pass
    elif operation == "nop":
        pass
    elif operation == "done":
        machine_code = "111111111"
    else:
        print("Error: no such instruction exists")