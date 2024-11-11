`include "../Components/IM/IM.v"
`include "../Components/DM/DM.v"

//MEMORIA
/*brief: la Memoria agrupa los dos bancos de almacenamiento de la computadora
  a  simular: Memoria de Instrucciones y Memoria de Datos. */

module Memory(   
  input wire clk,                             //Señal de reloj
  input wire [4:0] address_Instruction,      //Dirección de Lectura de Instrucción de Memoria de Programa
  input wire we,                              //Señal de habilitar escritura de Memoria de Datos
  input wire [4:0] address_Data,             //Dirección de Lectura/Escritura de Memoria de Datos
  input wire [31:0] W_Data,                   //Dato de escritura de Memoria de Datos
  output wire [31:0] R_Instruction,           //Instrucción leída de Memoria de Programa
  output wire [31:0] R_Data                   //Dato de lectura de Memoria de Datos 
);

IM InstructionMemory(
    .addressIM(address_Instruction),
    .inst(R_Instruction)
);

DM DataMemory(
    .clk(clk),
    .addressDM(address_Data),
    .we(we),
    .wd(W_Data),
    .rd(R_Data)
);

endmodule