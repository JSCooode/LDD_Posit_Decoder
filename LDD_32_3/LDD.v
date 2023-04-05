module LDD(out, allone, allzero, in);
input [30:0] in;
output [29:0] out;
output allone, allzero;

wire [29:0] diff, invdif; //'0' if diff
wire [29:0] ndiff;
wire [28:0] en, inven; //'0' if disable
wire [1:0] no;//not in use

genvar i;

for (i = 0; i < 30; i = i + 1) begin
	assign invdif[i] = diff[29-i];
end

for (i = 0; i < 29; i = i + 1) begin
	assign en[i] = inven[28-i];
end

for (i = 0; i < 30; i = i + 1) begin
	xor(ndiff[i],in[i],in[i+1]);
	assign diff[i] = ~ndiff[i];
end

and32 a0({no,inven[28:0]},{2'b11,invdif[29:0]});

assign out[29] = ndiff[29];
and(out[28], diff[29], ndiff[28]);
for (i = 0; i < 28; i = i + 1) begin
	and(out[i], en[i+1], ndiff[i]);
end

and(allone, en[0], in[30]);
and(allzero, en[0], ~in[30]);

endmodule
