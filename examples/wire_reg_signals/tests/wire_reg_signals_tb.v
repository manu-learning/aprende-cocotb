// Nota: lo agregaríamos si en el compilador no incluyeramos ambos ficheros .v
// `include "hello_world.v"

// - timescale tiempo_total / tiempo de cada paso
// - tiempo_total= 1 (ns) nanosegundo
// - tiempo de cada paso = 1 (ps) picosegundo
// - el tiempo de la simulación será de 1.000 picosegundos
// `timescale 1ns / 1ps

module wire_reg_signals_tb();
   // señales tipo REG
   // ----------------
   //
   // - entradas del módulo "hello_world"
   reg A, B;

   // señales tipo wire
   // ----------------
   //
   // - salidas del módulo "hello_world"
   wire F;

   // asociamos con la simulación las entradas/salidas del módulo "hello_world"
   wire_reg_signals dut(A, B, F);

initial
begin
   // persistimos el comportamiento en un fichero (vcd) "value change dump"
   $dumpfile("views/wire_reg_signals.vcd");

   // definimos las variables de que entorno guardar
   $dumpvars(1,wire_reg_signals_tb);

   // inicializamos las entradas
   // - nombre_variable = cantidad de bits + tipo bit + valor
   //
   A=1'b0; // inicializamos la entrada_A con un valor de 1 bit igual a 0 (cero)
   B=1'b0; // inicializamos la entrada_B con un valor de 1 bit igual a 0 (cero)

   // el valor de las entradas será: 00
   #10 // esperará 10 unidades de tiempo
   A=1'b1; // cambia el valor de la entrada_A por 1
   B=1'b0; //

   // esperará otras 10 unidades de tiempo
   // el valor de las entradas será: 01
   #10
   A=1'b0;
   B=1'b1;

   // esperará otras 10 unidades de tiempo
   // el valor de las entradas será: 11
   #10
   A=1'b1;
   B=1'b1;
end
endmodule
