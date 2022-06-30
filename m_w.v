module m_w(input clk,reset,
	input [31:0] aluoutM,readdataM,
	input  [4:0] writeregM,

	output reg [31:0] aluoutW,readdataW,
	output reg [4:0] writeregW);

always @(posedge clk)
begin
	aluoutW <= aluoutM;
	readdataW <= readdataM;
	writeregW <= writeregM;
end
endmodule
