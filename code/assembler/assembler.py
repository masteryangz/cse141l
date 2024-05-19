"""
usage: python assembler.py [assembly file] [machine code file]

requires python 3.x

This assembler is assuming the bit breakdown as follows:
R-Type: 3 bits opcode, 2 bits destination register, 2 bits operand 1 register, 2 bits operand 2 register
I-Type: 3 bits opcode, 2 bits destination register, 4 bits immediate
B-Type: 3 bits opcode, 2 bits address register, 2 bits operand 1 register, 2 bits operand 2 register
"""

import sys

# map registers to binary
registers_two_bit = {
    "r0": "00",
    "r1": "01",
    "r2": "10",
    "r3": "11",
    }

# map opcode to binary
# NOTE: THIS WILL BE DIFFERENT FOR YOU!
opcode = {
    "add": "000",
    "sub": "001",
    "loadi": "010",
    "beq": "011",
    }

# classify instructions into different types
# NOTE: THIS WILL BE DIFFERENT FOR YOU!
rtype = ['add', 'sub']
itype = ['loadi']
btype = ['beq']

# NOTE: THIS WILL BE DIFFERENT FOR YOU!
comment_char = '#'

with (
    open(sys.argv[1], "r") as read,
    open(sys.argv[2], "w") as write
):
# with automatically handles file (no need for open and close)
    line = read.readline() # read a line

    # for every line
    while(line):
        # strip takes away whitespace from left and right
        line = line.strip()

        # split your comments out
        line = line.split(comment_char, 1)

        # store instruction and comment
        inst = line[0].strip()
        comment = line[1].strip()
        print(inst)
        print(comment)

        # split instruction into arguments
        inst = inst.split()

        # initialize the string that contains the machine code binary
        writeline = ''

        # write the opcode
        if inst[0] in opcode:
            writeline += opcode[inst[0]]
        else:
            # if it an instruction that doesn't exist, exit
            sys.exit()

        # write the first register to binary (maybe you need checking on this)
        writeline += registers_two_bit[inst[1]]

        # if it's r-type or b-type, then you know you have 2 args after (this might be different for you)
        if inst[0] in rtype or inst[0] in btype:
            writeline += registers_two_bit[inst[2]]
            writeline += registers_two_bit[inst[3]]
        elif inst[0] in itype:
            # immediate just goes straight in
            writeline += inst[2]

        # SystemVerilog ignores comments prepended with // with readmemb or readmemh
        writeline += ' //' + comment
        writeline += '\n'

        # write the line into the desired file
        write.write(writeline)

        # read the next line
        line = read.readline()
