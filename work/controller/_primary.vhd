library verilog;
use verilog.vl_types.all;
entity controller is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        op              : in     vl_logic_vector(5 downto 0);
        funct           : in     vl_logic_vector(5 downto 0);
        zero            : in     vl_logic;
        memtoreg        : out    vl_logic;
        memwrite        : out    vl_logic;
        alusrca         : out    vl_logic;
        alusrcb         : out    vl_logic_vector(1 downto 0);
        pcsrc           : out    vl_logic_vector(1 downto 0);
        regdst          : out    vl_logic;
        regwrite        : out    vl_logic;
        alucontrol      : out    vl_logic_vector(2 downto 0);
        iord            : out    vl_logic;
        irwrite         : out    vl_logic;
        pcen            : out    vl_logic
    );
end controller;
