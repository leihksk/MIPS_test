module testbench();

reg clk;
reg reset;

wire [31:0] writedata,dataadr;
wire memwrite;

top dut(clk,reset,dataadr,writedata,memwrite);
initial
begin
	reset <= 1; #22;reset <= 0;
end

always
begin
	clk <= 1;#5;clk <= 0;#5;
end

always @(negedge clk)
begin
	if(memwrite) begin
		if(dataadr===84 & writedata===7) begin
			$display("Simulation succeeded");
			$stop;
		end else if (dataadr != 80) begin
			$display("SImulation dailed");
			$stop;
		end
	end
end
initial begin
        $dumpfile("wave.vcd"); //指定用作dumpfile的文件
              $dumpvars; //dump all vars
end
endmodule
