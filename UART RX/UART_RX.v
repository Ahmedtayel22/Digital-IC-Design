module UART_RX 
(RX_IN, Prescale, PAR_EN, PAR_TYP,
CLK, RST, P_DATA, data_valid, strt_glitch, par_err, stp_err );
input         RX_IN;
input  [5:0]  Prescale;
input         PAR_EN;
input         PAR_TYP;
input         CLK;
input         RST;
output [7:0]  P_DATA;
output        data_valid;
output        strt_glitch;
output        par_err;
output        stp_err;


wire  [5:0] edge_cnt_wire;
wire  [3:0] bit_cnt_wire;
wire        strt_chk_en_wire;
wire        par_chk_en_wire;
wire        stp_chk_en_wire;
wire        enable_wire;
wire        sampled_bit_wire;
wire        deser_en_wire;
wire        calculated_par_bit_wire;
wire        data_valid_en_wire;
wire        DONE_wire;


FSM FSM (
    .RX_IN(RX_IN),
    .PAR_EN(PAR_EN),
    .bit_cnt(bit_cnt_wire),
    .Prescale(Prescale),
    .edge_cnt(edge_cnt_wire),
    .par_err(par_err),
    .strt_glitch(strt_glitch),
    .stp_err(stp_err),
    .CLK(CLK),
    .RST(RST),
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
    .CLK(CLK),
    .RST(RST),
    .bit_cnt(bit_cnt_wire),
    .edge_cnt(edge_cnt_wire)
);

data_sampling sampler (
    .RX_IN(RX_IN),
    .edge_cnt(edge_cnt_wire),
    .enable(enable_wire),
    .Prescale(Prescale),
    .CLK(CLK),
    .RST(RST),
    .sampled_bit(sampled_bit_wire),
    .DONE(DONE_wire)
);

deserializer_parityCalc deserializer_parityCalc (
    .sampled_bit(sampled_bit_wire),
    .bit_cnt(bit_cnt_wire),
    .deser_en(deser_en_wire),
    .PAR_TYP(PAR_TYP),
    .par_chk_en(par_chk_en_wire),
    .data_valid_en(data_valid_en_wire),
    .CLK(CLK),
    .RST(RST),
    .P_DATA(P_DATA),
    .calculated_par_bit(calculated_par_bit_wire)
);

strt_checker strt_checker (
    .sampled_bit(sampled_bit_wire),
    .strt_chk_en(strt_chk_en_wire),
    .CLK(CLK),
    .RST(RST),
    .clearFlag(enable_wire),
    .DONE(DONE_wire),
    .strt_glitch(strt_glitch)
);

par_checker par_checker (
    .sampled_bit(sampled_bit_wire),
    .par_chk_en(par_chk_en_wire),
    .calculated_par_bit(calculated_par_bit_wire),
    .CLK(CLK),
    .RST(RST),
    .clearFlag(enable_wire),
    .DONE(DONE_wire),
    .par_err(par_err)
);


stp_checker stp_checker (
    .sampled_bit(sampled_bit_wire),
    .stp_chk_en(stp_chk_en_wire),
    .CLK(CLK),
    .RST(RST),
    .DONE(DONE_wire),
    .clearFlag(enable_wire),
    .stp_err(stp_err)
);
endmodule
