`timescale 1ns/1ns
module IM_tb();
    reg [31:0] addressIM;
    wire [31:0] inst;

    IM uut(
        .addressIM(addressIM),
        .inst(inst)
    );

    initial begin
        $dumpfile("./IM_tb.vcd");
        $dumpvars(0, IM_tb);

        addressIM = 32'h00000040;
        #10;
        addressIM = 32'h00001400;
        #10;
        addressIM = 32'h00000028;
        #10;
    end;

endmodule