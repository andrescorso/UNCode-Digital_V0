// Verilog test bench for example_3_4
`timescale 1ns/100ps

module example_3_4_tb;

   wire A, B, C, D;
   wire E, F;
   wire [4:0]G;
   integer k=0;

   assign {A,B,C,D} = k;
   example_3_4 DUT(E, F, G, A, B, C, D);

   initial begin

      $dumpfile("example_3_4.vcd");
      $dumpvars(0, example_3_4_tb);

      for (k=0; k<16; k=k+1)
        #10 $display("done testing case %d", k);

      $finish;

   end 

endmodule
