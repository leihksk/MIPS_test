module imem(input [5:0] a,
	output [31:0] rd);

reg [31:0] RAM[31:0];

initial
begin
	$readmemh("memfile.dat",RAM);
end
	assign rd = RAM[a];
endmodule
