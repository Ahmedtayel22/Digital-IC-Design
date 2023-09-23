
/////////////////////////////////////////////////////////////
///////////////////////// DATA_SYNC /////////////////////////
/////////////////////////////////////////////////////////////

module DATA_SYNC 
#(parameter BUS_WIDTH = 8, NUM_STAGES = 4) 
 (unsync_bus, bus_enable, CLK, RST, sync_bus, enable_pulse);
input  [BUS_WIDTH-1:0]  unsync_bus;
input                   bus_enable;
input                   CLK;
input                   RST;
output [BUS_WIDTH-1:0]  sync_bus;
output                  enable_pulse;

reg  [BUS_WIDTH-1:0] sync_bus;
reg                  enable_pulse;
reg [NUM_STAGES-1:0] Multi_ff;
reg                  Pulse_Gen_ff;

wire [BUS_WIDTH-1:0] Mux_out;
wire                 IN_and_0;
wire                 IN_and_1;
wire                 mux_sel;

assign IN_and_0 = ~ (Pulse_Gen_ff);
assign IN_and_1 = Multi_ff [0];
assign mux_sel  = (IN_and_0) & (IN_and_1);
assign Mux_out  = mux_sel ? unsync_bus:sync_bus;

integer i;

////////___Multi Flip Flop Stage___////////
always @ (posedge CLK or negedge RST)
begin
    if(!RST)
    begin
        for (i=0; i<NUM_STAGES; i=i+1)
        begin
             Multi_ff[i] <= 0;
        end
    end
    else
    begin
        Multi_ff [NUM_STAGES-1] <= bus_enable;
        for (i=NUM_STAGES; i>1; i=i-1)
        begin
            Multi_ff [i-2] <= Multi_ff [i-1];
        end
    end
end

always @ (posedge CLK or negedge RST)
begin
    if(!RST)
    begin
        Pulse_Gen_ff <= 0;
        enable_pulse <= 0;
        sync_bus     <= 0;
    end
    else
    begin
        Pulse_Gen_ff <= Multi_ff [0];
        enable_pulse <= mux_sel;
        sync_bus     <= Mux_out;
    end
end
endmodule
