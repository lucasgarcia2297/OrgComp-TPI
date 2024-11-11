`include "../Modules/BR.v"

module tb_BR();
    reg clk;       
    reg we;       
    reg[4:0] a1, a2, a3;
    reg[31:0] wd;
    wire[31:0] rd1, rd2;  

    BR uut(
        .clk(clk),
        .a1(a1),
        .a2(a2),
        .a3(a3),
        .we(we),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2)
    );

    // Generador de reloj
    always #5 clk = ~clk;

    initial begin
        $dumpfile("./gtkwave/tb_BR.vcd");
        $dumpvars(0, uut); 
        clk = 0;
        we = 0;
        a1 = 0; 
        a2 = 0;
        a3 = 0;
        wd = 0;

        // Prueba 1: Escribir y leer en la dirección 1
        #10;
        we = 1;
        a3 = 5'b00001;
        wd = 32'hAAAA_AAAA;
        #10;
        we = 0;
        a1 = 5'b00001;
        #10;

        // Prueba 2: Escribir y leer en la dirección 2
        we = 1;
        a3 = 5'b00010;
        wd = 32'hBBBB_BBBB;
        #10;
        we = 0;
        a2 = 5'b00010;
        #10;

        // Prueba 3: Escribir y leer en la dirección 3
        we = 1;
        a3 = 5'b00011;
        wd = 32'hCCCC_CCCC;
        #10;
        we = 0;
        a1 = 5'b00011;
        #10;

        // Prueba 4: Escribir y leer en la dirección 4
        we = 1;
        a3 = 5'b00100;
        wd = 32'hDDDD_DDDD;
        #10;
        we = 0;
        a2 = 5'b00100;
        #10;

        $finish;
    end
endmodule
