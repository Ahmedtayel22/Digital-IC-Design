
/////////////////////////////////////////////////////////////
/////////////////////// regFile8x16 /////////////////////////
/////////////////////////////////////////////////////////////

module regFile8x16 #(parameter width = 16, depth = 8, addressBus = 4)
    (WrData, Address, WrEN, RdEN, REF_CLK, RST, 
    RdData, RdData_Valid);
    input [width-1:0] WrData;
    input [addressBus-1:0] Address;
    input WrEN;
    input RdEN;
    input REF_CLK; 
    input RST;
    output [width-1:0] RdData;
    output RdData_Valid;

    reg RdData_Valid;
    reg [width-1:0] RdData;
    reg [width-1:0] reg_file [0:depth-1]; 
    integer i;

    always@(posedge REF_CLK or negedge RST)
    begin
        if(!RST)
        begin
            for (i=0; i<depth; i=i+1)
            begin
                 reg_file[i]<= 0;
            end
            RdData       <= 0;
            RdData_Valid <= 0;
        end
        else if (WrEN ==1 && RdEN==0)
        begin
        reg_file[Address] <= WrData;
        RdData_Valid <= 0;
        end
        else if (RdEN==1 && WrEN==0)
        begin
        RdData <= reg_file [Address];
        RdData_Valid <= 1'b1;
        end
        else
        begin
        RdData <= RdData;
        RdData_Valid <= 0;
        reg_file[Address] <= reg_file[Address];
        end
    end
endmodule
