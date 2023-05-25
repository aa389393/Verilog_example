`timescale	1ns/1ns
module divn_tb();

reg		sclk;
reg		rst_n;
wire	o_clk;


initial begin
	sclk	=	1'b1;
	rst_n	<=	1'b0;
	#50
	rst_n	<=	1'b1;
end

always #10 sclk = ~sclk;

divn	divn_inst
(
	.sclk(sclk),
	.rst_n(rst_n),
	.o_clk(o_clk)
);

endmodule