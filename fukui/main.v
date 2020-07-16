module GenComp4D(
	input [3:0] Q1000,
	input [3:0] Q0100,
	input [3:0] Q0010,
	input [3:0] Q0001,
	input [3:0] V1000,
	input [3:0] V0100,
	input [3:0] V0010,
	input [3:0] V0001,
	output EQU
);
	wire [13:0] HEXQ;
	wire [13:0] HEXV;

  assign HEXQ = 14'd1000 * Q1000 + 14'd0100 * Q0100 + 14'd0010 * Q0010 + Q0001;
  assign HEXV = 14'd1000 * V1000 + 14'd0100 * V0100 + 14'd0010 * V0010 + V0001;
  assign EQU = (HEXV <= HEXQ);

endmodule


module Runner();
	integer i;
  reg CLK;

	reg [3:0] Q1000;
	reg [3:0] Q0100;
	reg [3:0] Q0010;
	reg [3:0] Q0001;
	reg [3:0] V1000;
	reg [3:0] V0100;
	reg [3:0] V0010;
	reg [3:0] V0001;
  wire EQU;
  
  GenComp4D genComp4D(.Q1000(Q1000), .Q0100(Q0100), .Q0010(Q0010), .Q0001(Q0001),
                      .V1000(V1000), .V0100(V0100), .V0010(V0010), .V0001(V0001), .EQU(EQU));

  initial begin
    CLK = 0;
    V1000 = 1;
    V0100 = 2;
    V0010 = 3;
    V0001 = 4;
    Q1000 = 0;
    Q0100 = 0;
    Q0010 = 0;
    Q0001 = 0;
    forever #1 begin
      CLK = ~CLK;
    end
  end

  initial begin
    #2000 $finish();
  end

  initial begin
    $dumpfile("Main.vcd");
    $dumpvars(0, CLK);
    $dumpvars(0, Q1000);
    $dumpvars(0, Q0100);
    $dumpvars(0, Q0010);
    $dumpvars(0, Q0001);
    $dumpvars(0, V1000);
    $dumpvars(0, V0100);
    $dumpvars(0, V0010);
    $dumpvars(0, V0001);
    $dumpvars(0, EQU);
  end

  always begin
    i = 0;
    Q1000 = 4'd0;
    Q0100 = 4'd0;
    Q0010 = 4'd0;
    Q0001 = 4'd0;
    while (~EQU) begin
      Q0001 = i%10;
      Q0010 = (i%100-Q0001)/10;
      Q0100 = (i%1000-Q0010-Q0001)/100;
      Q1000 = (i-Q0100-Q0010-Q0001)/1000;
      $write("[%t] Q: %d%d%d%d\n", $time, Q1000, Q0100, Q0010, Q0001);
      // $write("[%t] EQU: %b\n", $time, EQU);
      i += 1;
      #1;
    end
  end
endmodule
