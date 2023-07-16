module top();
localparam IN_WIDTH = 8;
localparam MAX_VEC = $pow(2, IN_WIDTH) -1;

reg [IN_WIDTH -1:0] data;

encoder_8to3 
#(	.IN_WIDTH ( IN_WIDTH )
)	test
(
	.data ( data ),
	.pos  (	     )
);

initial begin
	for (data = 1; data < MAX_VEC; data = (data << 1) + 1)
		#1 $display ("%b -> %d", data, test.pos);

	data = MAX_VEC;
	#1 $display ("%b -> %d", data, test.pos);
end
endmodule

module encoder_8to3 
#(
	parameter IN_WIDTH = 8,
	parameter OUT_WIDTH= $clog2(IN_WIDTH)
)
(
	input  [IN_WIDTH  -1:0] data,
	output [OUT_WIDTH -1:0] pos

);

wire [OUT_WIDTH -1:0] tmp_array [IN_WIDTH -1:0];

genvar ii;
generate for (ii = 0; ii < IN_WIDTH; ii = ii + 1)
begin: loop_0
	if (ii == 0)
		assign tmp_array[ii] = (data[ii] ? ii : 0);
	else
		assign tmp_array[ii] = (data[ii] ? ii : tmp_array[ii -1]);
end
endgenerate

assign pos = tmp_array[IN_WIDTH -1];
endmodule