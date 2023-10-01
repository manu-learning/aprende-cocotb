/*
 * Definición del Módulo
 * - entradas y salidas
 */
module Circuito_1(
                  input  entrada_A, input entrada_B,
                  output salida_1, output salida_2, output salida_3,
                  output salida_4, output salida_5, output salida_6,
                  output salida_7
                  );
/*
* Cuerpo del diseño
 *
 * las salidas
 * - van a la IZQUIERDA del operador de asignación `=`
 * - se pueden ESCRIBIR
 *
 * las entradas
 * - van a la DERECHA del operador de asignación `=`
 * - se pueden LEER
*/

   // genera un circuito con
   // - 1 compuerta NOT
   // - 1 entrada + 1 salida
   assign salida_1 = ~entrada_A;

   // genera un circuito con
   // - 1 compuerta AND
   // - 2 entradas + 1 salida
   assign salida_2 = entrada_A & entrada_B;

   // idem, pero con 1 compuerta OR
   assign salida_3 = entrada_A | entrada_B;

   // idem, pero con 1 compuerta XOR
   assign salida_4 = entrada_A ^ entrada_B;

   // idem, pero con 1 compuerta NAND
   assign salida_5 = ~(entrada_A & entrada_B);

   // idem, pero con 1 compuerta NOR
   assign salida_6 = ~(entrada_A | entrada_B);

   // idem, pero con 1 compuerta XNOR
   assign salida_7 = ~(entrada_A ^ entrada_B);

endmodule
