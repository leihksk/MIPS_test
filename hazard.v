`include "fu_id.v"
`include "fu_ex.v"
module hazard(input regwriteM,regwriteW,regwriteE,
	input [4:0] rsE,rtE,rsD,rtD,writeregE,writeregM,writeregW,
	output forwardAD,forwardBD,
	output [1:0] forwardAE,forwardBE,
	input memtoregE,memtoregM,branchD,
	output stallF,stallD,flushE);

wire lwstallD,branchstallD;

fu_id fud(regwriteM,rsD,rtD,writeregM,forwardAD,forwardBD);

fu_ex ex(regwriteW,regwriteM,writeregW,rsE,rtE,writeregM,forwardAE,forwardBE);

assign  lwstallD = memtoregE & (rsD == rtE | rtD == rtE);
assign  branchstallD = branchD & ((regwriteE & (writeregE == rsD | writeregE == rtD))|(memtoregM&(writeregM == rsD | writeregM == rtD)));
assign  stallD = lwstallD|branchstallD;
assign  stallF = stallD;
assign  flushE = stallF;
endmodule
