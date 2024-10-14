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

