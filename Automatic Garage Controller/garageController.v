module garageController (up_max, activate, dn_max, clk, rst, up_m, dn_m);
input up_max;
input dn_max;
input activate;
input clk;
input rst;

output up_m;
output dn_m;

reg up_m;
reg dn_m;
reg [2:0] state;
reg [2:0] next_state;

localparam idle = 3'b001;
localparam mv_up = 3'b010;
localparam mv_dn = 3'b100;

always@(*)
    begin
        case (state)
        idle:
            begin
               if( activate == 0) 
               next_state = idle;
               else if ( activate == 1 && dn_max == 1 && up_max == 0 )
               next_state = mv_up;
               else if ( activate == 1 && dn_max == 0 && up_max == 1 )
               next_state = mv_dn;
               else
               next_state = next_state;
            end

            mv_up:
                begin
                    if ( up_max == 1)
                    next_state = idle;
                    else
                    next_state = next_state;
                end
            mv_dn:
                begin
                    if( dn_max == 1 )
                    next_state = idle;
                    else 
                    next_state = next_state;
                end
            default
                begin
                    next_state = 3'bx;
                end
        endcase
    end

always@(posedge clk or negedge rst)
    begin
        if(!rst)
        state <= idle;
        else
        state <= next_state;
    end

always@(*)
    begin
        
        case (state)
        idle:
        begin
            up_m = 0;
            dn_m = 0;
        end
         mv_up:
         begin
            up_m = 1;
            dn_m = 0;
         end
         mv_dn:
         begin
            up_m = 0;
            dn_m = 1;
         end
        default
        begin
            up_m = up_m;
            dn_m = dn_m;
        end
        endcase
    end
endmodule   