module TX_FSM 
(DATA_VALID, ser_done, PAR_EN, ser_en, mux_sel,
 BUSY, CLK, RST);
input        DATA_VALID;
input        ser_done;
input        PAR_EN;
input        CLK;
input        RST;
output       ser_en;
output [1:0] mux_sel;
output       BUSY;

reg        BUSY;
reg        ser_en;
reg        busy_wire;
reg  [1:0] mux_sel;
reg  [2:0] current_state;
reg  [2:0] next_state;

parameter start_bit = 2'b00;
parameter stop_bit  = 2'b11;
parameter ser_data  = 2'b01;
parameter par_bit   = 2'b10;

parameter IDLE                   = 3'b000;
parameter START_BIT_TRANSMISSION = 3'b010; //2
parameter DATA_TRANSMISSION      = 3'b011; //4
parameter PAR_BIT_TRANSMISSION   = 3'b111; //7
parameter STOP_BIT_TRANSMISSION  = 3'b110; //6

always @ (posedge CLK or negedge RST)
begin
    if (!RST) begin BUSY <= 0;   end
    else      begin BUSY <= busy_wire; end
end

always @ (posedge CLK or negedge RST)
begin
    if (!RST) begin current_state <= IDLE;       end
    else      begin current_state <= next_state; end
end

always @(*)
begin
    case (current_state)
    IDLE:
    begin
        if (DATA_VALID)  
        begin
            next_state = START_BIT_TRANSMISSION; 
        end 
        else 
        begin
        next_state = IDLE; 
        end
        mux_sel = stop_bit;
        busy_wire = 0;
        ser_en = 0;
    end

    START_BIT_TRANSMISSION:
    begin
        
        next_state = DATA_TRANSMISSION;
        ser_en = 1;
        busy_wire = 1;
        mux_sel = start_bit;

    end

    DATA_TRANSMISSION:
    begin
        if (ser_done == 1)
         begin
            if(PAR_EN) 
            next_state = PAR_BIT_TRANSMISSION; 
            else
            next_state = STOP_BIT_TRANSMISSION;
        end
        else  
        begin 
            next_state = DATA_TRANSMISSION; 
        end
        ser_en = 1;
        busy_wire = 1;
        mux_sel = ser_data;

    end

    PAR_BIT_TRANSMISSION:
    begin
        next_state = STOP_BIT_TRANSMISSION;
        ser_en = 1;
        busy_wire = 1;
        mux_sel = par_bit;

    end

    STOP_BIT_TRANSMISSION:
    begin

        next_state = IDLE; 

        busy_wire = 1;
        ser_en = 0;     
        mux_sel = stop_bit;
    end
    default:
    begin
        next_state = IDLE;

        busy_wire = 0;
        ser_en = 0;     
        mux_sel = stop_bit;
    end
    endcase
end
endmodule