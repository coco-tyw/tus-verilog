`include "libs/D_FF.v"
`include "libs/Switching.v"

module IdeaC(
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
  reg [3:0] IdeaC_reg;

  initial begin
    IdeaC_reg = IN;
  end

  /** 状態推移回路 **/
  assign db = IdeaC_reg == 4'b0101 ? 4'b1110 : 
              (IdeaC_reg > 4'b0101 && IdeaC_reg <= 4'b1110) ? IdeaC_reg - 1 : 4'b0101;
  /** 状態推移回路 **/

  Switching switching(.CE(CE), .IN_1(IdeaC_reg), .IN_2(db), .OUT(d));
  D_FF d_ff(.RST(RST), .CLK(CLK), .IN(d), .OUT(q));

  always @(q) begin
    IdeaC_reg = q;
  end

  assign OUT_LOGIC = db;
  assign OUT_SWITCHING = d;
  assign OUT = q;
endmodule // IdeaC

