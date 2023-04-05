module decoder(sign, regi, expo, frac, allone, allzero, in);
input [31:0] in;

output [5:0] regi;
output [2:0] expo;
output [25:0] frac;
output allone, allzero, sign;

wire [30:0] twos_in;
wire [29:0] ldd;

assign sign = in[31];
twoscom t0(twos_in, in);
LDD l0(ldd, allone, allzero, twos_in);
LDDShifter s0(regi, expo, frac, ldd, allone, twos_in);

endmodule
