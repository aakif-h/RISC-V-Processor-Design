`timescale 1ns / 1ps

module tb_top;

//clock and reset signal declaration
  logic tb_clk, reset;
  logic [31:0] tb_WB_Data;
  integer c = 1;
  integer score = 60;
  
    //clock generation
  always begin
  #10 tb_clk = ~tb_clk;
  end
  
  //reset Generation
  initial begin
    tb_clk = 0;
    reset = 0;
  end
  
  
  riscv riscV(
      .clk(tb_clk),
      .reset(reset),
      .WB_Data(tb_WB_Data)      
     );
	
  integer a;
  
  initial begin
   
	a = 0;
	$readmemb ( "$verif/program/inst.bin" , riscV.dp.instr_mem.Inst_mem);
	
	//Branch delayed slot: 1
	reset = 1;
	@(posedge tb_clk);
	reset = 0;
    @(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	if(riscV.dp.WB_Data !== 32'd0) //andi
		begin
			score = score - 4;
			$display("andi is not working: The WB_data should be: %d, But you got: %d",32'd0,riscV.dp.WB_Data);
		end
	@(posedge tb_clk);
	if(riscV.dp.WB_Data !== 32'd3) //xori
		begin
			score = score - 4;
			$display("xori is not working: The WB_data should be: %d, But you got: %d",32'd3,riscV.dp.WB_Data);
		end
	@(posedge tb_clk);
	if(riscV.dp.WB_Data !== 32'd4) //xori
	    begin
			score = score - 4;
			$display("xori is not working: The WB_data should be: %d, But you got: %d",32'd4,riscV.dp.WB_Data);
		end
	@(posedge tb_clk);
	if(riscV.dp.WB_Data !== 32'd1) //sub
		begin
			score = score - 4;
			$display("sub is not working: The WB_data should be: %d, But you got: %d",32'd1,riscV.dp.WB_Data);
		end
	@(posedge tb_clk);
	if(riscV.dp.WB_Data !== 32'd7) //add
		begin
			score = score - 4;
			$display("add is not working: The WB_data should be: %d, But you got: %d",32'd7,riscV.dp.WB_Data);
		end
	@(posedge tb_clk);
	@(posedge tb_clk);
	if(riscV.dp.WB_Data !== 32'd7) //lw
		begin
			score = score - 5;
			$display("lw/sw is not working: The WB_data should be: %d, But you got: %d",32'd7,riscV.dp.WB_Data);
		end
	@(posedge tb_clk);
	@(posedge tb_clk);
	if(riscV.dp.WB_Data !== 32'd1) //slt
		begin
			score = score - 4;
			$display("slt is not working: The WB_Data should be: %d, But you got: %d",32'd1,riscV.dp.WB_Data);
		end
	@(posedge tb_clk);
	if(riscV.dp.WB_Data !== 32'd7) //lw
		begin
			score = score - 5;
			$display("lw/sw is not working: The WB_Data should be: %d, But you got: %d",32'd7,riscV.dp.WB_Data);
		end
	if(riscV.dp.PC !== 32'd48) //beq
		begin
			score = score - 6;
			$display("beq is not working: The PC should be: %d, But you got: %d",32'd48,riscV.dp.PC);
		end
	@(posedge tb_clk);
	if(riscV.dp.WB_Data !== 32'd0) //xori
		begin
			score = score - 4;
			$display("xori is not working: The WB_Data should be: %d, But you got: %d",32'd0,riscV.dp.WB_Data);
		end
	@(posedge tb_clk);
	@(posedge tb_clk);
	if(riscV.dp.WB_Data !== 32'd0) //xori
		begin
			score = score - 4;
			$display("xori is not working: The WB_Data should be: %d, But you got: %d",32'd0,riscV.dp.WB_Data);
		end
	if(riscV.dp.PC !== 32'd0) //jalr
		begin
			score = score - 6;
			$display("jalr is not working: The PC should be: %d, But you got: %d",32'd0,riscV.dp.PC);
		end
	
	
	$display("The total score is: %d",score);
	
	$stop;
   end
endmodule
