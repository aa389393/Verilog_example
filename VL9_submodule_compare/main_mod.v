`timescale 1ns/1ns
module main_mod(
	input clk,
	input rst_n,
	input [7:0]a,
	input [7:0]b,
	input [7:0]c,
	
	output [7:0]d
);

wire [7:0] q1, q2;

sub_mod sub_mod_inst0(
	.clk(clk),
	.rst_n(rst_n),
	.a(a),
	.b(b),
	.c(q1)
);

sub_mod sub_mod_inst1(
	.clk(clk),
	.rst_n(rst_n),
	.a(a),
	.b(c),
	.c(q2)
);

sub_mod sub_mod_inst3(
	.clk(clk),
	.rst_n(rst_n),
	.a(q1),
	.b(q2),
	.c(d)
);



endmodule

module sub_mod(
	input clk,
	input rst_n,
	input [7:0]a,
	input [7:0]b,
	output reg [7:0]c
);

always@(posedge clk or rst_n)begin
	if(!rst_n)
		c <= 8'b0;
	else if(a > b)
		c <= b;
	else
		c <= a;
	
end

endmodule