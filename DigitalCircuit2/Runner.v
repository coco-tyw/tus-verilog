`include "IdeaA.v"

module Runner();
  reg CLK, RST, CE;
  reg[7:0] TIME;
  wire [3:0] result;
  wire [3:0] result_logic;
  wire [3:0] result_switching;

  IdeaA ideaA(.CLK(CLK), .RST(RST), .CE(CE), .IN(4'b1110),
              .OUT(result), .OUT_LOGIC(result_logic), .OUT_SWITCHING(result_switching));

  initial begin
    CLK = 0;
    TIME = 0;
    CE = 0;
    RST = 1;
    $write("[%t] counter: %b\n", $time, result);
    forever #1 begin
      TIME += 1;
      CLK = ~CLK;
      if (TIME%6 == 2 || TIME%6 === 4) begin
        CE = ~CE;
      end
    end
  end
  initial begin
    #127 $finish();
  end
  always @(posedge CLK) begin
    $write("[%t] counter: %b\n", $time, result);
  end
  initial begin
      $dumpfile("IdeaA.vcd");
      $dumpvars(0, CLK);
      $dumpvars(0, CE);
      $dumpvars(0, result);
      $dumpvars(0, result_logic);
      $dumpvars(0, result_switching);
  end
endmodule // Runner
