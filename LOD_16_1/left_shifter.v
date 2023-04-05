module left_shifter(out, in, k);
input [14:0] in;
input [3:0] k;

output reg [14:0] out;

always @(in,k)
case(k)
 0: out = in << 1;
 1: out = in << 2;
 2: out = in << 3;
 3: out = in << 4;
 4: out = in << 5;
 5: out = in << 6;
 6: out = in << 7;
 7: out = in << 8;
 8: out = in << 9;
 9: out = in << 10;
10: out = in << 11;
11: out = in << 12;
12: out = in << 13;
13: out = in << 14;
14: out = in << 15;
15: out = in << 16;
endcase

endmodule
