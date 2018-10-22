module maindec( input logic clk, reset, zero,
                input logic [5:0] op,
                output logic memtoreg, memwrite,
                output logic branch, alusrc_a, 
                output logic [1:0] alusrc_b,
                output logic regdst, regwrite,
                output logic pcen, iord, irwrite,
                output logic [1:0] pcsrc, aluop);

  typedef enum logic [3:0] {FETCH, DECODE, MEMADR, MEMREAD, MEMWRITEBACK, MEMWRITE,
   EXECUTE, ALUWRITEBACK, BRANCH, ADDIEXECUTE, ADDIWRITEBACK, JUMP} statetype;
  logic [3:0] state, nextstate;
  
  logic [14:0] controls;
  logic pcwrite;
  
  assign {memtoreg, memwrite, branch, alusrc_a, alusrc_b, regdst, regwrite, pcsrc, pcwrite, iord, irwrite, aluop} = controls;
  
  assign pcen = (branch & zero) | pcwrite;  
  
  // state register
  always_ff @ (posedge clk, posedge reset)
    if (reset) state <= FETCH;
    else       state <= nextstate;

  // next state logic  
  always
    case(state)
      FETCH: nextstate <= DECODE; // DECODE
      DECODE: 
        casez(op)
          6'b000000:  nextstate <= EXECUTE;       // RTYPE
          6'b10????:  nextstate <= MEMADR;        // LW or SW
          6'b000100:  nextstate <= BRANCH;        // BEQ
          6'b001000:  nextstate <= ADDIEXECUTE;   // ADDI
          6'b000010:  nextstate <= JUMP;          // JUMP
			 default:	 nextstate <= FETCH;
        endcase
      MEMADR:
        if (op == 6'b100011) nextstate <= MEMREAD;       //LW
        else if (op == 6'b101011) nextstate <= MEMWRITE; //SW
      MEMREAD:        nextstate <= MEMWRITEBACK;
      MEMWRITE:       nextstate <= FETCH;
      MEMWRITEBACK:   nextstate <= FETCH;
      EXECUTE:        nextstate <= ALUWRITEBACK;
      ALUWRITEBACK:   nextstate <= FETCH;
      BRANCH:         nextstate <= FETCH;
      ADDIEXECUTE:    nextstate <= ADDIWRITEBACK;
      ADDIWRITEBACK:  nextstate <= FETCH;        
      JUMP:           nextstate <= FETCH; 
		default:			 nextstate <= FETCH;
  endcase
  
  always_comb
    case(state)
      FETCH:          controls <= 15'b0_0_0_0_01_0_0_00_1_0_1_00;
      DECODE:         controls <= 15'b0_0_0_0_11_0_0_00_0_0_0_00;
      MEMADR:         controls <= 15'b0_0_0_1_10_0_0_00_0_0_0_00;
      MEMREAD:        controls <= 15'b0_0_0_0_00_0_0_00_0_1_0_00;
      MEMWRITE:       controls <= 15'b0_1_0_0_00_0_0_00_0_1_0_00;
      MEMWRITEBACK:   controls <= 15'b1_0_0_0_00_0_1_00_0_0_0_00;
      EXECUTE:        controls <= 15'b0_0_0_1_00_0_0_00_0_0_0_10;
      ALUWRITEBACK:   controls <= 15'b0_0_0_0_00_1_1_00_0_0_0_00;
      BRANCH:         controls <= 15'b0_0_1_1_00_0_0_01_0_0_0_01;
      ADDIEXECUTE:    controls <= 15'b0_0_0_1_10_0_0_00_0_0_0_00;
      ADDIWRITEBACK:  controls <= 15'b0_0_0_0_00_0_1_00_0_0_0_00;  
      JUMP:           controls <= 15'b0_0_0_0_00_0_0_10_1_0_0_00;  
	   default: 		 controls <= 15'b0_0_0_0_01_0_0_01_1_0_0_00;       
  endcase
endmodule

