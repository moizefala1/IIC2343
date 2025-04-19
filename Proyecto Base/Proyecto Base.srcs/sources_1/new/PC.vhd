
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity PC is
    Port ( clock       : in std_logic;
           loadPC      : in std_logic;
           clear       : in std_logic;
           address : in std_logic_vector (11 downto 0);
           pc_out : out std_logic_vector (11 downto 0));
              
end PC;

architecture Behavioral of PC is

signal pc_reg: std_logic_vector (11 downto 0) := (others => '0');

begin
    process (clock, clear)
    begin
        if clear = '1' then
            pc_reg <= (others => '0');
        elsif rising_edge(clock) then
            if loadPC = '1' then
                pc_reg <= address;
            else
                pc_reg <= std_logic_vector(unsigned(pc_reg) + 1);
             end if;
        end if;
    end process;
    
 pc_out <= pc_reg;
                
end Behavioral;
