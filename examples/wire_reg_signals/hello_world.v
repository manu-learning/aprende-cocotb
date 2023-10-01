module hello_world(input entrada_A, input entrada_B, output salida_F);

// Conexión interna tipo Wire
// --------------------------
//
// interconecta
//   - una Salida de una compuerta lógica
//   - una Entrada de otra compuerta lógica
wire conexion_1;

// una salida sólo puede estar del lado izquierdo del operador de asignación `=`
// (una conexión "interna" del tipo wire es la excepción)
assign conexion_1 = entrada_A | entrada_B ;

// una entrada sólo puede estar del lado derecho del operador de asignación `=`
// (una conexión "interna" del tipo wire es la excepción)
assign salida_F = conexion_1 & entrada_B;

endmodule
