module left_shifter(out, in, k);
input [6:0] in;
input [2:0] k;

output reg [6:0] out;

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

endcase

endmodule
