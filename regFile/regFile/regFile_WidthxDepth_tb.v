`timescale 1us/1us
module regFile_WidthxDepth_tb #(parameter width_tb = 16, depth_tb = 8, addressBus_tb = 3) ();
    reg [width_tb-1:0] wr_data_tb;
    reg [addressBus_tb-1:0] address_tb;
    reg wr_en_tb;
    reg rd_en_tb;
    reg clk_tb;
    reg rst_tb;
    wire [width_tb-1:0] rd_data_tb;

    //////////instantiation of regFile8x16//////////
    regFile8x16 #(.width(width_tb),.depth(depth_tb),.addressBus(addressBus_tb))  DUT 
    (
        .wr_data(wr_data_tb),
        .address(address_tb),
        .wr_en(wr_en_tb),
        .rd_en(rd_en_tb),
        .CLK(clk_tb),
        .RST(rst_tb),
        .rd_data(rd_data_tb)
    );

    always #5 clk_tb=~clk_tb;

    initial
    begin
        wr_data_tb=0;
        address_tb=0;
        wr_en_tb=0;
        rd_en_tb=0;
        clk_tb=0;
        rst_tb=1;

        #10 wr_en_tb = 1; wr_data_tb = 'hAA; address_tb = 2;
        #10 wr_en_tb = 0; rd_en_tb = 1;
        #10 if (rd_data_tb == 'hAA) $display("regFile[2] is PASSED");

        #10 rd_en_tb = 0; wr_en_tb = 1; wr_data_tb = 'hBB; address_tb = 5;
        #10 wr_en_tb = 0; rd_en_tb = 1;
        #10 if (rd_data_tb == 'hBB) $display("regFile[5] is PASSED");

        #10 wr_en_tb =1;
        #10 if(rd_data_tb == rd_data_tb) $display("wr&rd ENABLED --> NO ACTION");

        #10 rst_tb=0;
        #40 if (rd_data_tb == 0) $display("RST is PASSED");
        $stop;
    end
endmodule