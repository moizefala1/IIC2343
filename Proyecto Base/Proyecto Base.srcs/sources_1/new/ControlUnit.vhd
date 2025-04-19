library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ControlUnit is
Port ( rom_dataout :in std_logic_vector (35 downto 16);
       status      :in std_logic_vector (2 downto 0); 
       enable_A    :out std_logic;
       enable_B    :out std_logic;
       selA        :out std_logic_vector (1 downto 0);
       selB        :out std_logic_vector (1 downto 0);
       upA         :out std_logic;
       upB         :out std_logic;
       downA       :out std_logic;
       downB       :out std_logic;
       loadPC      :out std_logic;
       selALU      :out std_logic_vector (2 downto 0);
       w           :out std_logic;
       selAdd      :out std_logic_vector (1 downto 0);
       inc_sp      :out std_logic;
       dec_sp      :out std_logic;
       selPC       :out std_logic;
       selDin      :out std_logic);

end ControlUnit;

architecture Behavioral of ControlUnit is
---- 13 CEROS, 7 OPCODE, 16 LIT, DIR(12)

begin

with rom_dataout (22 downto 16) select
    enable_A <= '1'  when "0000001",
                '1'  when "0000011",
                '1'  when "0000101",
                '1'  when "0001001",
                '1'  when "0001011",
                '1'  when "0001101",
                '1'  when "0010000",
                '1'  when "0010010",
                '1'  when "0010100",
                '1'  when "0010111",
                '1'  when "0011001",
                '1'  when "0011011",
                '1'  when "0011110",
                '1'  when "0100000",
                '1'  when "0100010",
                '1'  when "0100101",
                '1'  when "0100111",
                '1'  when "0101001",
                '1'  when "0101100",
                '1'  when "0101111",
                '1'  when "0110010",    
                '1' when  "1000100",
                '1' when  "1001000",
                '1' when "1001010",
                '1' when "1001100",
                '1' when "1001110",
                '1' when "1010000",
                '1' when "1011010",
                '1' when "1011100",
                '0' when others;
                
                
with rom_dataout (22 downto 16) select              
    enable_B <= '1' when "0000010",
                '1' when "0000100",
                '1' when "0000110",
                '1' when "0001010",
                '1' when "0001100",
                '1' when "0001110",
                '1' when "0010001",
                '1' when "0010011",
                '1' when "0010101",
                '1' when "0011000",
                '1' when "0011010",
                '1' when "0011100",
                '1' when "0011111",
                '1' when "0100001",
                '1' when "0100011",
                '1' when "0100110",
                '1' when "0101000",
                '1' when "0101010",
                '1' when "0101101",
                '1' when "0110000",
                '1' when "0110011",
                '1' when "1000101",
                '1' when "1001001",
                '1' when "1001011",
                '1' when "1001101",
                '1' when "1001111",
                '1' when "1010001",
                '1' when "1011100",
                '0' when others;
                
                
