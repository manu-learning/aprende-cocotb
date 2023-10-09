// - el testbench no tendrá entradas ni salidas,
// por eso no las declaramos entre los paréntesis del módulo
module flipflopjk_tb( );

   // - manejamos todas las entradas/salidas del sistema como variables internas del módulo (reg y wire)
   // - las entradas las declaramos como registros (reg)
   // - las entradas las declaramos como cables (wire)
   reg  iJ, iK, iClk;
   wire oQ, oQn;

   // - "creamos una instancia" del Flip Flop JK (llamandolo por su nombre de módulo),
   // - a la instancia del FF_JK le asignamos una etiqueta (para crear un tipo de dato)
   //
   // no confundir las variables
   // - si tiene "un punto de prefijo" => pertenece al módulo que estamos invocamos
   // - si está "dentro de los paréntesis" => entonces el del módulo top ó bien el testbench
   //
   // a cada entrada/salida le conectamos el cable (wire ó reg) correspondiente de éste módulo
   flipflopjk dut (
              .iJ (iJ),
              .iK (iK),
              .iClk (iClk),
              .oQ (oQ),
              .oQn (Oqn)
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
        $dumpfile("views/flipflopjk.vcd");

        // definimos las variables de que entorno guardar
        $dumpvars(1, flipflopjk_tb);

        // inicializamos las entradas
        iJ = 0; iK = 0;
        iClk = 0;

        #100;
        iJ = 1; iK = 1;
        iClk = 1;

        #100;
        iJ = 0; iK = 1;
        iClk = 0;

        #100;
        iClk = 1;

        #100;
     end // initial begin


   // TODO: no podemos terminar su ejecución con mi configuración de makefile
   /*
   // - con éste Bloque always+forever que se ejecuta siempre,
   // podemos hacer que la señal de reloj cambie, separado de las entradas
   // (las entradas que cambiabamos su valor en el Bloque Initial)
   //
   // - si utilizamos ésta técnica, entonces comentamos las asignaciones a la entrada iClk del bloque initial
   always
     begin
        forever
          begin
             // - cambiamos el valor de la señal de reloj,
             // al valor opuesto que tenía "su estado estado anterior"
             iClk = ~iClk;

             // - definimos un retraso de 50 unidades de tiempo,
             // cada 50 unidades de tiempo se cambiará el valor de la entrada de reloj
             //
             // - se recomienda que su valor sea la mitad que
             // el tiempo espera/retraso definido entre cambios de estado de mis entradas (iJ, iK)
             #50;
          end
     end
    */

endmodule
