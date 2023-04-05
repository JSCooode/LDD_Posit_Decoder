module left_shifter(out, in, k);
input [62:0] in;
input [5:0] k;

output reg [62:0] out;


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
28: out = in << 29;
29: out = in << 30;
30: out = in << 31;
31: out = in << 32;
32: out = in << 33;
33: out = in << 34;
34: out = in << 35;
35: out = in << 36;
36: out = in << 37;
37: out = in << 38;
38: out = in << 39;
39: out = in << 40;
40: out = in << 41;
41: out = in << 42;
42: out = in << 43;
43: out = in << 44;
44: out = in << 45;
45: out = in << 46;
46: out = in << 47;
47: out = in << 48;
48: out = in << 49;
49: out = in << 50;
50: out = in << 51;
51: out = in << 52;
52: out = in << 53;
53: out = in << 54;
54: out = in << 55;
55: out = in << 56;
56: out = in << 57;
57: out = in << 58;
58: out = in << 59;
59: out = in << 60;//Three left
60: out = in << 61;
61: out = in << 62;
62: out = in << 63;
63: out = in << 64;
endcase

endmodule
