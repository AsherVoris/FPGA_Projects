module I2C_Master(inout wire SDA, output wire SCL, input wire clk, input wire reset_n, input wire [6:0] dev_addr, input wire rw, input wire [7:0] addr, input wire [7:0] data, input wire en, output wire ready, output wire [7:0] State, output reg err, output wire i2c_read_out);

`include "params.vh"

// States for I2C state machine
localparam IDLE = 0; // no clock
localparam START = 1; // no clock
localparam SEND_DEV_ADDRESS = 2; //clock
localparam ACK_DEV_ADDRESS = 3; //clock 
localparam SEND_ADDRESS = 4; // clock
//localparam READ_WRITE = 5; // clock
localparam ACK_ADDR = 6; // clock
localparam ACK_DATA = 7; //clock
localparam NACK = 8; // no clock
localparam DATA = 9; //clock
localparam STOP = 10; // no clock
		
reg [7:0] state; //will hold the state
reg signed [7:0] count; //will hold the bitcount of bits written across bus
reg scl_enable = 0; //dictates if bus is enabled
reg [7:0] dev_addr_internal; // save data and address internally to prevent data loss to this module
reg rw_internal;
reg [7:0] addr_internal; 
reg [7:0] data_internal;
reg sda_internal;
wire i2c_drive_en; // 1 master holds line, 0 slave holds line (basically the in acknowledge signal)
wire i2c_read; //echos the read when slave drives line

assign i2c_drive_en = ((state == IDLE) || (state == START) || (state == SEND_DEV_ADDRESS) || (state == SEND_ADDRESS) /*|| (state == READ_WRITE)*/ || (state == NACK) || (state == DATA) || (state == STOP));
Tristate_Buffer Tristate_Buffer_inst (.datain(sda_internal), .oe(i2c_drive_en), .dataio(SDA), .dataout(i2c_read));
assign i2c_read_out = i2c_read;

//doesn't work (optimized out?)
//assign i2c_read = SDA;
//assign SDA = i2c_drive_en ? 1'bZ : sda_internal;

assign State = state;

assign SCL = (scl_enable == 0) ? 1 : ~clk; // if scl_enable == 0 then SCL is high, else it is the same as the inverse of input clk
assign ready = ((reset_n == 1'b1) && (state == IDLE)) ? 1 : 0; // if reset is not asserted and we are in idle state then module is ready to run

// Since the scl line does not need to be driven all the time, as per i2c protocol; we can generate
// an always block that will only allow the clock to run in the desired states. 
always @(negedge clk or negedge reset_n) //allows a phase shift in the clock so that the data is written during the rising edge of clock
begin	
	if(reset_n == 1'b0)
	begin
		scl_enable = 0;
	end
	else
	begin
		if((state == IDLE) || (state == START) || (state == STOP) || (state == NACK)/*|| (state == ACK_DEV_ADDRESS) || (state == ACK_ADDR) || (state == ACK_DATA) || (count < 0 && state == READ_WRITE) || (count < 0 && state == SEND_ADDRESS) || (count < 0 && state == DATA)*/)
		begin
			scl_enable = 0;
		end
		else
		begin
			scl_enable = 1;
		end
	end
end

always @(posedge clk or negedge reset_n)
begin
	if(reset_n == 1'b0)
	begin
		count = 0;
		sda_internal = 1;
		//i2c_drive_en <= 1;
		state = IDLE;
		err = 0;
	end
	else
	begin
	case(state)
		IDLE:						begin // both scl and sda will be high, internal registers are written to their default states
										sda_internal = 1;
										if(en)
										begin
											state = START; //move to start state
											dev_addr_internal = {dev_addr, rw}; //load up the data to be sent
											addr_internal = addr;
											data_internal = data;
											//i2c_drive_en <= 1;
										end
										else
										begin
											state = IDLE; //else wait here
										end
									end
		START:					begin // sda will drop and then scl will drop signalling a start
										sda_internal = 0;
										count = 7;
										state = SEND_DEV_ADDRESS; //move to send dev addr
										//i2c_drive_en <= 1;
									end
		SEND_DEV_ADDRESS:
									begin
										if(count < 0)
										begin
											sda_internal = 1'bz;
											count = 7; //set count to addr len
											state = ACK_DEV_ADDRESS;
											//i2c_drive_en <= 1;
										end
										sda_internal = dev_addr_internal[count]; //send dev addr until count is 0
										count = count-1;
									end
		ACK_DEV_ADDRESS:		begin
										if(`ifdef SIMULATION i2c_read == 1'b0 `else i2c_read != 1'b0 `endif)
										begin
											state = NACK; //else go trap in nack
										end
										state = SEND_ADDRESS; //move to reg addr
									end
		SEND_ADDRESS:			begin // addr data will change on rising edge of scl and be read during scl = 1
										if(count < 0) 
										begin
											sda_internal = 1'bz;
											count = 7;
											state = ACK_ADDR; //move to ack
										end
										sda_internal = addr_internal[count]; //send address until count is 0
										count = count-1;
									end
		ACK_ADDR:				begin 
										if(`ifdef SIMULATION i2c_read == 1'b0 `else i2c_read != 1'b0 `endif) 
										begin
											state = NACK;
										end
										state = DATA;
									end	
		DATA:						begin //send the data until count is 0
										if(count < 0)
										begin
											sda_internal = 1'bz;
											state = ACK_DATA; //move to ack data
										end
										sda_internal = data_internal[count];
										count = count-1;
									end
		ACK_DATA:				begin
										if(`ifdef SIMULATION i2c_read == 1'b0 `else i2c_read != 1'b0 `endif)
										begin
											state = NACK;
										end
										state = STOP;
									end
		STOP:						begin // inverse of start condition
										sda_internal = 1'b1;
										state = IDLE;
									end
		NACK:						begin
										//i2c_drive_en <= 1;
										sda_internal = 1'b0;
										err = 1'b1;
									end
		default:
									begin
										state = IDLE;
									end
	endcase
	end
end

endmodule 
