module top();
reg [7:0] data;
wire	   ans;
div2 test (
	.data ( data ),
	.ans  ( ans  )
);
initial begin
	#1 data = 8'd255;
	#1 data = 8'd127;
	#1 data = 8'd64;
	#1 data = 8'd15;
	#1 data = 8'd6;
	#1 data = 8'd0;
end

always @(data) begin
	if (ans)
		$display ("%d is even", data);
	else
		$display ("%d is odd", data);
end

endmodule

module div2 (
input  wire [7:0] data,
output wire 	   ans
);
assign ans = ~data[0];
endmodule