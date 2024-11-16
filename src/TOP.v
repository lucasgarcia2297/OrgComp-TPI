// TOP
// brief: module that unifies the RISC-V32I with the memory module and simulates a computer.

// `include "./src/MEMORY.v"
// `include "./src/RISCV32I.v"
// `include "../Components/IM/IM.v"

module TOP(
    input wire clk                 // Clock;
    );

    // Wires
    wire [31:0] pc;                     // Next Instruccion address
    wire [31:0] address;                // Address of the Data Memory
    wire writeEnable;                   // Data to write in the Data Memory
    wire [31:0] writeData;              // Data to write in the Data Memory
    wire [31:0] instruction;            // Instruccion of the Instruction Memory
    wire [31:0] data;                   // Data of the Data Memory

    MEMORY Memory(
        .clk(clk),
        .address_Instruction(pc[4:0]),
        .we(writeEnable),
        .address_Data(address[4:0]),
        .W_Data(writeData),
        .R_Instruction(instruction),
        .R_Data(data)
    );

    RISCV32I RISCV32I(
        .clk(clk),
        .instruction(instruction),
        .data1(data),
        .pc(pc),
        .address(address),
        .writeData(writeData),
        .writeEnable(writeEnable)
    );

endmodule