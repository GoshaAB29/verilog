`timescale 1ns / 1ns

module top();
localparam DATA_WIDTH = 3;
localparam MAX_ADDR   = 4;
localparam ADDRSIZE   = $clog2(MAX_ADDR);

reg clk   = 1'b0;
reg reset = 1'b1;

reg 			rd_en   = 0;
reg [ADDRSIZE -1:0]	rd_addr = 0;
reg 			wr_en	= 0;
reg [ADDRSIZE -1:0]	wr_addr = 0;
reg [DATA_WIDTH -1:0]	wr_data = 0;

memory
#(	.DATA_WIDTH ( DATA_WIDTH ),
	.MAX_ADDR   ( MAX_ADDR   )
) 	mem
(
	.clk		( clk	  ),
	.reset		( reset   ),
	.rd_en		( rd_en	  ),
	.rd_addr	( rd_addr ),
	.wr_en		( wr_en	  ),
	.wr_addr	( wr_addr ),
	.wr_data	( wr_data ),
	.rd_data	(	  )
);

always #1 clk = ~clk;

initial begin 

#2 reset <= 1'b0;
#2

wr_addr <= 3;
wr_data <= 5;
#2 $display ("wr_en = %d --> in memory %d (0 is true)", 
	     wr_en, mem.mem[wr_addr]);

wr_en   <= 1;
wr_addr <= 3;
wr_data <= 5;
#2

wr_addr <= 2;
wr_data <= 4;
#2

wr_addr <= 1;
wr_data <= 3;
#2

wr_addr <= 0;
wr_data <= 2;
#2 

#2
rd_en   <= 1;
rd_addr <= 2;
#2 $display ("rd_data = %b (3'd4 is true)", mem.rd_data);
#2
wr_addr <= 1;
rd_addr <= 1;
wr_data <= 7;
#2 $display ("rd_data = %b (3'd3 is true), but mem[1] = %b (3'd7 is true)",
	     mem.rd_data, mem.mem[rd_addr]);

end
endmodule


module memory
#(
	parameter DATA_WIDTH = 4,
	parameter MAX_ADDR   = 8,
	parameter ADDRSIZE   = $clog2(MAX_ADDR)
)
(
	input	wire	             	clk,
	input	wire			reset,
	input	wire                 	rd_en,
	input	wire [ADDRSIZE -1:0] 	rd_addr,
	input	wire                	wr_en,
	input	wire [ADDRSIZE -1:0]	wr_addr,
	input	wire [DATA_WIDTH -1:0]	wr_data,
	output  reg  [DATA_WIDTH -1:0]	rd_data
);
reg [DATA_WIDTH -1:0] mem [MAX_ADDR -1:0];

always @(posedge clk)

if (reset) begin: reset_0
	integer ii;
	for (ii = 0; ii < MAX_ADDR; ii = ii + 1)
	begin: loop0
		mem[ii] <= 0;
	end

end else begin
	if (rd_en)
		rd_data <= mem[rd_addr];

	if (wr_en)
		mem[wr_addr] <= wr_data; 
end

endmodule