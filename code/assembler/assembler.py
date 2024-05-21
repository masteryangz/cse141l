"""
usage: python assembler.py [assembly file] [machine code file]

requires python 3.x

This assembler is assuming the bit breakdown as follows:
R-Type: 3 bits opcode, 3 bits destination and operand 1 register, 3 bits operand 2 register
I-Type: 3 bits opcode, 3 bits destination register, 3 bits immediate
B-Type: 3 bits opcode, 2 bits address register, 2 bits operand 1 register, 2 bits operand 2 register
"""

import sys

# map registers to binary
registers_two_bit = {
    "r0": "000",
    "r1": "001",
    "r2": "010",
    "r3": "011",
    "r4": "100",
    "r5": "101",
    "r6": "110",
    "r7": "111",
    }

# map opcode to binary
# NOTE: THIS WILL BE DIFFERENT FOR YOU!
opcode = {
    "ld": "000",
    "rst": "001",
    "add": "010",
    "pos": "011",
    "xor": "100",
    "jmp": "101",
    "lw": "110",
    "sw": "111"
    }

# classify instructions into different types
# NOTE: THIS WILL BE DIFFERENT FOR YOU!
#rtype = ['add', 'pos', 'xor', 'lw', 'sw']
itype = ['ld','rst', 'jmp', 'add', 'pos', 'xor', 'lw', 'sw']


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


        # split instruction into arguments
        inst = inst.split()

        # initialize the string that contains the machine code binary
        writeline = ''


        # write the opcode
        if inst[0] in opcode:
            writeline += opcode[inst[0]]
        else:
            # if it an instruction that doesn't exist, exit
            
            # sys.exit()

            raise ValueError("Insn DNE")


        # write the first register to binary (maybe you need checking on this)
        writeline += registers_two_bit[inst[1]]

        # if it's r-type or b-type, then you know you have 2 args after (this might be different for you)
        #if inst[0] in rtype:
        #    writeline += registers_two_bit[inst[2]]
        #elif inst[0] in itype:
        if inst[0] in itype:
            # immediate just goes straight in
            writeline += inst[2]

        # SystemVerilog ignores comments prepended with // with readmemb or readmemh
        writeline += ' //' + comment
        writeline += '\n'

        # write the line into the desired file
        write.write(writeline)

        # read the next line
        line = read.readline()
