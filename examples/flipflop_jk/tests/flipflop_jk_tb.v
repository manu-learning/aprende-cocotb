// escala de tiempo
// =================
//
// - la sintáxis es de la forma `timescale utime/precision dónde utime >= precision
`timescale 1ns/1ns

// - el testbench no tendrá entradas ni salidas,
// por eso no las declaramos entre los paréntesis del módulo
module flipflop_jk_tb( );

   // - manejamos todas las entradas/salidas del sistema como variables internas del módulo (reg y wire)
   // - las entradas las declaramos como registros (reg)
   // - las salidas las declaramos como cables (wire)
   reg  i_j, i_k, i_clk;
   wire o_q, o_qn;

   // - "creamos una instancia" del Flip Flop JK (llamandolo por su nombre de módulo),
   // - a la instancia del FF_JK le asignamos una etiqueta (para crear un tipo de dato)
   //
   // no confundir las variables
   // - si tiene "un punto de prefijo" => pertenece al módulo que estamos invocamos
   // - si está "dentro de los paréntesis" => entonces el del módulo top ó bien el testbench
   //
   // a cada entrada/salida le conectamos el cable (wire ó reg) correspondiente de éste módulo
   flipflop_jk dut (
              .i_j (i_j),
              .i_k (i_k),
              .i_clk (i_clk),
              .o_q (o_q),
              .o_qn (o_qn)
              );

   // TODO: no podemos terminar su ejecución con mi configuración de makefile
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
        $dumpvars(1, flipflop_jk_tb);

        // imprimimos los valores
        $monitor("i_j=%0d, i_k=%d, o_q=%0d, i_clk=%d", i_j, i_k, o_q, i_clk);

        // - inicializamos las entradas
        // - en el instante 0
        i_j = 0; i_k = 0;
        // i_clk = 0;

        // - generamos un retraso de 100 unidades de tiempo
        #100;
        i_j = 1; i_k = 1;
        // i_clk = 1;

        // - generamos un retraso de otras 100 unidades de tiempo
        #100;
        i_j = 0; i_k = 1;
        // i_clk = 0;

        // - generamos un retraso de otras 100 unidades de tiempo
        // #100;
        // i_clk = 1;

        // - generamos un retraso de otras 100 unidades de tiempo, para visualizarlo en el GTKWave
        #100;

        // IMPORTANTE:
        // si nos olvidamos de FINALIZAR éste bloque,
        // cuando ejecutemos el testbench con el comando `vvp`
        // sobre el ejecutable que fue compilado por `iverilog`
        // entonces la linea de comandos tampóco finalizará (necesitaremos matar el proceso)
        $finish;
     end // initial begin

endmodule
