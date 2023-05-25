module divn
#(
	parameter	width = 3,
	parameter	N	  = 5
)
(
	input		sclk,
	input		rst_n,
	output		o_clk
);

reg		[width -1 : 0]	cnt_p;
reg		[width -1 : 0]	cnt_n;
reg						clk_p;
reg						clk_n;

assign o_clk = clk_p | clk_n;

always@(posedge sclk or negedge rst_n)begin
	if(!rst_n)
		cnt_p	<=	0;
	else if(cnt_p == N-1)
		cnt_p	<=	0;
	else
		cnt_p 	<=	cnt_p + 1'b1;
end

always@(posedge sclk or negedge rst_n)begin
	if(!rst_n)
		clk_p	<=	1'b1;
	else if(cnt_p	<	N>>1)
		clk_p	<=	1'b1;
	else
		clk_p	<=	1'b0;
end

always@(negedge sclk or negedge rst_n)begin
	if(!rst_n)
		cnt_n	<=	1'b0;
	else if(cnt_n == N-1)
		cnt_n	<=	1'b0;
	else
		cnt_n	<=	cnt_n + 1'b1;
end

always@(negedge sclk or negedge rst_n)begin
	if(!rst_n)
		clk_n	<=	1'b1;
	else if(cnt_n	<	N>>1)
		clk_n	<=	1'b1;
	else
		clk_n	<=	1'b0;
end


endmodule