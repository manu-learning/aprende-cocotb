module half_adder_tb();
   reg A, B;
   wire suma, acarreo;

   half_adder dut(A,B,suma,acarreo);

   initial
     begin
        $dumpfile("views/half_adder.vcd");
        $dumpvars(1,half_adder_tb);

        // 00 es el valor de las entradas A y B respectivamente
        A=1'b0;
        B=1'b0;

        // 01 es el valor de las entradas A,B respectivamente
        #10
        A=1'b0;
        B=1'b1;

        // 10 es el valor de las entradas A,B respectivamente
        #10
        A=1'b1;
        B=1'b0;

        // 11 es el valor de las entradas A,B respectivamente
        #10
        A=1'b1;
        B=1'b1;
     end

endmodule
