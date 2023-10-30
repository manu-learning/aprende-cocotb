// - timescale tiempo_total / tiempo de cada paso
// - tiempo_total= 1 (ns) nanosegundo
// - tiempo de cada paso = 1 (ps) picosegundo
// - el tiempo de la simulación será de 1.000 picosegundos
`timescale 1ns / 1ps

module wire_reg_signals_tb();
   // señales tipo REG
   // ----------------
   //
   // - entradas del módulo "wire_reg_signals"
   reg i_a, i_b;

   // señales tipo wire
   // ----------------
   //
   // - salidas del módulo "wire_reg_signals"
   wire o_q;

   // asociamos con la simulación las entradas/salidas del módulo "hello_world"
   wire_reg_signals dut(i_a, i_b, o_q);

   initial
     begin
        // persistimos el comportamiento en un fichero (vcd) "value change dump"
        $dumpfile("waveforms/dump.vcd");

        // definimos las variables de que entorno guardar
        $dumpvars(1,wire_reg_signals_tb);

        // imprimimos los valores
        $monitor("---------> o_q=((i_a=%0d OR i_b=%0d) AND i_b=%0d)=%0d", i_a, i_b, i_b, o_q);

        // inicializamos las entradas
        // - nombre_variable = cantidad de bits + tipo bit + valor
        //
        i_a=1'b0; // inicializamos la entrada_A con un valor de 1 bit igual a 0 (cero)
        i_b=1'b0; // inicializamos la entrada_B con un valor de 1 bit igual a 0 (cero)

        // el valor de las entradas será: 00
        #10; // esperará 10 unidades de tiempo
        i_a=1'b1; // cambia el valor de la entrada_A por 1
        i_b=1'b0; //

        // esperará otras 10 unidades de tiempo
        // el valor de las entradas será: 01
        #10;
        i_a=1'b0;
        i_b=1'b1;

        // esperará otras 10 unidades de tiempo
        // el valor de las entradas será: 11
        #10;
        i_a=1'b1;
        i_b=1'b1;
  end
endmodule
