module flipflop_jk (
  input i_j, // entrada de 1 bit, similar a la entrada S del flip flop SR
  input i_k,  // entrada de 1 bit, similar a la entrada R del flip flop SR
  input i_clk, // entrada de 1 bit, hace de entrada de reloj
  output o_q, // salida de 1 bit, hace de "salida Q del flip flop jk"
  output o_qn // salida de 1 bit, es la "salida Q negada"
);

  // definimos registros (variables internas) que guardarán el valor de las salidas Oq y Oqn en el tiempo
  reg r_q = 1'b0; // le asignamos un bit al registro, con valor binario 0

  //
  assign o_q = r_q;
  assign o_qn = ~r_q;

  // éste Bloque Combinacional se ejecuta a cada rato, no requiere de una variable que lo active para ejecutarse
  /*
  always @ *
    begin
    end
  */

  // - éste "Bloque Secuencial" difiere del anterior porque tiene un condicional que lo activa/ejecuta
  // - con "la palabra reservada posedge" detectamos cuando hay un "flanco de subida/positivo" (ej. de reloj, de un pulsador)
  // - existe la "palabra reservada negedge" que es para flancos de bajada/negativos
  // - con cada "flanco de subida/positivo de la entrada de reloj" se activará éste bloque
  always @ (posedge i_clk)
    begin
      if(i_j == 0 && i_k == 0) // combinación de entradas J,K es 00
        begin
          r_q = r_q; // su estado no cambia, mantiene el mismo valor
        end
      else if (i_j == 1 && i_k == 0) // combinación de entradas J,K es 10
        begin
          r_q = 1'd1; // asignamos un bit a r_q, con el valor decimal 1
        end
      else if (i_j == 0 && i_k == 1) // combinación de entradas J,K es 01
        begin
          r_q = 1'd0; // asignamos un bit a r_q, con el valor decimal 0
        end
      else if (i_j == 1 && i_k == 1) // combinación de entradas J,K es 11
        begin
          r_q = ~r_q; // le asignamos su valor negado
        end
    end

// - the "macro" to dump signals
// - to get waveforms in VCD format some Verilog code must be added to the top component
`ifdef COCOTB_SIM
   initial begin
      $dumpfile ("dump.vcd");
      $dumpvars (0, flipflop_jk);
      #1;
   end
`endif
endmodule
