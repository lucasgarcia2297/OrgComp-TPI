`include "../Modules/SE.v"

module tb_SE();
    reg[24:0] inm; 
    reg[1:0] src;
    wire[31:0] inmExt; 

SE uut(
    .inm(inm), 
    .src(src),
    .inmExt(inmExt)
);

initial begin
    $dumpfile("./gtkwave/tb_SE.vcd");
    $dumpvars(0, tb_SE);
    
    // // TEST 1: Instrucción tipo I (src = 00)
    // // inm[24:13] = 12'b111111111111 (bit de signo inm[24] es 1)
    // // Debe extender el bit de signo y tomar los bits [24:13] del inmediato.
    // inm = 25'b1111111111110000000000000;
    // src = 2'b00;
    // #10;
    // // inmExt esperado: 0xFFFFFFFF (extensión del bit de signo)
        
    // // TEST 2: Instrucción tipo S (src = 01)
    // // inm[24:18] = 7'b0000001, inm[4:0] = 5'b11111
    // // inmExt esperado: {{20{inm[24]}}, inm[24:18], inm[4:0]} = 0xFF00003F (extensión del bit de signo con combinación de bits)
    // inm = 25'b0000001111110000001111111;
    // src = 2'b01;
    // #10;
    // // inmExt esperado: 0xFF00003F
    
    // // TEST 3: Instrucción tipo B (src = 10)
    // // inm[24] = 1, inm[0] = 0, inm[23:18] = 6'b101010, inm[4:1] = 4'b1100
    // inm = 25'b1101010110000000000111100;
    // src = 2'b10;
    // #10;
    // // inmExt esperado: {{19{inm[24]}}, inm[24], inm[0], inm[23:18], inm[4:1], 1'b0} = 0xFF500C00
    
    // // TEST 4: Instrucción tipo I con signo 0
    // // inm[24:13] = 12'b000000000001
    // inm = 25'b0000000000010000000000000;
    // src = 2'b00;
    // #10;
    // // inmExt esperado: 0x00001000 (extensión del bit de signo en 0)
    
    // // TEST 5: Instrucción tipo S con bits de menor valor
    // // inm[24:18] = 7'b0000010, inm[4:0] = 5'b00010
    // inm = 25'b0000010000100000000000010;
    // src = 2'b01;
    // #10;
    // // inmExt= 0x00000202
    
    //TEST TIPO I
    inm = 25'b0000000000110000000001000; //addi s0, zero, 3
    src = 2'b00; 
    // inmExt = 00000000000000000000000000000011; //Este debe ser el resultado.
    #10; 
    //TEST TIPO S
    inm = 25'b0011100111000111110011101;
    src = 2'b01; 
    // inmExt = 11110011101; //Este debe ser el resultado.
    #10; 
    //TEST TIPO B
    inm = 25'b0011100111000111110011101;
    src = 2'b10; 
    // inmExt = 011110011101; //Este debe ser el resultado.
    #10; 
    
    //TEST TIPO J
    inm = 25'b0011100111000111110011101;
    src = 2'b11; 
    // inmExt = 11111001110100111000; //Este debe ser el resultado.
    #10; 
        
        
end;
endmodule;

