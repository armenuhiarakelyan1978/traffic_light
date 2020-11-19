`include "timer1.v"
`include "shift.v"
`include "7seg.v"
module timer(output [6:0] out_num,
input clk,
input rst);
wire rst_out, en_out, in_out;
wire [7:0] out;
timer1 t1(.clk(clk),.rst(rst),.out(in_out),
.en_out(en_out),.rst_out(rst_out));

shift shift1(.clk(clk), .rst(rst_out),
.we(en_out),.in(in_out),.out(out));

d7seg d7s(.in(out), .we(en_out),.out_num(out_num));

endmodule
