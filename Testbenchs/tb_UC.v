`include "../Modules/UC.v"
module tb_UC;
    // Entradas
    reg f7_b5;
    reg [2:0] f3;
    reg [6:0] op;
    reg zero;

    // Salida
    wire [10:0] salida;

    // Instancia de la unidad de control
    UC uut(
        .f7_b5(f7_b5),
        .f3(f3),
        .op(op),
        .zero(zero),
        .salida(salida)
    );
    //Prueba
    initial begin
        $dumpfile("./gtkwave/tb_UC.vcd");
        $dumpvars(0, tb_UC);

        //lw:op=0000011
        f7_b5 = 1'b0;
        f3 = 3'b010;
        op = 7'b0000011;
        zero = 1'b0;
        #10;

        //sw:op=0100011
        f7_b5 = 1'b0;
        f3 = 3'b001;
        op = 7'b0100011;
        zero = 1'b0;
        #10;

        //R-Type:op=0110011
        //ADD
        f7_b5 = 1'b0;
        f3 = 3'b000;
        op = 7'b0110011;
        zero = 1'b0;
        #10;

        //jal:op=1101111
        f7_b5 = 1'b0;
        f3 = 3'b000;
        op = 7'b1101111;
        zero = 1'b0;
        #10;
    end
endmodule