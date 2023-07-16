module top();
localparam IN_WIDTH = 16;

reg [IN_WIDTH -1:0] number;
log2
#(	.IN_WIDTH  ( IN_WIDTH )
)	test
(
	.num ( number ),
	.log (	      )
);


localparam MAX_NUMBER = $pow(2, IN_WIDTH -1);
initial begin
	for (number = MAX_NUMBER; number > 1; number = number >> 1)
		#1 $display ("log(%d) = %d", number, test.log);

	number = 1;
	#1 $display ("log(%d) = %d", number, test.log);
end
endmodule


module log2 
#(
	parameter IN_WIDTH  = 8,
	parameter OUT_WIDTH = $clog2(IN_WIDTH)                                                                     
)
(
	input  wire [IN_WIDTH  -1:0] num,
	output wire [OUT_WIDTH -1:0] log
); 

wire [OUT_WIDTH -1:0] tmp_array [IN_WIDTH -1:0];




genvar ii;
generate for (ii = 0; ii < IN_WIDTH; ii = ii + 1)
begin: loop_0
	if (ii == 0)
		assign tmp_array[ii] = {IN_WIDTH{num[ii]}} & ii;
	else
		assign tmp_array[ii] = {IN_WIDTH{num[ii]}} & ii | tmp_array[ii -1];
end
endgenerate

assign log = tmp_array[IN_WIDTH -1];
endmodule