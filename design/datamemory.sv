`timescale 1ns / 1ps

module datamemory#(
    parameter DM_ADDRESS = 9 ,
    parameter DATA_W = 32
    )(
    input logic clk ,
	input logic [2:0] Funct3 ,
	input logic MemRead ,
    input logic MemWrite ,
    input logic [ DM_ADDRESS -1:0] a , // Read / Write address - 9 LSB bits of the ALU output
    input logic [ DATA_W -1:0] wd , // Write Data
    output logic [ DATA_W -1:0] rd // Read Data
    );
    
	`ifdef __SIM__
	
		logic [DATA_W-1:0] mem [(2**DM_ADDRESS)-1:0];
				
		logic [3:0] WriteEnable;
		
		assign WriteEnable = (Funct3 == 3'b010 && a[1:0] == 2'bxx) ? 4'b1111 :( // for Word loads/saves
							 (Funct3 == 3'b001 && a[1:0] == 2'bx0) ? 4'b0011 :( // for Half Word loads/saves
							 (Funct3 == 3'b001 && a[1:0] == 2'bx1) ? 4'b1100 :( // for Half Word loads/saves
							 (Funct3 == 3'b000 && a[1:0] == 2'b00) ? 4'b0001 :( // for Byte loads/saves
							 (Funct3 == 3'b000 && a[1:0] == 2'b01) ? 4'b0010 :( // for Byte loads/saves
							 (Funct3 == 3'b000 && a[1:0] == 2'b10) ? 4'b0100 :( // for Byte loads/saves			 			 
							 (Funct3 == 3'b000 && a[1:0] == 2'b11) ? 4'b1000 :( // for Byte loads/saves
							 (Funct3 == 3'b101)					   ? 4'b1010 :( // for Unsigned Half Word loads
							 (Funct3 == 3'b100)					   ? 4'b1001 :( // for Unsigned Byte loads
																	 4'b0000))))))))); //default case
		always_comb 
		begin
			if (MemRead)
				casex (WriteEnable)
					4'b1111:
						rd = mem[a];										// LOAD WORD
					4'b0011:
						rd = {{17{mem[a][15]}}, mem[a][14:0]};				// LOAD HALF WORD
					4'b1100:
						rd = {mem[a][31:16], {16{1'b0}}};					// LOAD HALF WORD
					4'b0001:
						rd = {{25{mem[a][7]}}, mem[a][6:0]};				// LOAD BYTE
					4'b0010:
						rd = {{17{mem[a][15]}},mem[a][14:8], {8{1'b0}}};	// LOAD BYTE
					4'b0100:
						rd = {{9{mem[a][23]}},mem[a][22:16], {16{1'b0}}};	// LOAD BYTE
					4'b1000:
						rd = {mem[a][31:24], {24{1'b0}}};					// LOAD BYTE
					4'b1001:
						rd = {{24{1'b0}}, mem[a][7:0]};						// LOAD UNSIGNED BYTE
					4'b1010:
						rd = {{16{1'b0}}, mem[a][15:0]};					// LOAD UNSIGNED HALF WORD
					default:
						rd = mem[a];										// LOAD WORD
				endcase

			end
			
		always @(posedge clk) 
		begin
		   if (MemWrite)
				case (WriteEnable)
					4'b1111: // for Word saves 
						mem[a] = wd;
					4'b0011: // for Half Word saves
						mem[a][15:0] = wd[31:16];
					4'b1100: // for Half Word saves
						mem[a][31:16]  = wd[15:0];
					4'b0001: // for Byte saves
						mem[a][7:0] = wd[7:0];
					4'b0010: // for Byte saves
						mem[a][15:8] = wd[15:8];
					4'b0100: // for Byte saves
						mem[a][23:16] = wd[23:16];
					4'b1000: // for Byte saves
						mem[a][31:24] = wd[31:24];
					default:
						mem[a] = wd; // for Word saves
				endcase
		end

		
	`else
		   logic we;
			assign we = MemWrite;
		  
		   SRAM1RW512x32 RAM (
				 .A       ( a[8:0] ),
				 .CE      ( 1'b1   ),
				 .WEB     ( ~we    ),
				 .OEB     ( we     ),
				 .CSB     ( 1'b0   ),
				 .I       ( wd     ),
				 .O       ( rd     )
				 );

	`endif
    
endmodule
