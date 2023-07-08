module top();
reg [2:0] number;
decoder_3to8 test (
	.num3bit ( number[2:0] ),
	.num8bit (	       )
);

initial begin
	for (number = 3'd0; number < 3'd7; number = number + 1)
		#1 $display ("3->8 for %d is %b -> %b", number, number, test.num8bit);

	number = 3'd7;
	#1 $display ("3->8 for %d is %b -> %b", number, number, test.num8bit);
end
endmodule


module decoder_3to8 (
	input  wire [2:0] num3bit,
	output wire [7:0] num8bit
);
assign num8bit = 1'b1 << num3bit;
endmodule