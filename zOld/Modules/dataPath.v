`include "../Modules/PC.v"
`include "../Modules/BR.v"
`include "../Modules/SE.v"
`include "../Modules/ALU.v"
`include "../Modules/Adder.v"
`include "../Modules/Mux2x1.v"

module dataPath(
    //Entradas
    input wire clk,                     //Señal de reloj
    input wire reset,                   //Señal de reset
    input [31:0] instr,                 //Instruccion leida desde memoria IM
    input wire [31:0] mem_readdata,     //Dato leido desde memoria DM
    input wire [10:0] uc_salida,        //Salida de la unidad de control
    output wire uc_zero,
    output [15:0] mem_insadress,   //Direccion de la instruccion para leer de IM
    output wire mem_write,              //Señal de escritura de memoria    
    output wire [31:0] mem_writedata,   //Dato de lectura de registro que se puede escribir en memoria DM
    output wire [31:0] ALU_res          //Resultado de la ALU.    
);

//Señales intermedias
wire [31:0] pc1;
wire [31:0] pcMem;
wire [31:0] pcNext1;
wire [31:0] sal_M1;
wire [31:0] sal_A1;
wire [31:0] pc_Target;
wire [31:0] sal_InmExt;
wire [31:0] sal_M3;
wire [31:0] RReg_1;     //Es SrcA
wire [31:0] RReg_2;
wire [31:0] SrcB;        //Salida de M2
wire [31:0] sal_ALU;
wire sal_ALU_zero;  

//Constantes
reg [31:0] zero = 32'h00000000;
reg [31:0] four = 32'h00000004;

//Modulo PC -> Asigna por pulso de clock la proxima direccion de lectura del IM
PC PC(
    .clk(clk),
    .pcNext(pcNext1),
    .pc(pc1)
);

//Adder 1 -> Calcula la proxima direccion de lectura sumandole 4 bytes a la direccion actual del PC
Adder A1(
    .op1(four),
    .op2(pc1),
    .sal(sal_A1)
);

//Adder 2 -> Calcula la proxima direccion de lectura usando la salida del extensor de señal a la
//direccion actual PC
Adder A2(
    .op1(sal_InmExt),
    .op2(pc1),
    .sal(pc_Target)
);

//Mux 2x1 -> Selecciona entre la direccion calculada por A1 (direccion normal) o la calculada
//por A2 (direccion de salto)
Mux2x1 M1(
    .e1(pcMem),
    .e2(zero),
    .sel(reset),
    .sal(pcNext1)
);

//Extension de Signo
//Genera el campo de dato inmediato a partir de un segmento de la instruccion
//leida de IM y una parte de la señal de la UC
SE SignExtender(
    .inm(instr[24:0]),
    .src(uc_salida[2:1]),
    .inmExt(sal_InmExt)
);

//Banco de registro
//Arreglo de 32 registros de 32 bits de los cuales se lee y escriben datos
//durante la ejecucion.
BR BankRegister(
    .clk(clk),
    .a1(instr[19:15]),
    .a2(instr[24:20]),
    .a3(instr[11:7]),
    .we(uc_salida[0]),
    .wd(sal_M3),
    .rd1(RReg_1),
    .rd2(RReg_2)
);

//Mux 2x1 2 -> Selecciona entre la salida de lectura del banco de registros y la 
//salida del valor inmediato para ser entrada de la ALU
Mux2x1 M2(
    .e1(RReg_2), 
    .e2(sal_InmExt),
    .sel(uc_salida[3]),
    .sal(SrcB)
);

//Modulo ALU -> Realiza operaciones aritmetico logicas a partir de la primera lectura
//del banco de registros y la salida de M2
ALU ALU(
    .srcA(RReg_1),
    .srcB(SrcB),
    .ALUControl(uc_salida[6:4]),
    .res(sal_ALU),
    .zero(sal_ALU_zero)
);

//SALIDAS DEL DATAPATH
assign mem_insaddress = pc1;                //La salida del contador es salida de DataPath y entrada de IM. 
assign mem_writedata = RReg_2;              //La salida 2 del Banco de Registros es un dato que se puede escribir en el Banco de Memoria
assign ALU_res = sal_ALU;                   //La salida de la ALU es el dato que resulta de una operación matemática. Se obtiene desde acá para adelantar el dato y no volverlo a leer de memoria.
assign uc_zero = sal_ALU_zero;              //La salida zero de la ALU es entrada de la Unidad de Control en el RISCV. 
assign mem_write = uc_salida[7];

endmodule