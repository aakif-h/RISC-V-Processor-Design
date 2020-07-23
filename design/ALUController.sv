`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2018 10:10:33 PM
// Design Name: 
// Module Name: ALUController
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ALUController(
    
    //Inputs
    input logic [1:0] ALUOp,  //7-bit opcode field from the instruction
    input logic [6:0] Funct7, // bits 25 to 31 of the instruction
    input logic [2:0] Funct3, // bits 12 to 14 of the instruction
    
    //Output
    output logic [3:0] Operation //operation selection for ALU
);
 
 assign Operation = (ALUOp == 2'b10 && Funct7 == 7'b0000000 && Funct3 == 3'b000) ? 4'b0000 :( //ADD   0
					(ALUOp == 2'b10 && Funct7 == 7'b0100000 && Funct3 == 3'b000) ? 4'b0001 :( //SUB   1
                    (ALUOp == 2'b10 && Funct7 == 7'b0000000 && Funct3 == 3'b111) ? 4'b0010 :( //AND   2
                    (ALUOp == 2'b10 && Funct7 == 7'b0000000 && Funct3 == 3'b110) ? 4'b0011 :( // OR   3
					(ALUOp == 2'b10 && Funct7 == 7'b0000000 && Funct3 == 3'b100) ? 4'b1101 :( //XOR   13					
					(ALUOp == 2'b10 && Funct7 == 7'b0000000 && Funct3 == 3'b001) ? 4'b0100 :( //SLL   4
					(ALUOp == 2'b10 && Funct7 == 7'b0000000 && Funct3 == 3'b010) ? 4'b1001 :( //SLT   9
					(ALUOp == 2'b10 && Funct7 == 7'b0000000 && Funct3 == 3'b011) ? 4'b1011 :( //SLTU  11					
					(ALUOp == 2'b10 && Funct7 == 7'b0000000 && Funct3 == 3'b101) ? 4'b0101 :( //SRL   5										
					(ALUOp == 2'b10 && Funct7 == 7'b0100000 && Funct3 == 3'b101) ? 4'b0110 :( //SRA   6
					(ALUOp == 2'b11 && Funct3 == 3'b000)						 ? 4'b0111 :( //BEQ   7
					(ALUOp == 2'b11 && Funct3 == 3'b001)						 ? 4'b1000 :( //BNE   8
					(ALUOp == 2'b11 && Funct3 == 3'b100)						 ? 4'b1001 :( //BLT   9
					(ALUOp == 2'b11 && Funct3 == 3'b101)						 ? 4'b1010 :( //BGE   10
					(ALUOp == 2'b11 && Funct3 == 3'b110)						 ? 4'b1011 :( //BLTU  11
					(ALUOp == 2'b11 && Funct3 == 3'b111)						 ? 4'b1100 :( //BGEU  12
					(ALUOp == 2'b01 && Funct3 == 3'b000) 						 ? 4'b0000 :( //ADDi  0
					(ALUOp == 2'b01 && Funct3 == 3'b111) 						 ? 4'b0010 :( //ANDi  2
					(ALUOp == 2'b01 && Funct3 == 3'b110) 						 ? 4'b0011 :( // ORi  3
					(ALUOp == 2'b01 && Funct3 == 3'b100) 						 ? 4'b1101 :( //XORi  13
					(ALUOp == 2'b01 && Funct3 == 3'b010)						 ? 4'b1001 :( //SLTi  9
					(ALUOp == 2'b01 && Funct3 == 3'b011)						 ? 4'b1011 :( //SLTUi 11						
					(ALUOp == 2'b01 && Funct7 == 7'b0000000 && Funct3 == 3'b001) ? 4'b0100 :( //SLLI  4
					(ALUOp == 2'b01 && Funct7 == 7'b0000000 && Funct3 == 3'b101) ? 4'b0101 :( //SRLI  5
					(ALUOp == 2'b01 && Funct7 == 7'b0100000 && Funct3 == 3'b101) ? 4'b0110 :( //SRAI  6					
					(ALUOp == 2'b00)											 ? 4'b0000 :( //JALR, LOAD, SAVE, LUI, AUIPC 0
																				   4'b1111)))))))))))))))))))))))))); //DEFAULT :: NO VALID INSTRUCTION
					

endmodule
