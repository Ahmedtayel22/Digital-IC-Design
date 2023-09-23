
/////////////////////////////////////////////////////////////
///////////////////////// RST_SYNC //////////////////////////
/////////////////////////////////////////////////////////////

module RST_SYNC  #(parameter NUM_STAGES = 3) (CLK, RST, SYNC_RST);
input  CLK;
input  RST;
output SYNC_RST;

wire SYNC_RST;    
reg [NUM_STAGES-1:0] Multi_ff;
integer i;

assign SYNC_RST = Multi_ff[0];

////////___Multi Flip Flop Stage___////////
always @ (posedge CLK or negedge RST)
begin
    if(!RST)
    begin
        for (i=0; i<NUM_STAGES; i=i+1)
        begin
             Multi_ff[i] <= 1'b0;
        end
    end
    else
    begin
        Multi_ff [NUM_STAGES-1] <= 1;
        for (i=NUM_STAGES; i>1; i=i-1)
        begin
            Multi_ff [i-2] <= Multi_ff [i-1];
        end
    end
end
endmodule