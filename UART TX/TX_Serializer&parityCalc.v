module TX_Serializer (P_DATA, ser_en, PAR_TYP, CLK, RST, ser_data, ser_done, par_bit);
input [7:0] P_DATA;
input       ser_en;
input       PAR_TYP;
input       CLK;
input       RST;

output      par_bit;
output      ser_data;
output      ser_done;

reg         par_bit;
reg         ser_data;
reg         ser_done;
reg   [2:0] counter;
reg   [7:0] registers;
reg         value;
parameter even = 0;
parameter odd = 1;

/*Serializer Block*/
always@(posedge CLK or negedge RST)
    begin  
        if (!RST)
        begin
            ser_data   <= 0;
            ser_done   <= 0;
            counter    <= 0;
            registers  <=0;
        end
        else if (!ser_en)
        begin
            ser_done <= 0;
            registers <= P_DATA;  
        end
        else if (ser_en == 1 && ser_done == 0)
        begin
            ser_done <= 0;
            ser_data <= registers[counter];
            if (counter == 7) begin ser_done <= 1; end
            counter <= counter + 1;
        end
        else 
        counter <=0;
    end
    
    always @ (*)
    begin
        value = ^registers;
        case (PAR_TYP)
        even:
        begin
          if(value == 1'b0)
          begin
            par_bit = 1'b0;
          end
          else
          begin
           par_bit = 1'b1;
          end 
          end
        odd:
        begin
          if(value == 1'b1)
          begin
            par_bit = 1'b0;
          end
          else
          begin
            par_bit = 1'b1;
          end 
        end
        default:
        begin
            par_bit = 1'b0;
        end
      endcase
    end
endmodule
