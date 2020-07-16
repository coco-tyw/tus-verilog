`include "libs/D_FF.v"
`include "libs/Switching.v"

module IdeaB(
    input RST,
    input CLK,
    input CE,
    input [3:0]IN,
    output [3:0] VAL,
    output [3:0] LOG_LOGIC,
    output [3:0] LOG_SWITCHING
  );
  wire [3:0] db;
  wire [3:0] d;
  wire [3:0] q;
  reg [3:0] IdeaB_reg;

  initial begin
    IdeaB_reg = IN;
  end

  /** 状態推移回路 **/
  assign db = IdeaB_reg == 4'b0101 ? 4'b1110 : IdeaB_reg - 1;
  /** 状態推移回路 **/

  Switching switching(.CE(CE), .IN_1(IdeaB_reg), .IN_2(db), .OUT(d));
  D_FF d_ff(.RST(RST), .CLK(CLK), .IN(d), .OUT(q));

  always @(q) begin
    IdeaB_reg = q;
  end

  assign LOG_LOGIC = db;
  assign LOG_SWITCHING = d;
  assign VAL = q;
endmodule // IdeaB
