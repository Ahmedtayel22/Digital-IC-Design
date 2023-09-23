`timescale 1ns/1ns
module DATA_SYNC_tb #(parameter BUS_WIDTH_TB = 8, NUM_STAGES_TB = 2) ();
//**** portDecleration ****//
  reg  [BUS_WIDTH_TB-1:0] unsync_bus_tb;
  reg                      bus_enable_tb;
  reg                      CLK_tb;
  reg                      RST_tb;
  reg                      CLK1;
  wire [BUS_WIDTH_TB-1:0]  sync_bus_tb;
  wire                     enable_pulse_tb;

parameter CLK1_period  = 270.0;
parameter CLK2_period  = 100.0;

//**** designInstantiation ****//
DATA_SYNC #(.BUS_WIDTH(BUS_WIDTH_TB),.NUM_STAGES(NUM_STAGES_TB)) DUT
(
.unsync_bus(unsync_bus_tb),
.bus_enable(bus_enable_tb),
.CLK(CLK_tb),
.RST(RST_tb),
.sync_bus(sync_bus_tb),
.enable_pulse(enable_pulse_tb)
);


//**** Lanuching CLK1 generator with Tperiod == 270.0 ns ****//
always
begin
   CLK1=~CLK1;
   #(CLK1_period/2);
    CLK1=~CLK1;
   #(CLK1_period/2);
end

//**** Capture CLK2 generator with Tperiod == 100.0 ns ****//
always
begin
   CLK_tb=~CLK_tb;
   #(CLK2_period/2);
    CLK_tb=~CLK_tb;
   #(CLK2_period/2);
end

//**** Initial_Block ****//

initial
begin
   $dumpfile("DATA_SYN.vcd");
   $dumpvars;

   CLK_tb = 0;
   CLK1   = 1;
   RST_tb = 1;
   bus_enable_tb = 1'b0;
   #(CLK2_period)   RST_tb = 0;
   #(CLK2_period)   RST_tb = 1;

/******* Test Case.(1) *******/

@(posedge CLK1)
unsync_bus_tb = 'haa;
bus_enable_tb = 1'b1;
#(CLK1_period) 
bus_enable_tb = 1'b0;
#(NUM_STAGES_TB*CLK2_period);

/******* Test Case.(2) *******/
@(posedge CLK1)
unsync_bus_tb = 'hbb;
bus_enable_tb = 1'b1;
#(CLK1_period) 
bus_enable_tb = 1'b0;
#(NUM_STAGES_TB*CLK2_period);

/******* Test Case.(3) *******/
@(posedge CLK1)
unsync_bus_tb = 'hcc;
bus_enable_tb = 1'b1;
#(CLK1_period) 
bus_enable_tb = 1'b0;
#(NUM_STAGES_TB*CLK2_period);

/******* Test Case.(4) *******/
@(posedge CLK1)
unsync_bus_tb = 'hdd;
bus_enable_tb = 1'b1;
#(CLK1_period) 
bus_enable_tb = 1'b0;
#(NUM_STAGES_TB*CLK2_period);

/******* Test Case.(5) *******/
@(posedge CLK1)
unsync_bus_tb = 'hee;
bus_enable_tb = 1'b1;
#(CLK1_period)
bus_enable_tb = 1'b0;
#(NUM_STAGES_TB*CLK2_period);

/******* Test Case.(6) *******/
@(posedge CLK1)
unsync_bus_tb = 'hff;
bus_enable_tb = 1'b1;
#(CLK1_period)
bus_enable_tb = 1'b0;
#(NUM_STAGES_TB*CLK2_period);

/*******Test Case.(7)*******/
@(posedge CLK1)
unsync_bus_tb = 'ha1;
bus_enable_tb = 1'b1;
#(CLK1_period)
bus_enable_tb = 1'b0;
#(NUM_STAGES_TB*CLK2_period);

/*******Test Case.(8)*******/
@(posedge CLK1)
unsync_bus_tb = 'ha2;
bus_enable_tb = 1'b1;
#(CLK1_period)
bus_enable_tb = 1'b0;
#(NUM_STAGES_TB*CLK2_period);

/*******Test Case.(9)*******/
@(posedge CLK1)
unsync_bus_tb = 'ha3;
bus_enable_tb = 1'b1;
#(CLK1_period)
bus_enable_tb = 1'b0;
#(NUM_STAGES_TB*CLK2_period);
#(NUM_STAGES_TB*CLK2_period);
$stop;
end
endmodule
