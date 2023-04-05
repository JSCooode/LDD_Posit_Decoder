module LOD16(vld, k, in);
input [15:0] in;
output reg [3:0] k;
output vld;

wire [2:0] k1, k0; 
wire v1, v0;

LOD8 L0(v0, k0, in[7:0]);
LOD8 L1(v1, k1, in[15:8]);

or (vld, v0, v1);

always @(v1, k0, k1)
case (v1)
	1'b0: begin
		k[3] = 1;
		k[2:0] = k0;
	      end
	1'b1: begin
		k[3] = 0;
		k[2:0] = k1;
	      end
endcase

endmodule
