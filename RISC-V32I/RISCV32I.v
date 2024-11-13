//Module: RISCV32I
// brief: Processor RISC-V 32I

`include "../Modules/UC/UC.v"
`include "../Modules/DATAPATH/DATAPATH.v"

module RISCV32I(
    // Entradas
    input wire clk,                 // Clock
    input wire instruction,         // Instruction
    input wire [31:0] data1,        // Data from Memory: Data Memory
    // Salidas
    output wire [31:0] pc,          // Address next instruction             // Salida datapath
    output wire [31:0] address,     // Address Memory: Data Memory          // Salida datapath
    output wire [31:0] writeData,   // Data to write in Memory: Data Memory // Salida datapath
    output wire writeEnable,        // Enable write in Memory: Data Memory  // Salida Unit Control
);

    //Wires to connect Unit Control and Datapath
    wire [6:0] s_opcode;        // Opcode
    wire s_funct7_b5;           // Funct7 bit 5
    wire [2:0] s_funct3;        // Funct3
    wire s_zero;                // Zero
    wire s_PCSrc;               // PCSrc
    wire [1:0] s_resSrc;        // ResSrc
    wire [2:0] s_ALUcontrol;    // ALUcontrol
    wire s_aluSrc;              // AluSrc
    wire [1:0] s_inmSrc;        // InmSrc
    wire s_regWrite;            // RegWrite

    UC UnitControl(
        .opcode(s_opcode),
        .funct7_b5(s_funct7_b5),
        .funct3(s_funct3),
        .zero(s_zero),
        .PCSrc(s_PCSrc),
        .resSrc(s_resSrc),
        .memWrite(writeEnable),
        .ALUcontrol(s_ALUcontrol),
        .aluSrc(s_aluSrc),
        .inmSrc(s_inmSrc),
        .regWrite(s_regWrite)
    );

    DATAPATH DataPath(
        .clk(clk),
        // .rst(rst),
        .instruction(instruction),
        .data1(data1),
        .PCSrc(s_PCSrc),
        .regWrite(s_regWrite),
        .inmSrc(s_inmSrc),
        .aluSrc(s_aluSrc),
        .ALUcontrol(s_ALUcontrol),
        .resSrc(s_resSrc),
        .pc(pc),
        .address(address),
        .writeData(writeData),
        .zero(s_zero),
        .funct7_b5(s_funct7_b5),
        .f3(s_funct3),
        .opcode(s_opcode)
    );

endmodule