module deserializer_parityCalc 
(sampled_bit, bit_cnt, deser_en, PAR_TYP, par_chk_en, data_valid_en, CLK, RST,
P_DATA, calculated_par_bit);
input         sampled_bit;
input  [3:0]  bit_cnt;
input         deser_en;
input         PAR_TYP;
input         par_chk_en;
input         data_valid_en;
input         CLK;
input         RST;
output [7:0]  P_DATA;
output        calculated_par_bit;

reg [7:0] P_DATA;
reg       calculated_par_bit;
reg [7:0] registers;
reg       value;

parameter EVEN = 0;
parameter ODD = 1;

always @(posedge CLK or negedge RST)
begin
    if(!RST)
    begin
        P_DATA    <= 8'b0;
        registers <= 8'b0;
    end
    else if (deser_en)
    begin
        registers[bit_cnt-1] <= sampled_bit;
    end
    else if (data_valid_en) 
    begin
        P_DATA <= registers;
    end
end

always @(*)
  begin
    if (par_chk_en)
      begin
        value = ^registers;
        case (PAR_TYP)
        EVEN:
        begin
          if(value == 1'b0)
          begin
            calculated_par_bit = 1'b0;
          end
          else
          begin
           calculated_par_bit = 1'b1;
          end 
          end
        ODD:
        begin
          if(value == 1'b1)
          begin
            calculated_par_bit = 1'b0;
          end
          else
          begin
            calculated_par_bit = 1'b1;
          end 
        end
      endcase
    end 
    else
    begin
      calculated_par_bit = 1'b0;
      value = 1'b0;
    end
  end
endmodule

