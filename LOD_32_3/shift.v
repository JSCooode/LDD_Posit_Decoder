module shift(expo, frac, xin, k);
input [30:0] xin;
input [4:0] k;

output reg [2:0] expo;
output [25:0] frac;

wire [30:0] sh0;

left_shifter s0(sh0, xin, k);

always @(xin, sh0, k) begin
if (k < 28)
	expo = sh0[30:28];
else if (k == 28) begin
	expo[2] = 0;
	expo[1:0] = sh0[30:29];
	end
else if (k == 29) begin
	expo[2:1] = 0;
	expo[0] = sh0[30];
	end
else
	expo = 0;
end

assign frac = sh0[27:2];

endmodule
