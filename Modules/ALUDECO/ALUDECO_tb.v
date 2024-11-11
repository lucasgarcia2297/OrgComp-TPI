`timescale 1ns/1ns
module ALUDECO_tb();
    reg [1:0] ALUop;        // Señal de control de la ALU.
    reg opcode_b5;          // Bit numero 5 del opcode.
    reg funct7_b5;          // Bit numero 5 del funct7.
    reg [2:0] funct3;       // Campo funct3.
    wire [2:0] ALUcontrol;  // Señal de control de la ALU.

    ALUDECO uut(
        .ALUop(ALUop),
        .opcode_b5(opcode_b5),
        .funct7_b5(funct7_b5),
        .funct3(funct3),
        .ALUcontrol(ALUcontrol)
    );

    initial begin
        $dumpfile("./ALUDECO_tb.vcd");
        $dumpvars(0, ALUDECO_tb);
        //TEST add:ALUop=00,opcode_b5=x,funct7_b5=x,funct3=xxx
        ALUop = 2'b00;
        funct3 = 3'bxxx;
        opcode_b5 = 1'bx;
        funct7_b5 = 1'bx;
        // ALUControl_expected = 000
        #10;
        //TEST subtract:ALUop=01,opcode_b5=x,funct7_b5=x,funct3=xxx
        ALUop = 2'b01;
        funct3 = 3'bxxx;
        opcode_b5 = 1'bx;
        funct7_b5 = 1'bx;
        // ALUControl_expected = 001
        #10;
        //TEST add:ALUop=10,opcode_b5=0,funct7_b5=1,funct3=000
        ALUop = 2'b10;
        funct3 = 3'b000;
        opcode_b5 = 1'b0;
        funct7_b5 = 1'b1;
        // ALUControl_expected = 000
        #10;
        //TEST subtract:ALUop=10,opcode_b5=1,funct7_b5=1,funct3=000
        ALUop = 2'b10;
        funct3 = 3'b000;
        opcode_b5 = 1'b1;
        funct7_b5 = 1'b1;
        // ALUControl_expected = 001
        #10;
        //TEST slt:ALUop=10,opcode_b5=x,funct7_b5=x,funct3=010
        ALUop = 2'b10;
        funct3 = 3'b000;
        opcode_b5 = 1'bx;
        funct7_b5 = 1'bx;
        funct3 = 3'b010;
        // ALUControl_expected = 101
        #10;
        //TEST or:ALUop=10,opcode_b5=x,funct7_b5=x,funct3=110
        ALUop = 2'b10;
        opcode_b5 = 1'bx;
        funct7_b5 = 1'bx;
        funct3 = 3'b110;
        // ALUControl_expected = 011
        #10;
        //TEST and:ALUop=10,opcode_b5=x,funct7_b5=x,funct3=111
        ALUop = 2'b10;
        opcode_b5 = 1'bx;
        funct7_b5 = 1'bx;
        funct3 = 3'b111;
        // ALUControl_expected = 111
        #10;
        $finish;
    end
endmodule