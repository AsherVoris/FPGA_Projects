`timescale 1 ns / 100ps
module testbench();
`include "params.vh"

// reg inputs
// wire outputs

reg clkin;
reg reset;
wire SCL;
wire SDA;
wire i2c_clock;
wire i2c_ready;
wire i2c_en;
wire [7:0] State;
wire lrc;
wire bclk;
wire dacdat;
wire [15:0] aud_addr;
wire done; 
wire out;
wire [9:0] ledr;

Audio_Codec DUT (.LEDR(ledr), .DONE(done), .AUDIO_ADDR(aud_addr), .AUD_DACDAT(dacdat), .AUD_BCLK(bclk), .AUD_DACLRCK(lrc), .STATE(State), .CLOCK_50(clkin), .FPGA_I2C_SDAT(SDA), .FPGA_I2C_SCLK(SCL), .RESET(reset), .I2C_CLOCK(i2c_clock), .I2C_EN(i2c_en), .OUT(out));

always #10 clkin = ~clkin;

initial
	begin
		$display ($time, "<< STARTING SIM >>");
		clkin = 0;
		#100 reset = 1'b0;
		$display ($time, " << ASSERTING RESET >> ");
		#200 reset = 1'b1;
		$display ($time, " << DEASSERTING RESET >> ");
		#1000000 $stop; 
	end
endmodule
