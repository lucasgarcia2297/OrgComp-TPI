`timescale 1ns/1ns
module MUX2x1_tb();
    reg[31:0] in0;
    reg[31:0] in1;
    reg sel;
    wire[31:0] out;

    MUX2x1 uut(
        .in0(in0),
        .in1(in1),
        .sel(sel),
        .out(out)
    );

    initial begin
        $dumpfile("./MUX2x1_tb.vcd");
        $dumpvars(0, MUX2x1_tb);

        in0 = 32'h44f5a600;
        in1 = 32'h11111111;
        sel = 1'b0;
        // out = 44f5a600
        #10;
        
        sel = 1'b1;
        // out = 11111111
        #10;
    end
endmodule