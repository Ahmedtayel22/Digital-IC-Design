`timescale 1ns/1ns
module BIT_SYNC_tb #(parameter BUS_WIDTH_TB = 8, NUM_STAGES_TB = 4) ();
//**** portDecleration ****//
  reg  [BUS_WIDTH_TB-1:0] ASYNC_tb;
  reg  CLK_tb;
  reg  RST_tb;
  reg  CLK1;
  wire [BUS_WIDTH_TB-1:0] SYNC_tb;

parameter CLK1_period  = 270.0;
parameter CLK2_period  = 100.0;

//**** designInstantiation ****//
BIT_SYNC #(.BUS_WIDTH(BUS_WIDTH_TB),.NUM_STAGES(NUM_STAGES_TB)) DUT
(
.ASYNC(ASYNC_tb),
.CLK(CLK_tb),
.RST(RST_tb),
.SYNC(SYNC_tb)
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
   $dumpfile("BIT_SYN.vcd");
   $dumpvars;

   CLK_tb   = 0;
   CLK1     = 1;
   RST_tb   = 1;
   ASYNC_tb = 0;
   #(CLK2_period)   RST_tb = 0;
   #(CLK2_period)   RST_tb = 1;

/******* Test Case.(1) *******/
@(posedge CLK1)
ASYNC_tb = 'haa;
#(CLK1_period/5)

/******* Test Case.(2) *******/
@(posedge CLK1)
ASYNC_tb = 'hbb;
#(CLK1_period/5)

/******* Test Case.(3) *******/
@(posedge CLK1)
ASYNC_tb = 'hcc;
#(CLK1_period/5)

/******* Test Case.(4) *******/
@(posedge CLK1)
ASYNC_tb = 'hdd;
#(CLK1_period/5)

/******* Test Case.(5) *******/
@(posedge CLK1)
ASYNC_tb = 'hee;
#(CLK1_period/5)

/******* Test Case.(6) *******/
@(posedge CLK1)
ASYNC_tb = 'hff;
#(CLK1_period/5)

/******* Test Case.(7) *******/
@(posedge CLK1)
ASYNC_tb = 'hb1;
#(CLK1_period/5)

/******* Test Case.(8) *******/
@(posedge CLK1)
ASYNC_tb = 'hb2;
#(CLK1_period/5)

#(NUM_STAGES_TB*CLK2_period);
#(NUM_STAGES_TB*CLK2_period);
$stop;
end
endmodule