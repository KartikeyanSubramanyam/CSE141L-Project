$main:
        lb      32          # loads mem[32] into rM
        nop
        mov     rX,rM       # moves rM to rX
        li      3           # loads 3 into rM
        mov     rY,rM       # moves rM to rY
        sra     3           # rZ = rX >> rY

        # stack stuff - keeping just to see if we need
        ; mov     rM,rZ       # rM -> rZ
        ; sb      rM,36($fp)
        ; sw      $0,8($fp)
        ; sw      $0,12($fp)
        ; sw      $0,16($fp)
        ; sw      $0,20($fp)
        ; b       $line_33b
        ; nop

$line_10:
        ; sw      $0,24($fp)
        li      3
        mov     rY,rM
        ; sw      $2,28($fp)
        b       $line_19
        nop

$line_13:
        ; lw      $2,20($fp)
        addiu   $3,$fp,8
        addu    $2,$3,$2
        ; lb      $2,36($2)
        nop
        move    $3,$2
        ; lw      $2,28($fp)
        nop
        sra     $2,$3,$2
        ; sb      $2,40($fp)
        ; lb      $3,40($fp)
        ; lb      $2,36($fp)
        nop
        bne     $3,$2,$line_12
        nop

        ; lw      $2,8($fp)
        nop
        addiu   $2,$2,1
        ; sw      $2,8($fp)
        ; lw      $2,16($fp)
        nop
        addiu   $2,$2,1
        ; sw      $2,16($fp)
        li      $2,1                        # 0x1
        ; sw      $2,24($fp)
$line_12:
        ; lw      $2,28($fp)
        nop
        addiu   $2,$2,1
        ; sw      $2,28($fp)
$line_19:
        ; lw      $2,28($fp)
        nop
        bgez    $2,$line_13
        nop

        lw      $2,24($fp)
        nop
        beq     $2,$0,$line_23
        nop

        lw      $2,12($fp)
        nop
        addiu   $2,$2,1
        sw      $2,12($fp)
$line_23:
        lw      $2,20($fp)
        nop
        slt     $2,$2,31
        beq     $2,$0,$line_33
        nop

        li      $2,1                        # 0x1
        sw      $2,32($fp)
        b       $line_31
        nop

$line_25:
        lw      $2,20($fp)
        addiu   $3,$fp,8
        addu    $2,$3,$2
        lb      $2,36($2)
        nop
        move    $3,$2
        lw      $2,32($fp)
        nop
        sll     $2,$3,$2
        sb      $2,37($fp)
        lw      $2,20($fp)
        nop
        addiu   $2,$2,1
        addiu   $3,$fp,8
        addu    $2,$3,$2
        lb      $2,36($2)
        nop
        move    $4,$2
        li      $3,8                        # 0x8
        lw      $2,32($fp)
        nop
        subu    $2,$3,$2
        sra     $2,$4,$2
        sb      $2,38($fp)
        lbu     $3,37($fp)
        lbu     $2,38($fp)
        nop
        or      $2,$3,$2
        sll     $2,$2,24
        sra     $2,$2,24
        andi    $2,$2,0x1f
        sb      $2,39($fp)
        lb      $3,39($fp)
        lb      $2,36($fp)
        nop
        bne     $3,$2,$line_24
        nop

        lw      $2,16($fp)
        nop
        addiu   $2,$2,1
        sw      $2,16($fp)
$line_24:
        lw      $2,32($fp)
        nop
        addiu   $2,$2,1
        sw      $2,32($fp)
$line_31:
        lw      $2,32($fp)
        nop
        slt     $2,$2,5
        bne     $2,$0,$line_25
        nop

$line_33:
        lw      $2,20($fp)
        nop
        addiu   $2,$2,1
        sw      $2,20($fp)
$line_33b:
        lw      $2,20($fp)
        nop
        slt     $2,$2,32
        bne     $2,$0,$line_10
        nop
