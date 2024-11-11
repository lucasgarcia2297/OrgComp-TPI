`timescale 1ns/1ns
module ALU_tb;
 //Declarar señales para el tb
	// Inputs
    reg[31:0] srcA;
    reg[31:0] srcB;
    reg[2:0] aluControl;
	// Outputs
	wire [31:0] result;

	 //Instanciar el modulo bajo prueba
    ALU alu(
        .srcA(srcA),
        .srcB(srcB),
        .aluControl(aluControl),
        .result(result)
    );
    
	//Inicializacion de las variables de entrada
   initial begin
        $dumpfile("./ALU_tb.vcd");
        $dumpvars(0, ALU_tb);


        srcA = 32'h00000001;    //Valor de ejemplo para srcA
        srcB = 32'h00000002;    //Valor de ejemplo para srcB
        aluControl = 3'b000;    //SUMA
        //Esperar un tiempo antes de cambiar las entradas
        #10; 
        srcA = 32'h00000003;
        srcB = 32'h00000004;
        aluControl = 3'b001; //RESTA
	
			//Esperar un tiempo antes de cambiar las entradas
        #10; 
        srcA = 32'b00010111;
        srcB = 32'b00011001;
        aluControl = 3'b010; //AND

		//Esperar un tiempo antes de cambiar las entradas
        #10; 
        srcA = 32'b00011011;
        srcB = 32'b00001001;
        aluControl = 3'b011; //OR
        
		//Esperar un tiempo antes de cambiar las entradas
        #10; 
        srcB = 32'h11100003;
        srcA = 32'h0005eBa0;
        aluControl = 3'b101; //SLT
        
        #10 
        srcA = 32'h11100003;
        srcB = 32'h0005eBa0;
        aluControl = 3'b101; //SLT

		//Esperar un tiempo antes de cambiar las entradas
        #10; 
        srcA = 32'h00000013;
        srcB = 32'h00c0aa04;
        aluControl = 3'b111; //salida por default. 

        //Finalizar la simulacion despues de un tiempo suficiente
        #10;
   end
endmodule