`include "libs/D_FF.v"
`include "libs/Switching.v"

module IdeaA(
    input RST,
    input CLK,
    input CE,
    input [3:0]IN,
    output [3:0] OUT,
    output [3:0] OUT_LOGIC,
    output [3:0] OUT_SWITCHING
  );
  wire [3:0] db;
  wire [3:0] d;
  wire [3:0] q;
  reg [3:0] IdeaA_reg;

  initial begin
    IdeaA_reg = IN;
  end

  assign db[3] = (~IdeaA_reg[1] & IdeaA_reg[0]) | (IdeaA_reg[3] & IdeaA_reg[1]) | (IdeaA_reg[3] & IdeaA_reg[2]);
  assign db[2] = (~IdeaA_reg[2] & ~IdeaA_reg[1] & ~IdeaA_reg[0]) | (IdeaA_reg[2] & IdeaA_reg[0]) | (IdeaA_reg[2] & IdeaA_reg[1]);
  assign db[1] = (~IdeaA_reg[1] & ~IdeaA_reg[0]) | (IdeaA_reg[1] & IdeaA_reg[0]) | (~IdeaA_reg[3] & IdeaA_reg[0]);
  assign db[0] = (~IdeaA_reg[1] & ~IdeaA_reg[0]) | (IdeaA_reg[1] & ~IdeaA_reg[0]);

  Switching switching(.CE(CE), .IN_1(IdeaA_reg), .IN_2(db), .OUT(d));
  D_FF d_ff(.RST(RST), .CLK(CLK), .IN(d), .OUT(q));

  always @(q) begin
    IdeaA_reg = q;
  end

  assign OUT_LOGIC = db;
  assign OUT_SWITCHING = d;
  assign OUT = q;
endmodule // IdeaA
