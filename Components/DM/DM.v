//COMPONENTE: MEMORIA DE DATOS
//brief: es un arreglo de 32 registros de 32 bits.

module DM(
    input wire clk,                 //Señal de reloj
    input wire [4:0] address,       //Dirección de lectura/escritura
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
            memory[address] <= wd;
        end
    end
    assign rd = memory[address];

    /* reg [31:0] memory [31:0];

    initial
    //Escritura
    always @(posedge clk) begin
        if (we) begin 
            if (address != 5'b0) begin //No se puede escribir en el primer registro (zero)
                memory[address] <= wd;
            end;
        end;
    end;
    //Lectura
    assign rd = (address == 0) ? 32'h0 : memory[address]; */
endmodule