`include "ctrl.v"
`include "datapath_p.v"
module mips(input clk,reset,
	output [31:0] pc,
	input [31:0] instr,
	output memwriteM,
	output [31:0] aluout,writedataM,
	input [31:0] readdata);

wire memtoregE,memtoregM,memtoregW,alusrc,regdstE,regwriteE,regwriteM,regwriteW,jump,pcsrc,zero,branch,flushE;
wire [2:0] alucontrol;
wire [5:0] op,funct;

//assign op = instr[31:26];
//assign funct = instr[5:0];

controller c(clk,reset,op,funct,flushE,zero,memtoregE,memtoregM,memtoregW,memwriteM,branch,pcsrc,alusrc,regdstE,regwriteE,regwriteM,regwriteW,jump,alucontrol);
datapath dp(clk,reset,memtoregE,memtoregM,memtoregW,pcsrc,branch,alusrc,regdstE,regwriteE,regwriteM,regwriteW,jump,alucontrol,zero,pc,instr,aluout,writedataM,readdata,op,funct,flushE);
endmodule
