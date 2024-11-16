`timescale 1ns/1ns
module MUX4x1_tb();
    reg[31:0] in0;
    reg[31:0] in1;
    reg[31:0] in2;
    reg[31:0] in3;
    reg [1:0] sel;
    wire[31:0] out;

    MUX4x1 uut(
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .sel(sel),
        .out(out)
    );

    initial begin
        $dumpfile("./MUX4x1_tb.vcd");
        $dumpvars(0, MUX4x1_tb);

        in0 = 32'h00000000;
        in1 = 32'h11111111;
        in2 = 32'h22222222;
        in3 = 32'h33333333;
        sel = 2'b00;
        // out = 00000000
        #10;

        sel = 2'b01;
        // out = 11111111
        #10;

        sel = 2'b10;
        // out = 22222222
        #10;

        sel = 2'b11;
        // out = 33333333
        #10;
    end
endmodule