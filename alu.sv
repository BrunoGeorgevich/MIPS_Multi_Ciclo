module alu32(input logic [31:0] A, B,
              input logic [2:0] F,
              output logic [31:0] Y,
              output logic zero);

  always_comb
    case (F[2:0])
      3'b000: Y <= A & B;
      3'b001: Y <= A | B;
      3'b010: Y <= A + B;
      3'b011: Y <= 32'bz;
      3'b100: Y <= A & ~B;
      3'b101: Y <= A | ~B;
      3'b110: Y <= A - B;
      3'b111: Y <= (A < B);
      default: Y <= 32'bz;
    endcase
  
  assign zero = (Y == 0); 
    
endmodule
