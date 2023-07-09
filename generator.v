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

initial #1 reset <= 1'b0;
endmodule


module generator (
	input	wire	clk,
	input	wire	reset,
	output  reg	pulse
);
reg [2:0] r_cnt;

always @(posedge clk)
if (reset)
	{r_cnt, pulse} <= 4'b00;

else	case (r_cnt)
		3'd0: begin 
			pulse <= ~pulse; 
			r_cnt <= r_cnt + 1; 
			end
		3'd1, 3'd2, 3'd3: begin 
			pulse <= 0; 
			r_cnt <= r_cnt + 1; 
			end
		3'd4: begin
			 pulse <= 0;
			 r_cnt <= 0;
			end
	endcase
endmodule