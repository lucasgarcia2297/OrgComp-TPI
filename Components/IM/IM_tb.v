`timescale 1ns/1ns
module IM_tb();
    reg [4:0] addressIM;
    wire [31:0] inst;

    IM uut(
        .addressIM(addressIM),
        .inst(inst)
    );

    initial begin
        $dumpfile("./IM_tb.vcd");
        $dumpvars(0, IM_tb);

        addressIM = 5'b11;
        #10;
        addressIM = 5'b0;
        #10;
        addressIM = 5'b01;
        #10;
    end;

endmodule