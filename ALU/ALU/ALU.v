
/////////////////////////////////////////////////////////////
//////////////////////////// ALU ////////////////////////////
/////////////////////////////////////////////////////////////

module ALU #(parameter WIDTH = 8, OUT_WIDTH = 8)
(a, b, ALU_FUN, Enable, REF_CLK, RST, ALU_OUT, OUT_VALID);
  
  input [WIDTH-1:0] a;
  input [WIDTH-1:0] b;
  input [3:0] ALU_FUN;
  input Enable;
  input REF_CLK;
  input RST;
  output [OUT_WIDTH-1:0] ALU_OUT;
  output OUT_VALID;
  
  reg [OUT_WIDTH-1:0] ALU_OUT;
  reg OUT_VALID;

  always@(posedge REF_CLK or negedge RST)
  begin
    if(!RST)
    begin
      ALU_OUT   <= 'b0;
    end
    else if (Enable)
    begin
      case (ALU_FUN)
      4'b0000:  begin ALU_OUT <= a+b;   OUT_VALID <= 1;  end
      4'b0001:  begin ALU_OUT <= a-b;   OUT_VALID <= 1;  end
      4'b0010:  begin ALU_OUT <= a*b;   OUT_VALID <= 1;  end
      4'b0011:  begin ALU_OUT <= a/b;   OUT_VALID <= 1;  end
        
      4'b0100:  begin ALU_OUT <= a&b;    OUT_VALID <= 1; end
      4'b0101:  begin ALU_OUT <= a|b;    OUT_VALID <= 1; end
      4'b0110:  begin ALU_OUT <= ~(a&b); OUT_VALID <= 1; end
      4'b0111:  begin ALU_OUT <= ~(a|b); OUT_VALID <= 1; end
      4'b1000:  begin ALU_OUT <= (a^b);  OUT_VALID <= 1; end
      4'b1001:  begin ALU_OUT <= ~(a^b); OUT_VALID <= 1; end
        
      4'b1010:  begin ALU_OUT <= a==b? 1:0; OUT_VALID <= 1; end
      4'b1011:  begin ALU_OUT <= a>b?  2:0; OUT_VALID <= 1; end
      4'b1100:  begin ALU_OUT <= a<b?  3:0; OUT_VALID <= 1; end
        
      4'b1101:  begin ALU_OUT <= a>>'b1; OUT_VALID <= 1; end
      4'b1110:  begin ALU_OUT <= a<<'b1; OUT_VALID <= 1; end
      default   begin ALU_OUT <= 'b0;    OUT_VALID <= 1; end
      endcase
    end
    else
    OUT_VALID <= 0;
end
endmodule




  
  
