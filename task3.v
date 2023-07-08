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
assign log = (num == 8'd128) ? 3'd7 :
	     (num == 8'd64)  ? 3'd6 : 
	     (num == 8'd32)  ? 3'd5 :
	     (num == 8'd16)  ? 3'd4 :
	     (num == 8'd8)   ? 3'd3 :
	     (num == 8'd4)   ? 3'd2 :
	     (num == 8'd2)   ? 3'd1 :
			       3'd0;
endmodule