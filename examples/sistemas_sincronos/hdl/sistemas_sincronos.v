module sistemas_sincronos(
                          input [3:0] i_data, // entrada del tipo vector de 4 bits
                          input [1:0] i_selector, // entrada del tipo vector de 2 bits
                          input       i_clk, // entrada del tipo escalar de 1 bit (idem con la salida)
                          output reg o_q);

   // - declaramos registros
   // - necesario que sean de éste tipo, porque los usaremos dentro de los bloques always
   reg r_salida_d;

   // - otra alternativa, si en los parámetros del módulo no hubieramos declarado
   // la salida o_q del tipo reg es decir.. "output o_q"
   //
   // reg r_salida_q;
   // assign o_q = r_salida_q;

   // - al tener más de una sentencia el bloque always,
   // requiere las keywords begin/end para delimitar su contenido
   // - con el * (asterísco), indicamos éste bloque es sensible a todas las entradas
   // (es decir se activará ante cualquier cambio de valor)
   always @ *
     begin
        // en cada condicional haremos un asignación bloqueante ó continua

        // verificamos si la combinación de 2 bits es 00
        if (i_selector == 2'b00)
          r_salida_d = i_data[0];
        // verificamos si la combinación de 2 bits es 01
        else if (i_selector == 2'b01)
          r_salida_d = i_data[1];
        // verificamos si la combinación de 2 bits es 10
        else if (i_selector == 2'b10)
          r_salida_d = i_data[2];
        // verificamos si la combinación de 2 bits es 11
        else
          r_salida_d = i_data[3];
     end

   // no utilizamos las keywords begin/end en el bloque always, porque contiene sólo 1 sentencia
   always @(posedge i_clk)
      begin
         // asignación no bloqueante ó secuencial,
         // se asignará el valor ante cada "flanco de reloj"
         o_q <= r_salida_d;
      end


// - the "macro" to dump signals
// - to get waveforms in VCD format some Verilog code must be added to the top component
`ifdef COCOTB_SIM
   initial begin
      $dumpfile ("dump.vcd");
      $dumpvars (0, sistemas_sincronos);
      #1;
   end
`endif
endmodule
