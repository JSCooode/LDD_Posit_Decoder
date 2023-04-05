module LDD(out, allone, allzero, in);
parameter n = 64;

input [n-2:0] in;
output [n-3:0] out;
output allone, allzero;

wire [n-3:0] diff, invdif; //'0' if diff
wire [n-3:0] ndiff;
wire [n-4:0] en, inven; //'0' if disable
wire [1:0] no;//not in use

genvar i;

for (i = 0; i < n-2; i = i + 1) begin
	assign invdif[i] = diff[n-3-i];
end

for (i = 0; i < n-3; i = i + 1) begin
	assign en[i] = inven[n-4-i];
end

for (i = 0; i < n-2; i = i + 1) begin
	xor(ndiff[i],in[i],in[i+1]);
	assign diff[i] = ~ndiff[i];
end


and64 a0({no,inven[n-4:0]},{2'b11,invdif[n-3:0]});

assign out[n-3] = ndiff[n-3];
and(out[n-4], diff[n-3], ndiff[n-4]);
for (i = 0; i < n-4; i = i + 1) begin
	and(out[i], en[i+1], ndiff[i]);
end

and(allone, en[0], in[n-2]);
and(allzero, en[0], ~in[n-2]);

endmodule
