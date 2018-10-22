module controller(input logic clk, reset,
                  input logic [5:0] op, funct,  
                  input logic zero, 
                  output logic memtoreg, memwrite,
                  output logic alusrca,
                  output logic [1:0] alusrcb, pcsrc,
                  output logic regdst, regwrite,
                  output logic [2:0] alucontrol,
                  output logic iord, irwrite,
                  output logic pcen); 
  logic [1:0] aluop;
  logic branch; 
  
  maindec md(clk, reset, zero, op, memtoreg, memwrite, branch, alusrca, alusrcb, regdst, regwrite, pcen, iord, irwrite, pcsrc, aluop);
  
  aludec ad(funct, aluop, alucontrol);
endmodule