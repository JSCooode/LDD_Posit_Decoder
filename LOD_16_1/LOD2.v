module LOD2(vld, k, in);
input [1:0] in;
output vld, k;

or (vld, in[1], in[0]);
and (k, ~in[1], in[0]);

endmodule
