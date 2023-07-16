module top();
localparam IN_WIDTH = 5;
localparam MAX_NUMBER = $pow(2, IN_WIDTH) - 1;

reg [IN_WIDTH -1:0] number;

decoder_3to8 
#(	.IN_WIDTH  ( IN_WIDTH )
)	test
(
	.num3bit ( number ),
	.num8bit ( 	  )
);

initial begin
	for (number = 0; number < MAX_NUMBER; 
	     number = number + 1)
		#1 $display ("%d->%d for %d is %b -> %b", test.IN_WIDTH, test.OUT_WIDTH,
		 test.num3bit, test.num3bit, test.num8bit);

	number = MAX_NUMBER;
	#1 $display ("%d->%d for %d is %b -> %b", test.IN_WIDTH, test.OUT_WIDTH,
		test.num3bit, test.num3bit, test.num8bit);
end
endmodule


module decoder_3to8 
#(
	parameter IN_WIDTH  = 3,
	parameter OUT_WIDTH = $pow(2, IN_WIDTH)                                                                     
)
(
	input  wire [IN_WIDTH -1:0] num3bit,
	output wire [OUT_WIDTH -1:0] num8bit
);
assign num8bit = 1'b1 << num3bit;
endmodule