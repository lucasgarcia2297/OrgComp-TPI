//COMPONENTE: SUMADOR
//brief: Dispositivo que suma dos operandos que recibe como entrada.
module Adder(
    input wire [31:0] op1,
    input wire [31:0] op2,
    output wire [31:0] sal
    );

    assign sal = op1 + op2;
endmodule