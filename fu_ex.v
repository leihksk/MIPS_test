module fu_ex(input regwriteW,regwriteM,
	input [4:0] writeregW,rsE,rtE,writeregM,
	output reg [1:0] forwardAE,forwardBE);

always @(*)
begin
	forwardAE = 2'b00;
	forwardBE = 2'b00;
	/*
	if(rsE!=0)
	begin
		if((rsE==writeregM)&regwriteM)
			forwardAE = 2'b10;
		else if ((rsE==writeregW)&regwriteW);
			forwardAE = 2'b01;
	end
	else forwardAE = 2'b00;
	if(rtE!=0)
	begin
		if((rtE==writeregM)&regwriteM)
			forwardBE = 2'b10;
		else if ((rtE==writeregW)&regwriteW);
			forwardBE = 2'b01;
	end
	else forwardBE = 2'b00;
	*/

forwardAE = ((regwriteM)&(rsE!=0)&(writeregM==rsE)) ? 2'b10:((regwriteW)&(rsE!=0)&(writeregW==rsE)) ? 2'b01:2'b00;

forwardBE = ((regwriteM)&(rtE!=0)&(writeregM==rtE)) ? 2'b10:((regwriteW)&(rtE!=0)&(writeregW==rtE)) ? 2'b01:2'b00;
end
endmodule
