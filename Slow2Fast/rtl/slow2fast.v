module slow2fast(
	input	clk1,	// slow clk
	input	clk2,	// fast clk
	input	rstn,
	input	data,
	output	d_out
);

reg		q1, q2, q3;

assign d_out = q2 & (~q3);

always@(posedge clk2 or negedge rstn)begin
	if(!rstn)
		{q1, q2, q3} <= 3'b0;
	else
		{q3, q2, q1} <= {q2, q1, data};
end



endmodule