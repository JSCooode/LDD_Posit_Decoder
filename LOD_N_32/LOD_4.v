module LOD_4(C, A);
input [3:0] A;
output [2:0] C;

assign C[0] = (~A[3]&A[2])|(~A[3]&A[0])|(~A[3]&A[1]);
assign C[1] = (~A[3]&~A[2])&(A[1]|A[0]);
assign C[3] = ~A[3]&~A[2]&~A[1]&A[0];

endmodule
