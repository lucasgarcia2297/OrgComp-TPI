//COMPONENTE: MEMORIA DE INSTRUCCIONES (IM)
//brief: es un arreglo de 32 registros de 32 bits.

module IM(
    input wire [31:0] addressIM, 
    output wire [31:0] inst
);

/*Defino el contenido de la memoria de instrucciones*/
reg[31:0] memory [31:0];
reg[31:0] deco_address;

initial begin
    memory[0] = 32'h00300413;       //addi s0, zero, 3 	# a = 3
    memory[1] = 32'h00100493;       //addi s1, zero, 1	# b = 1
    memory[2] = 32'h01000913;       //addi s2, zero, 16	#cte = 16
                                    // operaciones lógicas aritméticas y slt
    memory[3] = 32'h009462b3;       // or t0, s0, s1		# c = 3
    memory[4] = 32'h00947333;       // and t1, s0, s1		# d = 1 
    memory[5] = 32'h009403b3;       // add t2, s0, s1		# e = 4
    memory[6] = 32'h40940e33;       // sub t3, s0, s1		# f = 2
    memory[7] = 32'h40848eb3;       // sub t4, s1, s0		# g = 0xfffffffe = -2
    memory[8] = 32'h00942f33;       // slt t5, s0, s1		# h = 0 
    memory[9] = 32'h0084afb3;       // slt t6, s1, s0		# i = 1
    memory[10] = 32'h01d4afb3;      // slt t6, s1, t4,	# j = 0
    
                                    //# un while usando beq y j
                                    // # Inicializo 3 variables
                                    // # s2 = 0x10 cte para comparar (16)
    memory[11] = 32'h00100293;      // addi t0, zero, 1		# var = 1, variable de trabajo
    memory[12] = 32'h00000313;      // addi t1, zero, 0		# cuenta = 0, un contador
                                    // while: 
    memory[13] = 32'h01228863;      // 	beq t0, s2, sal1	# si var == cte, sale del while
    memory[14] = 32'h005282b3;      // 	add t0, t0, t0		# var = var + var
    memory[15] = 32'h00130313;      // 	addi t1, t1, 1		# cuenta = cuenta + 1
    memory[16] = 32'hff5ff06f;      // 	j while
                                    // sal1:
                                    // # Debió quedar var en 0x10 y cuenta en 4
                                    //    # unloop. 
                                    // # Inicializo 3 variables
                                    // # $t0 = i, $s1 = var
    memory[17] = 32'h000004b3;      //  add s1, zero, zero	# var = 0, $s0 
                                    // 	#add $s0, $0, 3		# cte = 3, $s1
    memory[18] = 32'h00000293;      // 	addi t0, zero, 0	# indice = 0, $t0
    memory[19] = 32'h00a00313;      // 	addi t1, zero, 10	# veces = 10, $t1 
                                    //for:
    memory[20] = 32'h00628863;      // 	beq t0, t1, sal2	# if indice == veces, branch to done
    memory[21] = 32'h008484b3;      // 	add s1, s1, s0		# var = var + cte
    memory[22] = 32'h00128293;      // 	addi t0, t0, 1		# incremento indice
    memory[23] = 32'hff5ff06f;      // 	j for
                                    //sal2: 
                                    //# Debió quedar var en 30 (0x1e) e incremento en 10 (0xa)
                                    // # almacenamiento (escritura) sw
    memory[24] = 32'h00802023;      // 	sw s0, 0(zero)		# guarda $s0 en registro 0
    memory[25] = 32'h00902223;      // 	sw s1, 4(zero)		# guarda $s1 en registro 4
    memory[26] = 32'h01202423;      // 	sw s2, 8(zero)		# guarda $s2 en registro 8
                                    // 	# carga(lectura) lw
    memory[27] = 32'h00002283;      // 	lw t0, 0(zero)		# lee registro 0 en $t0
    memory[28] = 32'h00402303;      //	lw t1, 4(zero)		# lee registro 4 en $t1
    memory[29] = 32'h00802383;      // 	lw t2, 8(zero)		# lee registro 8 en $t2
end

/*Leer la instruccion en la direccion especificada*/
always @(addressIM) begin
    deco_address = addressIM/4;
end;
assign inst = memory[deco_address];

endmodule