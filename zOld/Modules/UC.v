//Unidad de control
//Contiene dos modulos, el decodificador principal y el de la ALU
`include "../Modules/MainDeco.v"
`include "../Modules/AluDeco.v"
module UC(
    input wire f7_b5,           //Entrada funct7
    input wire [2:0] f3,        //Entrada funct3 de 3 bits
    input wire [6:0] op,        //Entrada op de 7 bits
    input wire zero,            //Entrada zero
    output wire [10:0] salida   //Salida de 11 bits
);

//Señales intermedias
wire branch;            //Branch
wire jump;              //Jump
wire [1:0] resSrc;      //resSrc de 2 bits
wire memWrite;          //memWrite
wire aluSrc;            //aluSrc
wire [1:0] inmSrc;      //inmSrc de 2 bits
wire regWrite;          //regWrite
wire [1:0] aluOp;       //aluOp
wire [2:0] aluControl;  //aluControl de 3 bits

//Señales auxiliares
reg PCSrc;

MainDeco mainDecoder(
    .op(op),
    .branch(branch),
    .jump(jump),
    .resSrc(resSrc),
    .memWrite(memWrite),
    .aluSrc(aluSrc),
    .inmSrc(inmSrc),
    .regWrite(regWrite),
    .aluOp(aluOp)
);

AluDeco aluDecoder(
    .op_b5(op[5]),          //El bit 5 es el unico que cambia en lo que implementamos
    .f7_b5(f7_b5),          //El bit 5 es el unico que cambia en lo que implementamos
    .f3(f3),
    .aluOp(aluOp),
    .aluControl(aluControl)
);

always @(*) begin
    PCSrc = ((zero && branch) | jump);
end

assign salida = {PCSrc, resSrc, memWrite, aluControl, aluSrc, inmSrc, regWrite};

endmodule