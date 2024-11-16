//COMPONENTE: Multiplexor 2x1
//brief: Multiplexor 2x1 de 32 bits

module MUX2x1(
    input wire [31:0] in0,      //Entrada 1 de 32 bits
    input wire [31:0] in1,      //Entrada 2 de 32 bits
    input wire sel,             //Señal de seleccion.
    output wire [31:0] out      //Salida de 32 bits
);
    assign out = (sel) ? in1 : in0;   //Seleccion de entrada basada en sel
endmodule