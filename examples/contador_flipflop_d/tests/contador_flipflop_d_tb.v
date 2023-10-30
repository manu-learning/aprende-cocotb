// escala de tiempo
// =================
//
// - la sintáxis es de la forma `timescale utime/precision dónde utime >= precision
`timescale 1ns/1ns

// - el testbench no tendrá entradas ni salidas,
// por eso no las declaramos entre los paréntesis del módulo
module contador_flipflop_d_tb( );

   // - manejamos todas las entradas/salidas del sistema como variables internas del módulo (reg y wire)
   // - las entradas las declaramos como registros (reg)
   // - las salidas las declaramos como cables (wire)
   reg  i_clk;
   wire [3:0] o_cuenta;

   // - "creamos una instancia" del Flip Flop D (llamandolo por su nombre de módulo),
   // - a la instancia del FF_D le asignamos una etiqueta (para crear un tipo de dato)
   //
   // no confundir las variables
   // - si tiene "un punto de prefijo" => pertenece al módulo que estamos invocamos
   // - si está "dentro de los paréntesis" => entonces el del módulo top ó bien el testbench
   //
   // a cada entrada/salida le conectamos el cable (wire ó reg) correspondiente de éste módulo
   contador_flipflop_d dut (
                            .i_clk (i_clk),
                            .o_cuenta (o_cuenta)
                            );

   // - con éste Bloque always+forever que se ejecuta siempre,
   // podemos hacer que la señal de reloj cambie, separado de las entradas
   // (las entradas que cambiabamos su valor en el Bloque Initial)
   //
   // - si utilizamos ésta técnica, entonces comentamos las asignaciones a la entrada i_clk del bloque initial
   always
     begin
        // si no inicializamos el clock con un valor,
        // tendrá un valor indeterminado cuando en el bloque forever hagamos i_clk = ~i_clk;
        i_clk = 0;

        forever
          begin
             // - definimos un retraso de 50 unidades de tiempo,
             // cada 50 unidades de tiempo se cambiará el valor de la entrada de reloj
             //
             // - se recomienda que su valor sea la mitad que
             // el tiempo espera/retraso definido entre cambios de estado de mis entradas (i_j, i_k)
             #50;

             // - cambiamos el valor de la señal de reloj,
             // al valor opuesto que tenía "su estado estado anterior"
             i_clk = ~i_clk;
          end
     end

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
        $dumpvars(1, contador_flipflop_d_tb);

        // imprimimos los valores
        $monitor("i_clk=%0d, o_cuenta=%0d", i_clk, o_cuenta);

        // - inicializamos las entradas
        // - en el instante 0
        // i_clk = 0;

        // - generamos un retraso de 100 unidades de tiempo
        #100;
        // i_clk = 1;

        // - generamos un retraso de otras 100 unidades de tiempo
        #100;
        // i_clk = 0;

        // - generamos un retraso de otras 100 unidades de tiempo
        #100;
        // i_clk = 0;

        // - generamos un retraso de otras 100 unidades de tiempo, para visualizarlo en el GTKWave
        #100;

        // IMPORTANTE:
        // si nos olvidamos de FINALIZAR éste bloque,
        // cuando ejecutemos el testbench con el comando `vvp`
        // sobre el ejecutable que fue compilado por `iverilog`
        // entonces la linea de comandos tampóco finalizará (necesitaremos matar el proceso)
        $finish;
     end

endmodule
