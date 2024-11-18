`timescale  1ns/1ns

module RISCV32I_tb;
    reg clk;
    reg reset;
    reg [31:0] instruction;
    reg [31:0] data1;
    wire [31:0] pc;
    wire [31:0] address;
    wire [31:0] writeData;
    wire writeEnable;

    RISCV32I uut(
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .data1(data1),
        .pc(pc),
        .address(address),
        .writeData(writeData),
        .writeEnable(writeEnable)
    );

    initial begin
        $dumpfile("RISCV32I_tb.vcd");
        $dumpvars(0, RISCV32I_tb);

        clk = 1'b0;
        reset = 1'b1;
        instruction = 32'h00300413;       //addi s0, zero, 3 	# a = 3
        data1 = 32'h00000000;

        #10 reset = 1'b0; clk = 1'b1;
        #10 clk = 1'b0;
        #10 clk = 1'b1;
        #10 clk = 1'b0;
        #10 clk = 1'b1;
    end

endmodule
    