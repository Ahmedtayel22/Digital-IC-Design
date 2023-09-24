
//****************************************************//
//******************* Debouncer **********************//
//* Depends on "Delay" detection debouncer technique *//

//****************************************************//
//******************** Parameters ********************//
//****************************************************//
//"no_sync_stages" --> no.of stages @ the bit_sync 
//"desired_Delay refers" --> No.cycles 
//"Counter_width" --> bit_width of counter 

module Debouncer #(parameter no_sync_stages = 2, desired_Delay = 100, 
Counter_width = 8)
(noisy_IN, CLK, RST, Debouncer_out);
input noisy_IN;
input CLK;
input RST;
output Debouncer_out;

wire SYNC_WIRE;
wire timer_DONE_WIRE;
wire timer_EN_WIRE;

BIT_SYNC #(1,no_sync_stages) DUT0
(
    .ASYNC(noisy_IN),
    .CLK(CLK),
    .RST(RST),
    .SYNC(SYNC_WIRE)
);


FSM DUT3
(
    .sync_sig(SYNC_WIRE),
    .CLK(CLK),
    .RST(RST),
    .timer_DONE(timer_DONE_WIRE),
    .debouncer_out(Debouncer_out),
    .timer_EN(timer_EN_WIRE)

);


Timer #(.delay_time(desired_Delay), .counter_width(Counter_width))DUT1
(
    .timer_EN(timer_EN_WIRE),
    .CLK(CLK),
    .RST(RST),
    .timer_DONE(timer_DONE_WIRE)
);


endmodule
