module reset_synchronizer(input clk, input rst_n, output reg q_2);

/* For each clk pulse
*		if reset is not asserted on first flip flop
*				do not assert the signal to the second flipflop
*				else assert the signal to the seccond flip flop
*
*	For each clk pulse
*		if the input signal is asserted, assert q_2
*			else if input signal is not asserted, assert q_1
*
*	There will be a reset signal pulse generated between the 
*		Delays of the flip flops as the reset signal propogates
*		through the module
*/ 

	reg q_1;
	
	always@(*)
	begin
		if(rst_n)
			q_1 <= 1'b0; //1
		else
			q_1 <= 1'b1; // 0
	end
	
	always@(*)
	begin
		q_2 <= q_1;
	end
	
endmodule