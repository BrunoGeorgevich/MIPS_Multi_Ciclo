library verilog;
use verilog.vl_types.all;
entity datapath is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        memtoreg        : in     vl_logic;
        pcsrc           : in     vl_logic_vector(1 downto 0);
        alusrca         : in     vl_logic;
        alusrcb         : in     vl_logic_vector(1 downto 0);
        regdst          : in     vl_logic;
        regwrite        : in     vl_logic;
        alucontrol      : in     vl_logic_vector(2 downto 0);
        zero            : out    vl_logic;
        readdata        : in     vl_logic_vector(31 downto 0);
        adr             : out    vl_logic_vector(31 downto 0);
        writedata       : out    vl_logic_vector(31 downto 0);
        instr           : out    vl_logic_vector(31 downto 0);
        IorD            : in     vl_logic;
        irwrite         : in     vl_logic;
        pcen            : in     vl_logic
    );
end datapath;
