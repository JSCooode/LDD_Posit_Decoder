module shift(expo, frac, xin, k);
input [6:0] xin;
input [2:0] k;

output expo;
output [3:0] frac;

wire [6:0] sh0;

left_shifter s0(sh0, xin, k);

assign expo = sh0[6];

assign frac = sh0[5:2];

endmodule
