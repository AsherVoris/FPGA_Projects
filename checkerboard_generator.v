module image_generator(input VGA_CLK, input IAA, input VS, input CLK, input [10:0] HCNT, input [10:0] VCNT, input [3:0] KEY, input[9:0] SW, input rst, output [7:0] R, output [7:0] G, output [7:0] B);

/*
*	This Image Generator module draws an 8x8 checkerboard on the screen.
*	Colors for the board are pulled from a 64 word ROM.
* 	The address for accessing the ROM is calculated by first dividing the total screen width
* 	and height by 8. This gives the size of one rectangle of the checkerboard.
*	An if statement is then used to calculate the indeces of the checkerboard matrix the
*	screen cursor is in at the time of drawing.
*	After these indeces are calculated, they are passed through a nested case statement 
* 	to determine which address to access.
*/

//VGA parameters
parameter 	HORIZONTAL_VISIBLE_AREA 			= 		-1;
parameter 	VERTICAL_VISIBLE_AREA				= 		-1;

//OFF colors = 0
parameter	RED_OFF_VALUE							=		-1;
parameter	GREEN_OFF_VALUE						= 		-1;
parameter	BLUE_OFF_VALUE							=		-1;

//Addresses
parameter	COLOR_1									=		-1;
parameter	COLOR_2									=		-1;
parameter	COLOR_3									=		-1;
parameter	COLOR_4									=		-1;
parameter	COLOR_5									=		-1;
parameter	COLOR_6									=		-1;
parameter	COLOR_7									=		-1;
parameter	COLOR_8									=		-1;

//Checkerboard Sizes
parameter	CHECKERBOARD_HORIZONTAL_SIZE = (HORIZONTAL_VISIBLE_AREA / 8); 
parameter 	CHECKERBOARD_VERTICAL_SIZE	= (VERTICAL_VISIBLE_AREA / 8);

//Reg/Wire
reg	[7:0] 	r, g, b;
reg 	[7:0] 	SQUARES_RED_VALUE, SQUARES_GREEN_VALUE, SQUARES_BLUE_VALUE;
reg	[7:0]		x, y; //for indeces
reg	[7:0]		address;
wire	[23:0]	q;

