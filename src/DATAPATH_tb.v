`timescale 1ns/1ns
module DATAPATH_tb();
    reg clk;                 // Clock
    reg [31:0] ins;          // Instruction                  // Viene de la Memory
    reg [31:0] data1;        // Data de la memoria
    reg [1:0] PCSrc;              //Salida PCSrc
    reg [1:0] resSrc;       //Salida de resSrc de 2 bits correspondiente a data_S
    reg [2:0] ALUcontrol;   //Control de la ALU
    reg aluSrc;             //Salida aluSrc
    reg [1:0] inmSrc;       //Salida inmSrc de 2 bits
    reg regWrite;           //Salida regWrite
    wire [31:0] pc;                //al Module Memory // Dirección de la instrucción
    wire [31:0] address;           //al Module Memory // Dirección de la memoria
    wire [31:0] writeData;        //al Module Memory // Dato a escribir en la memoria
    wire zero;               //al Module Unit Control
    wire funct7_b5;          //al Module Unit Control
    wire [2:0] f3;                //al Module Unit Control
    wire [6:0] opcode;            //al Module Unit Control

    DATAPATH uut(
        .clk(clk),
        .ins(ins),
        .data1(data1),
        .PCSrc(PCSrc),
        .regWrite(regWrite),
        .inmSrc(inmSrc),
        .aluSrc(aluSrc),
        .ALUcontrol(ALUcontrol),
        .resSrc(resSrc),
        .pc(pc),
        .address(address),
        .writeData(writeData),
        .zero(zero),
        .funct7_b5(funct7_b5),
        .f3(f3),
        .opcode(opcode)
    );

    initial begin
        $dumpfile("./DATAPATH_tb.vcd");
        $dumpvars(0, DATAPATH_tb);

        clk = 1'b0;

        ins = 32'h00300413; //addi s0, zero, 3 	# a = 3 // I-type
        data1 = 32'h00000000;
        PCSrc = 2'b01;
        resSrc = 2'b00;
        ALUcontrol = 3'b000;
        aluSrc = 1'b1;
        inmSrc = 2'b00;
        regWrite = 1'b1;
        
        clk = 1'b0;  
        #50;
        clk = 1'b1;  
        #50;   
        clk = 1'b0;  
        #50;
        clk = 1'b1;  
        #50;   
        clk = 1'b0;  
        #50;   

        $finish;
    end;
endmodule