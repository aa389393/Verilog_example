module fast2slow(
	input	clk1,	//	fast
	input	clk2,	//	slow
	input	data,
	input	rstn,
	output  d_out
);

reg		toggle;
reg		q1, q2, q3;

always@(posedge clk1 or negedge rstn)begin
	if(!rstn)
		toggle <= 1'b0;
	else if(data)
		toggle <= ~toggle;
	else
		toggle <= toggle;
end

always@(posedge clk2 or negedge rstn)begin
	if(!rstn)
		{q3, q2, q1} <= 3'b0;
	else
		{q3, q2, q1} <= {q2, q1, toggle};
end

assign d_out = q2 ^ q3;

endmodule