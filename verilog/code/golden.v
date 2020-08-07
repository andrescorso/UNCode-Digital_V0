module example_3_4(E, F, G, A, B, C, D);
   
   output E, F;
   output [4:0] G;
   input  A, B, C, D;

   assign E = B || (B && C) || ((!B) && D);
   assign F = (!(B) && C) || (B && (!C) && (!D));
   assign G[0] = D;
   assign G[1] = C;
   assign G[2] = B;
   assign G[3] = A;
   assign G[4] = B;

endmodule
