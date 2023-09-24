
//****************************************************//
//********************* Timer ************************//
//****************************************************//

module Timer #(parameter delay_time = 100, counter_width = 8)
(timer_EN, CLK, RST, timer_DONE);
input timer_EN;
input CLK;
input RST;
output timer_DONE;

reg timer_DONE;
reg [counter_width-1:0] counter;

always @(posedge CLK or negedge RST) 
begin
    if(!RST)
    begin
        timer_DONE <= 0;
        counter <= 0;
    end
    else if (timer_EN)
    begin
        counter <= counter + 1;
        if (counter == delay_time) 
        begin 
            counter <= 0;
            timer_DONE <= 1;
        end
    end
    else
    begin
        timer_DONE <= 0;
        counter <= 0;
    end
end
endmodule