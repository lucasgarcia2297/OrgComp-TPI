//MODULO: MAIN DECO
//brief: Decodificador principal de instrucciones

module MAINDECO(
    input wire [6:0] opcode,        //Entrada opcode de 7 bits
    output wire branch,             //Salida de branch
    output wire jump,               //Salida de jump
    output wire [1:0] resSrc,       //Salida de resSrc de 2 bits correspondiente a data_S
    output wire memWrite,           //Salida memwrite
    output wire aluSrc,             //Salida aluSrc
    output wire [1:0] inmSrc,       //Salida inmSrc de 2 bits
    output wire regWrite,           //Salida regWrite
    output wire [1:0] aluOp         //Salida aluOp de 2 bits    
);

    reg branch1;
    reg jump1;
    reg [1:0] resSrc1;
    reg memWrite1;
    reg aluSrc1;
    reg [1:0] inmSrc1;
    reg regWrite1;
    reg [2:0] aluOp1;

    // Salida de 14 bits {branch, jump[1:0], reg, resSrc(1:0), memWrite, ALUcontrol(2:0), aluSrc, inmSrc(1:0), regWrite}

    /*
        0000011: lw
        0100011: sw
        0110011: R-Type
        1100011: beq
        0010011: I-Type
        1101111: jal
    */

    always @(*) begin
        case (opcode)
        7'b0000011:      //lw
            begin
                regWrite1 = 1'b1;
                inmSrc1 = 2'b00;
                aluSrc1 = 1'b1;
                memWrite1 = 1'b0;
                resSrc1 = 2'b01;
                branch1 = 1'b0;
                aluOp1 = 2'b00;
                jump1 = 1'b0;
            end
        7'b0100011:     //sw
            begin
                regWrite1 = 1'b0;
                inmSrc1 = 2'b01;
                aluSrc1 = 1'b1;
                memWrite1 = 1'b1;
                resSrc1 = 2'bxx;
                branch1 = 1'b0;
                aluOp1 = 2'b00;
                jump1 = 1'b0;
            end
        7'b0110011:     //R-Type
            begin
                regWrite1 = 1'b1;
                inmSrc1 = 2'bxx;
                aluSrc1 = 1'b0;
                memWrite1 = 1'b0;
                resSrc1 = 2'b00;
                branch1 = 1'b0;
                aluOp1 = 2'b10;
                jump1 = 1'b0;
            end
        7'b1100011:     //B-Type
            begin
                regWrite1 = 1'b0;
                inmSrc1 = 2'b10;
                aluSrc1 = 1'b0;
                memWrite1 = 1'b0;
                resSrc1 = 2'bxx;
                branch1 = 1'b1;
                aluOp1 = 2'b01;
                jump1 = 1'b0;
            end
        7'b0010011:     //I-Type
            begin
                regWrite1 = 1'b1;
                inmSrc1 = 2'b00;
                aluSrc1 = 1'b1;
                memWrite1 = 1'b0;
                resSrc1 = 2'b00;
                branch1 = 1'b0;
                aluOp1 = 2'b10;
                jump1 = 1'b0;
            end
        7'b1101111:        //jal
            begin
                regWrite1 = 1'b1;
                inmSrc1 = 2'b11;
                aluSrc1 = 1'bx;
                memWrite1 = 1'b0;
                resSrc1 = 2'b10;
                branch1 = 1'b0;
                aluOp1 = 2'bxx;
                jump1 = 1'b1;
            end
        default: begin //opcode no contemplado, retorno todo en 0. 
            regWrite1 = 0;
            inmSrc1 = 2'b00;
            aluSrc1 = 0;
            memWrite1 = 0;
            resSrc1 = 2'b00;
            branch1 = 0;
            aluOp1 = 2'b00;
            jump1 = 0;
        end
    endcase
    end

    assign regWrite = regWrite1;
    assign inmSrc   = inmSrc1;
    assign aluSrc   = aluSrc1;
    assign memWrite = memWrite1;
    assign resSrc   = resSrc1;
    assign branch   = branch1;
    assign aluOp    = aluOp1;
    assign jump = jump1;
endmodule