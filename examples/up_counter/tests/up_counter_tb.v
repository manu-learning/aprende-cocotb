module up_counter_tb();

// declaramos dos registros para persistir sus valores
reg clk, reset;

// para conectar con el módulo contador
wire [3:0] count;

// interconectamos las entradas del módulo
   up_counter dut(.clk(clk),
                  .reset(reset),
                  .count(count)
                  );

   // bloque initial, se ejecutará una única vez
   initial
     begin
        // inicializamos la señal de reloj con el "cero lógico" ó pulso bajo (LOW)
        clk = 0;

        // - ciclo de ejecución infinito, tiene un retraso de 5 unidades antes de modificar el valor de la señal de reloj
        // - alternamos el valor de la señal de reloj/clock con su complemento, resultando en 0,1,0,1,..
        forever
          #5
            clk = ~clk;
     end

   // bloque initial, se ejecutará una única vez
   initial
     begin
        //$dumpfile("waveforms/up_counter_tb.vcd");
        $dumpfile("dump.vcd");
        $dumpvars(1, dut);

   reset = 0;

   // retraso de 5 segundos, luego asignamos el valor 1 a la señal de reset
   #5
     reset = 1;

   // retraso de 5 segundos, luego asignamos el valor 0 a la señal de reset
   #5
     reset = 0;

   // retraso de 15 segundos, luego asignamos el valor 1 a la señal de reset
   #15
     reset = 1;

   // retraso de 5 segundos, luego asignamos el valor 0 a la señal de reset
   #5
     reset = 0;

   // retraso de 5 segundos, finalizamos el testbench
   #200
     $finish;
end

endmodule
