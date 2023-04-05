module shift(expo, frac, xin, k);
input [62:0] xin;
input [5:0] k;

output reg [3:0] expo;
output [56:0] frac;

wire [62:0] sh0;

left_shifter s0(sh0, xin, k);

always @(xin, sh0, k) begin
if (k < 59)
	expo = sh0[62:59];
else if (k == 59) begin
	expo[3] = 0;
	expo[2:0] = sh0[62:60];
	end
else if (k == 60) begin
	expo[3:2] = 0;
	expo[1:0] = sh0[62:61];
	end
else if (k == 61) begin
	expo[3:1] = 0;
	expo[0] = sh0[62];
	end

else
	expo = 0;
end

assign frac = sh0[58:2];

endmodule
