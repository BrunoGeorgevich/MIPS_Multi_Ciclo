module datapath(input logic clk, reset,
                input logic memtoreg, 
                input logic [1:0] pcsrc,
                input logic alusrca,
                input logic [1:0] alusrcb,
                input logic regdst, regwrite,
                input logic [2:0] alucontrol,
                output logic zero,
                input logic [31:0] readdata,
                output logic [31:0] adr, writedata,
                output logic [31:0] instr,
                input logic IorD,
                input logic irwrite,
                input logic pcen); 
  logic [31:0] pcnext, pc;
  logic [31:0] signimm, signimmsh;
  logic [31:0] srca, srcb;
  logic [31:0] aluresult, aluout;
  logic [31:0] data;
  logic [31:0] jump;
  logic [4:0] a3;
  logic [31:0] rd1, rd2, A, wd3;
  

  // next PC logic
  flopren #(32) pcreg(clk, reset, pcen, pcnext, pc);
  sl2 sigjump({6'b0,instr[25:0]}, jump);
  mux4 #(32) pcmux(aluresult, aluout, {pc[31:28],jump[27:0]}, aluresult, pcsrc, pcnext);
  // mux4:
  // 00 - ALUresult //pc + 4 - (others) 
  // 01 - ALUOut (branch)
  // 10 - pc[31:28],jump (jump)
  // 11 - pc+4 - n sei o que seria, talvez exce��o
  // PCsrc
  
  // mux to mem
  mux2 #(32) memmux(pc, aluout, IorD, adr);
  
    
  // register file logic
  flopren #(32) ireg(clk, reset, irwrite, readdata, instr);
  flopr #(32) datareg(clk, reset, readdata, data); 
  mux2 #(5) a3mux(instr[20:16], instr[15:11], regdst, a3);
  mux2 #(32) wd3mux(aluout, data, memtoreg, wd3);
  regfile rf(clk, regwrite, instr[25:21], instr[20:16], a3, wd3, rd1, rd2);
    
  flopr #(32) A_reg(clk, reset, rd1, A); 
  flopr #(32) B_reg(clk, reset, rd2, writedata);
  
  mux2 #(32) alu_src_a_mux(pc, A, alusrca, srca); 
  
  signext se(instr[15:0], signimm);
  sl2 signimml2(signimm, signimmsh);
  mux4 #(32) srcbmux(writedata, 32'b100, signimm, signimmsh, alusrcb, srcb);
  alu32 alu(srca, srcb, alucontrol, aluresult, zero);
  flopr #(32) resultreg(clk, reset, aluresult, aluout);
  
endmodule
