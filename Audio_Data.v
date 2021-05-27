module Audio_Data(input wire reset_n, input wire clk, input wire [32:0] data, output reg data_bit, input wire en);

reg [32:0] frame_count = 0;
reg [8:0] count = 15;

always@(negedge clk)
begin
	if(reset_n == 1'b0)
	begin
		frame_count <= 0;
		count <= 15;
		data_bit <= 0;
	end
	else if(en)
	begin
		if(frame_count < 16)
		begin
			data_bit <= data[count];
			count <= count - 1;
			frame_count <= frame_count + 1;
			if(count == 0)
			begin
				count <= 15;
			end
		end
		else if(frame_count >= 16 && frame_count < 32)
		begin
			data_bit <= data[count];
			count <= count - 1;
			frame_count <= frame_count + 1;
			if(count == 0)
			begin
				count <= 15;
			end
		end
		else if(frame_count == 250)
		begin	
			frame_count <= 0;
			count <= 15;
		end
		else
		begin
			frame_count <= frame_count + 1;
			data_bit <= 0;
		end
	end
end

endmodule
