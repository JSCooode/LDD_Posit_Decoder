module LOD32(k, in);
input [31:0] in;
output reg [4:0] k;
//output vld;

wire [3:0] k1, k0; 
wire v1, v0;

LOD16 L0(v0, k0, in[15:0]);
LOD16 L1(v1, k1, in[31:16]);

//or (vld, v0, v1);

always @(v1, k0, k1)
case (v1)
	1'b0: begin
		k[4] = 1;
		k[3:0] = k0;
	      end
	1'b1: begin
		k[4] = 0;
		k[3:0] = k1;
	      end
endcase

endmodule
