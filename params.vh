`ifdef 	VGA_640_480 
    				parameter	HORIZONTAL_VISIBLE_AREA 		= 	640;
					parameter	HORIZONTAL_FRONT_PORCH  		= 	16;
					parameter	HORIZONTAL_SYNC_PULSE  		= 	96;
					parameter	HORIZONTAL_BACK_PORCH   		= 	48;
					parameter	HORIZONTAL_TOTAL_LINE   		= 	800;

					parameter	VERTICAL_VISIBLE_AREA   		= 	480;
					parameter	VERTICAL_FRONT_PORCH    		= 	10;
					parameter	VERTICAL_SYNC_PULSE     		= 	2;
					parameter	VERTICAL_BACK_PORCH     		= 	33;
					parameter	VERTICAL_TOTAL_FRAME   		= 	525;

					//OFF colors = 0
					parameter	RED_OFF_VALUE				=	8'd0;
					parameter	GREEN_OFF_VALUE			=	8'd0;
					parameter	BLUE_OFF_VALUE				=	8'd0;

					//Default Square Locations (Vertical Center Horizontal Left)
					parameter 	D_POS_LEFT_SQUARE_LEFT_BOUND		=	0;
					parameter	D_POS_LEFT_SQUARE_RIGHT_BOUND		=	100;
					parameter	D_POS_RIGHT_SQUARE_LEFT_BOUND		=	150;
					parameter	D_POS_RIGHT_SQUARE_RIGHT_BOUND	=	250;
					parameter	D_POS_SQUARES_TOP_BOUND		=	190;
					parameter	D_POS_SQUARES_BOTTOM_BOUND		=	290;	
					
					//Clock Divider
					parameter	DIVIDER				=	251750;
`else
    				parameter	HORIZONTAL_VISIBLE_AREA 		= 	640;
					parameter	HORIZONTAL_FRONT_PORCH  		= 	16;
					parameter	HORIZONTAL_SYNC_PULSE  		= 	96;
					parameter	HORIZONTAL_BACK_PORCH   		= 	48;
					parameter	HORIZONTAL_TOTAL_LINE   		= 	800;

					parameter	VERTICAL_VISIBLE_AREA   		= 	480;
					parameter	VERTICAL_FRONT_PORCH    		= 	10;
					parameter	VERTICAL_SYNC_PULSE     		= 	2;
					parameter	VERTICAL_BACK_PORCH     		= 	33;
					parameter	VERTICAL_TOTAL_FRAME   		= 	525;

					//OFF colors = 0
					parameter	RED_OFF_VALUE				=	8'd0;
					parameter	GREEN_OFF_VALUE			=	8'd0;
					parameter	BLUE_OFF_VALUE				=	8'd0;

					//Default Square Locations (Vertical Center Horizontal Left)
					parameter 	D_POS_LEFT_SQUARE_LEFT_BOUND		=	0;
					parameter	D_POS_LEFT_SQUARE_RIGHT_BOUND		=	100;
					parameter	D_POS_RIGHT_SQUARE_LEFT_BOUND		=	150;
					parameter	D_POS_RIGHT_SQUARE_RIGHT_BOUND	=	250;
					parameter	D_POS_SQUARES_TOP_BOUND		=	190;
					parameter	D_POS_SQUARES_BOTTOM_BOUND		=	290;
					
					//Clock Divider
					parameter	DIVIDER				=	251750;	
`endif //parameters
