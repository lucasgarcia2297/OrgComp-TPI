//MODULO: CONTROL UNIT
//brief: Unidad de Control del camino de datos.

// `include "../ALUDECO/ALUDECO.v"
// `include "../MAINDECO/MAINDECO.v"

module UC(
    input wire [6:0] opcode,        //Entrada opcode de 7 bits
    input wire funct7_b5,            //Entrada funct7, bit 5
    input wire [2:0] funct3,            //Entrada funct3
    input wire zero,                //Entrada zero
    // output wire outUC               //Salida de la Unidad de Control - concatenación de señales
    // output wire branch,             //Salida de branch
    // output wire jump,               //Salida de jump
    output wire PCSrc,              // PC Source reemplaza a branch y a jump
    output wire [1:0] resSrc,       //Salida de resSrc de 2 bits correspondiente a data_S
    output wire memWrite,           //Salida memwrite
    output wire [2:0] ALUcontrol,   //Control de la ALU
    output wire aluSrc,             //Salida aluSrc
    output wire [1:0] inmSrc,       //Salida inmSrc de 2 bits
    output wire regWrite            //Salida regWrite
    );

    // ---------- SEÑALES INTERMEDIAS ----------
    wire [1:0] ALUop;       // Señal de control de la ALU.
    wire s_branch;          // Señal de branch.
    wire s_jump;            // Señal de branch.
    reg r_branch;           // Señal salida de branch.
    reg r_PCSrc;            // Señal salida de PcSrc.

    initial 
        r_branch = 1'b0;

    MAINDECO MainDeco(
        .opcode(opcode),
        .branch(s_branch),
        .jump(s_jump),
        .resSrc(resSrc),
        .memWrite(memWrite),
        .aluSrc(aluSrc),
        .inmSrc(inmSrc),
        .regWrite(regWrite),
        .aluOp(ALUop)
    );

    ALUDECO AluDeco(
        .ALUop(ALUop),
        .opcode_b5(opcode[5]),
        .funct7_b5(funct7_b5),
        .funct3(funct3),
        .ALUcontrol(ALUcontrol)
    );

    always @(*) begin
        // r_branch = s_branch && zero;
        r_PCSrc = s_jump || (s_branch && zero);
    end
    // assign branch = r_branch;
    assign PCSrc = r_PCSrc;
endmodule