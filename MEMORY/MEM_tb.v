`timescale 1ns/1ps

module Memory_tb();
    // Definición de señales de prueba
    reg clk;
    reg we;                             // Señal de habilitación de escritura
    reg [4:0] address_Instruction;      // Dirección de instrucción en IM
    reg [4:0] address_Data;             // Dirección de dato en DM
    reg [31:0] W_Data;                  // Dato de escritura en DM
    wire [31:0] R_Instruction;          // Salida de instrucción de IM
    wire [31:0] R_Data;                 // Salida de dato de DM

    // Instancia del módulo Memory
    Memory uut (
        .clk(clk),
        .address_Instruction(address_Instruction),
        .we(we),
        .address_Data(address_Data),
        .W_Data(W_Data),
        .R_Instruction(R_Instruction),
        .R_Data(R_Data)
    );

    // Generación del reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("MEM_tb.vcd");
        $dumpvars(0, Memory_tb);

        //TEST 1: Escritura en una dirección de DM
        address_Instruction = 5'd24;    // Instrucción store (sw) en la posición 24 de IM
        address_Data = 5'd3;            // Dirección de escritura en DM
        W_Data = 32'h12345678;          // Dato a guardar
        we = 1;                         // Habilitar escritura en DM
        #10;

        //TEST 2: Escritura en otra dirección de DM
        address_Instruction = 5'd24;    // Reusar la instrucción 24 de IM
        address_Data = 5'd10;           // Dirección de escritura en DM
        W_Data = 32'h87654321;          // Dato a guardar
        we = 1;
        #10;

        //TEST 3: Escritura en una dirección diferente de DM
        address_Instruction = 5'd24;    // Reusar instrucción 24 de IM
        address_Data = 5'd15;           // Dirección de escritura en DM
        W_Data = 32'hA5A5A5A5;          // Dato a guardar
        we = 1;
        #10;

        //TEST 4: Lectura de la primera dirección de DM
        address_Instruction = 5'd27;    // Instrucción load (lw) en la posición 27 de IM
        address_Data = 5'd3;            // Dirección de lectura en DM
        we = 0;                         // Deshabilitar escritura
        #10;

        //TEST 5: Lectura de la segunda dirección de DM
        address_Instruction = 5'd27;    // Reusar instrucción load (lw)
        address_Data = 5'd10;           // Dirección de lectura en DM
        we = 0;
        #10;

        //TEST 6: Lectura de la tercera dirección de DM
        address_Instruction = 5'd27;    // Reusar instrucción load (lw)
        address_Data = 5'd15;           // Dirección de lectura en DM
        we = 0;
        #10;
        
        //TEST 7: Escritura en una cuarta dirección de DM
        address_Instruction = 5'd24;    // Reusar instrucción store (sw)
        address_Data = 5'd20;           // Dirección de escritura en DM
        W_Data = 32'h5A5A5A5A;          // Dato a guardar
        we = 1;
        #10;

        //TEST 8: Lectura de la cuarta dirección de DM
        address_Instruction = 5'd27;    // Reusar instrucción load (lw)
        address_Data = 5'd20;           // Dirección de lectura en DM
        we = 0;
        #10;
        
        $finish;
    end
endmodule
