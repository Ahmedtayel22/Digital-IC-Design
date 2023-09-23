module data_sampling (RX_IN, edge_cnt, enable, Prescale, CLK, RST, sampled_bit, DONE);
input       RX_IN;
input [5:0] edge_cnt;
input       enable;
input [5:0] Prescale;
input       CLK;
input       RST;
output      sampled_bit;
output      DONE;


reg        sampled_bit;
reg        DONE;
reg  [2:0] samples;

wire  [4:0] middleEdge;
wire  [1:0] addition;
assign middleEdge = (Prescale >> 1);
assign addition   = samples[0] + samples[1] + samples[2];

always @ (posedge CLK or negedge RST)
begin
    if (!RST)
    begin
        samples     <= 3'b0;
        sampled_bit <= 1'b0;  
	DONE 	    <= 1'b0;
    end
    else if (enable)
    begin
        case (edge_cnt)
        (middleEdge - 1): 
        begin
            samples[0] <= RX_IN;
        end
        (middleEdge):
        begin
            samples[1] <= RX_IN;
        end
        (middleEdge + 1):
        begin
            samples[2] <= RX_IN;
        end
        endcase
        if(edge_cnt == (middleEdge + 1))
        begin
            DONE <= 1;
            if (addition[1] == 1)
            begin
                sampled_bit  <= 1'b1;
            end
            else
            begin
                sampled_bit  <= 1'b0;
            end
        end
        else
        begin
            DONE <= 0;
        end  
    end
    else
    begin
    sampled_bit  <= 1'b0;
    DONE         <= 0;
    end
end
endmodule
