module vertical_counter (input en, input clk, input rst, output [10:0] VCNT);

/*
* for each clock pulse
*		if reset
*			count = 0
*		else if count = max V count
*			count = 0
*		else if enabled 
*			count + 1
*		else 
*			count = count
*
* Maximum size of VGA is 1920Hx1200V
*		Thus a register of 11 bits will be used for V counter 2^10 = 1024, 2^11 = 2048
*/
	parameter VERTICAL_TOTAL_FRAME = -1;
	reg [10:0] Q;

	always@(posedge clk or negedge rst)
	begin
		if(rst == 1'b0)
			Q <= 11'b0;
		else if(Q == VERTICAL_TOTAL_FRAME - 1)
			Q <= 11'b0;
		else if(en == 1'b1)
			Q <= Q + 1'b1;
		else 
			Q <= Q;
	end
	
	assign VCNT = Q;
	
endmodule 