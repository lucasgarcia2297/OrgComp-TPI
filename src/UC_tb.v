`timescale 1ns/1ns
module UC_tb();
    reg [6:0] opcode;       // Entrada código de operación.
    reg funct7_b5;          // Entrada funct7, bit 5.
    reg [2:0] funct3;       // Entrada funct3.
    reg zero;               // Entrada zero.
    // Salidas 
    wire [1:0] PCSrc;       // Salida PCSrc.
    wire [1:0] resSrc;      // Salida de resSrc de 2 bits correspondiente a data_S.
    wire memWrite;          // Salida memwrite.
    wire [2:0] ALUcontrol;  // Salida control de la ALU.
    wire aluSrc;            // Salida aluSrc.
    wire [1:0] inmSrc;      // Salida inmSrc de 2 bits.
    wire regWrite;          // Salida regWrite.
    
    // Señal Intermedia
    reg [6:0] f7;       // Entrada funct7.


    UC uut(
        .opcode(opcode),
        .funct7_b5(funct7_b5),
        .funct3(funct3),
        .zero(zero),
        .PCSrc(PCSrc),
        .resSrc(resSrc),
        .memWrite(memWrite),
        .ALUcontrol(ALUcontrol),
        .aluSrc(aluSrc),
        .inmSrc(inmSrc),
        .regWrite(regWrite)
    );

    //Inicializacion de las seniales de entrada
    initial begin
    $dumpfile("UC_tb.vcd");
    $dumpvars(0, UC_tb);
        // Ejemplo nulo
        opcode = 7'b0000000;   
        f7 = 7'b0000000;
        funct7_b5 = f7[5];
        funct3 = 3'b000;   
        zero = 1'b0;          
        #5;

        // Ejemplo de un JAL
        opcode = 7'b1101111;
        f7 = 7'b0000000;
        funct7_b5 = f7[5];
        funct3 = 3'b000;
        zero = 1'b0;   
        #5;
        $finish;
    end
endmodule;