library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_A is
    Port ( 
    zero  : in std_logic_vector  (15 downto 0):= "0000000000000000" ;
    one   : in std_logic_vector  (15 downto 0):= "0000000000000001" ;
    Reg_A : in std_logic_vector  (15 downto 0) ;
    Sel_A : in std_logic_vector  (1 downto 0)  ;
    M     : out std_logic_vector (15 downto 0));
    
end MUX_A;

architecture Behavioral of MUX_A is

begin

with Sel_A select
    M <= Reg_A  when "00",
           zero when "01",
           one  when "10",
           zero when "11";

end Behavioral;
