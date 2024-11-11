module MainDeco(
    input wire [6:0] op,        //Entrada op de 7 bits
    output wire branch,         //Salida de branch
    output wire jump,           //Salida de jump
    output wire [1:0] resSrc,   //Salida de resSrc de 2 bits correspondiente a data_S
    output wire memWrite,       //Salida memwrite
    output wire aluSrc,         //Salida aluSrc
    output wire [1:0] inmSrc,   //Salida inmSrc de 2 bits
    output wire regWrite,       //Salida regWrite
    output wire [1:0] aluOp     //Salida aluOp de 2 bits    
);

reg branch1;
reg jump1;
reg [1:0] resSrc1;
reg memWrite1;
reg aluSrc1;
reg [1:0] inmSrc1;
reg regWrite1;
reg [2:0] aluOp1;

always @(*) begin
    case(op)
        7'b0000011: begin //lw
            aluOp1 = 2'b00;
            branch1 = 1'b0;
            resSrc1 = 2'b01;
            memWrite1 = 1'b0;
            aluSrc1 = 1'b1;
            inmSrc1 = 2'b00;
            regWrite1 = 1'b1;
            jump1 = 1'b0;
        end
        7'b0100011: begin //sw
            aluOp1 = 2'b00;
            branch1 = 1'b0;
            resSrc1 = 2'bxx;
            memWrite1 = 1'b1;
            aluSrc1 = 1'b1;
            inmSrc1 = 2'b01;
            regWrite1 = 1'b0;
            jump1 = 1'b0;
        end
        7'b0110011: begin //R-Type
            aluOp1 = 2'b10;
            branch1 = 1'b0;
            resSrc1 = 2'b00;
            memWrite1 = 1'b0;
            aluSrc1 = 1'b0;
            inmSrc1 = 2'bxx;
            regWrite1 = 1'b1;
            jump1 = 1'b0;
        end
        7'b1100011: begin //beq
            aluOp1 = 2'b01;
            branch1 = 1'b1;
            resSrc1 = 2'bxx;
            memWrite1 = 1'b0;
            aluSrc1 = 1'b0;
            inmSrc1 = 2'b10;
            regWrite1 = 1'b0;
            jump1 = 1'b0;
        end
        7'b0010011: begin //addi
            aluOp1 = 2'b10;
            branch1 = 1'b0;
            resSrc1 = 2'b00;
            memWrite1 = 1'b0;
            aluSrc1 = 1'b1;
            inmSrc1 = 2'b00;
            regWrite1 = 1'b1;
            jump1 = 1'b0;
        end
        7'b1101111: begin //jal
            aluOp1 = 2'bxx;
            branch1 = 1'b0;
            resSrc1 = 2'b10;
            memWrite1 = 1'b0;
            aluSrc1 = 1'bx;
            inmSrc1 = 2'b11;
            regWrite1 = 1'b1;
            jump1 = 2'b1;
        end
        default: begin //op no contemplado, retorno todo 0. 
            aluOp1 = 2'b00;
            branch1 = 1'b0; 
            resSrc1 = 2'b00; 
            memWrite1 = 1'b0;
            aluSrc1 = 1'b0;
            inmSrc1 = 2'b00; 
            regWrite1 = 1'b0;
        end
    endcase
end

assign branch   = branch1;
assign jump = jump1;
assign resSrc   = resSrc1;
assign memWrite = memWrite1;
assign aluSrc   = aluSrc1;
assign inmSrc   = inmSrc1;
assign regWrite = regWrite1;
assign aluOp    = aluOp1;

endmodule