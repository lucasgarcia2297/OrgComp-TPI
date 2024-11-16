//COMPONENTE: MEMORIA DE DATOS
//brief: es un arreglo de 32 registros de 32 bits.

module DM(
    input wire clk,                 //Señal de reloj
    input wire [4:0] addressDM,     //Dirección de lectura/escritura
    input wire we,                  //Señal de escritura
    input wire [31:0] wd,           //Dato de escritura
    output wire [31:0] rd           //Dato de lectura
);

    reg[31:0] memory[31:0];
    integer i;

    initial
    begin
        for(i = 0;i<32;i=i+1) begin
            memory[i] <= 32'h00000000;
        end
    end

    always @(posedge clk)
    begin
        if(we)
        begin
            memory[addressDM] <= wd;
        end
    end
    assign rd = memory[addressDM];

endmodule