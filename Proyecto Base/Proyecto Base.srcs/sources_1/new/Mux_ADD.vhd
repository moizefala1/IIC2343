library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux_ADD is
    Port ( 
    selAdd: in std_logic_vector (1 downto 0);
    rom_dataout: in std_logic_vector (11 downto 0);
    reg_b: in std_logic_vector (11 downto 0);
    sp: in std_logic_vector(11 downto 0);
    address: out std_logic_vector (11 downto 0));

end Mux_ADD;

architecture Behavioral of Mux_ADD is

begin

with selAdd select
address <= rom_dataout when "00",
           sp when "01",
           reg_b when "10",
           "000000000000" when others;
end Behavioral;
