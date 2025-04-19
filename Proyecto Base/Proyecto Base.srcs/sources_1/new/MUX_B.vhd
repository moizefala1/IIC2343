library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_B is
    Port ( 
    zero  : in  std_logic_vector (15 downto 0):= "0000000000000000" ;
    RAM   : in  std_logic_vector (15 downto 0) ;
    ROM   : in  std_logic_vector (15 downto 0) ;
    Reg_B : in  std_logic_vector (15 downto 0) ;
    Sel_B : in  std_logic_vector (1 downto 0)  ;
    M     : out std_logic_vector (15 downto 0));
    
end MUX_B;

architecture Behavioral of MUX_B is

begin

with Sel_B select
    M <= Reg_B  when "00",
           zero when "01",
           RAM  when "10",
           ROM  when "11";
end Behavioral;