//Calculate which indeces the "cursor" is in 0,0 corresponds to pixel 0,0 (top left). 
//8,8 corresponds to width,height (bottom right). 
always@(*)
begin
	if(rst == 1'b0)
	begin
		x <= 0;
	end
	else
	begin
		if(IAA == 1'b1)
		begin
			if(HCNT > 0 && HCNT <= CHECKERBOARD_HORIZONTAL_SIZE)
				x <= 1;
			else if(HCNT > CHECKERBOARD_HORIZONTAL_SIZE && HCNT <= (2*CHECKERBOARD_HORIZONTAL_SIZE))
				x <= 2;
			else if(HCNT > (2*CHECKERBOARD_HORIZONTAL_SIZE) && HCNT <= (3*CHECKERBOARD_HORIZONTAL_SIZE))
				x <= 3;
			else if(HCNT > (3*CHECKERBOARD_HORIZONTAL_SIZE) && HCNT <= (4*CHECKERBOARD_HORIZONTAL_SIZE))
				x <= 4;
			else if(HCNT > (4*CHECKERBOARD_HORIZONTAL_SIZE) && HCNT <= (5*CHECKERBOARD_HORIZONTAL_SIZE))
				x <= 5;
			else if(HCNT > (5*CHECKERBOARD_HORIZONTAL_SIZE) && HCNT <= (6*CHECKERBOARD_HORIZONTAL_SIZE))
				x <= 6;
			else if(HCNT > (6*CHECKERBOARD_HORIZONTAL_SIZE) && HCNT <= (7*CHECKERBOARD_HORIZONTAL_SIZE))
				x <= 7;
			else if(HCNT > (7*CHECKERBOARD_HORIZONTAL_SIZE) && HCNT <= (8*CHECKERBOARD_HORIZONTAL_SIZE))
				x <= 8;
			else
				x <= 0;
		end
	end
end

always@(*)
begin
	if(rst == 1'b0)
	begin
		y <= 0;
	end
	else
	begin
		if(IAA == 1'b1)
		begin
			if(VCNT > 0 && VCNT <= CHECKERBOARD_VERTICAL_SIZE)
				y <= 1;
			else if(VCNT > CHECKERBOARD_VERTICAL_SIZE && VCNT <= (2*CHECKERBOARD_VERTICAL_SIZE))
				y <= 2;
			else if(VCNT > (2*CHECKERBOARD_VERTICAL_SIZE) && VCNT <= (3*CHECKERBOARD_VERTICAL_SIZE))
				y <= 3;
			else if(VCNT > (3*CHECKERBOARD_VERTICAL_SIZE) && VCNT <= (4*CHECKERBOARD_VERTICAL_SIZE))
				y <= 4;
			else if(VCNT > (4*CHECKERBOARD_VERTICAL_SIZE) && VCNT <= (5*CHECKERBOARD_VERTICAL_SIZE))
				y <= 5;
			else if(VCNT > (5*CHECKERBOARD_VERTICAL_SIZE) && VCNT <= (6*CHECKERBOARD_VERTICAL_SIZE))
				y <= 6;
			else if(VCNT > (6*CHECKERBOARD_VERTICAL_SIZE) && VCNT <= (7*CHECKERBOARD_VERTICAL_SIZE))
				y <= 7;
			else if(VCNT > (7*CHECKERBOARD_VERTICAL_SIZE) && VCNT <= (8*CHECKERBOARD_VERTICAL_SIZE))
				y <= 8;
			else
				y <= 0;
		end
	end
end

// Determine which address to access based off of the indeces of the checkerboard matrix.
// I'm sure there is a better way to do this but as a degenerate implementation this works.
always@(*)
begin
	if(rst == 1'b0)
	begin
		address <= -1;
	end
	else
	begin
		if(IAA == 1'b1)
		begin
			case(x)
				1	: 	begin
							case(y)
								1	:	address <= COLOR_1;
								2	:	address <= COLOR_2;
								3	: 	address <= COLOR_3;
								4	:	address <= COLOR_4;
								5	:	address <= COLOR_5;
								6	:	address <= COLOR_6;
								7	:	address <= COLOR_7;
								8	:	address <= COLOR_8;
								default : address <= -1;
							endcase
						end
				2	: 	begin
							case(y)
								1	:	address <= COLOR_8;
								2	:	address <= COLOR_1;
								3	: 	address <= COLOR_2;
								4	:	address <= COLOR_3;
								5	:	address <= COLOR_4;
								6	:	address <= COLOR_5;
								7	:	address <= COLOR_6;
								8	:	address <= COLOR_7;
								default : address <= -1;
							endcase
					end 
				3	: 	begin
							case(y)
								1	:	address <= COLOR_7;
								2	:	address <= COLOR_8;
								3	: 	address <= COLOR_1;
								4	:	address <= COLOR_2;
								5	:	address <= COLOR_3;
								6	:	address <= COLOR_4;
								7	:	address <= COLOR_5;
								8	:	address <= COLOR_6;
								default : address <= -1;
							endcase
					end 
				4	: 	begin
							case(y)
								1	:	address <= COLOR_6;
								2	:	address <= COLOR_7;
								3	: 	address <= COLOR_8;
								4	:	address <= COLOR_1;
								5	:	address <= COLOR_2;
								6	:	address <= COLOR_3;
								7	:	address <= COLOR_4;
								8	:	address <= COLOR_5;
								default : address <= -1;
							endcase
					end
				5	: 	begin
							case(y)
								1	:	address <= COLOR_5;
								2	:	address <= COLOR_6;
								3	: 	address <= COLOR_7;
								4	:	address <= COLOR_8;
								5	:	address <= COLOR_1;
								6	:	address <= COLOR_2;
								7	:	address <= COLOR_3;
								8	:	address <= COLOR_4;
								default : address <= -1;
							endcase
					end 
				6	: 	begin
							case(y)
								1	:	address <= COLOR_4;
								2	:	address <= COLOR_5;
								3	: 	address <= COLOR_6;
								4	:	address <= COLOR_7;
								5	:	address <= COLOR_8;
								6	:	address <= COLOR_1;
								7	:	address <= COLOR_2;
								8	:	address <= COLOR_3;
								default : address <= -1;
							endcase
					end 
				7	: 	begin
							case(y)
								1	:	address <= COLOR_3;
								2	:	address <= COLOR_4;
								3	: 	address <= COLOR_5;
								4	:	address <= COLOR_6;
								5	:	address <= COLOR_7;
								6	:	address <= COLOR_8;
								7	:	address <= COLOR_1;
								8	:	address <= COLOR_2;
								default : address <= -1;
							endcase
					end 
				8	: 	begin
							case(y)
								1	:	address <= COLOR_2;
								2	:	address <= COLOR_3;
								3	: 	address <= COLOR_4;
								4	:	address <= COLOR_5;
								5	:	address <= COLOR_6;
								6	:	address <= COLOR_7;
								7	:	address <= COLOR_8;
								8	:	address <= COLOR_1;
								default : address <= -1;
							endcase
					end 
				default : address <= -1;
			endcase 
		end
		else
		begin
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
