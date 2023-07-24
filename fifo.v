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
$display ("wr_ready = %d (1 is true), rd_val = %d (0 is true)",
	  FIFO.wr_ready, FIFO.rd_val);

#2 wr_data <= 5;
$display ("wr_ready = %d (1), rd_val = %d (0)",
	  FIFO.wr_ready, FIFO.rd_val);
#2 wr_data <= 4;
$display ("wr_ready = %d (0), rd_val = %d (0)", 
	  FIFO.wr_ready, FIFO.rd_val);

wr_en <= 0;

#2 rd_en <= 1;
$display ("rd_data = %d (0)", FIFO.rd_data);

#2 $display ("rd_data = %d (7), wr_ready = %d (1), rd_val = %d (1)",
	     FIFO.rd_data, FIFO.wr_ready, FIFO.rd_val);

#2 $display ("rd_data = %d (6)", FIFO.rd_data);
#2 $display ("rd_data = %d (5), wr_ready = %d (1), rd_val = %d (1)",
	     FIFO.rd_data, FIFO.wr_ready, FIFO.rd_val);
#2 $display ("rd_data = %d (5), wr_ready = %d (1), rd_val = %d (0)",
	     FIFO.rd_data, FIFO.wr_ready, FIFO.rd_val);

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
reg			rd_ready;

always @(posedge clk)				//address always-block
begin
	if (reset)
		{rd_addr, wr_addr} <= 0;
	else begin
		if (rd_en & rd_ready)		
			rd_addr <= (rd_addr == FIFO_DEPTH - 1)? 0 : rd_addr + 1;
		if (wr_en & wr_ready)
			wr_addr	<= (wr_addr == FIFO_DEPTH - 1)? 0 : wr_addr + 1;
	end
end

always @(posedge clk)				//flag always-block
begin
	if (reset) begin
		{rd_val, rd_ready}  <= 2'b0;
		wr_ready <= 1'b1;
	end else begin

		if (rd_en & rd_ready)
			wr_ready <= 1;
		else if (wr_en & wr_ready) begin
			if (wr_addr + 1 == FIFO_DEPTH)
				wr_ready <= (0           != rd_addr);
			else
				wr_ready <= (wr_addr + 1 != rd_addr);
		end


		if (rd_en & rd_ready) begin
			if (rd_addr + 1 == FIFO_DEPTH)
				rd_ready <= (0           != wr_addr);
			else
				rd_ready <= (rd_addr + 1 != wr_addr);
		end else if (wr_en & wr_ready)
			rd_ready <= 1;


		rd_val <= (rd_en)? rd_ready : rd_val;

	end
end

always @(posedge clk)				//data always-block
begin 
	if (reset)
		rd_data <= 0;
	else begin
		if (rd_en & rd_ready)
			rd_data	     <= mem[rd_addr];

		if (wr_en & wr_ready) 
			mem[wr_addr] <= wr_data;
		
		
	end
end
endmodule