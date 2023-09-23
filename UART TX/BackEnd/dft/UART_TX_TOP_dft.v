/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Wed Sep 20 03:17:13 2023
/////////////////////////////////////////////////////////////


module mux2X1_1 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(SEL), .Y(OUT) );
endmodule


module mux2X1_0 ( IN_0, IN_1, SEL, OUT );
  input IN_0, IN_1, SEL;
  output OUT;


  MX2X2M U1 ( .A(IN_0), .B(IN_1), .S0(SEL), .Y(OUT) );
endmodule


module Serializer_parityCalc_test_1 ( P_DATA, ser_en, PAR_TYP, CLK, RST, 
        ser_data, ser_done, par_bit, test_si, test_se );
  input [7:0] P_DATA;
  input ser_en, PAR_TYP, CLK, RST, test_si, test_se;
  output ser_data, ser_done, par_bit;
  wire   N4, N5, N6, N13, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36,
         n37, n38, n39, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24,
         n25, n26, n40, n41, n43;
  wire   [7:0] registers;

  SDFFRQX2M ser_data_reg ( .D(n27), .SI(registers[7]), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(ser_data) );
  SDFFRQX2M registers_reg_4_ ( .D(n32), .SI(registers[3]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(registers[4]) );
  SDFFRQX2M registers_reg_0_ ( .D(n28), .SI(n16), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(registers[0]) );
  SDFFRQX2M registers_reg_2_ ( .D(n30), .SI(registers[1]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(registers[2]) );
  SDFFRQX2M registers_reg_3_ ( .D(n31), .SI(registers[2]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(registers[3]) );
  SDFFRQX2M counter_reg_2_ ( .D(n38), .SI(n18), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(N6) );
  SDFFRQX2M ser_done_reg ( .D(n37), .SI(ser_data), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(ser_done) );
  SDFFRQX2M counter_reg_1_ ( .D(n36), .SI(n19), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(N5) );
  SDFFRQX2M counter_reg_0_ ( .D(n39), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(N4) );
  SDFFRQX2M registers_reg_5_ ( .D(n33), .SI(registers[4]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(registers[5]) );
  SDFFRQX2M registers_reg_1_ ( .D(n29), .SI(registers[0]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(registers[1]) );
  SDFFRQX2M registers_reg_6_ ( .D(n34), .SI(registers[5]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(registers[6]) );
  MX4X1M U41 ( .A(registers[4]), .B(registers[5]), .C(registers[6]), .D(
        registers[7]), .S0(N4), .S1(N5), .Y(n14) );
  MX4X1M U40 ( .A(registers[0]), .B(registers[1]), .C(registers[2]), .D(
        registers[3]), .S0(N4), .S1(N5), .Y(n15) );
  MX2X2M U39 ( .A(n15), .B(n14), .S0(N6), .Y(N13) );
  SDFFRQX1M registers_reg_7_ ( .D(n35), .SI(registers[6]), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(registers[7]) );
  INVX2M U17 ( .A(n43), .Y(n20) );
  BUFX2M U18 ( .A(ser_en), .Y(n43) );
  OAI22X1M U19 ( .A0(n40), .A1(n20), .B0(n16), .B1(n25), .Y(n37) );
  AOI21X2M U20 ( .A0(n19), .A1(n40), .B0(n20), .Y(n41) );
  INVX2M U21 ( .A(n40), .Y(n17) );
  XOR3XLM U22 ( .A(n21), .B(n22), .C(PAR_TYP), .Y(par_bit) );
  XOR3XLM U23 ( .A(registers[1]), .B(registers[0]), .C(n23), .Y(n22) );
  XOR3XLM U24 ( .A(registers[5]), .B(registers[4]), .C(n24), .Y(n21) );
  CLKXOR2X2M U25 ( .A(registers[3]), .B(registers[2]), .Y(n23) );
  AO22X1M U26 ( .A0(registers[6]), .A1(n43), .B0(P_DATA[6]), .B1(n20), .Y(n34)
         );
  AO22X1M U27 ( .A0(registers[1]), .A1(n43), .B0(P_DATA[1]), .B1(n20), .Y(n29)
         );
  AO22X1M U28 ( .A0(registers[5]), .A1(n43), .B0(P_DATA[5]), .B1(n20), .Y(n33)
         );
  AO22X1M U29 ( .A0(registers[3]), .A1(n43), .B0(P_DATA[3]), .B1(n20), .Y(n31)
         );
  AO22X1M U30 ( .A0(registers[7]), .A1(n43), .B0(P_DATA[7]), .B1(n20), .Y(n35)
         );
  AO22X1M U31 ( .A0(registers[2]), .A1(n43), .B0(P_DATA[2]), .B1(n20), .Y(n30)
         );
  AO22X1M U32 ( .A0(registers[0]), .A1(n43), .B0(P_DATA[0]), .B1(n20), .Y(n28)
         );
  AO22X1M U33 ( .A0(registers[4]), .A1(n43), .B0(P_DATA[4]), .B1(n20), .Y(n32)
         );
  OAI32X1M U34 ( .A0(n19), .A1(N5), .A2(n17), .B0(n41), .B1(n18), .Y(n36) );
  NOR2X2M U35 ( .A(ser_done), .B(n20), .Y(n40) );
  OAI22X1M U36 ( .A0(n43), .A1(n19), .B0(N4), .B1(n17), .Y(n39) );
  OAI22X1M U37 ( .A0(N6), .A1(n25), .B0(n26), .B1(n16), .Y(n38) );
  AOI21BX2M U38 ( .A0(n40), .A1(n18), .B0N(n41), .Y(n26) );
  NAND3X2M U42 ( .A(N4), .B(n40), .C(N5), .Y(n25) );
  AO22X1M U43 ( .A0(N13), .A1(n40), .B0(ser_data), .B1(n17), .Y(n27) );
  CLKXOR2X2M U44 ( .A(registers[7]), .B(registers[6]), .Y(n24) );
  INVX2M U45 ( .A(N4), .Y(n19) );
  INVX2M U46 ( .A(N6), .Y(n16) );
  INVX2M U47 ( .A(N5), .Y(n18) );
endmodule


module TX_FSM_test_1 ( DATA_VALID, ser_done, PAR_EN, ser_en, mux_sel, BUSY, 
        CLK, RST, test_si1, test_so1, test_se );
  output [1:0] mux_sel;
  input DATA_VALID, ser_done, PAR_EN, CLK, RST, test_si1, test_se;
  output ser_en, BUSY, test_so1;
  wire   current_state_1_, n10, n11, n12, n13, n14, n15, n16, n17, n18, n20,
         n21, n24;
  wire   [2:0] next_state;

  SDFFRX1M current_state_reg_0_ ( .D(next_state[0]), .SI(ser_done), .SE(
        test_se), .CK(CLK), .RN(RST), .Q(n24), .QN(n10) );
  SDFFRX1M current_state_reg_2_ ( .D(next_state[2]), .SI(current_state_1_), 
        .SE(test_se), .CK(CLK), .RN(RST), .Q(n13), .QN(test_so1) );
  NOR2X2M U10 ( .A(n12), .B(n20), .Y(ser_en) );
  NAND2X2M U11 ( .A(test_so1), .B(current_state_1_), .Y(mux_sel[1]) );
  OAI21BX1M U12 ( .A0(n18), .A1(n14), .B0N(ser_en), .Y(n21) );
  INVX2M U13 ( .A(DATA_VALID), .Y(n14) );
  NOR3X2M U14 ( .A(n13), .B(n16), .C(n12), .Y(next_state[0]) );
  NOR3X2M U15 ( .A(n15), .B(n10), .C(PAR_EN), .Y(n16) );
  INVX2M U16 ( .A(n17), .Y(n11) );
  AOI31X2M U17 ( .A0(DATA_VALID), .A1(n10), .A2(test_so1), .B0(n21), .Y(n17)
         );
  AND2X2M U19 ( .A(n10), .B(n13), .Y(n20) );
  OAI211X2M U20 ( .A0(n10), .A1(n13), .B0(n18), .C0(current_state_1_), .Y(
        mux_sel[0]) );
  AOI211X2M U21 ( .A0(test_so1), .A1(n15), .B0(n12), .C0(n10), .Y(
        next_state[2]) );
  NAND2X2M U22 ( .A(n20), .B(current_state_1_), .Y(n18) );
  INVX2M U23 ( .A(ser_done), .Y(n15) );
  SDFFRX1M current_state_reg_1_ ( .D(n11), .SI(n24), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(current_state_1_), .QN(n12) );
  SDFFRHQX8M BUSY_reg ( .D(n21), .SI(test_si1), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(BUSY) );
endmodule


module TX_MUX_test_1 ( start_bit, stop_bit, ser_data, par_bit, mux_sel, CLK, 
        RST, MUX_OUT, test_si, test_se );
  input [1:0] mux_sel;
  input start_bit, stop_bit, ser_data, par_bit, CLK, RST, test_si, test_se;
  output MUX_OUT;
  wire   MUX_OUT_WIRE, n2, n3, n4;

  INVX2M U7 ( .A(mux_sel[0]), .Y(n2) );
  OAI2B2X1M U8 ( .A1N(mux_sel[1]), .A0(n3), .B0(mux_sel[1]), .B1(n4), .Y(
        MUX_OUT_WIRE) );
  AOI22X1M U9 ( .A0(start_bit), .A1(n2), .B0(ser_data), .B1(mux_sel[0]), .Y(n4) );
  AOI22X1M U10 ( .A0(par_bit), .A1(n2), .B0(stop_bit), .B1(mux_sel[0]), .Y(n3)
         );
  SDFFSHQX8M MUX_OUT_reg ( .D(MUX_OUT_WIRE), .SI(test_si), .SE(test_se), .CK(
        CLK), .SN(RST), .Q(MUX_OUT) );
endmodule


module UART_TX ( P_DATA, DATA_VALID, PAR_EN, PAR_TYP, CLK, RST, SI, SE, 
        scan_clk, scan_rst, test_mode, SO, TX_OUT, BUSY );
  input [7:0] P_DATA;
  input DATA_VALID, PAR_EN, PAR_TYP, CLK, RST, SI, SE, scan_clk, scan_rst,
         test_mode;
  output SO, TX_OUT, BUSY;
  wire   BUSY, dft_clk_wire, dft_rst_wire, ser_en_wire, par_bit_wire,
         ser_data_wire, ser_done_wire, n2;
  wire   [1:0] mux_sel_wire;
  assign SO = BUSY;

  mux2X1_1 CLK_mux2x1 ( .IN_0(CLK), .IN_1(scan_clk), .SEL(test_mode), .OUT(
        dft_clk_wire) );
  mux2X1_0 RST_mux2x1 ( .IN_0(RST), .IN_1(scan_rst), .SEL(test_mode), .OUT(
        dft_rst_wire) );
  Serializer_parityCalc_test_1 DUT0 ( .P_DATA(P_DATA), .ser_en(ser_en_wire), 
        .PAR_TYP(PAR_TYP), .CLK(dft_clk_wire), .RST(dft_rst_wire), .ser_data(
        ser_data_wire), .ser_done(ser_done_wire), .par_bit(par_bit_wire), 
        .test_si(SI), .test_se(SE) );
  TX_FSM_test_1 DUT1 ( .DATA_VALID(DATA_VALID), .ser_done(ser_done_wire), 
        .PAR_EN(PAR_EN), .ser_en(ser_en_wire), .mux_sel(mux_sel_wire), .BUSY(
        BUSY), .CLK(dft_clk_wire), .RST(dft_rst_wire), .test_si1(TX_OUT), 
        .test_so1(n2), .test_se(SE) );
  TX_MUX_test_1 DUT2 ( .start_bit(1'b0), .stop_bit(1'b1), .ser_data(
        ser_data_wire), .par_bit(par_bit_wire), .mux_sel(mux_sel_wire), .CLK(
        dft_clk_wire), .RST(dft_rst_wire), .MUX_OUT(TX_OUT), .test_si(n2), 
        .test_se(SE) );
endmodule

