module Switching(
    input CE,
    input [3:0] IN_1, // CE = 0
    input [3:0] IN_2, // C E= 1
    output [3:0] OUT
  );
  wire [3:0] Swiching_wire;

  assign Swiching_wire[3] = CE & IN_2[3] | ~CE & IN_1[3];
  assign Swiching_wire[2] = CE & IN_2[2] | ~CE & IN_1[2];
  assign Swiching_wire[1] = CE & IN_2[1] | ~CE & IN_1[1];
  assign Swiching_wire[0] = CE & IN_2[0] | ~CE & IN_1[0];

  assign OUT = Swiching_wire;

endmodule // Switching
