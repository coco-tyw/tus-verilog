module C1KGenB(
    input RST,
    input CK,
    output C1K
  );
  reg c1kd;
  reg c1kq;
  reg [15:0] ctd;
  reg [15:0] ctq;

  always @(c1kq or ctq) begin
    if(ctq < 16'd49999) begin
      c1kd = c1kq;
      ctd = ctq + 16'd1;
    end else begin
      c1kd = ~c1kq;
      ctd = 16'd0000;
    end
  end
  always @(posedge CK or negedge RST) begin
    if (RST == 1'b0) begin
      c1kq = 1'b0;
      ctq = 16'd0000;
    end else begin
      c1kq = c1kd;
      ctq = ctd;
    end
  end

  assign C1K = c1kq;
endmodule
