module AluDeco(
    input wire op_b5,               //bit numero 5 del opcode
    input wire f7_b5,               //bit numero 5 del funct7
    input wire [2:0] f3,            //Campo funct3
    input wire [1:0] aluOp,          //Senal de control de la ALU
    output wire [2:0] aluControl    //Senal de control de la operacion de la ALU
);

wire RTypeSub = f7_b5 && op_b5;
reg [2:0] control;  

// Asignar el valor de aluControl según la tabla de verdad
always @(*) begin
    case (aluOp)
        2'b00:
            control = 3'b000; //add
        2'b01:
            control = 3'b001; //subtraction
        default: begin
            case (f3)
                3'b000: begin
                    if (RTypeSub)
                        control = 3'b001; //sub
                    else
                        control = 3'b000; //add, addi
                end
                3'b010: begin
                    control = 3'b101; //slt, slti
                end
                3'b110: begin
                    control = 3'b011; //or, ori
                end
                3'b111: begin
                    control = 3'b010; //or, ori
                end
                default:
                    control = 3'bxxx;
            endcase;
        end
    endcase
end
    assign aluControl = control;
endmodule
