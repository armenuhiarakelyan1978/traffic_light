`include "timer.v"
module st_mach( output reg red,
output reg yellow,
output reg green,
input clk,
input  rst);

localparam S0 = 2'b00;
localparam S1 = 2'b01;
localparam S2 = 2'b10;
localparam S3 = 2'b11;

reg [1:0] state, next_state;
reg [10:0]count;
wire [6:0] out_t;
reg rst_t = 1;
timer tim(.clk(clk),.rst(rst_t), .out_num(out_t));
always@(posedge clk or  posedge rst )
begin
	if(rst)begin
		state <= S0;
	end
	else begin
                state <= next_state;
	end
end
always@(posedge clk or posedge rst)
begin
	if(rst)begin
		count <= 11'd0;

	end
	else if (count == 11'd2000)
	begin
		count <=11'd0;
	end
	else begin
		count <= count + 11'b1;
	end
end
always@(state)
begin    
        red = 1'b1;
	yellow = 1'b0;
	green = 1'b0;
	case(state)
		S0: ;
		S1:begin
			red = 1'b0;
			yellow = 1'b1;
		   end
		S2:begin
			red = 1'b0;
			green = 1'b1;
		end
		S3:begin
			red = 1'b0;
			yellow = 1'b1;
		end

	endcase
end
always@(*)
begin
	
	case(state)
		S0:
                begin
		if(out_t == 7'b0110000)begin

			next_state = S1;
	        end
		else begin
			next_state = S0;
		end
	        end
		S1:begin
			
			if(count == 11'd2000)begin
				next_state = S2;
			end
			else begin
				next_state = S1;
			end
		       end
		S2:    if(out_t == 7'b0110000) begin
			next_state = S3;
		        end
			else begin
			next_state = S2;
			end
		        
		S3:    begin
			if(count == 11'd2000) begin
			next_state = S0;
			end
		        else  begin
		       	next_state = S3;
		       	end
		end
	endcase
end
always@(*)
begin   
        
	if(state == S0 || state == S2)
	begin
		rst_t<=0;
	end
	else if(state == S1 || state == S3)
	begin
		rst_t <=1;
	end
end
endmodule
