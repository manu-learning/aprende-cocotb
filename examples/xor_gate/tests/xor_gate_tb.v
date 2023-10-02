module xor_tb();

   reg A, B;
   wire F;

   xor_gate dut(A, B, F);

   initial
     begin
        $dumpfile("views/xor_gate.vcd");

        $dumpvars(0, xor_tb);

        A=1'b0;
        B=1'b0;

        #10;
        A=1'b0;
        B=1'b1;

        #10;
        A=1'b1;
        B=1'b0;

        #10;
        A=1'b1;
        B=1'b1;

     end
endmodule
