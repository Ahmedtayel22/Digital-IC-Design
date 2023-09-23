module strt_checker 
(sampled_bit, strt_chk_en, CLK, RST, DONE, clearFlag, strt_glitch);
input   sampled_bit;
input   strt_chk_en;
input         CLK;
input         RST;
input         DONE;
input         clearFlag; //low level clear_flag connected to enable_en of the FSM
output        strt_glitch;
reg           strt_glitch;


always @(posedge CLK or negedge RST)
begin
    if(!RST)
    begin
        strt_glitch <= 0;
    end
    else if (strt_chk_en && DONE)
    begin
        if (sampled_bit == 1'b1)
        begin
            strt_glitch <= 1'b1;
        end
    end
    else if (clearFlag == 1'b0)
    begin
        strt_glitch <= 1'b0;
    end
end
endmodule
