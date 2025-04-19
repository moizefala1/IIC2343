library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity status is
    Port ( clock: in std_logic;
           c:     in std_logic;
           z:     in std_logic;
           n:     in std_logic;
           clear: in std_logic;
           status : out std_logic_vector (2 downto 0)
        );
end status;

architecture Behavioral of status is

begin
process(clear, clock)
begin
    if rising_edge(clock) then
        if clear = '1' then
            status <= "000";  
        else 
            status <= (c & z & n);
        end if;  
    end if;
end process;

end Behavioral;