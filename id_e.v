module id_e(input clk,reset,flush,
	input [31:0] readdata1D,readdata2D,signD,
	input [4:0] rsD,rtD,rdD,

	output [31:0] readdata1E,readdata2E,signE,
	output [4:0] rsE,rtE,rdE);

floprc #(32) f1(clk,reset,flush,readdata1D,readdata1E);
floprc #(32) f2(clk,reset,flush,readdata2D,readdata2E);
floprc #(32) fsign(clk,reset,flush,signD,signE);

floprc #(5) frs(clk,reset,flush,rsD,rsE);
floprc #(5) frt(clk,reset,flush,rtD,rtE);
floprc #(5) frd(clk,reset,flush,rdD,rdE);
/*
always @(posedge clk,posedge reset)
begin
	if (reset)
	begin
	signE <= #1 0;
	readdata1E <= #1 0;
	readdata2E <= #1 0;
	rtE <= #1 0;
	rdE <= #1 0;
	rsE <= #1 0;
	end
	else if (flush)
	begin
	signE <= #1 0;
	readdata1E <= #1 0;
	readdata2E <= #1 0;
	rtE <= #1 0;
	rdE <= #1 0;
	rsE <= #1 0;
	end
	else
	begin
	signE <= #1 signD;
	readdata1E <= #1 readdata1D;
	readdata2E <= #1 readdata2D;
	rtE <= #1 rtD;
	rdE <= #1 rdD;
	rsE <= #1 rsD;
	end
end*/
endmodule

