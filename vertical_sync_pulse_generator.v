module vertical_sync_pulse_generator (input rst, input [10:0] VCNT, output VS);

	/*
	*	sync pulse is active low and is based off of the VGA specification
	*/

	parameter VERTICAL_VISIBLE_AREA = -1;
	parameter VERTICAL_FRONT_PORCH = -1;
	parameter VERTICAL_SYNC_PULSE = -1;
	
	reg vs;
	
	always@(*)
	begin
	if(rst == 1'b0)
		vs <= 1'b0;
	else
		//vs <= ((VCNT >= (480+10)) && (VCNT < (480+10+2)));
		vs <= ((VCNT >= (VERTICAL_VISIBLE_AREA + VERTICAL_FRONT_PORCH) && (VCNT < (VERTICAL_VISIBLE_AREA + VERTICAL_FRONT_PORCH + VERTICAL_SYNC_PULSE))));
	end
	
	assign VS = ~vs;
	
endmodule 