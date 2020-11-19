module d7seg(output reg [6:0] out_num,
            input we,
            input [7:0] in);
always@(*)
	if(we)begin
           case(in)
           8'd0 : out_num = 7'b1111110;
	   8'd1 : out_num = 7'b0110000;
	   8'd2 : out_num = 7'b1101101;
	   8'd3 : out_num = 7'b1111001;
	   8'd4 : out_num = 7'b0110011;
	   8'd5 : out_num = 7'b1011011;
	   8'd6 : out_num = 7'b1011111;
	   8'd7 : out_num = 7'b1110010;
	   8'd8 : out_num = 7'b1111111;
	   8'd9 : out_num = 7'b1111011;
	   default: out_num = 7'b0000000;
            endcase
        end
        else begin
		out_num = 0;
	end
endmodule
