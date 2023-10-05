module I2c 
(wr_i2c, cmd, din, dvsr, clk, rst, sda_in, dout, ack, ready, done_tick, sda_out, scl);
input wr_i2c;
input  [2:0] cmd;
input  [7:0] din;
input  [15:0] dvsr;
input clk;
input rst;
input sda_in;
output wire [7:0] dout;
output wire ack;
output reg ready;
output reg done_tick;
output reg sda_out;
output reg scl;

reg [3:0] current_state;
reg [3:0] next_state;
reg [15:0] counter;
reg counter_rst;
reg [4:0] bit_cnt;
reg bit_done;
reg [8:0] tx_reg;
reg [8:0] rx_reg;
reg [8:0] tx_next;
reg [8:0] rx_next;
reg READ_DONE;


parameter IDLE      =  0;
parameter START_1   =  1;
parameter START_2   =  2;
parameter HOLD      =  3;
parameter DATA_1    =  4;
parameter DATA_2    =  5;
parameter DATA_3    =  6;
parameter DATA_4    =  7;
parameter ACK_1     =  8;
parameter ACK_2     =  9;
parameter ACK_3     =  10;
parameter ACK_4     =  11;
parameter STOP_1    =  12;
parameter STOP_2    =  13;

parameter START_CMD   = 0;
parameter WR_CMD      = 1;
parameter RD_CMD      = 2;
parameter STOP_CMD    = 3;


wire [15:0] qutr;
wire [15:0] half;
assign qutr = dvsr;
assign half = qutr<<1;
assign ack  = cmd == WR_CMD ? sda_in:1;
assign dout = READ_DONE ? rx_reg[8:1]:0;
 
always @(posedge clk or negedge rst) 
begin
    if(!rst)
    begin
        tx_reg <= 9'b0;
        rx_reg <= 9'b0;
    end
    else
    begin
        tx_reg <= tx_next;
        rx_reg <= rx_next;
    end
end

//quaters clk counter
always @(posedge clk or negedge rst) 
begin
    if(!rst)
        counter <= 0;
    else if (counter_rst)
        counter <= 0;
    else 
        counter <= counter + 1;
end

//bit counter
always @(posedge clk or negedge rst) 
begin
    if(!rst) 
        bit_cnt <= 0; 
    else if (bit_cnt == 9)
        bit_cnt <= 0;
    else if (bit_done)
        bit_cnt <= bit_cnt + 1;  
    else
        bit_cnt <= bit_cnt;
end

always @(posedge clk or negedge rst) 
begin
    if(!rst) 
        current_state <= IDLE; 
    else 
        current_state <= next_state;  
end

