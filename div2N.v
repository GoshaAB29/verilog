`timescale 100ns / 100ns

module top();
localparam N = 3;

reg clk   = 1'b0;
reg reset = 1'b1;

clk_div_2N
#(	.N ( N )
) 	divider
(
	.clk		( clk   ),
	.reset		( reset ),
	.clk_div	(	)
);

always #1 clk = ~clk;

initial #1 reset <= 1'b0;
endmodule


module clk_div_2N
#(
	parameter N = 3,
	parameter REG_WIDTH = $clog2(N)
)
(
	input	wire	clk,
	input	wire	reset,
	output  reg	clk_div
);
reg [REG_WIDTH -1:0] r_cnt;

always @(posedge clk) begin

if (reset)
	{r_cnt, clk_div} <= 0;

else	if (r_cnt == N - 1) begin
		r_cnt <= 0;
		clk_div <= ~clk_div;
     	end else
		r_cnt <= r_cnt + 1;
end
endmodule