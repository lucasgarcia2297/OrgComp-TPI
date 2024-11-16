//COMPONENTE: REGISTRO CONTADOR DE PROGRAMA (PC)
//brief: es un registro de 16 bits de tipo biestable D.
module PC(
    input wire clk,                 //Señal de reloj
    input wire [31:0] pcNext,       //Siguiente valor de contador de programa.
    output wire [31:0] pc           //Salida, valor del contador de programa.
    );
    
    reg [31:0] auxPC;

    initial begin
        auxPC = 32'b0;
    end

    always @(posedge clk) begin
        auxPC <= pcNext;
    end
    assign pc = auxPC;
endmodule