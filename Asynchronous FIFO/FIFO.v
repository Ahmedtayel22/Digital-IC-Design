
/////////////////////////////////////////////////////////////
//////////////////////////// FIFO ///////////////////////////
/////////////////////////////////////////////////////////////

module FIFO 
#(parameter WIDTH = 8, DEPTH = 8, ptr_width = 4, NUM_STAGES = 2)
(W_DATA, W_INC, R_INC, W_CLK, W_RST, R_CLK, R_RST,
 FULL, EMPTY, R_DATA);
input [WIDTH-1:0] W_DATA;
input             W_INC;
input             R_INC;
input             W_CLK;
input             W_RST;
input             R_CLK;
input             R_RST;
output FULL;
output EMPTY;
output [WIDTH-1:0] R_DATA;

wire FULL;
wire EMPTY;
wire [WIDTH-1:0] R_DATA;

reg [ptr_width-1:0] w_ptr;
reg [ptr_width-1:0] r_ptr;
reg [ptr_width-1:0] sync_w_ptr;
reg [ptr_width-1:0] sync_r_ptr;
reg [ptr_width-1:0] gray_w_ptr;
reg [ptr_width-1:0] gray_r_ptr;

reg [WIDTH-1:0] FIFO_MEMORY [0:DEPTH-1];
reg [NUM_STAGES-2:0] Multi_ff_1 [0:ptr_width-1]; 
reg [NUM_STAGES-2:0] Multi_ff_2 [0:ptr_width-1]; 


wire [ptr_width-2:0] w_addr;
wire [ptr_width-2:0] r_addr;
assign R_DATA = FIFO_MEMORY [r_addr];
assign w_addr = w_ptr [ptr_width-2:0];
assign r_addr = r_ptr [ptr_width-2:0];
assign FULL   = ((sync_r_ptr [(ptr_width-3):0] == gray_w_ptr [(ptr_width-3):0]) && (gray_w_ptr [ptr_width-1] != sync_r_ptr [ptr_width-1]) && ((gray_w_ptr [ptr_width-2] != sync_r_ptr [ptr_width-2]))) ? 1:0;
assign EMPTY  = (sync_w_ptr == gray_r_ptr) ? 1:0;

integer i;
integer J;

//FIFO Write
always @(posedge W_CLK or negedge W_RST) 
begin
    if (!W_RST)
    begin
        w_ptr <= 0;
        for(i=0; i<DEPTH; i=i+1)
        begin
            FIFO_MEMORY [i] <= 0;
        end
    end
    else if (!FULL && W_INC)
    begin
        FIFO_MEMORY [w_addr] <= W_DATA;
        w_ptr <= w_ptr + 1;
    end
end

//FIFO Read 
always @(posedge R_CLK or negedge R_RST) 
begin
    if (!R_RST)     
    begin 
        r_ptr <= 0;             
    end
    else if (R_INC && !EMPTY) 
    begin 
        r_ptr <= r_ptr + 1;   
    end
end

//r2w sync
always @ (posedge W_CLK or negedge W_RST)
begin
    if(!W_RST)
    begin
        for (i=0; i<ptr_width; i=i+1)
        begin
             Multi_ff_1[i] <= 1'b0;
        end
        sync_r_ptr <= 0;
    end
    else
    begin
        for (i=0; i<ptr_width; i=i+1)
        begin
            Multi_ff_1 [i][2-2] <= gray_r_ptr [i];
        end
        for (J=0; J<ptr_width; J=J+1)
        begin
            for (i=2; i>1; i=i-1)
            begin
                Multi_ff_1 [J][i-3] <= Multi_ff_1 [J][i-2];
            end
            sync_r_ptr [J] <= Multi_ff_1 [J][0];
        end
    end
end

//w2r sync
always @ (posedge R_CLK or negedge R_RST)
begin
    if(!R_RST)
    begin
        for (i=0; i<ptr_width; i=i+1)
        begin
             Multi_ff_2[i] <= 1'b0;
        end
        sync_w_ptr <= 0;
    end
    else
    begin
        for (i=0; i<ptr_width; i=i+1)
        begin
            Multi_ff_2 [i][2-2] <= gray_w_ptr [i];
        end
        for (J=0; J<ptr_width; J=J+1)
        begin
            for (i=2; i>1; i=i-1)
            begin
                Multi_ff_2 [J][i-3] <= Multi_ff_2 [J][i-2];
            end
            sync_w_ptr [J] <= Multi_ff_2 [J][0];
        end
    end
end


//r_ptr gray coding
always @(*)
begin
    case (r_ptr)
    0:  gray_r_ptr = 4'b0000;
    1:  gray_r_ptr = 4'b0001;
    2:  gray_r_ptr = 4'b0011;
    3:  gray_r_ptr = 4'b0010; 
    4:  gray_r_ptr = 4'b0110;
    5:  gray_r_ptr = 4'b0111;
    6:  gray_r_ptr = 4'b0101;
    7:  gray_r_ptr = 4'b0100;

    8:  gray_r_ptr = 4'b1100;
    9:  gray_r_ptr = 4'b1101;
    10: gray_r_ptr = 4'b1111;
    11: gray_r_ptr = 4'b1110; 
    12: gray_r_ptr = 4'b1010;
    13: gray_r_ptr = 4'b1011;
    14: gray_r_ptr = 4'b1001;
    15: gray_r_ptr = 4'b1000;
    endcase
end

//w_ptr gray coding
always @(*)
begin
    case (w_ptr)
    0:  gray_w_ptr = 4'b0000;
    1:  gray_w_ptr = 4'b0001;
    2:  gray_w_ptr = 4'b0011;
    3:  gray_w_ptr = 4'b0010; 
    4:  gray_w_ptr = 4'b0110;
    5:  gray_w_ptr = 4'b0111;
    6:  gray_w_ptr = 4'b0101;
    7:  gray_w_ptr = 4'b0100;

    8:  gray_w_ptr = 4'b1100;
    9:  gray_w_ptr = 4'b1101;
    10: gray_w_ptr = 4'b1111;
    11: gray_w_ptr = 4'b1110; 
    12: gray_w_ptr = 4'b1010;
    13: gray_w_ptr = 4'b1011;
    14: gray_w_ptr = 4'b1001;
    15: gray_w_ptr = 4'b1000;
    endcase
end

endmodule


