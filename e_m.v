module e_m(input clk,reset,
	input [4:0] writeregE,
	input [31:0] aluoutE,writedataE,
	output reg [4:0] writeregM,
	output reg [31:0] aluoutM,writedataM);

always @(posedge clk)
begin
	writeregM <= writeregE;

	aluoutM <= aluoutE;
	writedataM <= writedataE;
end
endmodule
