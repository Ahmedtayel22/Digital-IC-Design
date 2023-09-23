module UART_TX 
(P_DATA, DATA_VALID, PAR_EN, PAR_TYP, CLK, RST, TX_OUT, BUSY);
input [7:0] P_DATA;
input       DATA_VALID;
input       PAR_EN;
input       PAR_TYP;
input       CLK;
input       RST;
output      TX_OUT;
output      BUSY;


wire        TX_OUT;
wire        BUSY;
wire        ser_done_wire;
wire        ser_en_wire;
wire        ser_data_wire;
wire [1:0]  mux_sel_wire;
wire        par_bit_wire;
wire        start_bit_wire = 0;
wire        stop_bit_wire  = 1;

/*Serializer Block INSTANTIATION*/
TX_Serializer TX_Serializer (
.P_DATA(P_DATA),
.ser_en(ser_en_wire),
.CLK(CLK),
.RST(RST),
.PAR_TYP(PAR_TYP),
.par_bit(par_bit_wire),
.ser_data(ser_data_wire),
.ser_done(ser_done_wire)
);

TX_FSM TX_FSM (
 .DATA_VALID(DATA_VALID),
 .ser_done(ser_done_wire),
 .PAR_EN(PAR_EN),
 .CLK(CLK),
 .RST(RST),
 .ser_en(ser_en_wire),
 .mux_sel(mux_sel_wire),
 .BUSY(BUSY)
);

TX_MUX TX_MUX (
.start_bit(start_bit_wire),
.stop_bit(stop_bit_wire),
.ser_data(ser_data_wire),
.par_bit(par_bit_wire),
.mux_sel(mux_sel_wire),
.CLK(CLK),
.RST(RST),
.MUX_OUT(TX_OUT)
);

endmodule
