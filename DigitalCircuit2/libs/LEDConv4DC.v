module LEDConv4DC(
    input RST,
    input C1K,
    input [3:0] ValA,
    input [3:0] ValB,
    input [3:0] ValC,
    input [3:0] ValD,
    input [6:0] CharA,
    input [6:0] CharB,
    input [6:0] CharC,
    input [6:0] CharD,
    input [3:0] Cntrl,
    input [3:0] Brank,
    input [3:0] DPI,
    output [3:0] AN,
    output [6:0] C,
    output DPO
  );
  wire [1:0] DigA;
  wire DigE;
  reg [3:0] Val;
  reg [6:0] Char;
  reg Brankc;
  reg Cont;
  reg DPY;
  reg [1:0] D4;
  reg [1:0] D3;
  reg [1:0] Q4;
  reg [1:0] Q3;
  reg [6:0] seg;

  always @(Q4 or Q3) begin
    if(Q3 >= 2'd2) begin
      D4 = (Q4 - 2'd1) & 2'b11;
      D3 = 2'd0;
    end else begin
      D4 = Q4;
      D3 = Q3 + 2'd1;
    end
  end
  always @(posedge C1K or negedge RST) begin
    if(RST == 0) begin
      Q4 = 2'd3;
      Q3 = 2'd3;
    end else begin
      Q4 = D4;
      Q3 = D3;
    end
  end
  assign DigA = Q4;
  assign DigE = ((Q3 == 2'd0) & C1K) | (Q3 == 2'd3);

  assign AN[3]= ~( DigA[1] & DigA[0]) | DigE;
  assign AN[2]= ~( DigA[1] & ~DigA[0]) | DigE;
  assign AN[1]= ~(~DigA[1] & DigA[0]) | DigE;
  assign AN[0]= ~(~DigA[1] & ~DigA[0]) | DigE;

  always @(DigA or ValA or ValB or ValC or ValD) begin
    case (DigA)
      2'd3: Val = ValA;
      2'd2: Val = ValB;
      2'd1: Val = ValC;
      default: Val = ValD;
    endcase
  end

  always @(DigA or CharA or CharB or CharC or CharD) begin
    case (DigA)
      2'd3: Char = CharA;
      2'd2: Char = CharB;
      2'd1: Char = CharC;
      default: Char = CharD;
    endcase
  end

  always @(DigA or Cntrl) begin
    case (DigA)
      2'd3: Cont = Cntrl[3];
      2'd2: Cont = Cntrl[2];
      2'd1: Cont = Cntrl[1];
      default: Cont = Cntrl[0];
    endcase
  end

  always @(DigA or Brank) begin
    case (DigA)
      2'd3: Brankc = Brank[3];
      2'd2: Brankc = Brank[2];
      2'd1: Brankc = Brank[1];
      default: Brankc = Brank[0];
    endcase
  end

  always @(DigA or DPI) begin
    case (DigA)
      2'd3: DPY = DPI[3];
      2'd2: DPY = DPI[2];
      2'd1: DPY = DPI[1];
      default: DPY = DPI[0];
    endcase
  end
  always @(Val) begin
    case (Val)
      4'h0: seg = 7'b0000001;
      4'h1: seg = 7'b1001111;
      4'h2: seg = 7'b0010010;
      4'h3: seg = 7'b0000110;
      4'h4: seg = 7'b1001100;
      4'h5: seg = 7'b0100100;
      4'h6: seg = 7'b0100000;
      4'h7: seg = 7'b0001111;
      4'h8: seg = 7'b0000000;
      4'h9: seg = 7'b0000100;
      4'ha: seg = 7'b0001000;
      4'hb: seg = 7'b1100000;
      4'hc: seg = 7'b1110010;
      4'hd: seg = 7'b1000010;
      4'he: seg = 7'b0110000;
      default:seg= 7'b0111000;
    endcase
  end

  assign C[6] = Brankc | ~Cont & seg[6] | Cont & Char[6];
  assign C[5] = Brankc | ~Cont & seg[5] | Cont & Char[5];
  assign C[4] = Brankc | ~Cont & seg[4] | Cont & Char[4];
  assign C[3] = Brankc | ~Cont & seg[3] | Cont & Char[3];
  assign C[2] = Brankc | ~Cont & seg[2] | Cont & Char[2];
  assign C[1] = Brankc | ~Cont & seg[1] | Cont & Char[1];
  assign C[0] = Brankc | ~Cont & seg[0] | Cont & Char[0];

  assign DPO = DPY;
endmodule
