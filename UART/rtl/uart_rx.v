module uart_rx(
    input clk,
    input rst_n,
    input rs232,

    output reg [7:0] rx_data,
    output reg done
);

    reg rs232_t;
    reg rs232_t1;
    reg rs232_t2;
    reg state;
    reg [12:0] baud_cnt;
    reg bit_flag;
    reg [3:0] bit_cnt;

    wire nege;
//=============消除亞穩態===============//
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            rs232_t <= 1'b1;
            rs232_t1 <= 1'b1;
            rs232_t2 <= 1'b1;
        end
        else begin
            rs232_t <= rs232;
            rs232_t1 <= rs232_t;
            rs232_t2 <= rs232_t1;
        end
    end
//=============nege===============//
    assign nege = !rs232_t1 & rs232_t2;
//=============state===============//
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            state <= 1'b0;
        else if(nege)
            state <= 1'b1;
        else if(done)
            state <= 1'b0;
        else
            state <= state;
    end
//=============baud_cnt===============//
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            baud_cnt <= 0;
        else if(state)begin
            if(baud_cnt == 'd28)
                baud_cnt <= 'd0;
            else
                baud_cnt <= baud_cnt + 1'b1;
        end
        else
            baud_cnt <= 'd0;
    end
//=============bit_flag===============//
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            bit_flag <= 1'b0;
        else if(baud_cnt == 'd16)
            bit_flag <= 1'b1;
        else
            bit_flag <= 1'b0;
    end
//=============bit_cnt===============//
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            bit_cnt <= 'd0;
        else if(bit_flag)begin
            if(bit_cnt == 'd10)
                bit_cnt <= 'd0;
            else
                bit_cnt <= bit_cnt + 1'b1;
        end        
        else
            bit_cnt <= bit_cnt;
    end
//=============rx_data===============//
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            rx_data <= 'd0;
        else if(state)begin
            if(bit_flag)begin
                case(bit_cnt)
                   4'd1 : rx_data[0] <=  rs232_t2;
                   4'd2 : rx_data[1] <=  rs232_t2;
                   4'd3 : rx_data[2] <=  rs232_t2;
                   4'd4 : rx_data[3] <=  rs232_t2;
                   4'd5 : rx_data[4] <=  rs232_t2;
                   4'd6 : rx_data[5] <=  rs232_t2;
                   4'd7 : rx_data[6] <=  rs232_t2;
                   4'd8 : rx_data[7] <=  rs232_t2;
                   default : rx_data <= rx_data;
                endcase
            end
        end
        else
            rx_data <= rx_data;
    end
//=============done===============//
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            done <= 1'b0;
        else if(bit_flag && (bit_cnt == 'd10))
            done <= 1'b1;
        else
            done <= 1'b0;
    end

endmodule