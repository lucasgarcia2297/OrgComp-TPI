//COMPONENTE: EXTENSIÓN DE SIGNO
//brief: circuito combinacional que genera el campo de dato inmediato, 
//       de 12 ó 20 bits, para las instrucciones aritméticas, lógicas, carga,
//       almacenamiento, y saltos.
module SE (
    input wire [24:0] inm,          // Entrada de 25 bits (omite los 7 bits del opcode)
    input wire [1:0] src,           // Selector de fuente: 00, 01, 10, 11
    output wire [31:0] inmExt       // Salida de 32 bits (31:0)
);
    reg [31:0]inm1;
    //ii0(31:20) ->> if src = 00                     //Instrucción I
    //is1(31:25, 11:7), ->> if src = 01              //Instrucción S
    //ib2(31, 30:25, 11:8, 7, 1’b0), ->> if src = 10 //Instrucción B
    //iu3(31:12) ->> if src = 11                     //Instrucción U
    //iJ4(31, 30:21, 20, 12:19)                      //Instrucción J

    //Las instrucciones TIPO R no usan estos campos y las instrucciones tipo U no se implementarán
    always @(*) begin
        case (src)
            2'b00: inm1 = {{20{inm[24]}},inm[24:13]};                                      //TIPO I
            2'b01: inm1 = {{20{inm[24]}},inm[24:18],inm[4:0]};                             //TIPO S
            2'b10: inm1 = {{19{inm[24]}},inm[24],inm[0],inm[23:18],inm[4:1],1'b0};         //TIPO B
            2'b11: inm1 = {{11{inm[24]}}, inm[24], inm[12:5], inm[13], inm[23:14], 1'b0};  //TIPO J
            // 2'b11: inm1 = {11'b0,inm[24],inm[12:5],inm[13],inm[23:14],1'b0};            //TIPO J
            
            default:
                inm1 = 32'b0;
        endcase
    end
    assign inmExt = inm1;
endmodule