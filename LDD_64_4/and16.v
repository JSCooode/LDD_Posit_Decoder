module and16(out, in);
input [15:0] in;
output [14:0] out; //out[i]: i+2 and

wire [13:0] w;

genvar i;

and8 a0(w[6:0], in[7:0]);
and8 a1(w[13:7], in[15:8]);

assign out[6:0] = w[6:0];
assign out[7] = out[6] & in[8];
for (i = 8; i < 15; i = i + 1) begin
	assign out[i] = w[6] & w[i-1];
end

endmodule
