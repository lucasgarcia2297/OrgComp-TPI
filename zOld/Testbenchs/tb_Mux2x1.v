`include "../Modules/Mux2x1.v"
module tb_Mux2x1();
    reg[31:0] e1;
    reg[31:0] e2;
    wire[31:0] sal;
    reg sel;

    Mux2x1 uut(
        .e1(e1),
        .e2(e2),
        .sel(sel),
        .sal(sal)
    );

    initial begin
        $dumpfile("./gtkwave/tb_Mux2x1.vcd");
        $dumpvars(0, tb_Mux2x1);
        //La salida debería ser 44f5a600
        e1 = 32'h44f5a600;
        e2 = 32'h11111111;
        sel = 1'b0;
        #10;
        //La salida debería ser 11111111
        sel = 1'b1;
        #10;
    end

endmodule