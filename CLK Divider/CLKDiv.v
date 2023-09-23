
/////////////////////////////////////////////////////////////
////////////////////////// CLKDiv ///////////////////////////
/////////////////////////////////////////////////////////////

module CLKDiv #(parameter max_div_bits = 4)
    (i_ref_clk, i_rst_n, i_clk_en, i_div_ratio, o_div_clk);

    input                      i_ref_clk;
    input                      i_rst_n;
    input                      i_clk_en;
    input  [max_div_bits-1:0]  i_div_ratio;
    output                     o_div_clk;
    
    reg                        o_div_clk_wire;
    reg                        o_div_clk;
    reg                        rst_mux;
    reg    [max_div_bits-1:0]  counter;
 
    always @(posedge i_ref_clk or negedge i_rst_n) 
    begin
        if(!i_rst_n)
        begin
            o_div_clk_wire <= 0;
            counter <= 0;
            rst_mux <= 0;
        end
        else if(i_div_ratio !=0 && i_div_ratio!=1 && i_clk_en == 1)
        begin
            rst_mux <= 1;
            if (i_div_ratio[0] != 1)
            begin
                if (counter == (i_div_ratio>>1))                                      
                begin
                    o_div_clk_wire <= ~(o_div_clk_wire);
                    counter <= 1;  
                end
                else
                begin
                    counter <= counter +1;
                end
            end
            else if (i_div_ratio[0] == 1)
            begin
                if (counter == (i_div_ratio>>1))                                      
                begin
                    o_div_clk_wire <= ~(o_div_clk_wire);
                    counter <= counter + 1;   
                end
                else if (counter == (i_div_ratio))
                begin
                    o_div_clk_wire <= ~(o_div_clk_wire);
                    counter <= 1;
                end
                else
                begin
                    counter <= counter +1;
                end
            end
        end
        else
        begin
            rst_mux <= 1;
        end
    end

always @ (*)
begin
    if(!rst_mux)
    begin
        o_div_clk = 0;
    end
    else if(i_div_ratio !=0 && i_div_ratio!=1 && i_clk_en == 1)
    begin
        o_div_clk = o_div_clk_wire;
    end
    else  if (i_clk_en)
    begin
        o_div_clk = i_ref_clk;
    end
    else
    o_div_clk = i_ref_clk;
end
endmodule
