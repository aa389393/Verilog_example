`timescale 1ns/1ns

module uart_tx_tb;

    reg clk;
    reg rst_n;
    reg start;
    reg [7:0]data;
    wire rs232_tx;
    wire done;    

    uart_tx uart_tx_inst(
    .clk(clk),
	.rst_n(rst_n),
	.start(start),
	.data(data),

	.rs232_tx(rs232_tx),
	.done(done)
    );

    initial clk = 1'b1;
    always#10 clk = ~clk;
    initial begin
        rst_n = 1'b0;
        start = 1'b0;
        data = 'd0;
        #100
        rst_n = 1'b1;
        #200;

        data = 'h55;
        start = 1'b1;
        #20
        start = 1'b0;
        #20000;

        data = 'h58;
        start = 1'b1;
        #20
        start = 1'b0;
        #20000;

        data = 'hb8;
        start = 1'b1;
        #20
        start = 1'b0;
        #20000;

        $stop;
    end
    
endmodule