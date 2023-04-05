module LOD64(k, in);
input [63:0] in;
output reg [5:0] k;
//output vld;

wire [4:0] k1, k0; 
wire v1, v0;

LOD32 L0(v0, k0, in[31:0]);
LOD32 L1(v1, k1, in[63:32]);

//or (vld, v0, v1);

always @(v1, k0, k1)
case (v1)
	1'b0: begin
		k[5] = 1;
		k[4:0] = k0;
	      end
	1'b1: begin
		k[5] = 0;
		k[4:0] = k1;
	      end
endcase

endmodule