always @(*)
begin
    case(current_state)
    IDLE: //0
    begin
        if(cmd == START_CMD && wr_i2c)
        begin
            next_state = START_1;
        end
        else
        begin
            next_state = IDLE;
        end

        sda_out      = 1'b1;
        scl          = 1'b1;
        ready        = 1'b1;
        counter_rst  = 1'b1;
        bit_done     = 1'b0;
        tx_next      = tx_reg;
        rx_next      = rx_reg;
        done_tick    = 1'b0;
        READ_DONE    = 1'b0;

    end   

    START_1: //1
    begin
        if(counter == half)
        begin
            next_state = START_2;
            counter_rst = 1'b1;
        end
        else
        begin
            next_state = START_1;
            counter_rst = 1'b0;
        end

        sda_out    = 1'b0;
        scl        = 1'b1;
        ready      = 1'b0; 
        bit_done   = 1'b0;
        tx_next    = tx_reg;
        rx_next    = rx_reg;
        done_tick  = 1'b0;
        READ_DONE    = 1'b0;

    end 

    START_2: //2
    begin
        if(counter == half)
        begin 
            next_state = HOLD;
            counter_rst = 1'b1;
        end
        else
        begin
            next_state = START_2;
            counter_rst = 1'b0;
        end
        sda_out      = 1'b0;
        scl          = 1'b0;
        ready        = 1'b0; 
        bit_done     = 1'b0;
        tx_next      = tx_reg;
        rx_next      = rx_reg;
        done_tick    = 1'b0;
        READ_DONE    = 1'b0;

    end 
    HOLD: //3
    begin
        if(cmd == WR_CMD)
        begin
            next_state  = DATA_1;
            tx_next     = {din,1'b0};
        end
        else if (cmd == RD_CMD)
        begin
            next_state = DATA_1;
            tx_next = tx_reg;
        end
        else if (cmd == STOP_CMD)
        begin
            next_state = STOP_1;
            tx_next = tx_reg;
        end
        else
        begin
            next_state = HOLD;
            tx_next = tx_reg;
        end

        sda_out     = 1'b0;
        scl         = 1'b0;
        ready       = 1'b1; 
        bit_done    = 1'b0;
        counter_rst = 1'b1;
        rx_next     = rx_reg;
        done_tick   = 1'b0;
        READ_DONE    = 1'b0;
    end 
    DATA_1: //4
    begin
        if(counter == qutr)
        begin
            next_state = DATA_2;
            counter_rst = 1'b1;
        end
        else
        begin
            next_state = DATA_1;
            counter_rst = 1'b0;
        end

        if(cmd == RD_CMD)
        sda_out  = 1'hz;
        else
        begin
        sda_out  = tx_reg[8];
        end
        
        scl         = 1'b0;
        ready       = 1'b0; 
        bit_done    = 1'b0;
        tx_next     = tx_reg;
        rx_next     = rx_reg;
        done_tick   = 1'b0;
        READ_DONE    = 1'b0;
    end 
    DATA_2: //5
    begin
        if(counter == qutr)
        begin
            next_state  = DATA_3;
            counter_rst = 1'b1;
            rx_next     = {rx_reg[7:0],sda_in};
        end
        else
        begin
            next_state  = DATA_2;
            counter_rst = 1'b0;
            rx_next     = rx_reg;
        end

        if(cmd == RD_CMD)
        sda_out  = 1'hz;
        else
        begin
        sda_out  = tx_reg[8];
        end

        scl         = 1'b1;
        ready       = 1'b0; 
        bit_done    = 1'b0;
        tx_next     = tx_reg;
        done_tick   = 1'b0;
        READ_DONE    = 1'b0;
    end 
    DATA_3: //6
    begin
        if(counter == qutr)
        begin
            next_state  = DATA_4;
            counter_rst = 1'b1;
        end
        else
        begin
            next_state  = DATA_3;
            counter_rst = 1'b0;
        end

        if(cmd == RD_CMD)
        sda_out  = 1'hz;
        else
        begin
        sda_out  = tx_reg[8];
        end
        
        scl         = 1'b1;
        ready       = 1'b0; 
        bit_done    = 1'b0;
        tx_next     = tx_reg;
        rx_next     = rx_reg;
        done_tick   = 1'b0;
        READ_DONE    = 1'b0;
    end 
    DATA_4: //7
    begin
        if (counter == qutr && bit_cnt == 8)
        begin
            next_state  = ACK_1;
            tx_next     = tx_reg;
            counter_rst = 1'b1;
            bit_done    = 1'b1;
        end
        else if(counter == qutr && bit_cnt != 8)
        begin
            next_state  = DATA_1;
            tx_next     = {tx_reg[7:0],1'b0};
            counter_rst = 1'b1;
            bit_done    = 1'b1;

        end
        else
        begin
            tx_next     = tx_reg;
            next_state  = DATA_4;
            counter_rst = 1'b0;
            bit_done    = 1'b0; 
            
        end

        if(cmd == RD_CMD)
        sda_out  = 1'hz;
        else
        begin
        sda_out  = tx_reg[8];
        end

        scl         = 1'b0;
        ready       = 1'b0;
        rx_next     = rx_reg; 
        done_tick   = 1'b0;
        READ_DONE    = 1'b0;
        
    end 
    ACK_1: //8
    begin
        if(counter == qutr)
        begin
            next_state  = ACK_2;
            counter_rst = 1'b1;
        end
        else
        begin
            next_state  = ACK_1;
            counter_rst = 1'b0;
        end

        if(cmd == WR_CMD)
        sda_out  = 1'hz;
        else
        begin
        sda_out  = 1'b0;
        end

        scl         = 1'b0;
        bit_done    = 1'b0;
        ready       = 1'b0; 
        done_tick   = 1'b0;
        tx_next     = tx_reg;
        rx_next     = rx_reg;
        READ_DONE    = 1'b0;
    end
    ACK_2: //9
    begin
        if(counter == qutr)
        begin
            next_state  = ACK_3;
            counter_rst = 1'b1;
        end
        else
        begin
            next_state  = ACK_2;
            counter_rst = 1'b0;
        end

        if(cmd == WR_CMD)
        sda_out  = 1'hz;
        else
        begin
        sda_out  = 1'b0;
        end

        scl         = 1'b1;
        bit_done    = 1'b0;
        ready       = 1'b0; 
        done_tick   = 1'b0;
        tx_next     = tx_reg;
        rx_next     = rx_reg;
        READ_DONE    = 1'b0;
    end
    ACK_3: //10
    begin
        if(counter == qutr)
        begin
            next_state  = ACK_4;
            counter_rst = 1'b1;
        end
        else
        begin
            next_state  = ACK_3;
            counter_rst = 1'b0;
        end

        if(cmd == WR_CMD)
        sda_out  = 1'hz;
        else
        begin
        sda_out  = 1'b0;
        end

        scl         = 1'b1;
        bit_done    = 1'b0;
        ready       = 1'b0; 
        done_tick   = 1'b0;
        tx_next     = tx_reg;
        rx_next     = rx_reg;
        READ_DONE    = 1'b0;
    end
    ACK_4: //11
    begin
        if(counter == qutr)
        begin
            next_state  = HOLD;
            counter_rst = 1'b1;
            done_tick   = 1'b1;
        end
        else
        begin
            next_state  = ACK_4;
            counter_rst = 1'b0;
            done_tick   = 1'b0;
        end

        if(cmd == WR_CMD)
        begin
        sda_out  = 1'hz;
        READ_DONE   = 1'b0;
        end
        else
        begin
        sda_out    = 1'b0;
        READ_DONE   = 1'b1;
        end

        scl         = 1'b0;
        bit_done    = 1'b0;
        ready       = 1'b0; 
        tx_next     = tx_reg;
        rx_next     = rx_reg;
    end
    STOP_1: //12
    begin
        if(counter == half)
        begin
            next_state  = STOP_2;
            counter_rst = 1'b1;
        end
        else
        begin
            next_state  = STOP_1;
            counter_rst = 1'b0;
        end
        sda_out     = 1'b0;
        scl         = 1'b1;
        ready       = 1'b0; 
        bit_done    = 1'b0;
        tx_next     = tx_reg;
        rx_next     = rx_reg;
        done_tick   = 1'b0;
        READ_DONE   = 1'b0;
    end   
    STOP_2: //13
    begin
        if(counter == half)
        begin
            next_state = IDLE;
            counter_rst = 1'b1;
        end
        else
        begin
            next_state = STOP_2;
            counter_rst = 1'b0;
        end
        sda_out     = 1'b1;
        scl         = 1'b1;
        ready       = 1'b0; 
        bit_done    = 1'b0;
        tx_next     = tx_reg;
        rx_next     = rx_reg;
        done_tick   = 1'b0;
        READ_DONE   = 1'b0;
    end  
    default:  
    begin
        next_state  = IDLE;
        sda_out     = 1'b1;
        scl         = 1'b1;
        ready       = 1'b0; 
        bit_done    = 1'b0;
        tx_next     = tx_reg;
        rx_next     = rx_reg;
        done_tick   = 1'b0;
        READ_DONE   = 1'b0;
        counter_rst = 1'b1;
    end 
    endcase
end
endmodule
