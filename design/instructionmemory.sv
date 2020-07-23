`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2018 10:20:16 PM
// Design Name: 
// Module Name: instructionmemory
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


module instructionmemory#(
    parameter INS_ADDRESS = 9,
    parameter INS_W = 32
     )(
    input logic [ INS_ADDRESS -1:0] ra , // Read address of the instruction memory , comes from PC
    output logic [ INS_W -1:0] rd // Read Data
    );
    

logic [INS_W-1 :0] Inst_mem [(2**(INS_ADDRESS-2))-1:0];
    
    assign Inst_mem[0] = 32'h00007033;
    assign Inst_mem[1] = 32'h00100093;
    assign Inst_mem[2] = 32'h00200113;
    assign Inst_mem[3] = 32'h00308193;
    assign Inst_mem[4] = 32'h00408213;
    assign Inst_mem[5] = 32'h00510293;
    assign Inst_mem[6] = 32'h00610313;
    assign Inst_mem[7] = 32'h00718393;
    assign Inst_mem[8] = 32'h00208433;
    assign Inst_mem[9] = 32'h404404b3;
    assign Inst_mem[10] = 32'h00317533;
    assign Inst_mem[11] = 32'h0041e5b3;
    assign Inst_mem[12] = 32'h02b20263;
    assign Inst_mem[13] = 32'h00108413;
    assign Inst_mem[14] = 32'h00419a63;
    assign Inst_mem[15] = 32'h00308413;
    assign Inst_mem[16] = 32'h0014c263;
    assign Inst_mem[17] = 32'h00408413;
    assign Inst_mem[18] = 32'h00b3da63;
    assign Inst_mem[19] = 32'h00208413;
    assign Inst_mem[20] = 32'hfe5166e3;
    assign Inst_mem[21] = 32'h00008413;
    assign Inst_mem[22] = 32'hfc74fee3;
    assign Inst_mem[23] = 32'h0083e6b3;
//jal
    assign Inst_mem[24] = 32'h018005ef;
//return
    assign Inst_mem[25] = 32'h02a02823;
    assign Inst_mem[26] = 32'h16802023;
    assign Inst_mem[27] = 32'h03002603;
    assign Inst_mem[28] = 32'h00311733;
//branch
    assign Inst_mem[29] = 32'h00c50a63;
    assign Inst_mem[30] = 32'h0072c7b3;
    assign Inst_mem[31] = 32'h00235833;
    assign Inst_mem[32] = 32'h4034d8b3;
//JALR
    assign Inst_mem[33] = 32'h000586e7;
//branch target
    assign Inst_mem[34] = 32'h01614513;
    assign Inst_mem[35] = 32'h02e2e593;
    assign Inst_mem[36] = 32'h06f37613;
    assign Inst_mem[37] = 32'h00349693;
    assign Inst_mem[38] = 32'h00335713;
    assign Inst_mem[39] = 32'h4026d793;
    assign Inst_mem[40] = 32'h00a8a833;
    assign Inst_mem[41] = 32'h00a8b833;
    assign Inst_mem[42] = 32'h0028a813;
    assign Inst_mem[43] = 32'h0028b813;
    assign Inst_mem[44] = 32'hccccc837;
    assign Inst_mem[45] = 32'hccccc817;
    assign Inst_mem[46] = 32'h00902a23;
    assign Inst_mem[47] = 32'h01402103;
    assign Inst_mem[48] = 32'h01400183;
    assign Inst_mem[49] = 32'h01401203;
    assign Inst_mem[50] = 32'h01404283;
    assign Inst_mem[51] = 32'h01405303;
    assign Inst_mem[52] = 32'h00459693;
    assign Inst_mem[53] = 32'h02d00423;
    assign Inst_mem[54] = 32'h02802703;
    assign Inst_mem[55] = 32'h02d01423;
    assign Inst_mem[56] = 32'h02802703;

assign rd =  Inst_mem [ra[INS_ADDRESS-1:2]];  

//      genvar i;
//      generate
//          for (i = 15; i < 127; i++) begin
//              assign Inst_mem[i] = 32'h00007033;
//          end
//      endgenerate

endmodule