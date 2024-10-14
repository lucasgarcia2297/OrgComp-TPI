module IM(
    input wire [4:0] addressIM,
    output wire [31:0] inst
);

/*Defino el contenido de la memoria de instrucciones*/
reg[31:0] memory [31:0];
reg[4:0] deco_address;

initial begin
    //# Inicializa los operandos
    memory[0] = 32'h01900213; // addi x4, x0, 25  # Primer operando
    memory[1] = 32'h01400293; // addi x5, x0, 20  # Segundo operando
                          //     # Inicializa los registros auxiliares
    memory[2] = 32'h00000333; // add x6, x0, x0  # Acumulador para el resultado
    memory[3] = 32'h00100393; // addi x7, x0, 1  # Máscara para el bit actual
                          //  loop:
    memory[4] = 32'h00727433; //     and x8, x4, x7  # Verifica si el bit actual es 1
    memory[5] = 32'h00040463; //     beq x8, x0, skip  # Si el bit actual es 0, salta la suma
    memory[6] = 32'h00530333; //     add x6, x6, x5  # Suma el segundo operando al acumulador  
                          // skip:
    memory[7] = 32'h00129293; //     slli x5, x5, 1  # Desplaza el segundo operando a la izquierda
    memory[8] = 32'h00139393; //     slli x7, x7, 1  # Desplaza la máscara a la izquierda
    memory[9] = 32'h0003a433; //     slt x8, x7, x0  # Verifica si la máscara se ha desbordado
    memory[10] = 32'hfe0404e3; //     beq x8, x0, loop  # Si la máscara no se ha desbordado, repite el bucle

end

/*Leer la instruccion en la direccion especificada*/
always @(addressIM) begin
    deco_address = addressIM;
end;
assign inst = memory[deco_address];

endmodule