module display_area_signal_generator (input rst, input [10:0] HCNT, input [10:0] VCNT, output IAA);

	/*
	*	Display Area Signal is active if the "cursor" is inside the active display area
	*	This value is given by the VGA specification
	*/

	parameter HORIZONTAL_VISIBLE_AREA 	= -1;
	parameter VERTICAL_VISIBLE_AREA 	= -1;
	
	reg iaa;
	
	always@(*)
	begin
	if(rst == 1'b0)
		iaa <= 1'b0;
	else
		iaa <= ((HCNT <= HORIZONTAL_VISIBLE_AREA) && (VCNT <= VERTICAL_VISIBLE_AREA));
	end 

	assign IAA = iaa;
	
endmodule 