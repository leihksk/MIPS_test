//`include "maindec.v"
`include "sl2.v"
//`include "flopr.v"
`include "adder.v"
`include "mux2.v"
`include "regfile.v"
`include "hazard.v"
`include "signnext.v"
`include "flopenrc.v"
`include "flopenr.v"
`include "comparator.v"
`include "id_e.v"
`include "execute.v"
`include "e_m.v"
`include "m_w.v"
module datapath(input clk,reset,
	input memtoregE,memtoregM,memtoregW,pcsrc,
	input branch,alusrc,regdstE,
	input regwriteE,regwriteM,regwriteW,jump,
	input [2:0] alucontrol,
	output zero,
	output [31:0] pc,
	input [31:0] instr,
	output [31:0] aluout,writedataM,
	input [31:0] readdataM,
	output [5:0] op,funct,
	output flushE);

wire forwardAD,forwardBD;
wire [1:0] forwardAE,forwardBE;
wire stallF,stallD,flush;
wire [4:0] rsD,rtD,rdD,rsE,rtE,rdE;
wire [4:0] writeregE,writeregM,writeregW;
wire [31:0] pcnext,pcnextbr,pcplus4F,pcplus4D,instrD,pcbranch,writedataE;
wire [31:0] signimmD,signimmE,signimmsh;
wire [31:0] srca,srcb,rd1,rd2,srcAD,srcBD,srcaE,srcbE;
wire [31:0] aluoutE,aluoutW;
wire [31:0] readdataW,result;

assign op = instrD[31:26];
assign funct = instrD[5:0];
assign rsD = instrD[25:21];
assign rtD = instrD[20:16];
assign rdD = instrD[15:11];
assign flush = pcsrc|jump;

hazard ha(regwriteM,regwriteW,regwriteE,rsE,rtE,rsD,rtD,writeregE,writeregM,writeregW,forwardAD,forwardBD,forwardAE,forwardBE,memtoregE,memtoregM,branch,stallF,stallD,flushE);
mux2 #(32) pcbrmux(pcplus4F,pcbranch,pcsrc,pcnextbr);
mux2 #(32) pcmux(pcnextbr,{pcplus4D[31:28],instrD[25:0],2'b00},jump,pcnext);

regfile rf(clk,regwriteW,rsD,rtD,writeregW,result,rd1,rd2);
flopenr #(32) pcreg(clk,reset,~stallF,pcnext,pc);
adder pcaddl(pc,32'b100,pcplus4F);

flopenr #(32) fdp(clk,reset,~stallD,pcplus4F,pcplus4D);
flopenrc #(32) fdi(clk,reset,~stallD,flush,instr,instrD);

signext se(instrD[15:0],signimmD);
sl2 immsh(signimmD,signimmsh);
adder pcadd2(pcplus4D,signimmsh,pcbranch);
mux2 #(32) muxAD(rd1,aluout,forwardAD,srcAD);
mux2 #(32) muxBD(rd2,aluout,forwardBD,srcBD);

comparator #(32) comp(srcAD,srcBD,zero);
id_e de(clk,reset,flushE,srcAD,srcBD,signimmD,rsD,rtD,rdD,srcaE,srcbE,signimmE,rsE,rtE,rdE);
execute ex(alusrc,regdstE,aluout,result,srcaE,srcbE,signimmE,alucontrol,rdE,rtE,forwardAE,forwardBE,writeregE,writedataE,aluoutE);

e_m em(clk,reset,writeregE,aluoutE,writedataE,writeregM,aluout,writedataM);

m_w mw(clk,reset,aluout,readdataM,writeregM,aluoutW,readdataW,writeregW);
mux2 #(32) wbmux(aluoutW,readdataW,memtoregW,result);

endmodule
