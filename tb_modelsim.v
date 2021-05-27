`timescale 1 ns / 100 ps
module tb_modelsim();
`include "params.vh"

reg clkin;
reg 				[9:0]		SW;
reg				[3:0]		KEY;
wire		          		VGA_BLANK_N;
wire		     	[7:0]		VGA_B;
wire		          		VGA_CLK;
wire		     	[7:0]		VGA_G;
wire		          		VGA_HS;
wire		     	[7:0]		VGA_R;
wire		          		VGA_SYNC_N;
wire		          		VGA_VS;


//test
reg 							RESET;
wire							RESET_N;
wire 				[10:0] 	HCNT_OUT;
wire							TC_OUT;
wire				[10:0]	VCNT_OUT;
wire							IAA;
wire							C_DIV_OUT;

VGA_Controller DUT (.C_DIV_OUT(C_DIV_OUT), .CLOCK_50(clkin), .VGA_CLK(VGA_CLK), .RESET(RESET), .RESET_N(RESET_N),.HCNT_OUT(HCNT_OUT), .TC_OUT(TC_OUT), .VCNT_OUT(VCNT_OUT), .VGA_HS(VGA_HS), .VGA_VS(VGA_VS), .VGA_R(VGA_R), .VGA_G(VGA_G), .VGA_B(VGA_B), .IAA_OUT(IAA));

always
    #10 clkin = ~clkin;

initial
    begin
		$display ($time, " << Starting Simulation >> ");
      clkin = 0;
		RESET = 1;
		KEY[3:0] = 4'b0;
		SW[9:0] = 10'b0;
		//works
		#40 RESET = 1'b1; 
		$display ($time, " << Asserting Reset >> ");
		#80 RESET = 1'b0;
		$display ($time, " << Deasserting Reset >> ");
		#15000000 KEY[3] = 1'b0;
		$display ($time, " << Moving Squares >> ");
		#15001000 SW[8:6] = 3'b111;
		$display ($time, " << Making Squares Red >> ");
		#25000000 KEY[3] = 1'b1;
		$display ($time, " << Stopping Squares >> ");
		#26000010 RESET = 1'b1;
		$display ($time, " << Asserting Reset >> ");
		#26000050 RESET = 1'b0;
		$display ($time, " << Deasserting Reset >> ");
		#35000000 $stop;
    end
	 
endmodule 