module timer1(input clk,
             input rst,
             output reg out,
             output reg en_out,
             output reg rst_out);

reg [25:0] slow_clk;
reg [3:0] countsec;
reg [7:0] out_r;
wire en;
reg [3:0] cnt;  
  
assign en = (slow_clk ==26'd20);
 
always @ (posedge clk or posedge rst) begin 
      if (rst) begin 
          slow_clk <= 26'd20;
          rst_out <= 1'b1;
      end
      else begin 
        rst_out <= 1'b0;
        if (en) slow_clk <= 26'b0;
        else  slow_clk <= slow_clk + 26'b1;
      end
end
  
always @ (posedge clk or posedge rst) begin
    if(rst) begin 
      out <= 1'b0;
      out_r <= 8'b0;
      en_out <= 1'b0;
      cnt <= 4'b0;
      countsec <=4'b0;
    end
    else 
    begin 
    if (en )
	    
            begin
            countsec <= countsec + 4'd1;
	    if(countsec == 4'd9)
            countsec<=0;
            out_r <= (9-countsec);
            en_out <= 1'b1;
            cnt <= 4'b0;
            end
            else begin 
            cnt <= cnt + 1'b1;
            out <= out_r[0];
            out_r <= (out_r >> 8'b1);
            if (cnt == 4'b1000) begin
                  en_out <= 1'b0;
                  cnt <= 4'b1000;
            end
            end
       
       end
    
end
  
endmodule
