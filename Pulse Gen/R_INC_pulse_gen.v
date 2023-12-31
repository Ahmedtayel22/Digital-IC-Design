
/////////////////////////////////////////////////////////////
///////////////////// pulse_gen ///////////////////////
/////////////////////////////////////////////////////////////

module pulse_gen (IN, pulse, CLK, RST);
input IN;
input CLK;
input RST;
output wire pulse;
reg IN_ff;


wire IN_and_0;
wire IN_and_1;
assign IN_and_0 = ~ (IN_ff);
assign IN_and_1 = IN;
assign pulse = IN_and_0 & IN_and_1;


always @ (posedge CLK or negedge RST)
begin
    if(!RST)
    begin
        IN_ff <= 0;
    end
    else
    begin
        IN_ff <= IN;
    end
end

endmodule
