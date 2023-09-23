`timescale 1us/1ns
module CRC_tb #(parameter width_tb = 8) ();
/***Declerations of inputs&outputs***/
reg data_tb;
reg active_tb;
reg clk_tb;
reg rst_tb;
wire crc_tb;
wire valid_tb;

reg [width_tb-1:0] DATA_h [9:0];
reg [width_tb-1:0] Expec_Out_h [9:0];

/***instantiation of CRC***/
CRC DUT 
(
    .data(data_tb),
    .active(active_tb),
    .CLK(clk_tb),
    .RST(rst_tb),
    .crc(crc_tb),
    .valid(valid_tb)
);

/***CLK generator of 10 Mhz (Tperiod = 0.1us)***/
parameter clk_period = 0.1;
always #(clk_period/2) clk_tb=~clk_tb;

/*********TASKS**********/
task initalization;
    begin
    data_tb=0;
    active_tb=0;
    clk_tb=0;
    rst_tb=1;

    #(clk_period) rst_tb=0;
    #(clk_period) rst_tb=1; 
    #(10*clk_period);
    end
endtask

task New_data; /***call it like "New_data(yourdata, case_No, data_index);"***/
    input [width_tb-1:0] yourdata;
    input [4:0] case_No;
    input [4:0] data_index;
    begin
    @(negedge clk_tb) active_tb=1; data_tb = yourdata[0]; 
    #(clk_period) data_tb = yourdata[1];
    #(clk_period) data_tb = yourdata[2];
    #(clk_period) data_tb = yourdata[3];
    #(clk_period) data_tb = yourdata[4];
    #(clk_period) data_tb = yourdata[5];
    #(clk_period) data_tb = yourdata[6];
    #(clk_period) data_tb = yourdata[7]; 
    #(clk_period) active_tb=0;
    $display("****CASE No.%d****", case_No);

    end
endtask

task test_output; /***call it like "test_output(expec_out);"***/
    input [width_tb-1:0] expec_out;
    begin
    #(clk_period) if (crc_tb==expec_out[0]) $display ("CRC bit (0) is PASSED");
    #(clk_period) if (crc_tb==expec_out[1]) $display ("CRC bit (1) is PASSED");
    #(clk_period) if (crc_tb==expec_out[2]) $display ("CRC bit (2) is PASSED");
    #(clk_period) if (crc_tb==expec_out[3]) $display ("CRC bit (3) is PASSED");
    #(clk_period) if (crc_tb==expec_out[4]) $display ("CRC bit (4) is PASSED");
    #(clk_period) if (crc_tb==expec_out[5]) $display ("CRC bit (5) is PASSED");
    #(clk_period) if (crc_tb==expec_out[6]) $display ("CRC bit (6) is PASSED");
    #(clk_period) if (crc_tb==expec_out[7]) $display ("CRC bit (7) is PASSED");
    end
endtask

/***inital Block***/
initial 
begin
    $dumpfile("CRC_serially.vcd");
    $dumpvars;
    //$readmemh("DATA_h.txt", DATA_h);
    //$readmemh("Expec_Out_h.txt", Expec_Out_h);
    initalization();

    /***////////////////////////////////////////////////////
    ///////////////////////TEST CASES///////////////////////
    ////////////////////////////////////////////////////***/

    /***////////////////////CASE No. 1/////////////////////***/
    New_data('h93,1,0);
    test_output('h78);
    #(5*clk_period)

   /***////////////////////CASE No. 2/////////////////////**/
    New_data('h72,2,1);
    test_output('h44);
    #(5*clk_period)

    /***/////////////////////CASE No. 3/////////////////////***/
    New_data('h36,3,2);
    test_output('h11);
    #(5*clk_period)

    /***/////////////////////CASE No. 4/////////////////////***/
    New_data('h1B,4,2);
    test_output('hd2);
    #(5*clk_period)

    /***/////////////////////CASE No. 5/////////////////////***/
    New_data('hA6,5,3);
    test_output('h09);
    #(5*clk_period)
    #0.1;
    $stop;
end
endmodule
