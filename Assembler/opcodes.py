dict_opcodes = {
    "NOP"           : "00000000",

    # -- MOV -- 
    "MOV A, B"      : "0000001",
    "MOV B, A"      : "0000010",
    "MOV A, Lit"    : "0000011",
    "MOV B, Lit"    : "0000100",
    "MOV A, (dir)"  : "0000101",
    "MOV B, (dir)"  : "0000110",
    "MOV (dir), A"  : "0000111",
    "MOV (dir), B"  : "0001000",

    # -- ADD --
    "ADD A, B"      : "0001001",
    "ADD B, A"      : "0001010",
    "ADD A, Lit"    : "0001011",
    "ADD B, Lit"    : "0001100",
    "ADD A, (dir)"  : "0001101",
    "ADD B, (dir)"  : "0001110",
    "ADD (dir)"     : "0001111",
    

    # -- SUB --
    "SUB A, B"      : "0010000",
    "SUB B, A"      : "0010001",
    "SUB A, Lit"    : "0010010",
    "SUB B, Lit"    : "0010011",
    "SUB A, (dir)"  : "0010100",
    "SUB B, (dir)"  : "0010101",
    "SUB (dir)"     : "0010110",
    

    # -- AND:
    "AND A, B"      : "0010111",
    "AND B, A"      : "0011000",
    "AND A, Lit"    : "0011001",
    "AND B, Lit"    : "0011010",
    "AND A, (dir)"  : "0011011",
    "AND B, (dir)"  : "0011100",
    "AND (dir)"     : "0011101",

    # -- OR
    "OR  A, B"      : "0011110",
    "OR  B, A"      : "0011111",
    "OR  A, Lit"    : "0100000",
    "OR  B, Lit"    : "0100001",
    "OR  A, (dir)"  : "0100010",
    "OR  B, (dir)"  : "0100011",
    "OR  (dir)"     : "0100100",
    # -- XOR
    "XOR A, B"      : "0100101",
    "XOR B, A"      : "0100110",
    "XOR A, Lit"    : "0100111",
    "XOR B, Lit"    : "0101000",
    "XOR A, (dir)"  : "0101001",
    "XOR B, (dir)"  : "0101010",
    "XOR (dir)"     : "0101011",

    # -- NOT
    "NOT A"         : "0101100",
    "NOT B, A"      : "0101101",
    "NOT (dir), A"  : "0101110",

    # -- SHL
    "SHL A"         : "0101111",
    "SHL B, A"      : "0110000",
    "SHL (dir), A"  : "0110001",

    # -- SHR
    "SHR A"         : "0110010",      
    "SHR B, A"      : "0110011",    
    "SHR (dir), A"  : "0110100",

    # -- INC
    "INC A"         : "0110101",    
    "INC B"         : "0110110",
    "INC (dir)"     : "0110111",

    # -- DEC
    "DEC A"         : "0111000",

    # -- CMP
    "CMP A, B"      : "0111001",   
    "CMP A, Lit"    : "0111010",
    "CMP A, (dir)"  : "0111011",

    # -- JUMPs
    "JMP dir"       : "0111100",
    "JEQ dir"       : "0111101",
    "JNE dir"       : "0111110",
    "JGT dir"       : "0111111",
    "JGE dir"       : "1000000",
    "JLT dir"       : "1000001",
    "JLE dir"       : "1000010",
    "JCR dir"       : "1000011",
    
    "MOV" : "MOV",
    "ADD" : "ADD",
    "SUB" : "SUB",
    "AND" : "AND",
    "OR"  : "OR",
    "XOR" : "XOR",
    "NOT" : "NOT",
    "SHL" : "SHL",
    "SHR" : "SHR",
    "INC" : "INC",
    "DEC" : "DEC",
    "CMP" : "CMP",
    "JMP" : "JMP",
    "JEQ" : "JEQ",
    "JNE" : "JNE",
    "JGT" : "JGT",
    "JGE" : "JGE",
    "JLT" : "JLT",
    "JLE" : "JLE",
    "JCR" : "JCR"
    
}
