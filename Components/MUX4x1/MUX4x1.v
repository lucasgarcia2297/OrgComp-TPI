//COMPONENTE: Multiplexor 4x1
//brief: Multiplexor 4x1 de 32 bits, con selector de 2 bits

module MUX4x1(
    input wire [31:0] in0,      //Entrada 1 de 32 bits
    input wire [31:0] in1,      //Entrada 2 de 32 bits
    input wire [31:0] in2,      //Entrada 3 de 32 bits
    input wire [31:0] in3,      //Entrada 4 de 32 bits
    input wire [1:0] sel,             //Señal de seleccion.
    output wire [31:0] out      //Salida de 32 bits
);
    reg [31:0] aux;

    always @(*) begin
        case (sel)
            2'b00: aux = in0;
            2'b01: aux = in1;
            2'b10: aux = in2;
            2'b11: aux = in3;
            default: aux = 32'bx;
        endcase
    end
    assign out = aux;
endmodule