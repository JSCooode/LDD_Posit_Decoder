module left_shifter(out, in, k);
input [30:0] in;
input [4:0] k;

output reg [30:0] out;

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
16: out = in << 17;
17: out = in << 18;
18: out = in << 19;
19: out = in << 20;
20: out = in << 21;
21: out = in << 22;
22: out = in << 23;
23: out = in << 24;
24: out = in << 25;
25: out = in << 26;
26: out = in << 27;
27: out = in << 28;
28: out = in << 29;//two left
29: out = in << 30;
30: out = in << 31;
31: out = 0;
endcase

endmodule
