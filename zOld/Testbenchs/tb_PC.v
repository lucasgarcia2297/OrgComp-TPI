`include "../Modules/PC.v"

module tb_PC();
    //Declarar seniales para el test_bench
    reg clk;
    reg [31:0] pcNext;
    wire [31:0] pc;

    //Instanciar el modulo bajo prueba (PC)
    PC uut(
        .clk(clk),
        .pcNext(pcNext),
        .pc(pc)
    );

    //Inicializacion de las seniales de entrada
    initial begin
        $dumpfile("./gtkwave/tb_PC.vcd");
        $dumpvars(0, tb_PC);

        clk = 1'b0;         //Inicializar la senial de reloj
        pcNext = 16'h0000; //Valor de ejemplo para pcNext

        for (integer i = 0; i < 10; i = i + 1) begin  // Cambia 10 por la cantidad de incrementos deseados
            // Incrementar pcNext en 4 bytes
            case(clk)
                1'b1:pcNext = pcNext + 32'h00000004;
            endcase
            clk = ~clk; 
            #5;

            // Mostrar el valor de pcNext en cada iteración
            $display("clk = %h, pcNext = %h, pc = %h", clk, pcNext, pc);
        end
    end

endmodule