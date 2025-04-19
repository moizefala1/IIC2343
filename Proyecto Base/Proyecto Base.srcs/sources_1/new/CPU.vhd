library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity CPU is
    Port (
           clock : in STD_LOGIC;
           clear : in STD_LOGIC;
           ram_address : out STD_LOGIC_VECTOR (11 downto 0);
           ram_datain : out STD_LOGIC_VECTOR (15 downto 0);
           ram_dataout : in STD_LOGIC_VECTOR (15 downto 0);
           ram_write : out STD_LOGIC;
           rom_address : out STD_LOGIC_VECTOR (11 downto 0);
           rom_dataout : in STD_LOGIC_VECTOR (35 downto 0);
           dis : out STD_LOGIC_VECTOR (15 downto 0));
end CPU;

architecture Behavioral of CPU is

--- DECLARACION DE COMPONENTES

component ALU 
    Port ( a        : in  std_logic_vector (15 downto 0);   -- Primer operando.
           b        : in  std_logic_vector (15 downto 0);   -- Segundo operando.
           sop      : in  std_logic_vector (2 downto 0);   -- Selector de la operación.
           c        : out std_logic;                       -- Señal de 'carry'.
           z        : out std_logic;                       -- Señal de 'zero'.
           n        : out std_logic;                       -- Señal de 'nagative'.
           result   : out std_logic_vector (15 downto 0));  -- Resultado de la operación.
end component;   

component Reg
    Port ( clock    : in  std_logic;                        -- Señal del clock (reducido).
           clear    : in  std_logic;                        -- Señal de reset.
           load     : in  std_logic;                        -- Señal de carga.
           up       : in  std_logic;                        -- Señal de subida.
           down     : in  std_logic;                        -- Señal de bajada.
           datain   : in  std_logic_vector (15 downto 0);   -- Señales de entrada de datos.
           dataout  : out std_logic_vector (15 downto 0));  -- Señales de salida de datos.
end component;   

component ControlUnit
    Port( rom_dataout :in std_logic_vector (35 downto 16);
          status      :in std_logic_vector (2 downto 0); 
          enable_A    :out std_logic;
          enable_B    :out std_logic;
          selA        :out std_logic_vector (1 downto 0);
          selB        :out std_logic_vector (1 downto 0);
          upA         :out std_logic;
          downA       :out std_logic;
          upB         :out std_logic;
          loadPC      :out std_logic;
          selALU      :out std_logic_vector (2 downto 0);
          w           :out std_logic;
          selAdd      :out std_logic_vector (1 downto 0);
          inc_sp      :out std_logic;
          dec_sp      :out std_logic;
          selPC       :out std_logic;
          selDin      :out std_logic);
 end component;   
 
 component MUX_A
    Port( zero  : in std_logic_vector (15 downto 0):= "0000000000000000" ;
          one   : in std_logic_vector (15 downto 0):= "0000000000000001" ;
          Reg_A : in std_logic_vector (15 downto 0) ;
          Sel_A : in std_logic_vector (1 downto 0)  ;
          M     : out std_logic_vector (15 downto 0));
 end component;            
 
 component MUX_B
    Port( zero  : in std_logic_vector (15 downto 0):= "0000000000000000" ;
          RAM   : in std_logic_vector (15 downto 0);
          ROM   : in std_logic_vector (15 downto 0);
          Reg_B : in std_logic_vector (15 downto 0) ;
          Sel_B : in std_logic_vector (1 downto 0)  ;
          M     : out std_logic_vector(15 downto 0));
  end component; 
 component status
    Port( clock : in std_logic;
          c     : in std_logic;
          z     : in std_logic;
          n     : in std_logic;
          clear : in std_logic;
          status: out std_logic_vector (2 downto 0));
 end component;
 
 component PC
    Port( clock     : in std_logic;
          loadPC    : in std_logic;
          clear     : in std_logic;
          address   : in std_logic_vector (11 downto 0);
          pc_out    : out std_logic_vector (11 downto 0));
 end component;
          
component Mux_PC
    Port (
    ram_dataout: in std_logic_vector (11 downto 0);
    rom_dataout: in std_logic_vector (11 downto 0);
    selPC: in std_logic;
    address: out std_logic_vector (11 downto 0));
 end component;
 
 component Mux_Din
     Port (
    alu_result: in std_logic_vector (15 downto 0);
    pc_out: in std_logic_vector (11 downto 0);
    selDin: in std_logic;
    ram_datain: out std_logic_vector (15 downto 0));
end component;

