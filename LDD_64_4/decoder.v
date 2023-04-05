module decoder(sign, regi, expo, frac, allone, allzero, in);
parameter n = 64;
parameter es = 4;
parameter rs = 7;//size of regi
parameter fs = n-es-3;//size of frac
parameter ls = n-2;//size of ldd

input [n-1:0] in;

output [rs-1:0] regi;
output [es-1:0] expo;
output [fs-1:0] frac;
output allone, allzero, sign;

wire [n-2:0] twos_in;
wire [ls-1:0] ldd;

assign sign = in[n-1];
twoscom t0(twos_in, in);
LDD l0(ldd, allone, allzero, twos_in);
LDDShifter s0(regi, expo, frac, ldd, allone, twos_in);

endmodule
