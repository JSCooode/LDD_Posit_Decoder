module shift(expo, frac, xin, k);
input [14:0] xin;
input [3:0] k;

output expo;
output [11:0] frac;

wire [14:0] sh0;

left_shifter s0(sh0, xin, k);

assign expo = sh0[14];

assign frac = sh0[13:2];

endmodule
