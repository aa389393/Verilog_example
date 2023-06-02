`timescale 1ns/1ns

module uart_rx_tb;

    reg clk;
    reg rst_n;
    reg start;
    reg [7:0]data;
    wire rs232_tx;
    wire done;    
    wire [7:0] rx_data;

    uart_tx uart_tx_inst(
    .clk(clk),
	.rst_n(rst_n),
	.start(start),
	.data(data),

	.rs232_tx(rs232_tx),
	.done()
    );

    uart_rx uart_rx_inst(
        .clk(clk),
        .rst_n(rst_n),
        .rs232(rs232_tx),

        .rx_data(rx_data),
        .done()
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