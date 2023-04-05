module decoder(sign, regi, expo, frac, allone, allzero, in);
input [15:0] in;

output reg [4:0] regi;
output expo;
output [11:0] frac;
output reg allone, allzero;
output sign;

assign sign = in[15];

wire [14:0] twos_in;
reg [15:0] lod_in; //input of LOD
wire [3:0] k;
wire [4:0] k0;
wire vld;

assign k0[4] = 0;
assign k0[3:0] = k; //LOD's output

twoscom t0(twos_in, in);

always @(twos_in)
case (twos_in[14])
	1'b0: begin 
		lod_in[15:1] = twos_in;
		lod_in[0] = 1'b1; //k=1111 when all 0
	      end
	1'b1: begin 
		lod_in[15:1] = ~twos_in;
		lod_in[0] = 1'b1; //k=1111 when all 1
	      end
endcase

LOD16 l0(vld, k, lod_in);

always @(twos_in[14], k0)//Pos or neg for regime
case (twos_in[14])
	1'b0: regi = ~(k0-1);
	1'b1: regi = k0-1;
endcase

shift s0(expo, frac, twos_in, k);

always @(twos_in[14],k)
case ({twos_in[14],k})
	6'b01111: begin
		allone = 0;
		allzero = 1;
		end
	6'b11111: begin
		allone = 1;
		allzero = 0;
		end
	default: begin
		allone = 0;
		allzero = 0;
		end
endcase

endmodule
