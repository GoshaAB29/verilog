`timescale 100ns / 100ns

module top();
localparam N = 5;

reg clk   = 1'b0;
reg reset = 1'b1;

generator_N
#(	.N ( N )
) 	generator
(
	.clk		( clk   ),
	.reset		( reset ),
	.pulse	(	)
);

always #1 clk = ~clk;

initial #1 reset <= 1'b0;
endmodule


module generator_N
#(
	parameter N = 5,
	parameter REG_WIDTH = $clog2(N)
)
(
	input	wire	clk,
	input	wire	reset,
	output  wire	pulse
);
reg [REG_WIDTH :0] cnt;

always @(posedge clk) begin
	if (reset)
		cnt <= 0;
	else
		cnt <= (cnt < N - 1)? cnt + 1 : 0;
end

assign pulse = (cnt == N - 1);
endmodule