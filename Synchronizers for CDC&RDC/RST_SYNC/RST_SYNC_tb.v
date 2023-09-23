`timescale 1ns/1ns
module RST_SYNC_tb ();
//**** portDecleration ****//
  reg  CLK_tb;
  reg  RST_tb;
  reg  CLK1;
  wire SYNC_RST_tb;

parameter CLK2_period  = 100.0;

//**** designInstantiation ****//
RST_SYNC DUT
(
.CLK(CLK_tb),
.RST(RST_tb),
.SYNC_RST(SYNC_RST_tb)
);

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

   CLK_tb   = 1'b0;
   RST_tb   = 1'b1;
   
/******* Test Case.(1) *******/
#(CLK2_period) RST_tb = 1'b0;
#(CLK2_period) RST_tb = 1'b1;
#(5*CLK2_period);

/******* Test Case.(3) *******/
#(CLK2_period) RST_tb = 1'b0;
#(CLK2_period) RST_tb = 1'b1;
#(5*CLK2_period);

/******* Test Case.(3) *******/
#(CLK2_period) RST_tb = 1'b0;
#(CLK2_period) RST_tb = 1'b1;
#(5*CLK2_period);

/******* Test Case.(4) *******/
#(CLK2_period) RST_tb = 1'b0;
#(CLK2_period) RST_tb = 1'b1;
#(5*CLK2_period);

$stop;
end
endmodule