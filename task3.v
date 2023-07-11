module top();
reg [7:0] number;
log2 test (
	.num ( number[7:0] ),
	.log (	           )
);

initial begin
	for (number = 8'd128; number > 8'd1; number = number >> 1'd1)
		#1 $display ("log(%d) = %d", number, test.log);

	number = 3'd1;
	#1 $display ("log(%d) = %d", number, test.log);
end
endmodule


module log2 (
	input  wire [7:0] num,
	output wire [2:0] log
); 
	assign log = {3{num[7]}} & 3'd7 |
		     {3{num[6]}} & 3'd6 |
		     {3{num[5]}} & 3'd5 |
		     {3{num[4]}} & 3'd4 |
		     {3{num[3]}} & 3'd3 |
		     {3{num[2]}} & 3'd2 |
		     {3{num[1]}} & 3'd1 |
		     {3{num[0]}} & 3'd0;
endmodule
