module floprc#(parameter WIDTH = 8)
		(input clk,reset,flush,
		input [WIDTH-1:0] d,
		output reg [WIDTH-1:0] q);
always @(posedge clk,posedge reset)
	if (reset) q <= #1 0;
	else if (flush) q <= #1 0;
	else q <= #1 d;
endmodule
