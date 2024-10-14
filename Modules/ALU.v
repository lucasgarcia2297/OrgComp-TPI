//Modulo Unidad Aritmetica Logica (ALU)
//Dispositivo que realiza las operaciones: suma, resta por complemento a 2,
//AND, OR, SLE: 
module ALU(
    input wire [31:0] srcA,         //Entrada 1 de 32 bits.
    input wire [31:0] srcB,         //Entrada 2 de 32 bits.
    input wire [2:0] ALUControl,    //Selector de operacion de 3 bits.
    output wire [31:0] res,         //Salida de 32 bits.
    output wire zero                //TRUE cuando ALUControl = b001 and auxRes = 0;
);

reg[31:0] auxRes;
reg auxZero;

always @(*) begin
    case (ALUControl)
        3'b000: auxRes = srcA + srcB;                   //ADD
        3'b001: auxRes = srcA - srcB;                   //SUB
        3'b010: auxRes = srcA & srcB;                   //AND
        3'b011: auxRes = srcA | srcB;                   //OR
        3'b101: auxRes = (srcA < srcB) ? 1'b1 : 1'b0;   //SLT
        default: auxRes = 32'bx;                        //Valor predeterminado
    endcase
    if((ALUControl == 3'b001) | (auxRes == 32'b0)) begin
        auxZero <= 1'b1;
    end
    else begin
        auxZero <= 1'b0;
    end
end;
assign res = auxRes;
assign zero = auxZero;
endmodule