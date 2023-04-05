module twoscom(out, in);
input [31:0] in;
output reg [30:0] out;

always @(in)
case (in[31])
	1'b0: out = in[30:0];
	1'b1: out = ~in[30:0]+1'b1;
endcase

endmodule
