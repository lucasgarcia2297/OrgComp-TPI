//MÓDULO MEMORIA DE DATOS
//brief: es un arreglo de 32 registros de 32 bits
module DM(
    input wire clk,                 //señal de reloj
    input wire[31:0] address,       //dirección de lectura/escritura
    input wire[31:0] wd,            //dato de escritura
    input wire we,                  //señal de escritura
    output wire[31:0] rd            //dato de lectura
);

reg [31:0] mem [31:0];
reg [31:0] auxRD;

always @(posedge clk) begin
    if (we) begin
        mem[address] = wd; 
    end;    
    auxRD = mem[address];
end;
assign rd = auxRD;
endmodule; 