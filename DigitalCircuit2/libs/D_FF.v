module D_FF(
    input RST,
    input CLK,
    input [3:0] IN,
    output [3:0] OUT
  );
  reg [3:0] D_FF_reg;

  always @(posedge CLK or negedge RST) begin
    if (RST == 0) D_FF_reg = 4'h0;
    else D_FF_reg = IN;
  end

  assign OUT = D_FF_reg;

endmodule // D_FF
