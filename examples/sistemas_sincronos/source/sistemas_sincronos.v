module sistemas_sincronos(
                          input [3:0] iData, // entrada del tipo vector de 4 bits
                          input [1:0] iSelector, // entrada del tipo vector de 2 bits
                          input       iClock, // entrada del tipo escalar de 1 bit (idem con la salida)
                          output oSalida);

   // - declaramos dos registros
   // - necesario que sean de éste tipo, porque los usaremos dentro de los bloques always
   reg rSalida_D, rSalida_Q;

   // - otra alternativa, sería haber declarado "output reg oSalida"
   assign oSalida = rSalida_Q;

   // - al tener más de una sentencia el bloque always,
   // requiere las keywords begin/end para delimitar su contenido
   // - con el * (asterísco), indicamos éste bloque es sensible a todas las entradas
   // (es decir se activará ante cualquier cambio de valor)
   always @ *
     begin
        // en cada condicional haremos un asignación bloqueante ó continua

        // verificamos si la combinación de 2 bits es 00
        if (iSelector == 2'b00)
          rSalida_D = iData[0];
        // verificamos si la combinación de 2 bits es 01
        else if (iSelector == 2'b01)
          rSalida_D = iData[1];
        // verificamos si la combinación de 2 bits es 10
        else if (iSelector == 2'b10)
          rSalida_D = iData[2];
        // verificamos si la combinación de 2 bits es 11
        else
          rSalida_D = iData[3];
     end

   // no utilizamos las keywords begin/end en el bloque always, porque contiene sólo 1 sentencia
   always @(posedge iClock)
     // asignación no bloqueante ó secuencial,
     // se asignará el valor ante cada "flanco de reloj"
     rSalida_Q <= rSalida_D;

endmodule // sistemas_sincronos
