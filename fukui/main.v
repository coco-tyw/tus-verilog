module GenComp4D();

  reg CLK;
	//inputs
	reg [3:0] Q1000;
	reg [3:0] Q0100;
	reg [3:0] Q0010;
	reg [3:0] Q0001;
	reg [3:0] V1000;
	reg [3:0] V0100;
	reg [3:0] V0010;
	reg [3:0] V0001;

	//outputs
	wire EQU;

	//wire
	wire [13:0] HEXQ;
	wire [13:0] HEXV;

	//i
	integer i1000;
	integer i0100;
	integer i0010;
	integer i0001;

  assign HEXQ = 14'd1000 * Q1000 + 14'd0100 * Q0100 + 14'd0010 * Q0010 + Q0001;
  assign HEXV = 14'd1000 * V1000 + 14'd0100 * V0100 + 14'd0010 * V0010 + V0001;
  assign EQU = (HEXV <= HEXQ);

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
    forever #1000000 begin
      CLK = ~CLK;
    end
  end

  always begin: exit
    if (EQU == 1) begin
      Q1000 = 4'd0000;
      Q0100 = 4'd0000;
      Q0010 = 4'd0000;
      Q0001 = 4'd0000;
    end else begin
      for (i1000=0 ; i1000<2 ; i1000=i1000+1) begin
        for (i0100=0 ; i0100<=9 ; i0100=i0100+1) begin
          for( i0010=0 ; i0010<=9 ; i0010=i0010+1) begin
            for (i0001=0 ; i0001<=9 ; i0001=i0001+1) begin
              Q0001 = Q0001 + 4'd0001;
              #1000000;
              if (EQU == 1) disable exit;
            end
            if (EQU == 1) disable exit;
            Q0001 = 0;
            Q0010 = Q0010 + 4'd0010;
            #1000000;
            if (EQU == 1) disable exit;
          end
          if (EQU == 1) disable exit;
          Q0010 = 0;
          Q0100 = Q0100 + 4'd0100;
          #1000000;
          if (EQU == 1) disable exit;
        end
        if (EQU == 1) disable exit;
        Q0100 = 0;
        Q1000 = Q1000 + 4'd1000;
        #1000000;
        if (EQU == 1) disable exit;
      end
    end
  end

  initial begin
      $dumpfile("Main.vcd");
      $dumpvars(0, CLK);
      $dumpvars(0, EQU);
  end

endmodule

