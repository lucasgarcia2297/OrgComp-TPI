`timescale 1ns/1ns
module MAINDECO_tb();
    reg [6:0] opcode;   // Entrada código de operación.
    wire branch;        // Salida de branch.
    wire jump;          // Salida de jump.
    wire [1:0] resSrc;  // Salida de resSrc de 2 bits correspondiente a data_S.
    wire memWrite;      // Salida memwrite.
    wire aluSrc;        // Salida aluSrc.
    wire [1:0] inmSrc;  // Salida inmSrc de 2 bits.
    wire regWrite;      // Salida regWrite.
    wire [1:0] aluOp;   // Salida aluOp de 2 bits.

    MAINDECO uut(
        .opcode(opcode),
        .branch(branch),
        .jump(jump),
        .resSrc(resSrc),
        .memWrite(memWrite),
        .aluSrc(aluSrc),
        .inmSrc(inmSrc),
        .regWrite(regWrite),
        .aluOp(aluOp)
    );

    initial begin
        $dumpfile("./MAINDECO_tb.vcd");
        $dumpvars(0, MAINDECO_tb);
        //TEST lw:op=0000011
        opcode = 7'b0000011;
        #10;
        //TEST sw:opcode=0100011
        opcode = 7'b0100011;
        #10;
        //TEST R-Type:opcode=0110011
        opcode = 7'b0110011;
        #10;
        //TEST lw:opcode=1100011
        opcode = 7'b1100011;
        #10;
        //TEST addi:opcode=0010011
        opcode = 7'b0010011;
        #10;
        //TEST jal:opcode=1101111
        opcode = 7'b1101111;
        #10;
end;

endmodule