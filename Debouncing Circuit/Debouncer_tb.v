`timescale 1ns/1ns
module Debouncer_tb #(parameter no_sync_stages_tb = 2, Delay_tb = 100, 
Counter_width_tb = 8) ();
//**** portDecleration ****//
  reg         noisy_IN_tb;
  reg         CLK_tb;
  reg         RST_tb;
  wire         Debouncer_out;

parameter CLK_Period = 10.0;

//**** designInstantiation ****//
Debouncer #(.no_sync_stages(no_sync_stages_tb), .Delay(Delay_tb), .Counter_width(Counter_width_tb) )DUT(
.noisy_IN(noisy_IN_tb),
.CLK(CLK_tb),
.RST(RST_tb),
.Debouncer_out(Debouncer_out_tb)
);

//**** CLK generator with Tperiod == 10.0 ns ****//
always
begin
   CLK_tb=~CLK_tb;
   #5.0;
    CLK_tb=~CLK_tb;
   #5.0;
end

//**** Initial_Block ****//

initial
begin
   $dumpfile("Debouncer.vcd");
   $dumpvars;

   CLK_tb   = 1'b0;
   RST_tb   = 1'b1;
   noisy_IN_tb = 1'b0; // Debouncer_out = 1'b0
   #(CLK_Period) RST_tb = 1'b0;
   #(CLK_Period) RST_tb = 1'b1;

   //*************************************************//
   //***************** Test Case.(1) *****************//
   //*************************************************//
   // input = 1b'1 -- Debouncer_out = 1'b1

   #(CLK_Period)     noisy_IN_tb   = 1'b1;
   #(2*CLK_Period)   noisy_IN_tb   = 1'b0;
   #(CLK_Period/3)   noisy_IN_tb   = 1'b1;
   #(CLK_Period)     noisy_IN_tb   = 1'b0;
   #(CLK_Period/2)   noisy_IN_tb   = 1'b1;
   #(CLK_Period/2)   noisy_IN_tb   = 1'b0;
   #(CLK_Period)     noisy_IN_tb   = 1'b1;

   //*************************************************//
   //***************** Test Case.(2) *****************//
   //*************************************************//
   // input = 1b'0 -- Debouncer_out = 1'b0

   @(posedge Debouncer_out_tb)
   #(CLK_Period)     noisy_IN_tb   = 1'b0;
   #(2*CLK_Period)   noisy_IN_tb   = 1'b0;
   #(CLK_Period/3)   noisy_IN_tb   = 1'b1;
   #(CLK_Period)     noisy_IN_tb   = 1'b0;
   #(CLK_Period/2)   noisy_IN_tb   = 1'b1;
   #(CLK_Period/2)   noisy_IN_tb   = 1'b0;
   #(CLK_Period)     noisy_IN_tb   = 1'b0;

   //*************************************************//
   //***************** Test Case.(3) *****************//
   //*************************************************//
   // input = 1b'0 -- Debouncer_out = "STILL 1'b0";

   @(negedge Debouncer_out_tb)
   #(CLK_Period)     noisy_IN_tb   = 1'b1;
   #(2*CLK_Period)   noisy_IN_tb   = 1'b0;
   #(CLK_Period/3)   noisy_IN_tb   = 1'b1;
   #(CLK_Period)     noisy_IN_tb   = 1'b0;
   #(CLK_Period/2)   noisy_IN_tb   = 1'b1;
   #(CLK_Period/2)   noisy_IN_tb   = 1'b0;
   #(CLK_Period)     noisy_IN_tb   = 1'b0;
   #((Delay_tb+5)*CLK_Period);

   //*************************************************//
   //***************** Test Case.(4) *****************//
   //*************************************************//
   //input = 1'b1 -- Debouncer_out = 1'b1

   #(CLK_Period)     noisy_IN_tb   = 1'b1;
   #(2*CLK_Period)   noisy_IN_tb   = 1'b0;
   #(CLK_Period/3)   noisy_IN_tb   = 1'b1;
   #(CLK_Period)     noisy_IN_tb   = 1'b0;
   #(CLK_Period/2)   noisy_IN_tb   = 1'b1;
   #(CLK_Period/2)   noisy_IN_tb   = 1'b0;
   #(CLK_Period)     noisy_IN_tb   = 1'b1;

   //*************************************************//
   //***************** Test Case.(5) *****************//
   //*************************************************//
   //input = 1'b1 -- Debouncer_out = "STILL 1'b1";
   
   #(CLK_Period)     noisy_IN_tb   = 1'b0;
   #(2*CLK_Period)   noisy_IN_tb   = 1'b1;
   #(CLK_Period/3)   noisy_IN_tb   = 1'b0;
   #(CLK_Period)     noisy_IN_tb   = 1'b0;
   #(CLK_Period/2)   noisy_IN_tb   = 1'b0;
   #(CLK_Period/2)   noisy_IN_tb   = 1'b1;
   #(CLK_Period)     noisy_IN_tb   = 1'b1;
   #((Delay_tb+30)*CLK_Period);

   //*************************************************//
   //***************** Test Case.(6) *****************//
   //*************************************************//
   //input = 1'b0 -- Debouncer_out = 1'b0
   
   #(CLK_Period)     noisy_IN_tb   = 1'b0;
   #(2*CLK_Period)   noisy_IN_tb   = 1'b1;
   #(CLK_Period/3)   noisy_IN_tb   = 1'b0;
   #(CLK_Period)     noisy_IN_tb   = 1'b0;
   #(CLK_Period/2)   noisy_IN_tb   = 1'b0;
   #(CLK_Period/2)   noisy_IN_tb   = 1'b1;
   #(CLK_Period)     noisy_IN_tb   = 1'b0;

   #((Delay_tb+30)*CLK_Period);
   $stop;
end
endmodule
