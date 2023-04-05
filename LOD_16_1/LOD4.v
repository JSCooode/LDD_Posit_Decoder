module LOD4(vld, k, in);
input [3:0] in;
output reg [1:0] k;
output vld;

wire k1, k0, v1, v0;

LOD2 L0(v0, k0, in[1:0]);
LOD2 L1(v1, k1, in[3:2]);

or (vld, v0, v1);

always @(v1, k0, k1)
case (v1)
	1'b0: begin
		k[1] = 1;
		k[0] = k0;
	      end
	1'b1: begin
		k[1] = 0;
		k[0] = k1;
	      end
endcase

endmodule
