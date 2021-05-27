module Reset_Synchronizer(input clk, input reset, output reg reset_n);

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
		if(reset) 
			q_1 <= 1'b1; //1
		else
			q_1 <= 1'b0; //0
	end
	
	always@(*)
	begin
		reset_n <= q_1;
	end
	
endmodule