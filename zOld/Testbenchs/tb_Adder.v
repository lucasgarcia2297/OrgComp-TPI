`include "../Modules/Adder.v"
module tb_Adder;
    reg[31:0] op1;
    reg[31:0] op2;

    wire[31:0] sal;

    Adder uut(
        .op1(op1),
        .op2(op2),
        .sal(sal)
    );

    initial begin
        $dumpfile("./gtkwave/tb_Adder.vcd");
        $dumpvars(0, tb_Adder);
		op1 = 32'h00000003;
		op2 = 32'h00000002;
		
		#10;
   end

endmodule