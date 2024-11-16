//MODULO: ALU DECODER
//brief: Decodificador de señales de control de la ALU

module ALUDECO(
    input wire [1:0] ALUop,             // Señal de control de la ALU
    input wire opcode_b5,               //bit numero 5 del opcode
    input wire funct7_b5,               //bit numero 5 del funct7
    input wire [2:0] funct3,            //Campo funct3
    output wire [2:0] ALUcontrol        //Señal de control de la ALU
);

    wire RTypeSub = funct7_b5 && opcode_b5;
    reg [2:0] ALUcontrol1;

    /*
        ALU Control:
        000: add
        001: subtract
        010: and
        011: or
        100: xor -> no implementado
        101: slt
        110: srl -> no implementado
        111: sll -> no implementado
    */

    always @(*) begin
        case (ALUop)
            2'b00: ALUcontrol1 = 3'b000; //add
            2'b01: ALUcontrol1 = 3'b001; //subtract
            default: begin
                case (funct3)
                    3'b000: begin
                        if (RTypeSub) ALUcontrol1 = 3'b001; //subtract
                        else ALUcontrol1 = 3'b000; //add
                    end
                    3'b010: ALUcontrol1 = 3'b101; //slt
                    3'b110: ALUcontrol1 = 3'b011; //or
                    3'b111: ALUcontrol1 = 3'b010; //and
                    default: ALUcontrol1 = 3'bxxx; //add
                endcase
            end
        endcase
    end

    assign ALUcontrol = ALUcontrol1;
endmodule