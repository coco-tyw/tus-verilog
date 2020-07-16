module KeyOnDetB(
    input RST,
    input C1K,
    input BTN,
    output DET
  );
  reg KeyD;
  reg KeyQ;
  reg [5:0] CtQ;
  reg [5:0] CtD;

  always @(BTN or CtQ or KeyQ) begin
    if(BTN == 1) begin
      if(CtQ > 6'd50) CtD = 6'h3F;
      else CtD = CtQ + 6'd01;
    end else begin
      CtD = 6'd00;
    end
  end
  always @(posedge C1K or negedge RST) begin
    if(RST == 0) CtQ = 6'd00;
    else CtQ = CtD;
  end
  
  assign DET = (CtQ == 6'd50) & BTN;
endmodule
