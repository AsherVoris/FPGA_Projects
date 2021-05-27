module horizontal_counter (input clk, input rst, output [10:0]HCNT, output TC);

/*
* for each clock pulse
* 			increment counter by one
*			output this count value
* if count is at maximum (or terminal count)
* 			TC = high
*			else TC = low
*
* Maximum size of VGA is 1920Hx1200V
*		Thus a register of 11 bits will be used for H counter 2^10 = 1024, 2^11 = 2048
*/
	parameter HORIZONTAL_TOTAL_LINE = -1;
	reg [10:0] Q;
	reg		  tc;

	always@(posedge clk or negedge rst)
	begin
		if(rst == 1'b0)
			Q <= 11'b0;
		else if(Q == HORIZONTAL_TOTAL_LINE - 1)
			Q <= 11'b0;
		else
			Q <= Q + 1'b1;
	end
	
	always@(posedge clk or negedge rst)
	begin
		if(rst == 1'b0)
			tc <= 1'b0;
		else if(Q == HORIZONTAL_TOTAL_LINE - 1)
			tc <= 1'b1;
		else
			tc <= 1'b0;
	end
	
	assign TC = tc;
	assign HCNT = Q;
	
endmodule 