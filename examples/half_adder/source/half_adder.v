module half_adder(input entrada_A, input entrada_B,
                  output suma, output acarreo);

   assign suma = entrada_A ^ entrada_B;
   assign acarreo = entrada_A & entrada_B;

endmodule
