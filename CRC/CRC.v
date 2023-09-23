module CRC
#(parameter sead = 8'hD8, LSFRs = 7)
(data, active, CLK, RST, crc, valid);
input  data;
input  active;
input  CLK;
input  RST;
output crc;
output valid;

reg crc;
reg valid;
reg [7:0] registers;
reg [3:0] i;
reg [3:0] j;

always@(posedge CLK or negedge RST)
begin
    if(!RST)
    begin
        registers <= sead;
        valid     <= 1'b0;
        crc       <= 1'b0;
        i         <= 1'b0;
        j         <= 1'b0;
    end
    else if (active == 1)
    begin
            valid <= 0;
            j     <= j+1;
            registers[7]    <= registers[0]^data;
            registers[6]    <= registers[7]^(registers[0]^data);
            registers[5:3]  <= registers[6:4];
            registers[2]    <= registers[3]^(registers[0]^data);
            registers[1:0]  <= registers[2:1];
    end
    else if (active == 0 && i < (LSFRs+1) && j==(LSFRs+1))
    begin
        valid <= 1'b1;
        {registers[6:0],crc} <= registers;
        i <= i+1;
        if (i==LSFRs)
         begin 
            valid     <= 1'b0; 
            i         <= 4'b0;
            j         <= 4'b0;
            registers <= sead;
         end
    end 
end
endmodule