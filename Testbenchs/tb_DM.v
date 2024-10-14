`include "../Modules/DM.v"

module tb_DM();
    reg clk, we; 
    reg [31:0] addressDM;
    reg [31:0] wd;
    wire [31:0] rd; 

DM uut(
    .clk(clk),
    .addressDM(addressDM),
    .wd(wd),
    .we(we),
    .rd(rd)
);

initial begin
    $dumpfile("./gtkwave/tb_DM.vcd");
    $dumpvars(0, tb_DM);

    clk = 1'b0; #5;
    addressDM = 5'b01000; 
    wd = 32'hfffaa090;
    we = 1'b1;

    clk = ~clk; #5; //Debería escribir en el registro 8 lo que hay en wd y retornar en rd lo mismo.
    addressDM = 5'b0;
    wd = 32'b0;
    we = 1'b0;

    clk = ~clk; #5; //Debería retornar en rd 000000000
    clk = ~clk; #5;
    clk = ~clk; #5;
    clk = ~clk; #5;
end;


endmodule;