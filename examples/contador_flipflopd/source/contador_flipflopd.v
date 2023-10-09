module Contador (
                 input        iClk, // entrada de 1 bit para los flancos de reloj
                 output [3:0] oCuenta // salida de 4 bits
);
   // Observación sobre la salida de 4 bits
   //
   // 1) si la vemos como número binario
   // 1.1) tiene 2^4 Bytes = 2^2 Bytes  + 2^2 Bytes = 8 combinaciones únicas posibles
   // 1.2) tiene 8 combinaciones únicas posibles 0000 0001 0010 ...
   // 1.3) Ej. si quisieramos asignar la combinación 0110 => assign oCuenta =4'b0110;
   //
   // 2) si la vemos como un número decimal
   // 2.1) 2^4 Bytes = 8 combinaciones únicas posibles (es decir del 0 al 7)
   // 2.2) Ej. si quisieramos el valor decimal 3 => assign oCuenta=4'd3;
   // 2.2) Ej. si quisieramos el valor decimal 7 => assign oCuenta=4'd7;
   //
   // 3) si la vemos como un vector
   // 3.1) tiene 4 posiciones del 0 al 3
   // 3.3) Ej. si queremos leer a la posición 0, iOcuenta[0]
   // 3.3) Ej. si queremos leer a la posición 1, iOcuenta[1]
   // 3.4) Ej. si queremos leer a la posición 2, iOcuenta[2]

  // - será un sistema asíncrono por medio de un "Flip Flop en la salida"
  // por tanto "definimos dos registros" D y Q, igual que el Flip Flop D
  // - los registros D y Q, deben ser del tamaño de la salida (es decir de 4 bits)
  reg [3:0]rCuenta_D = 4'd0; // lo inicializamos con el valor decimal 0
  reg [3:0]rCuenta_Q = 4'd0; // lo inicializamos con el valor decimal 0

  assign oCuenta = rCuenta_Q;

  // Bloque Secuencial
  // - éste bloque secuencial, dará la pauta para salir de sistema
  // - en cada "flanco de reloj", incrementamos el valor de la salida
  // - siempre le asignamos algo a las Q, porque "son las salidas de los Flip Flops"
  always @ (posedge iClk)
    begin
      // - "asignación NO bloqueante" a rCuenta_Q, usando el valor de rCuenta_D
      // - en "cada flanco de reloj" le asigna el valor de rCuenta_D que es "la salida del Bloque Combinacional",
      // pero hace de "entrada de Flip Flop"
      // - ésta Q es la salida del Flip Flop, y también del sistema
      rCuenta_Q <= rCuenta_D;
    end

  // Bloque Combinacional
  // - éste bloque combinacional, tendrá la "lógica del sistema", el que "hace las cosas" (Ej. contar)
  // - siempre le asignamos a las D, porque "son las salidas del Bloque Combinacional",
  // y como éste "se conecta con el Bloque Secuencial" entonces "será las entradas del Bloque Secuencial"
  always @ *
    begin
      // ASIGNACION INVALIDA
      // - la siguiente sentencia de asignación tiene un error, a nivel de HW no tiene lógica hacer i=i+1
      //
      // rCuenta_D = rCuenta_D + 1'd1;

      // ASIGNACION VALIDA
      // - utilizamos el "último estado válido del sistema", que son las Q, porque ya pasaron por un flanco de reloj
      // - rCuenta_Q tiene el último estado válido del sistema
      //
      // rCuenta_D = rCuenta_Q + 1'd1; // rCuenta_D = el valor que tenía el sistema antes + 1

      // si quisieramos aplicar alguna lógica, debería sobre sobre las Q
      // porque la Q es "el último estado válido del sistema"
      if(rCuenta_Q == 4'd10)
        begin
          rCuenta_D = 4'd0;
        end
      else
        begin
          rCuenta_D = rCuenta_Q + 1'd1;
        end
    end
endmodule
