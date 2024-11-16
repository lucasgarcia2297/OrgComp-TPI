//COMPONENTE: SUMADOR
//brief: Dispositivo que suma dos operandos que recibe como entrada.
module ADDER(
    input wire [31:0] op1,
    input wire [31:0] op2,
    output wire [31:0] sal
    );

    reg [31:0] auxSuma;

    always @(*) begin
        if (^op1 === 1'bx) begin
            auxSuma = op2;
        end
        else begin
            if (^op2 === 1'bx) begin
                auxSuma = op1;
            end
            else begin
                auxSuma = op1 + op2;
            end
        end
    end
    assign sal = auxSuma;
endmodule