`include "../Modules/AluDeco.v"
module tb_AluDeco;
    reg op_b5;
    reg f7_b5;
    reg [2:0] f3;
    reg [1:0] aluOp;
    wire [2:0] aluControl;

    //instancia del modulo AluDeco
    AluDeco AluDeco(
        .op_b5(op_b5),
        .f7_b5(f7_b5),
        .f3(f3),
        .aluOp(aluOp),
        .aluControl(aluControl)
    );

    initial begin
    $dumpfile("./gtkwave/tb_AluDeco.vcd");
    $dumpvars(0, tb_AluDeco);

    for (integer i = 0; i < 3; i = i + 1) begin
        aluOp = i[1:0]; 
        for (integer j = 0; j < 4; j = j + 1) begin
            f3 = (j == 0) ? 3'b000 :
                 (j == 1) ? 3'b010 :
                 (j == 2) ? 3'b110 :
                 (j == 3) ? 3'b111 :
                 3'bxxx;
            for (integer k = 0; k < 4; k = k + 1) begin
                op_b5 = k[1]; 
                f7_b5 = k[0]; 
                #1;
                //$display("aluOp=%b, f3=%b, op_b5=%b, f7_b5=%b -> aluControl=%b", aluOp, f3, op_b5, f7_b5, aluControl); // Añadir este display
            end
        end
    end
    #1;
    $finish;
end
endmodule