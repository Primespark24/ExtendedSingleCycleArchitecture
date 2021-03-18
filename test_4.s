#       Assembly                  Description               Address     Machine Code
main:   addi $1, $0, 5          # initialize $2 = 5         0           20020005
        addi $2, $0, 12         # initialize $3 = 12        4           2003000c
        ori  $3, $2, 2          # OR bits of $3 and 2                  
        slti $4, $1, 6  
        beq  $4, $0, sltiTJ     # should be taken
        addi $2, $0, 12         # shouldn't happen                     2003000c
sltiTJ: sll  $5, $1, 4          # Shift $1 4bits left
        slr  $5, $2, 1          # Shift $2 1 bit right
        or   $4, $2, $3         # $4 <= 3 or 5 = 7          c           00e22025
        and  $5, $2, $3         # $5 <= 12 and 7 = 4        10          00642824
        sub  $1, $1, 1          # $1 = $1 - '1'             30          00e23822
        sw   $7, 68($3)         # [80] = 7                  34          ac670044
        lw   $2, 80($0)         # $2 = [80] = 7             38          8c020050
        j    end                # should be taken           3c          08000011
        addi $2, $0, 1          # shouldn't happen          40          20020001
end:    sw   $2, 84($0)         # write adr 84 = 7          44          ac020054
        j    main               # restart                   48          08000000