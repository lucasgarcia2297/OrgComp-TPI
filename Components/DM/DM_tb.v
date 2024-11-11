module DM_tb();
    reg clk, we; 
    reg [4:0] address;
    reg [31:0] wd;
    wire [31:0] rd; 

DM uut(
    .clk(clk),
    .address(address),
    .wd(wd),
    .we(we),
    .rd(rd)
);

initial begin
    $dumpfile("./DM_tb.vcd");
    $dumpvars(0, DM_tb);

    clk = 1'b0;
    address = 5'b00001;  // Direccion de ejemplo para lectura/escritura
    wd = 32'h0001000A;      // Valor de ejemplo para escritura
    we = 1'b1;

    #5;
    clk = ~clk;

    #10;
    address = 5'b00000; // Dirección de ejemplo para lectura
    we = 1'b0;              

    #5;
    clk = ~clk;
    $finish;

    // clk = 1'b0; #5;
    // addressDM = 5'b01000; 
    // wd = 32'hfffaa090;
    // we = 1'b1;

    // clk = ~clk; #5; 
    // addressDM = 5'b0;
    // wd = 32'b0;
    // we = 1'b0;

    // clk = ~clk; #5; //Debería retornar en rd 000000000
    // clk = ~clk; #5;
    // clk = ~clk; #5;
    // clk = ~clk; #5;
end;


endmodule;