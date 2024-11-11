`timescale 1ns/1ns
module SE_tb;

    // Definición de señales
    reg [24:0] inm;
    reg [1:0] src;
    wire [31:0] inmExt;
    reg [31:0] instr; // señal intermedia para la instrucción 

    // Instancia del módulo SE
    SE dut(
        .inm(inm),
        .src(src),
        .inmExt(inmExt)
    );

    // Generación de estímulos
    initial begin
        $dumpfile("./SE_tb.vcd");
        $dumpvars(0, SE_tb);
        //TEST TIPO I
        /*
            ADDI x10, x5, 4
            imm[11:0]    | rs1   | funct3 | rd      | opcode  
            000000000100 | 00101 | 000    | 01010   | 0010011
        */
        inm = 25'b0000000001000010100001011;
        src = 2'b00;
        // inmExt = 00000000000000000000000000000100 // Valor esperado en inmExt
        #10

        /*
            SLTI x11, x6, 5
            imm[11:0]    | rs1   | funct3 | rd      | opcode  
            000000000101 | 00110 | 010    | 01011   | 0010011
        */
        inm = 25'b0000000001010011001001011;
        src = 2'b00;
        // inmExt = 00000000000000000000000000000101 // Valor esperado en inmExt
        #10

        /*
            ORI x8, x6, 15
            imm[11:0]    | rs1   | funct3 | rd      | opcode  
            000000001111 | 00110 | 110    | 01000   | 0010011
        */
        inm = 25'b0000000011110011011001000;
        src = 2'b00;
        // inmExt = 00000000000000000000000000001111 // Valor esperado en inmExt
        #10
        //FIN TEST TIPO I

        //TEST TIPO S
        /*
            00000010101001101000001100100011
            inm[11:5] | rs2   | rs1   | funct3 | inm[4:0] | opcode
            0000001   | 01011 | 00101 | 000    | 10001    | 0100011
        */
        inm = 25'b0000001010100110100000110;
        src = 2'b01;
        // inmExt = 00000000000000000000000000100110 // Valor esperado en inmExt
        #10
        
        /*
            SW x5, 20(x10)
            00000000010101010010101010100011
            inm[11:5] | rs2   | rs1   | funct3 | inm[4:0] | opcode
            0000000   | 01010 | 00101 | 010    | 10100    | 0100011
        */
        inm = 25'b0000000001010101001010101;
        src = 2'b01;
        // inmExt = 00000000000000000000000000010101 // Valor esperado en inmExt
        #10
        //FIN TEST TIPO S

        // TEST TIPO B
        //TEST TIPO B
        /*
            BLT x9, x6, 8
            00000000011001001100010001100011
            inm[12] | inm[10:5] | rs2   | rs1   | funct3 | inm[4:1] | inm[11] | opcode
            0       | 000110    | 01011 | 00110 | 100    | 00100    | 1       | 1100011
           
        */
        inm = 25'b0011100111000111110011101;
        src = 2'b10; 
        // inmExt = 00000000000000000000101110011100; //Este debe ser el resultado.
        #10; 
        //FIN TEST TIPO B

        //TEST TIPO J
        /* 
            JAL x1, 8
            0x008000EF
            00000000100000000000000011101111
            inm[20] | inm[10:1] | inm[11] | inm[19:12] | inm[0] | opcode
            0       | 0000000000 | 1       | 00000000   | 1      | 1101111
        */
        instr = 32'h008000EF;
        inm = instr[31:7];
        src = 2'b11; 
        // inmExt = 00000000000000000000000000001000; //Este debe ser el resultado.
        #10; 
        $finish;
    end 
endmodule