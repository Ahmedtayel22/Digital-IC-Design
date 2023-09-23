module TX_MUX (start_bit, stop_bit, ser_data, par_bit, mux_sel, CLK, RST, MUX_OUT);
input       start_bit;
input       stop_bit;
input       ser_data;
input       par_bit;
input [1:0] mux_sel;
input       CLK;
input       RST;
output      MUX_OUT;

reg         MUX_OUT;
reg         MUX_OUT_COMB;

parameter start_bit_mux  = 2'b00;
parameter stop_bit_mux   = 2'b11;
parameter ser_data_mux   = 2'b01;
parameter par_bit_mux    = 2'b10;

always @ (*)
begin
    if (mux_sel == start_bit_mux)
        MUX_OUT_COMB = start_bit;

    else if (mux_sel == stop_bit_mux)
        MUX_OUT_COMB = stop_bit;

    else if (mux_sel == ser_data_mux)
        MUX_OUT_COMB = ser_data;

    else if (mux_sel == par_bit_mux)
        MUX_OUT_COMB = par_bit;
    else
        MUX_OUT_COMB = 1'b1;
end

always @ (posedge CLK or negedge RST )
begin
    if(!RST)
    MUX_OUT <= stop_bit;
    else
    MUX_OUT <= MUX_OUT_COMB;
end
endmodule