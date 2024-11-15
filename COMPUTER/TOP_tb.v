`default_nettype none
`define DUMPSTR(x) `"TOP_tb.vcd`"
`timescale 1 ns / 1 ps

module TOP_tb();

//-- Simulation time: 1us (10 * 100ns)
parameter DURATION = 100000;
//-- Clock signal. It is not used in this simulation
reg clk = 0;
always #0.5 clk = ~clk;

//-- Instantiate the unit to test
Top UUT (
    .clk(clk),
);

endmodule