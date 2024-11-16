`default_nettype none
// `define DUMPSTR(x) `"TOP_tb.vcd`"
`timescale 1 ns / 1 ps

module TOP_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 100000;
//-- Clock signal. It is not used in this simulation
reg reset;
reg clk = 1;
always #0.5 clk = ~clk;

//-- Instantiate the unit to test
TOP UUT (
    .clk(clk),
    .reset(reset)
);

initial begin
    $dumpfile("TOP_tb.vcd");
    $dumpvars(0, TOP_tb);

    reset = 1'b1;
    #1;
    reset = 1'b0;

    #150;
    $finish;
end

endmodule