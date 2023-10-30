// escala de tiempo
// =================
//
// - la sintáxis es de la forma `timescale utime/precision dónde utime >= precision
`timescale 1ns/1ns

// - el testbench no tendrá entradas ni salidas,
// por eso no las declaramos entre los paréntesis del módulo
module half_adder_tb();
   reg i_operando_a, i_operando_b;
   wire o_suma, _acarreo;

   // half_adder dut(i_operando_a,i_operando_b,suma,acarreo);
   half_adder dut(
                  .i_operando_a(i_operando_a),
                  .i_operando_b(i_operando_b),
                  .o_acarreo(o_acarreo),
                  .o_suma(o_suma)
                  );

   initial
     begin
        // imprimimos los valores
        $monitor("i_operando_a=%0d, i_operando_b=%d, o_acarreo=%0d, o_suma=%d", i_operando_a, i_operando_b, o_acarreo, o_suma);

        // 00 es el valor de las entradas A y B respectivamente
        i_operando_a=1'b0;
        i_operando_b=1'b0;

        // 01 es el valor de las entradas A,B respectivamente
        #10
        i_operando_a=1'b0;
        i_operando_b=1'b1;

        // 10 es el valor de las entradas A,B respectivamente
        #10
        i_operando_a=1'b1;
        i_operando_b=1'b0;

        // 11 es el valor de las entradas A,B respectivamente
        #10
        i_operando_a=1'b1;
        i_operando_b=1'b1;

        #10
        $finish;
     end

endmodule
