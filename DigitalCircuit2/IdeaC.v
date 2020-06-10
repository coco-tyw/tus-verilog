module IdeaC(
  input RST,
  input C1K,
  input CE,
  output [3:0] VAL
);
wire [3:0] DB;
wire [3:0] D;
reg [3:0] Q;


// 論理回路
assign DB[3] = ();
assign DB[2] = ();
assign DB[1] = ();
assign DB[0] = ();

// 切替回路
assign D[3] = ();
assign D[2] = ();
assign D[1] = ();
assign D[0] = ();

// D-FF
always @(posedge C1K or negedge RST) begin
  if (RST == 0)
    Q = 4'h0;
  else 
    Q =D;
  end
end

// 出力
assign VAL = Q;

endmodule // IdeaC
