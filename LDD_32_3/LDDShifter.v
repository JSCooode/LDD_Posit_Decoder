module LDDShifter(regi, expo, frac, ldd, allone, in);
parameter n = 32;
parameter es = 3;
parameter rs = 6;//size of regi

input [29:0] ldd;
input [30:0] in;
input allone;

output reg [5:0] regi;
output [2:0] expo;
output [25:0] frac;

wire [1049:0] temp; 
wire [5:0] oneRe, oneReTemp;
assign oneReTemp = 30;
//total output size: 6+3+26=35; ldd: 30, total:35*30=1050
//regi[i] under ldd[j]: temp[j*6+i+870]
//regi[i] under allone: oneRe[i]
//expo[i] under ldd[j]: temp[j*3+i+780]
//frac[i] under ldd[j]: temp[j*26+i]
wire [1049:0] outtemp;
//regi[i] under ldd[j]: outtemp[j+i*30+870]
//expo[i] under ldd[j]: outtemp[j+i*30+780]
//frac[i] under ldd[j]: outtemp[j+i*30]
wire [54:0] fractemp;
assign fractemp = {in[25:0],29'b00000000000000000000000000000};

wire [5:0] tempregi;

genvar i,j;

//regi: check absolute value first, do bit inverse (~) to get negative at the output stage
for (i = 0; i < 30; i = i + 1) begin//under ldd[i]
	assign temp[i*6+875:i*6+870] = 29-i;
end

//expo:
for (i = 3; i < 30; i = i+1) begin
	assign temp[i*3+782:i*3+780] = in[i-1:i-3];
end
assign temp[788:786] = {1'b0, in[1:0]};//ldd[2]
assign temp[785:783] = {2'b00, in[0]};//ldd[1]
assign temp[782:780] = 0;//ldd[0]

//frac:
for (i = 0; i < 30; i = i + 1) begin
	assign temp[i*26+25:i*26] = fractemp[i+25:i];
end

//switch order for temp
for (i = 0; i < 6; i = i + 1) begin
for (j = 0; j < 30; j = j + 1) begin
	nand(outtemp[j+i*30+870], temp[j*6+i+870], ldd[j]);
	//assign outtemp[j+i*30+870] = temp[j*6+i+870];
end
end
for (i = 0; i < 6; i = i + 1) begin
	nand(oneRe[i], oneReTemp[i], allone);
end

for (i = 0; i < 3; i = i + 1) begin
for (j = 0; j < 30; j = j + 1) begin
	nand(outtemp[j+i*30+780], temp[j*3+i+780], ldd[j]);
	//assign outtemp[j+i*30+780] = temp[j*3+i+780];
end
end

for (i = 0; i < 26; i = i + 1) begin
for (j = 0; j < 30; j = j + 1) begin
	nand(outtemp[j+i*30], temp[j*26+i], ldd[j]);
	//assign outtemp[j+i*30] = temp[j*26+i];
end
end

//frac out:
for (i = 0; i < 6; i = i + 1) begin
	assign tempregi[i] = ~&({outtemp[29+i*30+870:i*30+870],oneRe[i]});
end
for (i = 0; i < 3; i = i + 1) begin
	assign expo[i] = ~&(outtemp[29+i*30+780:i*30+780]);
end
for (i = 0; i < 26; i = i + 1) begin
	assign frac[i] = ~&(outtemp[29+i*30:i*30]);
end

always @(in[30], tempregi)
case (in[30])
	1'b1: regi = tempregi;
	1'b0: regi = ~tempregi;
endcase

endmodule
