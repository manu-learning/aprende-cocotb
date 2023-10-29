module full_adder_4bit(
                  // - vector de entrada de 4 bits
                  // - direccionamiento de 2^4 Bytes => 2^2 * 2^2 = 16 combinaciones únicas posibles
                  // - el rango de valores es 0 a es 15 (en sistema decimal) y 0000 a 1111 (en sistema binario)
                  input [3:0]  i_operando_a,

                  // vector de entrada de 4 bits, mismas características que el operando_a
                  input [3:0]  i_operando_b,

                  input        i_acarreo, // entrada de 1 bit
                  output       o_acarreo, // salida de 1 bit

                  // un vector de salida de 4 bits, mismas características que los operandos
                  output [3:0] o_suma
                  );

   // - usamos el operador de concatenación que son las {} (las llaves)
   // - la concatenación de o_acarreo y o_resultado_suma será otro vector de salida pero de 4+1 bits
   assign {o_acarreo, o_suma} = i_operando_a + i_operando_b + i_acarreo;

// - the "macro" to dump signals
// - to get waveforms in VCD format some Verilog code must be added to the top component
`ifdef COCOTB_SIM
   initial begin
      $dumpfile ("dump.vcd");
      $dumpvars (0, full_adder_4bit);
      #1;
   end
`endif
endmodule
