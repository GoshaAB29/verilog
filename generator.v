`timescale 100ns / 100ns

module top();
reg clk   = 1'b0;
reg reset = 1'b1;

generator test (
	.clk	( clk   ),
	.reset	( reset ),
	.pulse	(	)
);

always #1 clk = ~clk;

initial begin
	test.pulse <= 1'b0;
	#1 reset <= 1'b0;
end
endmodule


module generator (
	input	wire	clk,
	input	wire	reset,
	output  reg	pulse
);
reg [2:0] r_cnt;
reg [2:0] r_nxt;

always @(posedge clk) begin
if (reset)
	{r_cnt, r_nxt, pulse} <= 7'b00;

else	case (r_nxt)
		3'd1: begin 
			assign pulse = clk; 
			r_cnt <= r_nxt; 
			end
		3'd2, 3'd4: begin 
			assign pulse = 0; 
			r_cnt <= r_nxt; 
			end
		3'd3: begin 
			assign pulse = ~clk;
			r_cnt <= r_nxt; 
			end
		3'd5: begin
			 assign pulse = 0;
			 r_cnt <= 0;
			end
	endcase
 
assign r_nxt = r_cnt + 3'b01;
end
endmodule