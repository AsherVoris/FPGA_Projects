module DAI(input wire clk, input wire reset_n, output wire [32:0] ADDR, input wire en);

reg[32:0] addr;
assign ADDR = addr;

always@(posedge clk or negedge reset_n)
begin
	if(reset_n == 1'b0)
	begin
		addr <= 0;
	end
	else if(en)
	begin
		if(addr == 240255)
		begin
			addr <= 0;
		end
		else
		begin
			addr <= addr + 1;
		end
	end
end

endmodule 