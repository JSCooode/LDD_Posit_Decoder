module twoscom(out, in);
parameter n = 64;

input [n-1:0] in;
output reg [n-2:0] out;

always @(in)
case (in[n-1])
	1'b0: out = in[n-2:0];
	1'b1: out = ~in[n-2:0]+1'b1;
endcase

endmodule
