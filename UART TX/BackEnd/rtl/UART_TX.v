module UART_TX (P_DATA, DATA_VALID, PAR_EN, PAR_TYP, CLK, RST, SI, SE, scan_clk, scan_rst, test_mode, SO, TX_OUT, BUSY);
input [7:0] P_DATA;
input       DATA_VALID;
input       PAR_EN;
input       PAR_TYP;
input       CLK;
input       RST;
input 	SI;
input 	SE;
input 	scan_clk;
input 	scan_rst;
input 	test_mode;
output 	SO;
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
wire 	    dft_clk_wire;
wire 	    dft_rst_wire;


/*DFT CLK_MUX INSTANTIATION*/
mux2X1 CLK_mux2x1 (
.IN_0(CLK),
.IN_1(scan_clk),
.SEL(test_mode),
.OUT(dft_clk_wire)
);


/*DFT RST_MUX INSTANTIATION*/
mux2X1 RST_mux2x1 (
.IN_0(RST),
.IN_1(scan_rst),
.SEL(test_mode),
.OUT(dft_rst_wire)
);


/*Serializer Block INSTANTIATION*/
Serializer_parityCalc DUT0 (
.P_DATA(P_DATA),
.ser_en(ser_en_wire),
.CLK(dft_clk_wire),
.RST(dft_rst_wire),
.PAR_TYP(PAR_TYP),
.par_bit(par_bit_wire),
.ser_data(ser_data_wire),
.ser_done(ser_done_wire)
);

TX_FSM DUT1 (
 .DATA_VALID(DATA_VALID),
 .ser_done(ser_done_wire),
 .PAR_EN(PAR_EN),
 .CLK(dft_clk_wire),
 .RST(dft_rst_wire),
 .ser_en(ser_en_wire),
 .mux_sel(mux_sel_wire),
 .BUSY(BUSY)
);

TX_MUX DUT2 (
.start_bit(start_bit_wire),
.stop_bit(stop_bit_wire),
.ser_data(ser_data_wire),
.par_bit(par_bit_wire),
.mux_sel(mux_sel_wire),
.CLK(dft_clk_wire),
.RST(dft_rst_wire),
.MUX_OUT(TX_OUT)
);

endmodule