component SP
    Port(
    clock: in std_logic;
    clear: in std_logic;
    up: in std_logic;
    down: in std_logic;
    dataout: out std_logic_vector (11 downto 0));
 end component;
 
 component Mux_ADD
    Port(
    seladd: in std_logic_vector (1 downto 0);
    rom_dataout: in std_logic_vector (11 downto 0);
    reg_b: in std_logic_vector (11 downto 0);
    sp: in std_logic_vector (11 downto 0);
    address: out std_logic_vector (11 downto 0));
end component;
--- DECLARACION DE SEÑALES

--- ALU
signal a            :std_logic_vector (15 downto 0);
signal b            :std_logic_vector (15 downto 0);
signal sop          :std_logic_vector (2 downto 0);
signal c            :std_logic;
signal z            :std_logic;
signal n            :std_logic;
signal alu_result   :std_logic_vector(15 downto 0);

--- Registros

signal load_a       :std_logic;
signal regA_up      :std_logic;
signal regA_down    :std_logic;
signal datain_regA  :std_logic_vector (15 downto 0);
signal dataout_regA :std_logic_vector (15 downto 0);
signal load_b       :std_logic;
signal regB_up      :std_logic;
signal regB_down    :std_logic;
signal datain_regB  :std_logic_vector (15 downto 0);
signal dataout_regB :std_logic_vector (15 downto 0);

--- ControlUnit
signal loadPC : std_logic;
signal status_signal : std_logic_vector (2 downto 0);
signal w : std_logic;
signal selAdd: std_logic_vector (1 downto 0);
signal selDin: std_logic;
signal selPC: std_logic;
signal inc_sp: std_logic;
signal dec_sp: std_logic;


---Mux
signal selector_a : std_logic_vector (1 downto 0);
signal selector_b : std_logic_vector (1 downto 0);
--Mux PC
signal pc_address : std_logic_vector (11 downto 0);
signal pc_out     : std_logic_vector (11 downto 0);
--SP
signal sp_out: std_logic_vector (11 downto 0);

begin

dis <= dataout_regA(7 downto 0) & dataout_regB(7 downto 0);
rom_address <= pc_out;

inst_ALU: ALU port map(
    a              => a,
    b              => b,
    sop            => sop,
    c              => c,
    z              => z,
    n              => n,
    result         => alu_result
);

inst_ControlUnit: ControlUnit port map(
    enable_A       => load_a,
    enable_B       => load_b,
    selA           => selector_A,
    selB           => selector_B,
    upA            => regA_up,
    downA          => regA_down,
    upB            => regB_up,
    loadPC         => loadPC,
    selALU         => sop,  
    rom_dataout    => rom_dataout (35 downto 16),
    status         => status_signal,
    w              => ram_write,
    selAdd         => selAdd,
    inc_sp         => inc_sp,
    dec_sp         => dec_sp,
    selPC          => selPC,
    selDin         => selDin
);

inst_status: Status port map(
    clock   => clock,
    c       => c,
    z       => z,
    n       => n,
    clear   => clear,
    status  => status_signal
);
    
inst_REG_A: Reg port map(
    clock           => clock,
    clear           => clear,
    load            => load_a,
    up              => regA_up,
    down            => regA_down,
    datain          => alu_result,
    dataout         => dataout_regA
);

inst_REG_B: Reg port map(
    clock           => clock,
    clear           => clear,
    load            => load_b,
    up              => regB_up,
    down            => regB_down,
    datain          => alu_result,
    dataout         => dataout_regB
);

inst_MUX_A: Mux_A port map(
    Reg_A            => dataout_regA,
    M                => a,
    sel_A            => selector_A
);

inst_MUX_B: Mux_B port map(
    Reg_B           => dataout_regB,
    RAM             => ram_dataout,
    ROM             => rom_dataout (15 downto 0),
    sel_b           => selector_B,
    M               => b
);

inst_PC: PC port map(
    clock       => clock,
    loadPC      => loadPC,
    clear       => clear,
    address     => pc_address,
    pc_out      => pc_out
);

inst_Mux_PC: Mux_PC port map(
    ram_dataout     => ram_dataout(11 downto 0),
    rom_dataout     => rom_dataout (11 downto 0),
    selPC           => selPC,
    address         => pc_address
);

inst_Mux_Din: Mux_Din port map(
    alu_result   => alu_result,
    pc_out       => pc_out,
    selDin       => selDin,
    ram_datain   => ram_datain
);

inst_SP: SP port map(
    clock       => clock,
    clear       => clear,
    up          => inc_sp,
    down        => dec_sp,
    dataout     => sp_out
);

inst_mux_add: Mux_ADD port map(
    selAdd      => selAdd,
    rom_dataout => rom_dataout (11 downto 0),
    reg_b       => dataout_regB (11 downto 0),
    sp          => sp_out,
    address     => ram_address
);
end Behavioral;

