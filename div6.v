`timescale 100ns / 100ns

module top();
reg clk   = 1'b0;
reg reset = 1'b1;

clk_div6 divider (
	.clk		( clk   ),
	.reset		( reset ),
	.clk_div6	(	)
);

always #1 clk = ~clk;

initial #1 reset <= 1'b0;
endmodule


module clk_div6 (
	input	wire	clk,
	input	wire	reset,
	output  reg	clk_div6
);
reg [1:0] r_cnt;

always @(posedge clk) begin

if (reset)
	{r_cnt, clk_div6} <= 3'b00;

else	if (r_cnt == 2'b10) begin
		r_cnt <= 2'b00;
		clk_div6 <= ~clk_div6;
     	end else
		r_cnt <= r_cnt + 1;
end
endmodule