module fu_id(input regwriteM,
	input [4:0] rsD,rtD,writeregM,
	output forwardAD,forwardBD);

assign forwardAD = ( rsD!= 0)& ( rsD== writeregM)&regwriteM;
assign forwardBD = (rtD!= 0)& (rtD == writeregM)&regwriteM;

endmodule
