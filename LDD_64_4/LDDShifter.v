module LDDShifter(regi, expo, frac, ldd, allone, in);
parameter n = 64;
parameter es = 4;
parameter rs = 7;//size of regi
parameter fs = n-es-3;//size of frac
parameter ls = n-2;//size of ldd

input [ls-1:0] ldd;
input [n-2:0] in;
input allone;

output reg [rs-1:0] regi; //Update based on the input size
output [es-1:0] expo;
output [fs-1:0] frac;

wire [(rs+es+fs)*ls:0] temp; 
wire [rs-1:0] oneRe, oneReTemp;
assign oneReTemp = n-2;
//total output size: (rs+es+fs)=68; ldd: ls, total:(rs+es+fs)*ls=4216
//regi[i] under ldd[j]: temp[j*rs+i+(es+fs)*ls]
//regi[i] under allone: oneRe[i]
//expo[i] under ldd[j]: temp[j*es+i+fs*ls]
//frac[i] under ldd[j]: temp[j*fs+i]
wire [(rs+es+fs)*ls:0] outtemp;
//regi[i] under ldd[j]: outtemp[j+i*ls+(es+fs)*ls]
//expo[i] under ldd[j]: outtemp[j+i*ls+fs*ls]
//frac[i] under ldd[j]: outtemp[j+i*ls]
wire [fs+ls-2:0] fractemp;
wire [ls-2:0] zerobus;
assign zerobus = 0;
assign fractemp = {in[fs-1:0],zerobus};

wire [rs-1:0] tempregi;//take the absolute of regi

genvar i,j;

//regi: check absolute value first, do bit inverse (~) to get negative at the output stage
for (i = 0; i < ls; i = i + 1) begin//under ldd[i]
	assign temp[i*rs+(es+fs)*ls+rs-1:i*rs+(es+fs)*ls] = ls-1-i;
end

//expo:
for (i = es; i < ls; i = i+1) begin
	assign temp[i*es+fs*ls+es-1:i*es+fs*ls] = in[i-1:i-es];
end
//expo that have no enough bits left
for (i = 0; i < es; i = i+1) begin
for (j = 0; j < i; j = j+1) begin
	assign temp[i*es+fs*ls+j] = in[j];
end
for (j = i; j < es; j = j+1) begin
	assign temp[i*es+fs*ls+j] = 1'b0;
end
end
//frac:
for (i = 0; i < ls; i = i + 1) begin
	assign temp[i*fs+fs-1:i*fs] = fractemp[i+fs-1:i];
end

//switch order for output
for (i = 0; i < rs; i = i + 1) begin
for (j = 0; j < ls; j = j + 1) begin
	nand(outtemp[j+i*ls+(es+fs)*ls], temp[j*rs+i+(es+fs)*ls], ldd[j]);
	//assign outtemp[j+i*30+870] = temp[j*6+i+870];
end
end
for (i = 0; i < rs; i = i + 1) begin
	nand(oneRe[i], oneReTemp[i], allone);
end

for (i = 0; i < es; i = i + 1) begin
for (j = 0; j < ls; j = j + 1) begin
	nand(outtemp[j+i*ls+fs*ls], temp[j*es+i+fs*ls], ldd[j]);
	//assign outtemp[j+i*30+780] = temp[j*3+i+780];
end
end

for (i = 0; i < fs; i = i + 1) begin
for (j = 0; j < ls; j = j + 1) begin
	nand(outtemp[j+i*ls], temp[j*fs+i], ldd[j]);
	//assign outtemp[j+i*30] = temp[j*26+i];
end
end

//frac out:
for (i = 0; i < rs; i = i + 1) begin
	assign tempregi[i] = ~&({outtemp[ls-1+i*ls+(es+fs)*ls:i*ls+(es+fs)*ls],oneRe[i]});
end
for (i = 0; i < es; i = i + 1) begin
	assign expo[i] = ~&(outtemp[ls-1+i*ls+fs*ls:i*ls+fs*ls]);
end
for (i = 0; i < fs; i = i + 1) begin
	assign frac[i] = ~&(outtemp[ls-1+i*ls:i*ls]);
end

always @(in[n-2], tempregi)
case (in[n-2])
	1'b1: regi = tempregi;
	1'b0: regi = ~tempregi;
endcase


endmodule
