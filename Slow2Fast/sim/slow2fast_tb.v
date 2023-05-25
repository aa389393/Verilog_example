`timescale 1ns/1ns
module slow2fast_tb();

reg		clk1;
reg		clk2;
reg		rstn;
reg		data;
wire	d_out;

initial begin
	clk1 = 0;
	clk2 = 0;
	rstn = 0;
	#20
	rstn = 1;
end

initial begin
	data = 0;
	#30
	data = 1;
	#2
	data = 0;
	#178
	data = 1;
	#2
	data = 0;
end

always #30 clk1 = ~clk1;
always #10 clk2 = ~clk2;

slow2fast slow2fast_inst(
	.clk1(clk1),	
	.clk2(clk2),	
	.rstn(rstn),
	.data(data),
	.d_out(d_out)
);


endmodule