module and32(out, in);
input [31:0] in;
output [30:0] out; //out[i]: i+2 and

wire [29:0] w;

genvar i;

and16 a0(w[14:0], in[15:0]);
and16 a1(w[29:15], in[31:16]);

assign out[14:0] = w[14:0];
assign out[15] = out[14] & in[16];
for (i = 16; i < 31; i = i + 1) begin
	assign out[i] = w[14] & w[i-1];
end

endmodule
