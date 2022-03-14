`include "aludec.v"
`include "maindec.v"
`include "floprc.v"
`include "flopr.v"
module controller(input clk,reset,
	input [5:0] op,funct,
	input flushE,zero,
	output memtoregE,memtoregM,memtoregW,memwriteM,
	output branch,pcsrc,alusrc,
	output regdstE,regwriteE,regwriteM,regwriteW,
	output jump,
	output [2:0] alucontrol);

wire [1:0] aluop;
wire memtoregD,memwriteD,alusrcD,regdstD,regwriteD,memwriteE;
wire [2:0] alucontrolD;

maindec md(op,memtoregD,memwriteD,branch,alusrcD,regdstD,regwriteD,jump,aluop);
aludec ad(funct,aluop,alucontrolD);

assign pcsrc = branch & zero;

floprc #(8) dereg(clk,reset,flushE,{memtoregD,memwriteD,regwriteD,alusrcD,regdstD,alucontrolD},{memtoregE,memwriteE,regwriteE,alusrc,regdstE,alucontrol});

flopr #(3) emreg(clk,reset,{memtoregE,memwriteE,regwriteE},{memtoregM,memwriteM,regwriteM});

flopr #(2) mWreg(clk,reset,{memtoregM,regwriteM},{memtoregW,regwriteW});

endmodule
