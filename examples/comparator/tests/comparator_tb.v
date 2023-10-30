// Escala de tiempo
// =================
//
// - la sintáxis es de la forma `timescale utime/precision dónde utime >= precision
`timescale 1ns/1ns

// TestBench
// =========
//
// - NO tiene entradas/salidas, por eso no las declaramos entre los paréntesis del módulo
module comparator_tb( );

   reg [2:0] i_a;
   reg [2:0] i_b;
   wire [2:0] o_f;

   // - manejamos todas las entradas/salidas del sistema como variables internas del módulo (reg y wire)
   // - las entradas las declaramos como registros (reg)
   // - las salidas las declaramos como cables (wire)
   comparator dut(
                  .i_a (i_a),
                  .i_b(i_b),
                  .o_f (o_f)
                  );

   // el Bloque Initial
   // - lo utilizamos sólo en TestBenches,
   // porque va a asignar valores a registros que yo quiero inicializar en algún punto
   //
   // - se ejecutan una única vez,
   // por tanto NO sería necesario inicializar las variables internas (reg, wire) en su momento de declaración
   //
   // los delay/retraso
   // - sólo pueden utilizar en los TestBenches
   // - se utilizan de la forma #unidadDeTiempo usando el caracter # como prefijo
   initial
     begin
        // persistimos el comportamiento en un fichero (vcd) "value change dump"
        $dumpfile("waveforms/dump.vcd");

        // definimos las variables de que entorno guardar
        $dumpvars(1, comparator_tb);

        // - %b imprime el número en sistema binario
        // - %d imprime el número en sistema decimal
        $monitor("-----> i_a=%b, i_b=%b, o_f=%b\n", i_a, i_b, o_f);

        // - combinación (i_a > i_b)
        i_a = 3'b100; //
        i_b = 3'b001;

        // otra forma de decir lo mismo que las asignaciones anteriores, pero usando el sistema decimal
        // i_a = 3'd4;
        // i_b = 3'd1;

        // - combinación (i_a == i_b)
        // - generamos un retraso de 20 unidades de tiempo
        #20;
        i_a = 3'b000;
        i_b = 3'b000;

        // - combinación (i_a < i_b)
        // - generamos un retraso de 20 unidades de tiempo
        #20;
        i_a = 3'b001;
        i_b = 3'b100;

        // - generamos un retraso de 20 unidades de tiempo, para verlo en el GTKWave
        #20;
     end
endmodule






