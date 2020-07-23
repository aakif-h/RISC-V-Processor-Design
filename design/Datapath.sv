`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2018 10:10:33 PM
// Design Name: 
// Module Name: Datapath
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

module Datapath #(
    parameter PC_W = 9, // Program Counter
    parameter INS_W = 32, // Instruction Width
    parameter RF_ADDRESS = 5, // Register File Address
    parameter DATA_W = 32, // Data WriteData
    parameter DM_ADDRESS = 9, // Data Memory Address
    parameter ALU_CC_W = 4 // ALU Control Code Width
    )(
    input logic clk , reset , 
    Jal      , Jalr		, 
    Branch 	 ,  
	ALUsrcA  , ALUsrcB	,
	RegWrite , MemtoReg	,     
    MemRead , MemWrite	, 
	input logic [1:0] writeSelect, 
    input logic [ ALU_CC_W -1:0] ALU_CC, // ALU Control Code ( input of the ALU )
    output logic [6:0] opcode,
    output logic [6:0] Funct7,
    output logic [2:0] Funct3,
    output logic [DATA_W-1:0] WB_Data //ALU_Result
    );

logic [PC_W-1:0] PC, PCPlus4;
logic [PC_W-1:0] BranchResult, JumpResult;
logic [DATA_W-1:0] BranchAdd;
logic [INS_W-1:0] Instr;
logic [DATA_W-1:0] DataResult;
logic [DATA_W-1:0] Reg1, Reg2;
logic [DATA_W-1:0] ReadData;
logic [DATA_W-1:0] SrcB, ALUResult;
logic [DATA_W-1:0] ExtImm;
logic [DATA_W-1:0] Result;
logic BrSel;
logic Zero;

// next PC
    adder #(9) pcadd (PC, 9'b100, PCPlus4);
    adder #(32) imm_add({23'b0, PC}, ExtImm, BranchAdd);
	
    assign instruction_select = (Branch & Zero) || Jal;
    mux2 #(9) pcmux(PCPlus4, BranchAdd[PC_W-1:0], instruction_select, BranchResult);

    mux2 #(9) jumpmux(BranchResult, ALUResult[PC_W-1:0], Jalr, JumpResult);

    flopr #(9) pcreg(clk, reset, JumpResult, PC);

 //Instruction memory
    instructionmemory instr_mem (PC, Instr);
    
    assign opcode = Instr[6:0];
    assign Funct7 = Instr[31:25];
    assign Funct3 = Instr[14:12];
      
// //Register File
    RegFile rf(clk, reset, RegWrite, Instr[11:7], Instr[19:15], Instr[24:20],
            Result, Reg1, Reg2);
            
    mux2 #(32) datamux(ALUResult, ReadData, MemtoReg, DataResult);
	
    mux4 #(32) writemux(DataResult, {23'b0, PCPlus4}, ExtImm, BranchAdd, writeSelect, Result);
    assign WB_Data = Result;
           
//// sign extend
    imm_Gen Ext_Imm (Instr,ExtImm);

//// ALU
	logic [DATA_W-1:0] SrcA;
	mux2 #(32) srcbmux(Reg2, ExtImm, ALUsrcB, SrcB);
		
	mux2 #(32) srcamux(Reg1, 32'b0, ALUsrcA, SrcA);
	
    alu alu_module(SrcA, SrcB, ALU_CC, ALUResult);
    assign Zero = ALUResult[0];
    
    
////// Data memory 
	datamemory data_mem (clk, Funct3, MemRead, MemWrite, ALUResult[DM_ADDRESS-1:0], Reg2, ReadData);
     
endmodule