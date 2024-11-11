//MÓDULO BANCO DE REGISTROS
//brief: arreglo de 32 registros de 32 bits con:
module BR(
    input wire clk,         //señal de reloj
    input wire[4:0] a1,     //dirección registro 1
    input wire[4:0] a2,     //dirección registro 2
    input wire[4:0] a3,     //dirección registro 3
    input wire we,          //señal de escritura
    input wire[31:0] wd,   //dato de escritura
    output wire[31:0] rd1,  //dato de lectura 1
    output wire[31:0] rd2   //dato de lectura 2
);
    reg [31:0] mem [31:0];

    //Escritura
    always @(posedge clk) begin
        if (we) begin 
            if (a3 != 5'b0) begin //No se puede escribir en el primer registro (zero)
                mem[a3] <= wd;
            end;
        end;
    end;
    //Lectura
    assign rd1 = (a1 == 0) ? 32'h0 : mem[a1];
    assign rd2 = (a2 == 0) ? 32'h0 : mem[a2];
endmodule