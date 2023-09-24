
//****************************************************//
//******************** BIT_SYNC **********************//
//****************************************************//

module BIT_SYNC 
#(parameter BUS_WIDTH = 8, NUM_STAGES = 4) 
(ASYNC, RST, CLK, SYNC);
input  [BUS_WIDTH-1:0] ASYNC;
input                  RST;
input                  CLK;
output [BUS_WIDTH-1:0] SYNC;

reg [BUS_WIDTH-1:0]  SYNC;
reg [NUM_STAGES-2:0] Multi_ff [0:BUS_WIDTH-1];  

integer i;
integer J;

////////___Multi Flip Flop Stage___////////
always @ (posedge CLK or negedge RST)
begin
    if(!RST)
    begin
        for (i=0; i<BUS_WIDTH; i=i+1)
        begin
             Multi_ff[i] <= 1'b0;
        end
        SYNC <= 0;
    end
    else
    begin
        for (i=0; i<BUS_WIDTH; i=i+1)
        begin
            Multi_ff [i][NUM_STAGES-2] <= ASYNC [i];
        end
        for (J=0; J<BUS_WIDTH; J=J+1)
        begin
            for (i=NUM_STAGES; i>1; i=i-1)
            begin
                Multi_ff [J][i-3] <= Multi_ff [J][i-2];
            end
            SYNC [J] <= Multi_ff [J][0];
        end
    end
end
endmodule

