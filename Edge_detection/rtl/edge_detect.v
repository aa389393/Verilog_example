module edge_detect
(
	input			sclk,
	input			rst_n,
	input			i_data_in,
	output	reg		o_rise_edge
);

reg		r_data_in0;

always@(posedge sclk or negedge rst_n)begin
	if(!rst_n)
		r_data_in0 <= 0;
	else begin
		r_data_in0 <= i_data_in;
		if({r_data_in0, i_data_in} == 2'b01)
			o_rise_edge <= 1;
		else
			o_rise_edge <= 0;
	end
end

endmodule