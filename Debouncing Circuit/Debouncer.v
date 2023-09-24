
//****************************************************//
//******************* Debouncer **********************//
//* Depends on "Delay" detection debouncer technique *//

//****************************************************//
//******************** Parameters ********************//
//****************************************************//
//"Delay refers" --> No.cycles 
//"no_sync_stages" --> no.of stages @ the bit_sync 
//"Counter_width" --> bit_width of counter 

module Debouncer #(parameter no_sync_stages = 2, Delay = 100, 
Counter_width = 8)
(noisy_IN, CLK, RST, Debouncer_out);
input noisy_IN;
input CLK;
input RST;
output Debouncer_out;

wire SYNC_WIRE;

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


Timer #(.delay_time(Delay), .counter_width(Counter_width))DUT1
(
    .timer_EN(timer_EN_WIRE),
    .CLK(CLK),
    .RST(RST),
    .timer_DONE(timer_DONE_WIRE)
);


endmodule