with rom_dataout (22 downto 16) select 
    selA     <= "01" when "0000001",
                "01" when "0000011",
                "01" when "0000100",
                "01" when "0000101",
                "01" when "0000110",
                "01" when "0001000",
                "10" when "0110111",
                "11" when "1000100",
                "11" when "1000101",
                "11" when "1000111",
                "10" when "1010101",
                "01" when "1011000",
                "01" when "1011100",
                "00" when others;
 with rom_dataout (22 downto 16) select 
    selB     <= "01" when "0000010",
                "01" when "0101100",
                "01" when "0101101",
                "01" when "0101111",
                "01" when "0110000",
                "01" when "0110010",
                "01" when "0110011",
                "10" when "0000101",
                "10" when "0000110",
                "01" when "0000111",
                "00" when "0001000",
                "10" when "0001101",
                "10" when "0001110",
                "10" when "0010100",
                "10" when "0010101",
                "10" when "0011011",
                "10" when "0011100",
                "10" when "0100010",
                "10" when "0100011",
                "10" when "0101001",
                "10" when "0101010",
                "10" when "0101110",
                "10" when "0110001",
                "10" when "0110100",
                "10" when "0110111",
                "10" when "0111011",
                "11" when "0000011",
                "11" when "0000100",
                "11" when "0001011",
                "11" when "0001100",
                "11" when "0010010",
                "11" when "0010011",
                "11" when "0011001",
                "11" when "0011010",
                "11" when "0100000",
                "11" when "0100001",
                "11" when "0100111",
                "11" when "0101000",
                "11" when "0111010",
                "10" when "1000100",
                "10" when "1000101",
                "01" when "1000110",
                "11" when "1000111",
                "10" when "1001000",
                "10" when "1001001",
                "10" when "1001010",
                "10" when "1001011",
                "10" when "1001100",
                "10" when "1001101",
                "10" when "1001110",
                "10" when "1001111",
                "10" when "1010000",
                "10" when "1010001",
                "01" when "1010010",
                "01" when "1010011",
                "01" when "1010100",
                "10" when "1010101",
                "10" when "1010110",
                "01" when "1010111",
                "10" when "1011010",
                "10" when "1011100",
                "00" when others;
                
 with rom_dataout (22 downto 16) select
    selALU   <=  "001" when "0010000",
                 "001" when "0010001",
                 "001" when "0010010",
                 "001" when "0010011",
                 "001" when "0010100",
                 "001" when "0010101",
                 "001" when "0010110",
                 "001" when "0111001",
                 "001" when "0111010",
                 "001" when "0111011",
                 "010" when "0010111",
                 "010" when "0011000",
                 "010" when "0011001",
                 "010" when "0011010",
                 "010" when "0011011",
                 "010" when "0011100",
                 "010" when "0011101",
                 "011" when "0011110",
                 "011" when "0011111",
                 "011" when "0100000",
                 "011" when "0100001",
                 "011" when "0100010",
                 "011" when "0100011",
                 "011" when "0100100",
                 "100" when "0100101",
                 "100" when "0100110",
                 "100" when "0100111",
                 "100" when "0101000",
                 "100" when "0101001",
                 "100" when "0101010",
                 "100" when "0101011",
                 "101" when "0101100",
                 "101" when "0101101",
                 "101" when "0101110",
                 "110" when "0110010",
                 "110" when "0110011",
                 "110" when "0110100",
                 "111" when "0101111",
                 "111" when "0110000",
                 "111" when "0110001",
                 "001" when "0111111",
                 "001" when "1001010",
                 "001" when "1001011",
                 "010" when "1001100",
                 "010" when "1001101",
                 "011" when "1001110",
                 "011" when "1001111",
                 "100" when "1010000",
                 "100" when "1010001",
                 "101" when "1010010",
                 "111" when "1010011",
                 "110" when "1010100",
                 "001" when "1010110",
                 "000" when others;
                 
 with rom_dataout (22 downto 16) select
    w         <= '1' when "0000111",
                 '1' when "0001000",
                 '1' when "0001111",
                 '1' when "0010110",
                 '1' when "0011101",
                 '1' when "0100100",
                 '1' when "0101011",
                 '1' when "0101110",
                 '1' when "0110001",
                 '1' when "0110100",
                 '1' when "0110111",
                 '1' when "1000110",
                 '1' when "1000111",
                 '1' when "1010010",
                 '1' when "1010011",
                 '1' when "1010100",
                 '1' when "1010101",
                 '1' when "1010111",
                 '1' when "1011000",
                 '1' when "1011101",
                 '0' when others;
                 
with rom_dataout (22 downto 16) select
    upA       <= '1' when "0110101",
                 '0'  when others;
                
with rom_dataout (22 downto 16) select
    downA     <= '1' when "0111000",
                 '0' when others;
 
with rom_dataout (22 downto 16) select
    upB       <= '1' when "0110110",
                 '0' when others;
                
   
---CZN
with rom_dataout (22 downto 16) select 
    loadPC <= '1' when "0111100", ---jmp
               '1' when "1011101", ---CALL
              '1' when "1011111", ---RET
               status(1) when "0111101", ---jmp eq
               not(status(1)) when "0111110",-- jmp neq
               (not(status(1))) and (not(status(0))) when "0111111", --jmp gt
               not(status(0)) when "1000000",-- JMP GE
               status(0) when "1000001",---JMP LT
               status(1) or status(0) when "1000010", ---jmp LE
               status(2) when "1000011",
               '0' when others;
               
with rom_dataout (22 downto 16) select
    selAdd <= "10" when "1000100",
              "10" when "1000101",
              "10" when "1000110",
              "10" when "1000111",
              "10" when "1001000",
              "10" when "1001001",
              "10" when "1001010",
              "10" when "1001011",
              "10" when "1001100",
              "10" when "1001101",
              "10" when "1001110",
              "10" when "1001111",
              "10" when "1010000",
              "10" when "1010001",
              "10" when "1010010",
              "10" when "1010011",
              "10" when "1010100",
              "10" when "1010101",
              "10" when "1010110",
              "01" when "1010111",
              "01" when "1011000",
              "01" when "1011010",
              "01" when "1011100",
              "01" when "1011101",
              "01" when "1011111",
              "00" when others;
              
with rom_dataout (22 downto 16) select
    inc_SP <= '1' when "1011001",
             '1' when "1011011",
             '1' when "1011110",
             '0' when others;
           
with rom_dataout (22 downto 16) select
    dec_SP <= '1' when "1010111",
              '1' when "1011000",
              '1' when "1011101",
              '0' when others;
             
with rom_dataout (22 downto 16) select
    selPC <= '1' when "1011101",
             '0' when others;
            
with rom_dataout (22 downto 16) select
    selDin <= '1' when "1011101",
              '0' when others;
end Behavioral;
