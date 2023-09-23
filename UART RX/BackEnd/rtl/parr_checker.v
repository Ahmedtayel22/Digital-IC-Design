module par_checker 
(sampled_bit, par_chk_en, calculated_par_bit, 
CLK, RST, clearFlag, DONE, par_err);
input        sampled_bit;
input        par_chk_en;
input        calculated_par_bit;
input        CLK;
input        RST;
input        clearFlag; //low level clear_flag connected to enable_en of the FSM
input        DONE;
output       par_err;
reg          par_err;


always @(posedge CLK or negedge RST)
begin
    if(!RST)
    begin
        par_err <= 1'b0;
    end
    else if (clearFlag == 1'b0)
    begin
        par_err <= 1'b0;
    end
    else if(par_chk_en && DONE) 
    begin  
        if (sampled_bit != calculated_par_bit)
            par_err <= 1'b1;
        else
            par_err <= 1'b0;
    end
end
endmodule
