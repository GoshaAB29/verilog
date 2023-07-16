`timescale 1ns / 1ns

module top();
localparam FIFO_DEPTH = 3;
localparam DATA_WIDTH = 4;

reg clk   = 1'b0;
reg reset = 1'b1;

reg 			rd_en   = 0;
reg 			wr_en	= 0;
reg [DATA_WIDTH -1:0]	wr_data = 0;

FIFO
#(	.FIFO_DEPTH ( FIFO_DEPTH ),
	.DATA_WIDTH ( DATA_WIDTH )
) 	FIFO
(
	.clk		( clk	  ),
	.reset		( reset   ),
	.rd_en		( rd_en	  ),
	.wr_en		( wr_en	  ),
	.wr_data	( wr_data ),
	.rd_data	(	  ),
	.rd_val		(	  ),
	.wr_ready	(	  )
);

always #1 clk = ~clk;

initial begin 
#2 reset <= 1'b0;

wr_en <= 1;
wr_data <= 7;

#2 wr_data <= 6;

#2 wr_data <= 5;
$display ("wr_ready = %d (1 is true), rd_ready = %d (1 is true)",
	  FIFO.wr_ready, FIFO.rd_val);
#2 wr_data <= 4;
$display ("wr_ready = %d (0 is true), rd_ready = %d (1 is true)", 
	  FIFO.wr_ready, FIFO.rd_val);

wr_en <= 0;

#2 rd_en <= 1;
$display ("rd_data = %d (0 is true)", FIFO.rd_data);

#2 $display ("wr_ready = %d (1 is true), rd_val = %d (1 is true)",
	     FIFO.wr_ready, FIFO.rd_val);
   $display ("rd_data = %d (7 is true)", FIFO.rd_data);

#2 $display ("rd_data = %d (6 is true)", FIFO.rd_data);
#2 $display ("rd_data = %d (5 is true)", FIFO.rd_data);
#2 $display ("wr_ready = %d (1 is true), rd_val = %d (0 is true)",
	     FIFO.wr_ready, FIFO.rd_val);

end
endmodule


module FIFO
#(
	parameter FIFO_DEPTH = 3,
	parameter DATA_WIDTH = 4
)
(
	input	wire	             	clk,
	input	wire			reset,
	input	wire                 	rd_en,
	input	wire                	wr_en,
	input	wire [DATA_WIDTH -1:0]	wr_data,
	output  reg  [DATA_WIDTH -1:0]  rd_data,
	output  reg			rd_val,
	output  reg 			wr_ready
);
localparam ADDRSIZE = $clog2(FIFO_DEPTH);

reg [DATA_WIDTH -1:0] 	mem [FIFO_DEPTH -1:0];
reg [ADDRSIZE -1:0]	wr_addr;
reg [ADDRSIZE -1:0]	rd_addr;

always @(posedge clk)

if (reset) begin: reset_0
	integer ii;
	for (ii = 0; ii < FIFO_DEPTH; ii = ii + 1)
	begin: loop0
		mem[ii] <= 0;
	end
	{rd_data, rd_val, wr_addr, rd_addr} <= 0;
	wr_ready <= 1;

end else begin
	if (rd_en & rd_val) begin
		rd_addr        <= (rd_addr + 1 == FIFO_DEPTH)? 0 : rd_addr + 1;
		rd_data        <= mem[rd_addr];
		mem[rd_addr]   <= 0;

		wr_ready       <= 1;

		if (rd_addr + 1 == FIFO_DEPTH)
			rd_val <= (0           == wr_addr)? 1'b0 : 1'b1;
		else
			rd_val <= (rd_addr + 1 == wr_addr)? 1'b0 : 1'b1;
	end

	if (wr_en & wr_ready) begin
		mem[wr_addr]     <= wr_data;
		wr_addr	         <= (wr_addr + 1 == FIFO_DEPTH)? 0 : wr_addr + 1;

		if (wr_addr + 1 == FIFO_DEPTH)
			wr_ready <= (0           == rd_addr)? 1'b0 : 1'b1;
		else
			wr_ready <= (wr_addr + 1 == rd_addr)? 1'b0 : 1'b1;

		rd_val           <= 1'b1;
	end
		
end
endmodule