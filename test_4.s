#       Assembly                  Description               Address     Machine Code
main:   addi $2, $0, 5          # initialize $2 = 5         0           20020005        
        addi $3, $0, 12         # initialize $3 = 12        4           2003000c
        ori  $4, $3, 2          # OR bits of $3 and 2       c           34640002
        slti $4, $2, 4          # Checks if $4 < $2         10          28440004
        beq  $4, $0, sltiTJ     # should be taken           14          10800001
        addi $2, $0, 12         # shouldn't happen          18          2003000c
sltiTJ: sll  $6, $3, 4          # Shift $1 4bits left       1c          00033100
        srl  $7, $3, 1          # Shift $2 1 bit right      20          00033840
        or   $4, $2, $3         # $4 <= 3 or 5 = 7          24          00432025
        and  $5, $2, $3         # $5 <= 12 and 7 = 4        28          00432824
        sub  $2, $2, $2         # $2 = $2 - $2 = 0          2c          00421022
        j    end                # should be taken           30          0800000d
        addi $2, $0, 1          # shouldn't happen          34          20020001
end:    sw   $2, 84($0)         # write adr 84 = 7          38          ac020054
        j    main               # restart                   3c          08000000