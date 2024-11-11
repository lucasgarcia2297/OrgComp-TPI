//CIRCUITO RISC-V 32i
//brief: este circuito agrupa 

`include "../Modules/dataPath.v"
`include "../Modules/UC.v"

module RV32I(
    input wire clk,
    input wire reset,
    input wire [31:0] instr,
    input wire [31:0] mem_readdata,
    output wire [15:0] mem_insaddress,
    output wire [31:0] mem_address, 
    output wire mem_write,        
    output wire [31:0] mem_writedata
);

//Señales intermedias
wire zero;
wire [10:0] UC_sal;

///----------- UNIDAD DE CONTROL -----------
UC UnityControl(
    .f7_b5(instr[30]),
    .f3(instr[14:12]),
    .op(instr[6:0]),
    .zero(zero),
    .salida(UC_sal)
);

///----------- DATAPATH -----------
dataPath DP(
    .clk(clk),
    .reset(reset),
    .instr(instr),
    .mem_readdata(mem_readdata),
    .uc_salida(UC_sal),
    .uc_zero(zero),
    .mem_insadress(mem_insaddress),
    .mem_write(mem_write),
    .mem_writedata(mem_writedata),
    .ALU_res(mem_address)
);

endmodule