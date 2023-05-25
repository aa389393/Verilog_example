`timescale 1ns/1ns

module edge_detect_tb();

reg			sclk;
reg			rst_n;
reg			i_data_in;
wire		o_rise_edge;

initial begin
	sclk 	  = 1'b0;
	rst_n 	  <= 1'b0;
	i_data_in <= 1'b0;
	#100
	rst_n <= 1'b1;
	#250
	i_data_in <= 1'b1;
	#50
	i_data_in <= 1'b0;
	
end

edge_detect edge_detect_inst(
	.sclk			(sclk)			,
    .rst_n			(rst_n)			,
    .i_data_in		(i_data_in)		,
	.o_rise_edge    (o_rise_edge)
); 


always #5 sclk = ~sclk;

endmodule 