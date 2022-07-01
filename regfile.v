module regfile(input clk,
	input we3,
	input [4:0] ra1,ra2,wa3,
	input [31:0] wd3,
	output [31:0] rd1,rd2);

reg [31:0] RF[31:0];
integer i;
initial
begin
	for (i=0;i<31;i=i+1) RF[i]=32'h0000_0000;
end
assign rd1 = (ra1 != 0) ? RF[ra1] : 0;
assign rd2 = (ra2 != 0) ? RF[ra2] : 0;
always @(*)
begin
	if(we3) RF[wa3] <= wd3;
end
endmodule
