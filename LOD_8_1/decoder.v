module decoder(sign, regi, expo, frac, allone, allzero, in);
input [7:0] in;

output reg [3:0] regi;
output expo;
output [3:0] frac;
output reg allone, allzero;
output sign;

assign sign = in[7];

wire [6:0] twos_in;
reg [7:0] lod_in; //input of LOD
wire [2:0] k;
wire [3:0] k0;
wire vld;

assign k0[3] = 0;
assign k0[2:0] = k; //LOD's output

twoscom t0(twos_in, in);

always @(twos_in)
case (twos_in[7])
	1'b0: begin 
		lod_in[7:1] = twos_in;
		lod_in[0] = 1'b1; //k=1111 when all 0
	      end
	1'b1: begin 
		lod_in[7:1] = ~twos_in;
		lod_in[0] = 1'b1; //k=1111 when all 1
	      end
endcase

LOD8 l0(vld, k, lod_in);

always @(twos_in[6], k0)//Pos or neg for regime
case (twos_in[6])
	1'b0: regi = ~(k0-1);
	1'b1: regi = k0-1;
endcase

shift s0(expo, frac, twos_in, k);

always @(twos_in[6],k)
case ({twos_in[6],k})
	4'b0111: begin
		allone = 0;
		allzero = 1;
		end
	4'b1111: begin
		allone = 1;
		allzero = 0;
		end
	default: begin
		allone = 0;
		allzero = 0;
		end
endcase

endmodule
