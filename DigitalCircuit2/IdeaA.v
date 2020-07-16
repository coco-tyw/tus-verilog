`include "libs/D_FF.v"
`include "libs/Switching.v"

module IdeaA(
    input RST,
    input C1K,
    input CE,
    output [3:0] VAL,
    output [3:0] LOG_LOGIC,
    output [3:0] LOG_SWITCHING
  );
  wire [3:0] db;
  wire [3:0] d;
  wire [3:0] q;
  reg [3:0] IdeaA_reg;

  /** 状態推移回路 **/
  assign db[3] = (~IdeaA_reg[1] & IdeaA_reg[0]) | 
                 (IdeaA_reg[3] & IdeaA_reg[1]) | 
                 (IdeaA_reg[3] & IdeaA_reg[2]) ;
                 
  assign db[2] = (~IdeaA_reg[2] & ~IdeaA_reg[1] & ~IdeaA_reg[0]) |
                 (IdeaA_reg[2] & IdeaA_reg[0]) |
                 (IdeaA_reg[2] & IdeaA_reg[1]) ;

  assign db[1] = (~IdeaA_reg[1] & ~IdeaA_reg[0]) |
                 (IdeaA_reg[1] & IdeaA_reg[0]) | 
                 (~IdeaA_reg[3] & IdeaA_reg[0]) ;

  assign db[0] = (~IdeaA_reg[1] & ~IdeaA_reg[0]) |
                 (IdeaA_reg[1] & ~IdeaA_reg[0]) ;
  /** 状態推移回路 **/

  Switching switching(.CE(CE), .IN_1(IdeaA_reg), .IN_2(db), .OUT(d));
  D_FF d_ff(.RST(RST), .CLK(C1K), .IN(d), .OUT(q));

  always @(q) begin
    IdeaA_reg = q;
  end

  assign LOG_LOGIC = db;
  assign LOG_SWITCHING = d;
  assign VAL = q;
endmodule // IdeaA
