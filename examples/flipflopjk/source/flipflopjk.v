module flipflopjk (
  input iJ, // entrada de 1 bit, similar a la entrada S del flip flop SR
  input iK,  // entrada de 1 bit, similar a la entrada R del flip flop SR
  input iClk, // entrada de 1 bit, hace de entrada de reloj
  output oQ, // salida de 1 bit, hace de "salida Q del flip flop jk"
  output oQn // salida de 1 bit, es la "salida Q negada"
);

  // definimos registros (variables internas) que guardarán el valor de las salidas Oq y Oqn en el tiempo
  reg rQ = 1'b0; // le asignamos un bit al registro, con valor binario 0

  //
  assign oQ = rQ;
  assign oQn = ~rQ;

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
  always @ (posedge iClk)
    begin
      if(iJ == 0 && iK == 0) // combinación de entradas J,K es 00
        begin
          rQ = rQ; // su estado no cambia, mantiene el mismo valor
        end
      else if (iJ == 1 && iK == 0) // combinación de entradas J,K es 10
        begin
          rQ = 1'd1; // asignamos un bit a rQ, con el valor decimal 1
        end
      else if (iJ == 0 && iK == 1) // combinación de entradas J,K es 01
        begin
          rQ = 1'd0; // asignamos un bit a rQ, con el valor decimal 0
        end
      else if (iJ == 1 && iK == 1) // combinación de entradas J,K es 11
        begin
          rQ = ~rQ; // le asignamos su valor negado
        end
    end
endmodule
