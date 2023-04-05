module and8(out, in);
input [7:0] in;
output [6:0] out; //out[i]: i+2 and

wire [5:0] w;

genvar i;

and4 a0(w[2:0], in[3:0]);
and4 a1(w[5:3], in[7:4]);

assign out[2:0] = w[2:0];
assign out[3] = out[2] & in[4];
for (i = 4; i < 7; i = i + 1) begin
	assign out[i] = w[2] & w[i-1];
end

endmodule
