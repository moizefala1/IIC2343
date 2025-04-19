-- NO TOCAR

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity SP is
    Port ( clock    : in  std_logic;                        -- Señal del clock (reducido).
           clear    : in  std_logic;                        -- Señal de reset.
           up       : in  std_logic;                        -- Señal de subida.
           down     : in  std_logic;                        -- Señal de bajada.
           dataout  : out std_logic_vector (11 downto 0));  -- Señales de salida de datos.
end SP;

architecture Behavioral of SP is

signal sp : std_logic_vector(11 downto 0) := "111111111111";

begin

sp_prosses : process (clock, clear)        -- Proceso sensible a clock y clear.
        begin
          if (clear = '1') then             -- Si clear = 1
            sp <= "111111111111";         -- Carga 0 en el registro.
          elsif (rising_edge(clock)) then   -- Si flanco de subida de clock.
            if (up = '1') then           -- Si clear = 0,load = 0 y up = 1.
                sp <= sp + 1;             -- Incrementa el registro en 1.
            elsif (down = '1') then         -- Si clear = 0,load = 0, up = 0 y down = 1. 
                sp <= sp - 1;             -- Decrementa el registro en 1.          
            end if;
          end if;
        end process;
        
dataout <= sp;                             -- Los datos del registro salen sin importar el estado de clock.
            
end Behavioral;
