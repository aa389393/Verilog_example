module uart_tx(
    input clk,
	input rst_n,
	input start,
	input [7:0] data,

	output reg rs232_tx,
	output reg done
);

	reg [7:0] r_data;
	reg state;
	reg [12:0] baud_cnt;
	reg bit_flag;
	reg [3:0] bit_cnt;

//=============r_data===============//
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n)
			r_data <= 0;
		else if(start)
			r_data <= data;
		else
			r_data <= r_data;
	end
//=============state===============//	
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n)
			state <= 1'b0;
		else if(start)
			state <= 1'b1;
		else if(done)
			state <= 1'b0;
		else
			done <= done;
	end

//=============baud_cnt===============//
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n)
			baud_cnt <= 0;
		else if(state)begin
            if(baud_cnt == 'd28)
                baud_cnt <= 'd0;
            else
			    baud_cnt <= baud_cnt + 1;
		end
        else
            baud_cnt <= 'd0;
	end
//=============bit_flag===============//    
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            bit_flag <= 1'b0;
        else if(baud_cnt == 'd1)
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
//=============rs232_tx===============//
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            rs232_tx <= 1'b1;
        else if(state)begin
            if(bit_flag)begin
                case(bit_cnt)
                   4'd0 : rs232_tx <= 1'b0;
                   4'd1 : rs232_tx <=  r_data[0];
                   4'd2 : rs232_tx <=  r_data[1];
                   4'd3 : rs232_tx <=  r_data[2];
                   4'd4 : rs232_tx <=  r_data[3];
                   4'd5 : rs232_tx <=  r_data[4];
                   4'd6 : rs232_tx <=  r_data[5];
                   4'd7 : rs232_tx <=  r_data[6];
                   4'd8 : rs232_tx <=  r_data[7];
                   4'd9 : rs232_tx <=  1'b1;
                   default : rs232_tx <= 1'b1;
                endcase
            end
        end
        else
            rs232_tx <= 1'b1;
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