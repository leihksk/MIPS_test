`include "mux3.v"
`include "alu_p.v"
module execute(input alusrcE,regdst,
	input [31:0] aluoutM,resultW,rd1E,rd2E,signE,
	input [2:0] alucontrolE,
	input [4:0] rdE,rtE,
	input [1:0] forwardaE,forwardbE,

	output [4:0] writeregE,
	output [31:0] writedataE,
	output [31:0] aluoutE);

wire [31:0] srcaE,srcbE,mux3Bresult;

mux3 mux3A(rd1E,resultW,aluoutM,forwardaE,srcaE);
mux3 mux3B(rd2E,resultW,aluoutM,forwardbE,mux3Bresult);

mux2 #(5) mux2R(rtE,rdE,regdst,writeregE);
mux2 #(32) mux2B(mux3Bresult,signE,alusrcE,srcbE);

alu_p alu(srcaE,srcbE,alucontrolE,aluoutE);

assign writedataE = mux3Bresult;
endmodule
