module xor_tb();

   reg i_a, i_b;
   wire o_f;

   xor_gate dut(i_a, i_b, o_f);

   // el Bloque Initial
   // - lo utilizamos sólo en TestBenches,
   // porque va a asignar valores a registros que yo quiero inicializar en algún punto
   //
   // - se ejecutan una única vez,
   // por tanto NO sería necesario inicializar las variables internas (reg, wire) en su momento de declaración
   initial
      begin
         // persistimos el comportamiento en un fichero (vcd) "value change dump"
         $dumpfile("waveforms/dump.vcd");

         // definimos las variables de que entorno guardar
         // If level = 0, then all variables within the modules from the list will be dumped. If any module from the list contains module instances, then all variables from these modules will also be dumped.
         // If level = 1, then only listed variables and variables of listed modules will be dumped.
         $dumpvars(1, xor_tb);

         // imprimimos los valores
         $monitor(" i_a=%0d, i_b=%d, o_f=%0d", i_a, i_b, o_f);
      end

   // los delay/retraso
   // - sólo pueden utilizar en los TestBenches
   // - se utilizan de la forma #unidadDeTiempo usando el caracter # como prefijo
   initial
     begin
        // imprimimos los valores
        $display("\n#############################################################");

        i_a=1'b0;
        i_b=1'b0;

        #10;
        i_a=1'b0;
        i_b=1'b1;

        #10;
        i_a=1'b1;
        i_b=1'b0;

        #10;
        i_a=1'b1;
        i_b=1'b1;

        // - generamos un último retraso, para visualizarlo en el GTKWave
        #10;
        $display("#############################################################\n");
        $finish;
     end
endmodule
