module LOD8(vld, k, in);
input [7:0] in;
output reg [2:0] k;
output vld;

wire [1:0] k1, k0; 
wire v1, v0;

LOD4 L0(v0, k0, in[3:0]);
LOD4 L1(v1, k1, in[7:4]);

or (vld, v0, v1);

always @(v1, k0, k1)
case (v1)
	1'b0: begin
		k[2] = 1;
		k[1:0] = k0;
	      end
	1'b1: begin
		k[2] = 0;
		k[1:0] = k1;
	      end
endcase

endmodule
