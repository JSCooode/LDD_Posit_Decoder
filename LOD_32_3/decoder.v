module decoder(sign, regi, expo, frac, allone, allzero, in);
input [31:0] in;

output reg [5:0] regi;
output [2:0] expo;
output [25:0] frac;
output reg allone, allzero;
output sign;

assign sign = in[31];

wire [30:0] twos_in;
reg [31:0] lod_in; //input of LOD
wire [4:0] k;
wire [5:0] k0;

assign k0[5] = 0;
assign k0[4:0] = k;

twoscom t0(twos_in, in);

always @(twos_in)
case (twos_in[30])
	1'b0: begin 
		lod_in[31:1] = twos_in;
		lod_in[0] = 1'b1; //k=11111 when all 0
	      end
	1'b1: begin 
		lod_in[31:1] = ~twos_in;
		lod_in[0] = 1'b1; //k=11111 when all 1
	      end
endcase

LOD32 l0(k, lod_in);

always @(twos_in[30], k0)//Pos or neg for regime
case (twos_in[30])
	1'b0: regi = ~(k0-1);
	1'b1: regi = k0-1;
endcase

shift s0(expo, frac, twos_in, k);

always @(twos_in[30],k)
case ({twos_in[30],k})
	6'b011111: begin
		allone = 0;
		allzero = 1;
		end
	6'b111111: begin
		allone = 1;
		allzero = 0;
		end
	default: begin
		allone = 0;
		allzero = 0;
		end
endcase

endmodule
