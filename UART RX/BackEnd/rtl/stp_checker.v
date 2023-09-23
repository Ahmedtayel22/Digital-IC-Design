module stp_checker 
(sampled_bit, stp_chk_en, CLK, RST, clearFlag, DONE, stp_err);
input         sampled_bit;
input         stp_chk_en;
input         CLK;
input         RST;
input         clearFlag; //low level clear_flag connected to enable_en of the FSM
input         DONE;
output        stp_err;
reg           stp_err;


always @(posedge CLK or negedge RST)
begin
    if(!RST)
    begin
        stp_err <= 1'b0;
    end
    else if (stp_chk_en && DONE)
    begin
        if (sampled_bit == 0)
        begin
            stp_err <= 1'b1;
        end
        else
        begin
            stp_err <= 1'b0;
        end
    end
    else if (clearFlag == 1'b0)
    begin
        stp_err <= 0;
    end
    end
endmodule
