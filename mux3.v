module mux3(input [31:0] rd,resultW,alusrcM,
	input [1:0] forward,
	output [31:0] muxresult);

assign muxresult = (forward==2'b10)?alusrcM:(forward == 2'b01)?resultW:rd;
endmodule
