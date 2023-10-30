module wire_reg_signals(input i_a, input i_b, output o_q);

   // Conexión interna tipo Wire
   // --------------------------
   //
   // interconecta
   //   - una Salida de una compuerta lógica
   //   - una Entrada de otra compuerta lógica
   wire w_conexion;

   // una salida sólo puede estar del lado izquierdo del operador de asignación `=`
   // (una conexión "interna" del tipo wire es la excepción)
   assign w_conexion = i_a | i_b ;

   // una entrada sólo puede estar del lado derecho del operador de asignación `=`
   // (una conexión "interna" del tipo wire es la excepción)
   assign o_q = w_conexion & i_b;

endmodule
