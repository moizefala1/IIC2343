library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_PC is
    Port (
    ram_dataout: in std_logic_vector (11 downto 0);
    rom_dataout: in std_logic_vector (11 downto 0);
    selPC: in std_logic;
    address: out std_logic_vector (11 downto 0));
end Mux_PC;

architecture Behavioral of Mux_PC is

begin

with selPC select 
    address <= ram_dataout when '0',
               rom_dataout when '1';
end Behavioral;
