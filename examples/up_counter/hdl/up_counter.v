`timescale 1ns/1ps

module up_counter(
                  input        i_clk, // entrada de 1 bit para la señal de reloj
                  input        i_reset, // entrada de 1 bit para la señal de reset

                  // - vector de salida de 4 bits, 2^4=2^2 * 2^2 = 16 combinaciones únicas posibles (0 a 15)
                  // - rango de valores en sistema decimal: 0 a 15
                  // - en la "vista esquemática de tecnología" veremos 4 flips flops (por ser 4 bits)
                  output [3:0] o_count
                  );

   // - declaramos un registro de 4 bits, y lo inicializamos asignandole a cada bit el valor 1
   // - dónde 1111 (en binario) = 15 (en decimal)
   // - al ser un contador de 4 bits, el máximo valor es 15 en decimal
   // - como lo inicializamos con su máximo valor, luego de un "flanco de subida" de clock,
   // éste volverá a 0 (en decimal) ó bien 0000 (en binario)
   reg [3:0] r_counter = 4'b1111;

   // - la "lista sensitiva" del always tiene 2 entradas/señales/eventos (i_clk, i_reset)
   // - si hay un evento de "flanco de subida" (por usar posedge) osea una "transición de cero lógico a uno lógico" de alguna de las dos entradas,
   // entonces se activa el bloque always (ejecutando lo que contenga)
   always @(posedge i_clk or posedge i_reset)
     begin
        // la señal de Reset tiene prioridad por sobre la señal de Clock,
        // porque ésta primera es una "entrada asincrónica"
        // tiene control sobre las salidas (o_count), y puede anular las entradas sincrónicas, independientemente del valor de la señal de clock)
        if (i_reset)
           begin
              // - asignamos al contador 4 bits, con el valor 0 (en el sistema decimal) que representa 0000 (en sistema binario)
              // - al usar el operador <= indicamos que es una operación "no blocking"
              r_counter <= 4'd0;
           end
        else
          begin
             // incrementamos en 1 el valor del estado anterior del contador
             // asignando 4 bits, con el valor decimal 1
             r_counter <= r_counter + 4'd1;
          end
     end

   // al usar el operador = indicamos que es una operación "blocking"
   assign o_count = r_counter;

// - the "macro" to dump signals
// - to get waveforms in VCD format some Verilog code must be added to the top component
`ifdef COCOTB_SIM
   initial begin
      $dumpfile ("dump.vcd");
      $dumpvars (0, up_counter);
      #1;
   end
`endif
endmodule
