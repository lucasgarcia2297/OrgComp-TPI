//MODULO: CONTROL UNIT
//brief: Unidad de Control del camino de datos.

// `include "../ALUDECO/ALUDECO.v"
// `include "../MAINDECO/MAINDECO.v"

module UC(
    input wire reset,               //Entrada reset
    input wire [6:0] opcode,        //Entrada opcode de 7 bits
    input wire funct7_b5,            //Entrada funct7, bit 5
    input wire [2:0] funct3,            //Entrada funct3
    input wire zero,                //Entrada zero
    // output wire outUC               //Salida de la Unidad de Control - concatenación de señales
    // output wire branch,             //Salida de branch
    // output wire jump,               //Salida de jump
    output wire [1:0] PCSrc,              // PC Source reemplaza a branch y a jump
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
    reg [1:0] r_PCSrc;      // Señal salida de PcSrc.

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
        if (reset == 1'b1) begin
           r_PCSrc = 2'b00; // -> reset
        end
        else begin
            if ((s_jump || (s_branch && zero)) == 1'b1) begin
                r_PCSrc = 2'b10; // -> jump
            end
            else begin
                r_PCSrc = 2'b01; // -> next
            end
        end;

    end
    // assign branch = r_branch;
    assign PCSrc = r_PCSrc;
endmodule