module horizontal_sync_pulse_generator (input rst, input [10:0] HCNT, output HS);

	/*
	*	sync pulse is active low and is based off of the VGA specification
	*/

	parameter HORIZONTAL_FRONT_PORCH = -1;
	parameter HORIZONTAL_SYNC_PULSE = -1;
	parameter HORIZONTAL_VISIBLE_AREA = -1;
	
	reg hs;
	
	always@(*)
	begin
	if(rst == 1'b0)
		hs <= 1'b0;
	else
		//hs <= ((HCNT >= (640 + 16)) && (HCNT < (640+16+96)));
		hs <= ((HCNT >= (HORIZONTAL_VISIBLE_AREA + HORIZONTAL_FRONT_PORCH)) && (HCNT < (HORIZONTAL_VISIBLE_AREA + HORIZONTAL_FRONT_PORCH + HORIZONTAL_SYNC_PULSE)));
	end
	
	assign HS = ~hs;
	
endmodule 