from iic2343 import Basys3

class Assembler():
    
    def __init__(self):
        self.file = None
        self.lines = []
        self.opcodes = {}
        self.labels = {}
        self.instructions = []  
        self.memory = {}
        self.variable1 = 0
        self.variable2 = 0
        self.basys3 = None
    
    def read_file(self, file):
        self.file = open(file, "r")
        self.lines = self.file.readlines()
        self.file.close()
    
    def process_code(self):
        if not self.lines or self.lines[0].strip().upper() != "CODE:":
            raise ValueError("First line must be 'CODE'")
        
        for line in self.lines[1:]:
            line = line.strip()
            if line:
                self.instructions.append(line)
    
    def has_parenthesis(self, string):
        return "(" in string and ")" in string
    
    def extract_from_parenthesis(self, string):
        return string.strip('()')
    
    def parse_instruction(self, instruction):
        parts = instruction.split(' ')
        opcode = parts[0].upper()
        opcodes_parts = parts[1].split(",") if len(parts) > 1 else []
        
        if len(opcodes_parts) == 1:
            dest = opcodes_parts[0]
            src = None
        elif len(opcodes_parts) == 2:
            dest = opcodes_parts[0]
            src = opcodes_parts[1]
        
        opcode_binario = ""
        literal = None

        if opcode == "MOV":
            if dest == "A" and src == "B":
                opcode_binario = "0000001"
            elif dest == "B" and src == "A":
                opcode_binario = "0000010"
            elif dest == "A" and src not in ["A", "B"] and not self.has_parenthesis(src):
                opcode_binario = "0000011"
                literal = src
            elif dest == "B" and src not in ["A", "B"] and not self.has_parenthesis(src):
                opcode_binario = "0000100"
                literal = src
            elif dest == "A" and self.has_parenthesis(src):
                opcode_binario = "0000101"
                literal = self.extract_from_parenthesis(src)
            elif dest == "B" and self.has_parenthesis(src):
                opcode_binario = "0000110"
                literal = self.extract_from_parenthesis(src)
            elif self.has_parenthesis(dest) and src == "A":
                opcode_binario = "0000111"
                literal = self.extract_from_parenthesis(dest)
            elif self.has_parenthesis(dest) and src == "B":
                opcode_binario = "0001000"
                literal = self.extract_from_parenthesis(dest)
            else:
                raise ValueError(f"Invalid destination: {dest}")
        
        elif opcode == "ADD":
            if dest == "A" and src == "B":
                opcode_binario = "0001001"
            elif dest == "B" and src == "A":
                opcode_binario = "0001010"
            elif dest == "A" and src not in ["A", "B"] and not self.has_parenthesis(src):
                opcode_binario = "0001011"
                literal = src
            elif dest == "B" and src not in ["A", "B"] and not self.has_parenthesis(src):
                opcode_binario = "0001100"
                literal = src
            elif dest == "A" and self.has_parenthesis(src):
                opcode_binario = "0001101"
                literal = self.extract_from_parenthesis(src)
            elif dest == "B" and self.has_parenthesis(src):
                opcode_binario = "0001110"
                literal = self.extract_from_parenthesis(src)
            elif self.has_parenthesis(dest):
                opcode_binario = "0001111"
                literal = self.extract_from_parenthesis(dest)
            else:
                raise ValueError(f"Invalid destination: {dest}")
        
        elif opcode == "SUB":
            if dest == "A" and src == "B":
                opcode_binario = "0010000"
            elif dest == "B" and src == "A":
                opcode_binario = "0010001"
            elif dest == "A" and src not in ["A", "B"] and not self.has_parenthesis(src):
                opcode_binario = "0010010"
                literal = src
            elif dest == "B" and src not in ["A", "B"] and not self.has_parenthesis(src):
                opcode_binario = "0010011"
                literal = src
            elif dest == "A" and self.has_parenthesis(src):
                opcode_binario = "0010100"
                literal = self.extract_from_parenthesis(src)
            elif dest == "B" and self.has_parenthesis(src):
                opcode_binario = "0010101"
                literal = self.extract_from_parenthesis(src)
            elif self.has_parenthesis(dest):
                opcode_binario = "0010110"
                literal = self.extract_from_parenthesis(dest)
            else:
                raise ValueError(f"Invalid destination: {dest}")
        
        elif opcode == "AND":
            if dest == "A" and src == "B":
                opcode_binario = "0010111"
            elif dest == "B" and src == "A":
                opcode_binario = "0011000"
            elif dest == "A" and src not in ["A", "B"] and not self.has_parenthesis(src):
                opcode_binario = "0011001"
                literal = src
            elif dest == "B" and src not in ["A", "B"] and not self.has_parenthesis(src):
                opcode_binario = "0011010"
                literal = src
            elif dest == "A" and self.has_parenthesis(src):
                opcode_binario = "0011011"
                literal = self.extract_from_parenthesis(src)
            elif dest == "B" and self.has_parenthesis(src):
                opcode_binario = "0011100"
                literal = self.extract_from_parenthesis(src)
            elif self.has_parenthesis(dest):
                opcode_binario = "0011101"
                literal = self.extract_from_parenthesis(dest)
            else:
                raise ValueError(f"Invalid destination: {dest}")
        
        elif opcode == "OR":
            if dest == "A" and src == "B":
                opcode_binario = "0011110"
            elif dest == "B" and src == "A":
                opcode_binario = "0011111"
            elif dest == "A" and src not in ["A", "B"] and not self.has_parenthesis(src):
                opcode_binario = "0100000"
                literal = src
            elif dest == "B" and src not in ["A", "B"] and not self.has_parenthesis(src):
                opcode_binario = "0100001"
                literal = src
            elif dest == "A" and self.has_parenthesis(src):
                opcode_binario = "0100010"
                literal = self.extract_from_parenthesis(src)
            elif dest == "B" and self.has_parenthesis(src):
                opcode_binario = "0100011"
                literal = self.extract_from_parenthesis(src)
            elif self.has_parenthesis(dest):
                opcode_binario = "0100100"
                literal = self.extract_from_parenthesis(dest)
            else:
                raise ValueError(f"Invalid destination: {dest}")
        
        elif opcode == "XOR":
            if dest == "A" and src == "B":
                opcode_binario = "0100101"
            elif dest == "B" and src == "A":
                opcode_binario = "0100110"
            elif dest == "A" and src not in ["A", "B"] and not self.has_parenthesis(src):
                opcode_binario = "0100111"
                literal = src
            elif dest == "B" and src not in ["A", "B"] and not self.has_parenthesis(src):
                opcode_binario = "0101000"
                literal = src
            elif dest == "A" and self.has_parenthesis(src):
                opcode_binario = "0101001"
                literal = self.extract_from_parenthesis(src)
            elif dest == "B" and self.has_parenthesis(src):
                opcode_binario = "0101010"
                literal = self.extract_from_parenthesis(src)
            elif self.has_parenthesis(dest):
                opcode_binario = "0101011"
                literal = self.extract_from_parenthesis(dest)
            else:
                raise ValueError(f"Invalid destination: {dest}")
        
        elif opcode == "NOT":
            if dest == "A":
                opcode_binario = "0101100"
            elif dest == "B" and src == "A":
                opcode_binario = "0101101"
            elif self.has_parenthesis(dest) and src == "A":
                opcode_binario = "0101110"
                literal = self.extract_from_parenthesis(dest)
            else:
                raise ValueError(f"Invalid destination: {dest}")
        
        elif opcode == "SHL":
            if dest == "A":
                opcode_binario = "0101111"
            elif dest == "B" and src == "A":
                opcode_binario = "0110000"
            elif self.has_parenthesis(dest) and src == "A":
                opcode_binario = "0110001"
                literal = self.extract_from_parenthesis(dest)
            else:
                raise ValueError(f"Invalid destination: {dest}")
        
        elif opcode == "SHR":
            if dest == "A":
                opcode_binario = "0110010"
            elif dest == "B" and src == "A":
                opcode_binario = "0110011"
            elif self.has_parenthesis(dest) and src == "A":
                opcode_binario = "0110100"
                literal = self.extract_from_parenthesis(dest)
            else:
                raise ValueError(f"Invalid destination: {dest}")
        
        elif opcode == "INC":
            if dest == "A":
                opcode_binario = "0001011"  # This is the opcode for ADD A,literal
                literal = "1"
            elif dest == "B":
                opcode_binario = "0110110"
            elif self.has_parenthesis(dest):
                opcode_binario = "0110111"
                literal = self.extract_from_parenthesis(dest)
            else:
                raise ValueError(f"Invalid destination: {dest}")
        
        elif opcode == "DEC":
            if dest == "A":
                opcode_binario = "0010010"  
                literal = "1"
            else:
                raise ValueError(f"Invalid destination: {dest}")
        
        elif opcode == "CMP":
            if dest == "A" and src == "B":
                opcode_binario = "0111001"
            elif dest == "A" and src not in ["A", "B"] and not self.has_parenthesis(src):
                opcode_binario = "0111010"
                literal = src
            elif dest == "A" and self.has_parenthesis(src):
                opcode_binario = "0111011"
                literal = self.extract_from_parenthesis(src)
            else:
                raise ValueError(f"Invalid destination")
        
        elif opcode in ["JMP", "JEQ", "JNE", "JGT", "JGE", "JLT", "JLE", "JCR"]:
            opcode_binario = {
                "JMP": "0111100",
                "JEQ": "0111101",
                "JNE": "0111110",
                "JGT": "0111111",
                "JGE": "1000000",
                "JLT": "1000001",
                "JLE": "1000010",
                "JCR": "1000011"
            }[opcode]
            literal = dest
        else:
            raise ValueError(f"Invalid opcode: {opcode}")

        # New instruction format: 13 zeros + 7-bit opcode + 16-bit literal
        instruction_binaria = "0" * 13  # 13 zeros
        instruction_binaria += opcode_binario  # 7-bit opcode

        if literal is not None:
            literal_bits = self.literal_to_bits(literal)
            instruction_binaria += literal_bits  # 16-bit literal
        else:
            instruction_binaria += "0" * 16  # 16 zeros if no literal

        print(instruction_binaria)
        return instruction_binaria

    def literal_to_bits(self, literal):
        try:
            value = int(literal)
            if value < 0:
                value = (1 << 16) + value
            return format(value & 0xFFFF, '016b')
        except ValueError:
            raise ValueError(f"Invalid literal or unresolved label: {literal}")

    def assemble(self, file):
        self.read_file(file)
        self.process_code()
        
        all_code = []
        
        for instruction in self.instructions:
            all_code.append(self.parse_instruction(instruction))
        
        return all_code

    def write_to_file(self, assembled_code, output_file):
        with open(output_file, 'w') as f:
            for instruction in assembled_code:
                f.write(instruction + '\n')
        print(f"Assembled code written to {output_file}")

    def write_to_basys3(self, assembled_code, port_number=1):
        self.basys3 = Basys3()
        self.basys3.begin(port_number=port_number)

        for i, instruction in enumerate(assembled_code):
            if i >= 2**12:
                print("Warning: Exceeded maximum ROM size (2^12). Stopping write.")
                break
            
            inst_to_int = int(instruction, 2)
            inst_to_bytes = inst_to_int.to_bytes(5, "big")
            self.basys3.write(i, bytearray(inst_to_bytes))

        self.basys3.end()
        print(f"Successfully wrote {len(assembled_code)} instructions to Basys3.")

    def run(self, input_file, output_file="output.txt", write_to_basys=False, basys_port=1):
        try:
            assembled_code = self.assemble(input_file)
            print("Assembled successfully")
            self.write_to_file(assembled_code, output_file)
            
            if write_to_basys:
                self.write_to_basys3(assembled_code, port_number=basys_port)
            
            return assembled_code
        except Exception as e:
            print(f"Error: {e}")
            return None

# Usage example
assembler = Assembler()
result = assembler.run("ejemplo1.txt", "assembled_output.txt", write_to_basys=True, basys_port=1)
if result:
    print("Assembled instructions:")
    for instruction in result:
        print(instruction)