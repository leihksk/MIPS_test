module comparator #(parameter WIDTH=8)
		(input [WIDTH-1:0] a,b,
		output eq);

assign eq = (a==b);
endmodule
