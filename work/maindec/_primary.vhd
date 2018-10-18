library verilog;
use verilog.vl_types.all;
entity maindec is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        zero            : in     vl_logic;
        op              : in     vl_logic_vector(5 downto 0);
        memtoreg        : out    vl_logic;
        memwrite        : out    vl_logic;
        branch          : out    vl_logic;
        alusrc_a        : out    vl_logic;
        alusrc_b        : out    vl_logic_vector(1 downto 0);
        regdst          : out    vl_logic;
        regwrite        : out    vl_logic;
        pcen            : out    vl_logic;
        iord            : out    vl_logic;
        irwrite         : out    vl_logic;
        pcsrc           : out    vl_logic_vector(1 downto 0);
        aluop           : out    vl_logic_vector(1 downto 0)
    );
end maindec;
