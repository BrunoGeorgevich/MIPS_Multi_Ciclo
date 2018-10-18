module mips(input logic clk, reset,
            output logic memwrite,
            output logic [31:0] adr, writedata, // aluout ou dataadr? 
            input logic [31:0] readdata);
            
  logic memtoreg, alusrca, regdst, regwrite, irwrite, pcen, IorD, zero;
  logic [1:0] alusrcb, pcsrc;
  logic [2:0] alucontrol;
  logic [31:0] instr;

  
  
  controller c(clk, reset, instr[31:26], instr[5:0], zero, memtoreg, memwrite,
    alusrca, alusrcb, pcsrc, regdst, regwrite, alucontrol, IorD, irwrite, pcen);
  
  datapath dp(clk, reset, memtoreg, pcsrc, alusrca, alusrcb, regdst, regwrite,
    alucontrol, zero, readdata, adr, writedata, instr, IorD, irwrite, pcen);

endmodule