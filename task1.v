module top();
reg [15:0] data;
wire	  ans;
div2
#(	.IN_WIDTH ( 16   )
)	test
(
	.data  ( data ),
	.ans   ( ans  )
);
initial begin
	#1 data = 16'd65535;
	#1 data = 16'd12348;
	#1 data = 16'd64;
	#1 data = 16'd32;
	#1 data = 16'd15;
	#1 data = 16'd6;
	#1 data = 16'd0;
end

always @(data) begin
	if (ans)
		$display ("%d is even", data);
	else
		$display ("%d is odd", data);
end

endmodule

module div2
#(
	parameter IN_WIDTH = 8
)
(
	input  wire [IN_WIDTH -1:0] data,
	output wire 		    ans
);
assign ans = ~data[0];
endmodule