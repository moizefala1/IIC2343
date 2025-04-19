library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Mux_DIN is
    Port (
    alu_result: in std_logic_vector (15 downto 0);
    pc_out: in std_logic_vector (11 downto 0);
    selDin: in std_logic;
    ram_datain: out std_logic_vector (15 downto 0));
end Mux_DIN;

architecture Behavioral of Mux_DIN is

begin

with selDin select 
    ram_datain <= alu_result when '0',
                  std_logic_vector(unsigned("0000" & pc_out) + 1) when '1';
end Behavioral;
