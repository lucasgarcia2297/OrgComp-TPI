`include "../Modules/MainDeco.v"
module tb_MainDeco();
    reg [6:0] op;      // Entrada op de 7 bits
    wire branch;       // Salida branch
    wire jump;         // Salida jump
    wire [1:0] resSrc; // Salida resSrc de 2 bits se corresponde con Dato_S
    wire memWrite;     // Salida memWrite
    wire aluSrc;       // Salida aluSrc
    wire [1:0] inmSrc; // Salida inmSrc de 2 bits 
    wire regWrite;     // Salida regWrite
    wire [1:0] aluOp;  // Salida aluOp de 2 bits

MainDeco uut(
    .op(op),
    .branch(branch),
    .resSrc(resSrc),
    .memWrite(memWrite),
    .aluSrc(aluSrc),
    .inmSrc(inmSrc),
    .regWrite(regWrite),
    .aluOp(aluOp),
    .jump(jump)
);

initial begin
    $dumpfile("./gtkwave/tb_MainDeco.vcd");
    $dumpvars(0, tb_MainDeco);
    //TEST lw:op=0000011
    op = 7'b0000011;
    #10;
    //TEST sw:op=0100011
    op = 7'b0100011;
    #10;
    //TEST R-Type:op=0110011
    op = 7'b0110011;
    #10;
    //TEST lw:op=1100011
    op = 7'b1100011;
    #10;
    //TEST addi:op=0010011
    op = 7'b0010011;
    #10;
    //TEST jal:op=1101111
    op = 7'b1101111;
    #10;
end;
endmodule;