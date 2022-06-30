module alu_p(input [31:0] a,b,
	input [2:0] alucontrol,
	output reg [31:0] aluout);

wire [31:0] s,bb;

assign bb = alucontrol[2] ? ~b : b;
assign s = a + bb + alucontrol[2];

always @(*)
	case(alucontrol[1:0])
		2'b00: aluout <= a & bb;
		2'b01: aluout <= a | bb;
		2'b10: aluout <= s;
		2'b11: aluout <= s[31];
	endcase
endmodule
