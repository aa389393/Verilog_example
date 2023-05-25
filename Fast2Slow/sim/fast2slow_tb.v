`timescale 1ns/1ns

module fast2slow_tb();

reg		clk1;
reg 	clk2;
reg 	data;
reg 	rstn;
wire	d_out;

initial begin
	clk1 = 0;
	clk2 = 0;
	rstn = 0;
	#10
	rstn = 1;
end


initial begin
	data = 0;
	#30
	data = 1;
	#2
	data = 0;
	#198
	data = 1;
	#2
	data = 0;
end

always #10 clk1 = ~clk1;
always #30 clk2 = ~clk2;

fast2slow fast2slow_init(
	.clk1(clk1),
	.clk2(clk2),
	.data(data),
	.rstn(rstn),
	.d_out(d_out)
);

endmodule