module contador_flipflop_d (
                 input        i_clk, // entrada de 1 bit para los flancos de reloj
                 output reg [3:0] o_cuenta // vector de salida de 4 bits
);
   // Observación sobre la salida de 4 bits
   //
   // 1) si la vemos como número binario
   // 1.1) tiene 2^4 Bytes = 2^2 Bytes  + 2^2 Bytes = 8 combinaciones únicas posibles
   // 1.2) tiene 8 combinaciones únicas posibles 0000 0001 0010 ...
   // 1.3) Ej. si quisieramos asignar la combinación 0110 => assign o_cuenta =4'b0110;
   //
   // 2) si la vemos como un número decimal
   // 2.1) 2^4 Bytes = 8 combinaciones únicas posibles (es decir del 0 al 7)
   // 2.2) Ej. si quisieramos el valor decimal 3 => assign o_cuenta=4'd3;
   // 2.2) Ej. si quisieramos el valor decimal 7 => assign o_cuenta=4'd7;
   //
   // 3) si la vemos como un vector
   // 3.1) tiene 4 posiciones del 0 al 3
   // 3.3) Ej. si queremos leer a la posición 0, o_cuenta[0]
   // 3.3) Ej. si queremos leer a la posición 1, o_cuenta[1]
   // 3.4) Ej. si queremos leer a la posición 2, o_cuenta[2]

  // - será un sistema asíncrono por medio de un "Flip Flop en la salida"
  // por tanto "definimos dos registros" D y Q, igual que el Flip Flop D
  // - los registros D y Q, deben ser del tamaño de la salida (es decir de 4 bits)
  reg [3:0] r_cuenta_d = 4'd0; // lo inicializamos con el valor decimal 0

  //reg [3:0] r_cuenta_q = 4'd0; // lo inicializamos con el valor decimal 0
  //assign o_cuenta = r_cuenta_q;

  // Bloque Secuencial
  // - éste bloque secuencial, dará la pauta para salir de sistema
  // - en cada "flanco de reloj", incrementamos el valor de la salida
  // - siempre le asignamos algo a las Q, porque "son las salidas de los Flip Flops"
  always @ (posedge i_clk)
    begin
      // - "asignación NO bloqueante" a r_cuenta_q, usando el valor de r_cuenta_d
      // - en "cada flanco de reloj" le asigna el valor de r_cuenta_d que es "la salida del Bloque Combinacional",
      // pero hace de "entrada de Flip Flop"
      // - ésta Q es la salida del Flip Flop, y también del sistema

      //r_cuenta_q <= r_cuenta_d;
      o_cuenta <= r_cuenta_d;
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
      // r_cuenta_d = r_cuenta_d + 1'd1;

      // ASIGNACION VALIDA
      // - utilizamos el "último estado válido del sistema", que son las Q, porque ya pasaron por un flanco de reloj
      // - r_cuenta_q tiene el último estado válido del sistema
      //
      // r_cuenta_d = r_cuenta_q + 1'd1; // r_cuenta_d = el valor que tenía el sistema antes + 1

      // si quisieramos aplicar alguna lógica, debería sobre sobre las Q
      // porque la Q es "el último estado válido del sistema"
      if(o_cuenta == 4'd10)
        begin
          r_cuenta_d = 4'd0;
        end
      else
        begin
          r_cuenta_d = o_cuenta + 1'd1;
        end
    end

// - the "macro" to dump signals
// - to get waveforms in VCD format some Verilog code must be added to the top component
`ifdef COCOTB_SIM
   initial begin
      $dumpfile ("dump.vcd");
      $dumpvars (0, contador_flipflop_d);
      #1;
   end
`endif
endmodule
