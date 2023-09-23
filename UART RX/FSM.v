module FSM 
(RX_IN, PAR_EN, bit_cnt, Prescale, edge_cnt, par_err, strt_glitch,
stp_err, CLK, RST,enable, deser_en, data_valid,
strt_chk_en,par_chk_en, stp_chk_en, data_valid_en);
input       RX_IN;
input       PAR_EN;
input [3:0] bit_cnt;
input [5:0] Prescale;
input [5:0] edge_cnt;

input       par_err;
input       strt_glitch;
input       stp_err;
input       CLK;
input       RST;
output      enable;
output      deser_en;
output      data_valid;
output      strt_chk_en;
output      par_chk_en;
output      stp_chk_en;
output      data_valid_en;

reg         enable;
reg         deser_en;
reg         data_valid;
reg         strt_chk_en;
reg         par_chk_en;
reg         stp_chk_en;
reg         data_valid_en;
reg  [2:0]  current_state;
reg  [2:0]  next_state;

parameter  IDLE   = 0;
parameter  START  = 1;
parameter  DATA   = 2;
parameter  PARITY = 3;
parameter  STOP   = 4;
parameter  CHECK  = 5;


always @ (posedge CLK or negedge RST)
begin
    if(!RST) begin data_valid <= 1'b0;            end
    else     begin data_valid <= data_valid_en;   end
end
 
always @ (posedge CLK or negedge RST)
begin
    if(!RST) begin current_state <= IDLE;       end
    else     begin current_state <= next_state; end
end

always @(*)
begin
    case (current_state)
    IDLE:
    begin
        if (RX_IN == 1'b0)
        begin
            next_state = START;
        end
        else
        begin
            next_state = IDLE;
        end
        
        enable            = 1'b0;
        deser_en          = 1'b0;
        strt_chk_en       = 1'b0;
        par_chk_en        = 1'b0;
        stp_chk_en        = 1'b0;
        data_valid_en     = 1'b0;
    end
    START:
    begin
        if (bit_cnt == 4'b1 && strt_glitch == 1'b1)
        begin
            next_state = IDLE;
        end
        else if (bit_cnt == 4'b1 && strt_glitch == 1'b0)
        begin
            next_state = DATA;
        end
        else
        begin
            next_state = START;
        end

        enable            = 1'b1;
        deser_en          = 1'b0;
        strt_chk_en       = 1'b1;
        par_chk_en        = 1'b0;
        stp_chk_en        = 1'b0;
        data_valid_en     = 1'b0;
    end
    DATA:
    begin
        if (bit_cnt == 4'b1001 && PAR_EN == 1'b1)
        begin
            next_state = PARITY;
        end
        else if (bit_cnt == 4'b1001 && PAR_EN == 1'b0)
        begin
            next_state = STOP;
        end
        else
        begin
            next_state = DATA;
        end

        enable            = 1'b1;
        deser_en          = 1'b1;
        strt_chk_en       = 1'b0;
        par_chk_en        = 1'b0;
        stp_chk_en        = 1'b0;
        data_valid_en     = 1'b0;
    end
    PARITY:
    begin
        if (bit_cnt == 4'b1010)
        begin
            next_state = STOP;
        end
        else
        begin
            next_state = PARITY;
        end

        enable            = 1'b1;
        deser_en          = 1'b0;
        strt_chk_en       = 1'b0;
        par_chk_en        = 1'b1;
        stp_chk_en        = 1'b0;
        data_valid_en     = 1'b0;
    end
    STOP:
    begin
        if ((edge_cnt == (Prescale-2)))
        begin
         next_state = CHECK;
        end
        else 
        begin
            next_state = STOP;
        end

        enable          = 1'b1;
        deser_en        = 1'b0;
        par_chk_en      = 1'b0;
        strt_chk_en     = 1'b0;
        stp_chk_en      = 1'b1;
	    data_valid_en   = 1'b0;
    end
    CHECK:
    begin
        if((par_err) || (stp_err))
        begin
            data_valid_en = 1'b0;
            if(!RX_IN)
            begin
                next_state = START;
            end
            else
            begin
                next_state = IDLE;
            end
        end
        else
        begin
            data_valid_en = 1'b1;
            if(!RX_IN)
            begin
                next_state = START;
            end
            else
            begin
            next_state = IDLE;
            end
        end

        enable          = 1'b0;
        deser_en        = 1'b0;
        par_chk_en      = 1'b0;
        strt_chk_en     = 1'b0;
        stp_chk_en      = 1'b0;    
    end
    default:
    begin
        next_state      = IDLE;
        enable          = 1'b0;
        deser_en        = 1'b0;
        par_chk_en      = 1'b0;
        strt_chk_en     = 1'b0;
        stp_chk_en      = 1'b0;
        data_valid_en   = 1'b0;
       
    end
    endcase
end
endmodule
