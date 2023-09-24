

//****************************************************//
//********************** FSM *************************//
//****************************************************//

module FSM (sync_sig, CLK, RST, timer_DONE, timer_EN, debouncer_out);
input sync_sig;
input CLK;
input RST;
input timer_DONE;
output debouncer_out;
output timer_EN;

reg debouncer_out;
reg timer_EN;
reg [3:0] current_state;
reg [3:0] next_state;

parameter  IDLE       = 0; //Acts like LOW STATE
parameter  CHECK_HIGH = 1;
parameter  HIGH_STATE = 2;
parameter  CHECK_LOW  = 3;

always @(posedge CLK or negedge RST)
begin
    if(!RST)
    begin
        current_state <= 0;
    end
    else 
    begin
        current_state <= next_state;
    end
end

always @ (*)
begin
    case (current_state)
    IDLE:
    begin
        if(sync_sig)
        begin
            next_state = CHECK_HIGH;
        end
        else
        begin
            next_state = IDLE;
        end
        debouncer_out = 1'b0;
        timer_EN      = 1'b0;
    end
    CHECK_HIGH:
    begin
        if(timer_DONE)
        begin
            if(sync_sig)
            begin
                next_state    = HIGH_STATE;
                debouncer_out = 1'b1;
                timer_EN      = 1'b0;
            end
            else
            begin
                next_state    = IDLE;
                debouncer_out = 1'b0;
                timer_EN      = 1'b0;
            end
        end
        else
        begin
            next_state    = CHECK_HIGH;
            debouncer_out = 1'b0;
            timer_EN      = 1'b1;
        end
    end
    HIGH_STATE:
    begin
        if(!sync_sig)
        begin
            next_state   = CHECK_LOW;
        end
        else
        begin
            next_state    = HIGH_STATE;
        end
        debouncer_out = 1'b1;
        timer_EN      = 1'b0;
    end
    CHECK_LOW:
    begin
        if(timer_DONE)
        begin
            if(!sync_sig)
            begin
                next_state    = IDLE;
                debouncer_out = 1'b0;
                timer_EN      = 1'b0;
            end
            else
            begin
                next_state    = HIGH_STATE;
                debouncer_out = 1'b1;
                timer_EN      = 1'b0;
            end
        end
        else
        begin
            next_state    = CHECK_LOW;
            debouncer_out = 1'b1;
            timer_EN      = 1'b1;
        end
    end
    default:
    begin
        next_state    = IDLE;
        debouncer_out = 1'b0;
        timer_EN      = 1'b0;
    end
    endcase
end
endmodule