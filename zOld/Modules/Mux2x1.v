//Modulo Multiplexor 2x1
//Multiplexor 2x1 de 32 bits

module Mux2x1(
    input wire [31:0] e1,   //Entrada 1 de 32 bits
    input wire [31:0] e2,   //Entrada 2 de 32 bits
    input wire sel,         //Señal de seleccion.
    output wire [31:0] sal  //Salida de 32 bits
);

assign sal = (sel) ? e2 : e1;   //Seleccion de entrada basada en sel
endmodule