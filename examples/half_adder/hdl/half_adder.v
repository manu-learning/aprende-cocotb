module half_adder(
             input i_operando_a, // entrada de 1 bits
             input i_operando_b, // entrada de 1 bits
             output o_acarreo, // salida de 1 bit
             output o_suma // salida de 1 bits
             );

   // - la suma de dos bits, resulta de operar "a XOR b"
   // - ^ es el operador XOR (el OR exclusivo, sólo uno u otro puede ser verdadero)
   // - en la tabla de verdad XOR, es verdadero cuando "uno u otro es verdadero" pero.. NO ambos
   assign o_suma = i_operando_a ^ i_operando_b;

   // - el acarreo resulta de operar "a AND b"
   // - en la tabla de verdad el AND ó "y lógico", es verdadero cuando ambos lo son
   assign o_acarreo = i_operando_a & i_operando_b;


// - the "macro" to dump signals
// - to get waveforms in VCD format some Verilog code must be added to the top component
`ifdef COCOTB_SIM
   initial begin
      $dumpfile ("dump.vcd");
      $dumpvars (0, half_adder);
      #1;
   end
`endif
endmodule
