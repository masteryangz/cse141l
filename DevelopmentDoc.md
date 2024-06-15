

ISA size:
 - 9 bits  


Register:
- size: 1 byte
- total amount: 8 
- namespace: 3 bits

Instructions:
[link to ISA pdf](https://drive.google.com/file/d/13Y4vb4rbdHncJQRD8_gCckEcnlmZvwQp/view?usp=sharing)
- total amount: 8 
- namespace: 3 bits
- insns:
  - ld: 000
    -  load an intermediate to a reg
    -  e.g. `ld R3 111⇔ 000_011_111`
  - rst: 001
    - by default right shift
    -  e.g. `rst R0 101  ⇔ 001_000_101`
  - add: 010
    - e.g. `add R0, R1 ⇔ 010_000_001`
  - pos: 011
    - e.g. `pos R0 001 ⇔ 011_000_001`
  - xor: 100
    -  bitwise xor
    -  e.g. `xor R0 R1 ⇔ 100_000_001`
  - jmp: 101
    -  e.g. `beq R0 001 ⇔ 101_000_001`
  - lw: 110
    -  load from memory at reg
    -  e.g `lw R0 R1 ⇔ 110_000_001`
  - sw: 111
    -  store to memory at reg
    -  e.g. `sw R0 R1 ⇔ 111_000_001`
 
