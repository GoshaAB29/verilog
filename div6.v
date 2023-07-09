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

initial begin
	divider.clk_div6 <= 1'b0;
	#1 reset <= 1'b0;
end
endmodule


module clk_div6 (
	input	wire	clk,
	input	wire	reset,
	output  reg	clk_div6
);
reg [1:0] r_cnt;
reg [1:0] r_nxt;

always @(posedge clk) begin

if (reset)
	{r_cnt, r_nxt, clk_div6} <= 5'b00;

else	if (r_nxt == 2'b11) begin
		r_cnt <= 2'b00;
		clk_div6 <= ~clk_div6;
     	end else
		r_cnt <= r_nxt;

assign r_nxt = r_cnt + 2'b01;
end
endmodule