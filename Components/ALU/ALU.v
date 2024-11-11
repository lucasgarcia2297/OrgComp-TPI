//COMPONENTE: UNIDAD ARITMÉTICO LÓGICA (ALU)
//brief: dispositivo que realiza operaciones aritméticas y lógicas: suma, resta C2, and, or, slt

module ALU(
    input wire [31:0] srcA,    //Operando A de 32 bits
    input wire [31:0] srcB,    //Operando B de 32 bits
    input wire [2:0] aluControl,    //Código de operación de la ALU
    output wire [31:0] result,         //Salida de 32 bits.
    output wire zero                //TRUE cuando ALUControl = b001 and auxRes = 0;
);
    reg [31:0] aux;
    reg auxZero;

    always @(*) begin
        case (aluControl)
            3'b000: aux = srcA + srcB;                   //ADD
            3'b001: aux = srcA - srcB;                   //SUB
            3'b010: aux = srcA & srcB;                   //AND
            3'b011: aux = srcA | srcB;                   //OR
            3'b101: aux = (srcA < srcB) ? 1'b1 : 1'b0;   //SLT
            default: aux = 32'bx;                        //Valor predeterminado
        endcase
        if((aluControl == 3'b001) | (aux == 32'b0)) begin
            auxZero <= 1'b1;
        end
        else begin
            auxZero <= 1'b0;
        end
    end;
    assign result = aux;
    assign zero = auxZero;
endmodule;