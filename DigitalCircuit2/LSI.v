`include "IdeaA.v"
`include "IdeaB.v"
`include "libs/C1KGenB.v"
`include "libs/KeyOnDetB.v"
`include "libs/LEDConv4DC.v"

module Count10LSI(
    input CK,
    input BTNL,
    input BTNR,
    input BTND,
    output [3:0] AN,
    output [6:0] C,
    output DPO
  );
  wire RST;
  wire C1K;
  wire KDA;
  wire KDB;
  wire [3:0] VALA;
  wire [3:0] VALC;
  assign RST= ~BTND;

  C1KGenB C1KG (.RST(RST), .CK(CK), .C1K(C1K));

  KeyOnDetB KBL (.RST(RST), .C1K(C1K), .BTN(BTNL), .DET(KDA));
  KeyOnDetB KBR (.RST(RST), .C1K(C1K), .BTN(BTNR), .DET(KDB));

  IdeaA CIA (.RST(RST), .C1K(C1K), .CE(KDA), .VAL(VALA));
  IdeaB CIB (.RST(RST), .C1K(C1K), .CE(KDB), .VAL(VALC));

  LEDConv4DC DISP4D (.RST(RST), .C1K(C1K),
                     .ValA(VALA), .ValB(4'h0), .ValC(VALC), .ValD(4'h0),
                     .CharA(7'h7F), .CharB(7'h7F), .CharC(7'h7F), .CharD(7'h7F),
                     .Cntrl(4'b0000), .Brank(4'b0101), .DPI(4'b1111),
                     .AN(AN), .C(C), .DPO(DPO));
endmodule
