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

initial begin
	{divider.clk_div2, divider.clk_div4, 
	 divider.clk_div8} = 3'b0;

	#1 reset <= 1'b0;
end
endmodule


module clk_div (
	input	wire	clk,
	input	wire	reset,
	output  reg	clk_div2,
	output  reg	clk_div4,
	output  reg	clk_div8
);
reg [2:0] r_cnr;

always @(posedge clk)
if (reset)
	{r_cnr, clk_div2, clk_div4, clk_div8} <= 5'h0;
else begin
	r_cnr <= r_cnr + 1;

	clk_div2 <= ~clk_div2;
	clk_div4 <= r_cnr[1];
	clk_div8 <= r_cnr[2];
end
endmodule