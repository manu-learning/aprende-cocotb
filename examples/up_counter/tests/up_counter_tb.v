module up_counter_tb();

// declaramos dos registros para persistir sus valores
reg i_clk, i_reset;

// para conectar con el módulo contador
wire [3:0] o_count;

// interconectamos las entradas del módulo
   up_counter dut(.i_clk(i_clk),
                  .i_reset(i_reset),
                  .o_count(o_count)
                  );

   // bloque initial, se ejecutará una única vez
   initial
     begin
        // inicializamos la señal de reloj con el "cero lógico" ó pulso bajo (LOW)
        i_clk = 0;

        // - ciclo de ejecución infinito, tiene un retraso de 5 unidades antes de modificar el valor de la señal de reloj
        // - alternamos el valor de la señal de reloj/clock con su complemento, resultando en 0,1,0,1,..
        forever
          #5
            i_clk = ~i_clk;
     end

   initial
     begin
        // persistimos el comportamiento en un fichero (vcd) "value change dump"
        $dumpfile("waveforms/up_counter_tb.vcd");

        // definimos las variables de que entorno guardar
        // If level = 0, then all variables within the modules from the list will be dumped. If any module from the list contains module instances, then all variables from these modules will also be dumped.
        // If level = 1, then only listed variables and variables of listed modules will be dumped.
        $dumpvars(1, up_counter_tb);

        // imprimimos los valores
        $monitor(" i_clk=%0d, i_reset=%d, o_count=%0d", i_clk, i_reset, o_count);
     end

   // bloque initial, se ejecutará una única vez
   initial
     begin
        $display("\n#############################################################");
        i_reset = 0;

        // retraso de 5 segundos, luego asignamos el valor 1 a la señal de reset
        #5;
        i_reset = 1;

        // retraso de 5 segundos, luego asignamos el valor 0 a la señal de reset
        #5;
        i_reset = 0;

        // retraso de 15 segundos, luego asignamos el valor 1 a la señal de reset
        #15;
        i_reset = 1;

        // retraso de 5 segundos, luego asignamos el valor 0 a la señal de reset
        #5;
        i_reset = 0;

        // - generamos un último retraso, para visualizarlo en el GTKWave
        #200;
        $display("#############################################################\n");
        $finish;
     end
endmodule
