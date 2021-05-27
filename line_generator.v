module image_generator(input VGA_CLK, input IAA, input VS, input CLK, input [10:0] HCNT, input [10:0] VCNT, input [3:0] KEY, input[9:0] SW, input rst, output [7:0] R, output [7:0] G, output [7:0] B);

/*
*	Pushbuttons must be used to control square movement.
*	Key 3 will move the squares from left to right across the screen.
*	Key 0 is reset and will reset the posistion of the squares.
*	If the squares reach the end of the screen they will be reset.
*	The colors of the squares are controlled by the switches.
*	Since we only have 10 switches (sadly not 12); 3 switches
*	will be used to control the top 3 bits of the 8 bit color 
*	values. While this doesn't provide access to every color,
*	it provides enough colors to test the implementation.
*	SW[8:6] control Red[7:5], SW[5:3] control Green[7:5],
*	and SW[2:0] control Blue[7:5].
*/

//VGA parameters
parameter 	HORIZONTAL_VISIBLE_AREA 			= 		-1;
parameter 	VERTICAL_VISIBLE_AREA				= 		-1;

//OFF colors = 0
parameter	RED_OFF_VALUE							=		-1;
parameter	GREEN_OFF_VALUE						= 		-1;
parameter	BLUE_OFF_VALUE							=		-1;

//Default Square Locations
parameter 	D_POS_LEFT_SQUARE_LEFT_BOUND		= 		-1;
parameter	D_POS_LEFT_SQUARE_RIGHT_BOUND		=		-1;
parameter	D_POS_RIGHT_SQUARE_LEFT_BOUND		=		-1;
parameter	D_POS_RIGHT_SQUARE_RIGHT_BOUND	=		-1;
parameter	D_POS_SQUARES_TOP_BOUND				=		-1;
parameter	D_POS_SQUARES_BOTTOM_BOUND			=		-1;	

reg	[7:0] 	r, g, b;
reg 	[7:0] 	SQUARES_RED_VALUE, SQUARES_GREEN_VALUE, SQUARES_BLUE_VALUE;
reg 	[10:0]	LEFT_SQUARE_LEFT_BOUND;
reg 	[10:0]	LEFT_SQUARE_RIGHT_BOUND;
reg	[10:0]	RIGHT_SQUARE_LEFT_BOUND;
reg	[10:0]	RIGHT_SQUARE_RIGHT_BOUND;
reg	[10:0]	SQUARES_TOP_BOUND;
reg	[10:0]	SQUARES_BOTTOM_BOUND;
reg	[7:0]		address;
wire	[23:0]	q;

//initial LEFT_SQUARE_LEFT_BOUND 					= 		D_POS_LEFT_SQUARE_LEFT_BOUND;
//initial LEFT_SQUARE_RIGHT_BOUND 					= 		D_POS_LEFT_SQUARE_RIGHT_BOUND;	
//initial RIGHT_SQUARE_LEFT_BOUND 					= 		D_POS_RIGHT_SQUARE_LEFT_BOUND;
//initial RIGHT_SQUARE_RIGHT_BOUND 				= 		D_POS_RIGHT_SQUARE_RIGHT_BOUND;
//initial SQUARES_TOP_BOUND 							= 		D_POS_SQUARES_TOP_BOUND;	
//initial SQUARES_BOTTOM_BOUND 						= 		D_POS_SQUARES_BOTTOM_BOUND;	

//always@(*)
//begin
//	SQUARES_RED_VALUE[7:5] <= SW[8:6];
//	SQUARES_GREEN_VALUE[7:5] <= SW[5:3];
//	SQUARES_BLUE_VALUE[7:5] <= SW[2:0];
//end

//always@(posedge CLK or negedge rst)
//begin
//	if(rst == 1'b0)
//	begin
//		LEFT_SQUARE_LEFT_BOUND 		<= 	D_POS_LEFT_SQUARE_LEFT_BOUND;
//		LEFT_SQUARE_RIGHT_BOUND		<= 	D_POS_LEFT_SQUARE_RIGHT_BOUND;
//		RIGHT_SQUARE_LEFT_BOUND		<= 	D_POS_RIGHT_SQUARE_LEFT_BOUND;
//		RIGHT_SQUARE_RIGHT_BOUND 	<= 	D_POS_RIGHT_SQUARE_RIGHT_BOUND;
//	end
//	else
//	begin
//		if(KEY[3] == 1'b0)
//		begin
//				LEFT_SQUARE_LEFT_BOUND 		<= 	LEFT_SQUARE_LEFT_BOUND + 1'b1;
//				LEFT_SQUARE_RIGHT_BOUND		<= 	LEFT_SQUARE_RIGHT_BOUND + 1'b1;
//				RIGHT_SQUARE_LEFT_BOUND		<= 	RIGHT_SQUARE_LEFT_BOUND + 1'b1;
//				RIGHT_SQUARE_RIGHT_BOUND	<= 	RIGHT_SQUARE_RIGHT_BOUND + 1'b1;
//			if(RIGHT_SQUARE_RIGHT_BOUND == HORIZONTAL_VISIBLE_AREA-1)
//			begin
//				LEFT_SQUARE_LEFT_BOUND 		<= 	D_POS_LEFT_SQUARE_LEFT_BOUND;
//				LEFT_SQUARE_RIGHT_BOUND		<= 	D_POS_LEFT_SQUARE_RIGHT_BOUND;
//				RIGHT_SQUARE_LEFT_BOUND		<= 	D_POS_RIGHT_SQUARE_LEFT_BOUND;
//				RIGHT_SQUARE_RIGHT_BOUND 	<= 	D_POS_RIGHT_SQUARE_RIGHT_BOUND;
//			end
//		end
//	end
//end

always@(*)
begin
	if(rst == 1'b0)
	begin
		address <= 0;
	end
	else
	begin
		if(IAA == 1'b1)
		begin
			if(HCNT > 0 && HCNT <= 80)
				address <= 0;
			else if(HCNT > 80 && HCNT <= 160)
				address = 8;
			else if(HCNT > 160 && HCNT <= 240)
				address <= 16;
			else if(HCNT > 240 && HCNT <= 320)
				address <= 24;
			else if(HCNT > 320 && HCNT <= 400)
				address <= 32;
			else if(HCNT > 400 && HCNT <= 480)
				address <= 40;
			else if(HCNT > 480 && HCNT <= 560)
				address <= 48;
			else if(HCNT > 560 && HCNT <= 640)
				address <= 56;
			else
				address <= -1;
		end
	end
end

VGA_ROM	VGA_ROM_inst (.address(address),.clock(VGA_CLK),.q(q));

always@(*)
begin
	if(rst == 1'b0)
	begin
		r <= RED_OFF_VALUE;
		g <= GREEN_OFF_VALUE;
		b <= BLUE_OFF_VALUE;
	end
	else
	begin
		if(IAA == 1'b1)
		begin
			r <= q[23:16];
			g <= q[15:8];
			b <= q[7:0];
		end
		else
		begin
			r <= RED_OFF_VALUE;
			g <= GREEN_OFF_VALUE;
			b <= BLUE_OFF_VALUE;
		end
	end
end

assign R = r;
assign G = g;
assign B = b; 

endmodule
