module top();
reg [7:0] data;
encoder_8to3 test (
	.data ( data[7:0] ),
	.pos  (	          )
);

initial begin
	for (data = 8'd1; data < 8'd8; data = data + 8'd1)
		#1 $display ("%b -> %d", data, test.pos);
	for (data = 8'd8; data < 8'd128; data = data << 1'd1)
		#1 $display ("%b -> %d", data, test.pos);

	data = 8'd255;
	#1 $display ("%b -> %d", data, test.pos);
end
endmodule

module encoder_8to3 (
	input  wire [7:0] data,
	output wire [2:0] pos	  
); 
assign pos = (data & 8'd128) ? 3'd7 :
	     (data & 8'd64 ) ? 3'd6 :
	     (data & 8'd32 ) ? 3'd5 :
	     (data & 8'd16 ) ? 3'd4 :
	     (data & 8'd8  ) ? 3'd3 :
	     (data & 8'd4  ) ? 3'd2 :
	     (data & 8'd2  ) ? 3'd1 :
			       3'd0;
endmodule