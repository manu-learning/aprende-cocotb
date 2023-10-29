module comparator(input [2:0] i_a, // un vector de entrada de 3 bits (2 es el bit más significativo, 0 el menos significativo)
                  input [2:0] i_b, // un vector de entrada de 3 bits
                  output [2:0] o_f // un vector de salida de 3 bits
                 );

  // - al  vector de salida de 3 bits, le habilitamos uno de los bits según el valor de las dos entradas
  // - utilizamos el operador ternario (exp) ? rama_if : rama_else
  assign o_f = (i_a > i_b) ? 3'b100 //  si (i_a > i_b), se activa el bit más significativo (el de más a la izq.)
    : (i_a == i_b) ? 3'b010 // si (i_a == i_b), se activa el bit del medio
    : (i_a < i_b) ? 3'b001 // si (i_a < i_b), se activa el bit menos significativo (el de más a la der.)
    : 3'b000; // valor por default, si no se cumple ninguna de las 3 condiciones anteriores

  // Notas..
  // - el número 100 en binario es 1*2^2 + 0*2^1 + 0*2^0 = 2^2 = 4 en decimal
  // - el número 010 en binario es 0*2^2 + 1*2^1 + 0*2^0 = 2^1 = 2 en decimal
  // - el número 001 en binario es 0*2^2 + 0*2^1 + 1*2^0 = 2^0 = 1 en decimal
  // - el número 000 en binario es 0*2^2 + 0*2^1 + 0*2^0 = 2^0 = 0 en decimal

// - the "macro" to dump signals
// - to get waveforms in VCD format some Verilog code must be added to the top component
`ifdef COCOTB_SIM
   initial begin
      $dumpfile ("dump.vcd");
      $dumpvars (0, comparator);
      #1;
   end
`endif
endmodule
