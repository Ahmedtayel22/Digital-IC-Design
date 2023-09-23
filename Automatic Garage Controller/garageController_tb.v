`timescale 1ns/1ns
module garageController_tb ();
reg up_max_tb;
reg dn_max_tb;
reg activate_tb;
reg clk_tb;
reg rst_tb;

wire up_m_tb;
wire dn_m_tb;

garageController DUT (
    .up_max(up_max_tb),
    .dn_max(dn_max_tb),
    .activate(activate_tb),
    .clk(clk_tb),
    .rst(rst_tb),
    .up_m(up_m_tb),
    .dn_m(dn_m_tb)
);


always #10 clk_tb=~clk_tb;

initial 

    begin
        $dumpfile("garageController_tb.vcd");
        $dumpvars;
        up_max_tb = 0;
        dn_max_tb = 0;
        activate_tb = 0;
        clk_tb = 0;
        rst_tb = 1;

        ///////RST to initialize the counter///////
        #20 rst_tb = 0;
        #20 rst_tb = 1;
        if (up_m_tb == 0 && dn_m_tb == 0)
        $display ("garageDoor goes to idle case");

        #20 activate_tb = 1; up_max_tb = 1;
        #40 if ( dn_m_tb == 1) 
        $display ("garageDoor goes from idle --> closed");

        #20 activate_tb = 1; up_max_tb = 0; dn_max_tb = 1;
        #40 if ( up_m_tb == 1) 
        $display ("garageDoor goes from closed --> idle --> opened");

        #20 activate_tb = 1; up_max_tb = 1; dn_max_tb = 0;
        #40 if ( dn_m_tb == 1) 
        $display ("garageDoor goes from opened --> idle --> closed");
        $stop;
    end
endmodule
