module UART_RX (RX_IN, Prescale, PAR_EN, PAR_TYP, CLK, RST, SI, SE, scan_clk, scan_rst, test_mode, SO, P_DATA, data_valid);
input         RX_IN;
input  [5:0]  Prescale;
input         PAR_EN;
input         PAR_TYP;
input         CLK;
input         RST;
input SI;
input SE;
input scan_clk;
input scan_rst;
input test_mode;
output SO;
output [7:0]  P_DATA;
output        data_valid;

wire  [5:0] edge_cnt_wire;
wire  [3:0] bit_cnt_wire;
wire        strt_chk_en_wire;
wire        strt_glitch_wire;
wire        par_chk_en_wire;
wire        par_err_wire;
wire        stp_chk_en_wire;
wire        stp_err_wire;
wire        enable_wire;
wire        sampled_bit_wire;
wire        deser_en_wire;
wire        calculated_par_bit_wire;
wire        data_valid_en_wire;
wire 	    dft_clk_wire;
wire 	    dft_rst_wire;
wire 	    DONE_wire;

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

FSM FSM (
    .RX_IN(RX_IN),
    .PAR_EN(PAR_EN),
    .bit_cnt(bit_cnt_wire),
    .par_err(par_err_wire),
    .strt_glitch(strt_glitch_wire),
    .stp_err(stp_err_wire),
    .CLK(dft_clk_wire),
    .RST(dft_rst_wire),
    .enable(enable_wire),
    .deser_en(deser_en_wire),
    .data_valid(data_valid),
    .strt_chk_en(strt_chk_en_wire),
    .par_chk_en(par_chk_en_wire),
    .stp_chk_en(stp_chk_en_wire),
    .data_valid_en(data_valid_en_wire)
);

edge_bit_counter counter (
    .enable(enable_wire),
    .Prescale(Prescale),
    .CLK(dft_clk_wire),
    .RST(dft_rst_wire),
    .bit_cnt(bit_cnt_wire),
    .edge_cnt(edge_cnt_wire)
);

data_sampling sampler (
    .RX_IN(RX_IN),
    .edge_cnt(edge_cnt_wire),
    .enable(enable_wire),
    .Prescale(Prescale),
    .CLK(dft_clk_wire),
    .RST(dft_rst_wire),
    .DONE(DONE_wire),
    .sampled_bit(sampled_bit_wire)
);

deserializer_parityCalc deserializer_parityCalc (
    .sampled_bit(sampled_bit_wire),
    .bit_cnt(bit_cnt_wire),
    .deser_en(deser_en_wire),
    .PAR_TYP(PAR_TYP),
    .par_chk_en(par_chk_en_wire),
    .data_valid_en(data_valid_en_wire),
    .CLK(dft_clk_wire),
    .RST(dft_rst_wire),
    .P_DATA(P_DATA),
    .calculated_par_bit(calculated_par_bit_wire)
);

strt_checker strt_checker (
    .sampled_bit(sampled_bit_wire),
    .strt_chk_en(strt_chk_en_wire),
    .CLK(dft_clk_wire),
    .RST(dft_rst_wire),
    .clearFlag(enable_wire),
    .DONE(DONE_wire),
    .strt_glitch(strt_glitch_wire)
);

par_checker par_checker (
    .sampled_bit(sampled_bit_wire),
    .par_chk_en(par_chk_en_wire),
    .calculated_par_bit(calculated_par_bit_wire),
    .CLK(dft_clk_wire),
    .RST(dft_rst_wire),
    .DONE(DONE_wire),
    .clearFlag(enable_wire),
    .par_err(par_err_wire)
);


stp_checker stp_checker (
    .sampled_bit(sampled_bit_wire),
    .stp_chk_en(stp_chk_en_wire),
    .CLK(dft_clk_wire),
    .RST(dft_rst_wire),
    .DONE(DONE_wire),
    .clearFlag(enable_wire),
    .stp_err(stp_err_wire)
);
endmodule
