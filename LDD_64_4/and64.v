module and64(out, in);
input [63:0] in;
output [62:0] out; //out[i]: i+2 and

wire [61:0] w;

genvar i;

and32 a0(w[30:0], in[31:0]);
and32 a1(w[61:31], in[63:32]);

assign out[30:0] = w[30:0];
assign out[31] = out[30] & in[32];
for (i = 32; i < 63; i = i + 1) begin
	assign out[i] = w[30] & w[i-1];
end

endmodule
