
/////////////////////////////////////////////////////////////
/////////////////////// regFile8x16 /////////////////////////
/////////////////////////////////////////////////////////////
module regFile8x16 #(parameter width = 16, depth = 8, addressBus = 4)
    (wr_data, address, wr_en, rd_en, CLK, RST, rd_data);
    input [width-1:0] wr_data;
    input [addressBus-1:0] address;
    input wr_en;
    input rd_en;
    input CLK;
    input RST;
    output [width-1:0] rd_data;

    reg [width-1:0] rd_data;
    reg [width-1:0] reg_file [0:depth-1]; //2D-array memory 
    integer i;

    always@(posedge CLK or negedge RST)
    begin
        if(!RST)
        begin
            for (i=0; i<depth; i=i+1)
            begin
                 reg_file[i]<= 0;
            end
            rd_data <= 0;
        end
        else if (wr_en ==1 && rd_en==0)
        reg_file[address] <= wr_data;
        else if (rd_en==1 && wr_en==0)
        rd_data <= reg_file [address];
        else if (rd_en==1 && wr_en==1)
        begin
        rd_data <= rd_data;
        reg_file[address] <= reg_file[address];
        end
    end
endmodule
