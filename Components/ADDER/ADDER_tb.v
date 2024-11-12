`timescale 1ns/1ns
module ADDER_tb;
    reg [31:0] op1;
    reg [31:0] op2;

    wire [31:0] sal;

    ADDER uut(
        .op1(op1),
        .op2(op2),
        .sal(sal)
    );

    initial begin
        $dumpfile("./ADDER_tb.vcd");
        $dumpvars(0, ADDER_tb);

        op1 = 32'h00000001;
        op2 = 32'h00000002;
        // sal = 32'h00000003
        #10;
        op1 = 32'h00000003;
        op2 = 32'h00000005;
        // sal = 32'h00000008
        #10;
    end
endmodule