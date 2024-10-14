`include "../Modules/IM.v"
module tb_IM();
    reg [4:0] addressIM;
    wire [31:0] inst;

    IM uut(
        .addressIM(addressIM),
        .inst(inst)
    );

    initial begin
        $dumpfile("./gtkwave/tb_IM.vcd");
        $dumpvars(0, tb_IM);
        addressIM = 5'b11;
        #10;
        addressIM = 5'b0;
        #10;
        addressIM = 5'b01;
        #10;
    end;

endmodule