module and4(out, in);
input [3:0] in;
output [2:0] out; //out[i]: i+2 and

wire w;

assign out[0] = in[0] & in[1];
assign out[1] = out[0] & in[2];
assign w = in[2] & in[3];
assign out[2] = out[0] & w;

endmodule
