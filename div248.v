`timescale 100ns / 100ns

module top();
reg clk   = 1'b0;
reg reset = 1'b1;

clk_div divider (
	.clk		( clk   ),
	.reset		( reset ),
	.clk_div2 	(       ),
	.clk_div4	( 	),
	.clk_div8	(	)
);

always #1 clk = ~clk;

initial #1 reset <= 1'b0;
endmodule


module clk_div (
	input	wire	clk,
	input	wire	reset,
	output  reg	clk_div2,
	output  reg	clk_div4,
	output  reg	clk_div8
);

always @(posedge clk)
if (reset)
	{clk_div2, clk_div4, clk_div8} <= 3'h0;
else begin
	clk_div2 <= ~clk_div2;
	clk_div4 <= clk_div2 ? ~clk_div4 : clk_div4;
	clk_div8 <= clk_div2 & clk_div4 ? ~clk_div8 : clk_div8; 
end
endmodule