/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06
// Date      : Sun Sep 24 02:16:38 2023
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


module FSM_test_1 ( RX_IN, PAR_EN, bit_cnt, par_err, strt_glitch, stp_err, CLK, 
        RST, enable, deser_en, data_valid, strt_chk_en, par_chk_en, stp_chk_en, 
        data_valid_en, test_si, test_se );
  input [3:0] bit_cnt;
  input RX_IN, PAR_EN, par_err, strt_glitch, stp_err, CLK, RST, test_si,
         test_se;
  output enable, deser_en, data_valid, strt_chk_en, par_chk_en, stp_chk_en,
         data_valid_en;
  wire   n15, n32, n33, n13, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25,
         n26, n27, n28, n29, n30, n31, n34, n35, n36, n37, n38, n39, n40, n45;
  wire   [2:0] next_state;

  SDFFRX1M current_state_reg_2_ ( .D(next_state[2]), .SI(n33), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(n45), .QN(n32) );
  SDFFRX1M current_state_reg_0_ ( .D(next_state[0]), .SI(test_si), .SE(test_se), .CK(CLK), .RN(RST), .Q(n17), .QN(n15) );
  SDFFRX1M current_state_reg_1_ ( .D(next_state[1]), .SI(n15), .SE(test_se), 
        .CK(CLK), .RN(RST), .Q(n18), .QN(n33) );
  INVX2M U11 ( .A(n27), .Y(par_chk_en) );
  OAI221X1M U12 ( .A0(n25), .A1(n26), .B0(n27), .B1(n20), .C0(n13), .Y(
        next_state[2]) );
  OR4X1M U13 ( .A(strt_chk_en), .B(stp_chk_en), .C(deser_en), .D(par_chk_en), 
        .Y(enable) );
  NOR2X2M U14 ( .A(n18), .B(n38), .Y(strt_chk_en) );
  NAND2X2M U15 ( .A(n16), .B(n18), .Y(n27) );
  INVX2M U16 ( .A(n26), .Y(deser_en) );
  NAND3X2M U17 ( .A(n19), .B(n22), .C(n31), .Y(n25) );
  INVX2M U18 ( .A(n28), .Y(n20) );
  INVX2M U19 ( .A(n38), .Y(n16) );
  INVX2M U20 ( .A(stp_chk_en), .Y(n13) );
  NOR3X2M U21 ( .A(n18), .B(n32), .C(n17), .Y(stp_chk_en) );
  NOR3X2M U22 ( .A(n23), .B(bit_cnt[2]), .C(n21), .Y(n31) );
  NOR4X1M U23 ( .A(n22), .B(n21), .C(bit_cnt[0]), .D(bit_cnt[2]), .Y(n28) );
  AOI22X1M U24 ( .A0(n30), .A1(n16), .B0(RX_IN), .B1(n38), .Y(n37) );
  NOR4X1M U25 ( .A(n23), .B(bit_cnt[1]), .C(bit_cnt[2]), .D(bit_cnt[3]), .Y(
        n30) );
  INVX2M U26 ( .A(bit_cnt[1]), .Y(n22) );
  INVX2M U27 ( .A(bit_cnt[0]), .Y(n23) );
  NAND2X2M U28 ( .A(n32), .B(n17), .Y(n38) );
  NAND3X2M U29 ( .A(n32), .B(n18), .C(n15), .Y(n26) );
  INVX2M U30 ( .A(bit_cnt[3]), .Y(n21) );
  OAI21X2M U31 ( .A0(n28), .A1(n27), .B0(n29), .Y(next_state[1]) );
  AOI32X1M U32 ( .A0(strt_chk_en), .A1(n24), .A2(n30), .B0(n25), .B1(deser_en), 
        .Y(n29) );
  INVX2M U33 ( .A(strt_glitch), .Y(n24) );
  INVX2M U34 ( .A(PAR_EN), .Y(n19) );
  NAND3X2M U35 ( .A(n34), .B(n35), .C(n36), .Y(next_state[0]) );
  NAND3X2M U36 ( .A(n31), .B(n39), .C(PAR_EN), .Y(n34) );
  OAI211X2M U37 ( .A0(n32), .A1(n17), .B0(n33), .C0(n37), .Y(n35) );
  AOI32X1M U38 ( .A0(n28), .A1(n19), .A2(stp_chk_en), .B0(par_chk_en), .B1(n20), .Y(n36) );
  OAI22X1M U39 ( .A0(bit_cnt[1]), .A1(n26), .B0(n22), .B1(n13), .Y(n39) );
  NOR4X1M U40 ( .A(n40), .B(n32), .C(stp_err), .D(par_err), .Y(data_valid_en)
         );
  NAND2X2M U41 ( .A(n33), .B(n17), .Y(n40) );
  SDFFRHQX8M data_valid_reg ( .D(data_valid_en), .SI(n45), .SE(test_se), .CK(
        CLK), .RN(RST), .Q(data_valid) );
endmodule


module edge_bit_counter_test_1 ( enable, Prescale, CLK, RST, bit_cnt, edge_cnt, 
        test_si, test_se );
  input [5:0] Prescale;
  output [3:0] bit_cnt;
  output [5:0] edge_cnt;
  input enable, CLK, RST, test_si, test_se;
  wire   N21, N22, N23, N24, N32, N33, N34, N35, N36, N37, n28, n30, n31, n46,
         n47, n48, n49, n26, n27, n33, n34, n35, n36, n37, n38, n39, n40, n41,
         n42, n43, n44, n45, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67;
  wire   [5:2] add_26_carry;

  SDFFRQX2M edge_cnt_reg_5_ ( .D(N37), .SI(edge_cnt[4]), .SE(test_se), .CK(CLK), .RN(RST), .Q(edge_cnt[5]) );
  SDFFRQX2M edge_cnt_reg_2_ ( .D(N34), .SI(edge_cnt[1]), .SE(test_se), .CK(CLK), .RN(RST), .Q(edge_cnt[2]) );
  SDFFRQX2M edge_cnt_reg_3_ ( .D(N35), .SI(edge_cnt[2]), .SE(test_se), .CK(CLK), .RN(RST), .Q(edge_cnt[3]) );
  SDFFRQX2M edge_cnt_reg_4_ ( .D(N36), .SI(edge_cnt[3]), .SE(test_se), .CK(CLK), .RN(RST), .Q(edge_cnt[4]) );
  SDFFRQX2M edge_cnt_reg_1_ ( .D(N33), .SI(edge_cnt[0]), .SE(test_se), .CK(CLK), .RN(RST), .Q(edge_cnt[1]) );
  ADDHX1M U44 ( .A(edge_cnt[2]), .B(add_26_carry[2]), .CO(add_26_carry[3]), 
        .S(N22) );
  ADDHX1M U45 ( .A(edge_cnt[3]), .B(add_26_carry[3]), .CO(add_26_carry[4]), 
        .S(N23) );
  ADDHX1M U46 ( .A(edge_cnt[4]), .B(add_26_carry[4]), .CO(add_26_carry[5]), 
        .S(N24) );
  ADDHX1M U43 ( .A(edge_cnt[1]), .B(edge_cnt[0]), .CO(add_26_carry[2]), .S(N21) );
  SDFFRX1M bit_cnt_reg_1_ ( .D(n30), .SI(n46), .SE(test_se), .CK(CLK), .RN(RST), .Q(bit_cnt[1]), .QN(n47) );
  SDFFRX1M bit_cnt_reg_0_ ( .D(n31), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(bit_cnt[0]), .QN(n46) );
  SDFFRX1M bit_cnt_reg_3_ ( .D(n28), .SI(n48), .SE(test_se), .CK(CLK), .RN(RST), .Q(bit_cnt[3]), .QN(n49) );
  SDFFRX1M bit_cnt_reg_2_ ( .D(n26), .SI(n47), .SE(test_se), .CK(CLK), .RN(RST), .Q(bit_cnt[2]), .QN(n48) );
  SDFFRQX2M edge_cnt_reg_0_ ( .D(N32), .SI(n49), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(edge_cnt[0]) );
  OAI21X2M U23 ( .A0(n59), .A1(n35), .B0(n60), .Y(n58) );
  INVX2M U24 ( .A(n37), .Y(n27) );
  NAND2X2M U25 ( .A(n59), .B(n35), .Y(n60) );
  INVX2M U26 ( .A(enable), .Y(n33) );
  NOR2X2M U27 ( .A(n67), .B(Prescale[2]), .Y(n59) );
  NOR2X2M U28 ( .A(n33), .B(n45), .Y(n37) );
  AOI21X2M U29 ( .A0(Prescale[4]), .A1(n60), .B0(n55), .Y(n65) );
  NOR2X2M U30 ( .A(n60), .B(Prescale[4]), .Y(n55) );
  INVX2M U31 ( .A(Prescale[1]), .Y(n36) );
  AOI21X2M U32 ( .A0(Prescale[2]), .A1(n67), .B0(n59), .Y(n66) );
  NOR2BX2M U33 ( .AN(N21), .B(n27), .Y(N33) );
  NOR2BX2M U34 ( .AN(N22), .B(n27), .Y(N34) );
  NOR2BX2M U35 ( .AN(N23), .B(n27), .Y(N35) );
  NOR2BX2M U36 ( .AN(N24), .B(n27), .Y(N36) );
  INVX2M U37 ( .A(Prescale[3]), .Y(n35) );
  INVX2M U38 ( .A(Prescale[5]), .Y(n34) );
  INVX2M U39 ( .A(n40), .Y(n26) );
  AOI32X1M U40 ( .A0(n48), .A1(n27), .A2(n41), .B0(bit_cnt[2]), .B1(n42), .Y(
        n40) );
  AOI211X2M U41 ( .A0(n55), .A1(n34), .B0(n56), .C0(n57), .Y(n54) );
  OAI2B2X1M U42 ( .A1N(Prescale[0]), .A0(n61), .B0(Prescale[0]), .B1(n62), .Y(
        n56) );
  CLKXOR2X2M U47 ( .A(n58), .B(edge_cnt[3]), .Y(n57) );
  NOR2X2M U48 ( .A(edge_cnt[0]), .B(n64), .Y(n61) );
  AOI21X2M U49 ( .A0(enable), .A1(n46), .B0(n37), .Y(n39) );
  OAI2BB1X2M U50 ( .A0N(enable), .A1N(n47), .B0(n39), .Y(n42) );
  AND4X2M U51 ( .A(n51), .B(n52), .C(n53), .D(n54), .Y(n45) );
  CLKXOR2X2M U52 ( .A(edge_cnt[2]), .B(n66), .Y(n51) );
  XOR3XLM U53 ( .A(edge_cnt[5]), .B(n34), .C(n55), .Y(n53) );
  CLKXOR2X2M U54 ( .A(edge_cnt[4]), .B(n65), .Y(n52) );
  OAI21X2M U55 ( .A0(n49), .A1(n43), .B0(n44), .Y(n28) );
  NAND4X2M U56 ( .A(n49), .B(n45), .C(n41), .D(bit_cnt[2]), .Y(n44) );
  AOI21X2M U57 ( .A0(n48), .A1(enable), .B0(n42), .Y(n43) );
  NAND2BX2M U58 ( .AN(Prescale[0]), .B(n36), .Y(n67) );
  OAI32X1M U59 ( .A0(n38), .A1(n46), .A2(n37), .B0(n47), .B1(n39), .Y(n30) );
  NAND2X2M U60 ( .A(n47), .B(enable), .Y(n38) );
  OAI32X1M U61 ( .A0(bit_cnt[0]), .A1(n37), .A2(n33), .B0(n46), .B1(n27), .Y(
        n31) );
  NOR2BX2M U62 ( .AN(edge_cnt[0]), .B(n63), .Y(n62) );
  CLKXOR2X2M U63 ( .A(n36), .B(edge_cnt[1]), .Y(n63) );
  NOR2X2M U64 ( .A(edge_cnt[0]), .B(n27), .Y(N32) );
  NOR2X2M U65 ( .A(n50), .B(n27), .Y(N37) );
  XNOR2X2M U66 ( .A(edge_cnt[5]), .B(add_26_carry[5]), .Y(n50) );
  CLKXOR2X2M U67 ( .A(edge_cnt[1]), .B(Prescale[1]), .Y(n64) );
  NOR3X2M U68 ( .A(n46), .B(n47), .C(n33), .Y(n41) );
endmodule


module data_sampling_test_1 ( RX_IN, edge_cnt, enable, Prescale, CLK, RST, 
        sampled_bit, DONE, test_si, test_so, test_se );
  input [5:0] edge_cnt;
  input [5:0] Prescale;
  input RX_IN, enable, CLK, RST, test_si, test_se;
  output sampled_bit, DONE, test_so;
  wire   samples_0_, N17, N18, N19, N20, N21, n31, n40, n41, n42, n43, n9, n10,
         n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n28, n29,
         n30, n32, n33, n34, n35, n36, n37, n38, n39, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n54, n55, n56, n57;
  wire   [4:2] add_31_carry;

  SDFFRQX2M samples_reg_2_ ( .D(n43), .SI(n57), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(test_so) );
  SDFFRQX2M DONE_reg ( .D(n12), .SI(test_si), .SE(test_se), .CK(CLK), .RN(RST), 
        .Q(DONE) );
  ADDHX1M U16 ( .A(Prescale[3]), .B(add_31_carry[2]), .CO(add_31_carry[3]), 
        .S(N18) );
  ADDHX1M U14 ( .A(Prescale[2]), .B(Prescale[1]), .CO(add_31_carry[2]), .S(N17) );
  ADDHX1M U15 ( .A(Prescale[4]), .B(add_31_carry[3]), .CO(add_31_carry[4]), 
        .S(N19) );
  ADDHX1M U13 ( .A(Prescale[5]), .B(add_31_carry[4]), .CO(N21), .S(N20) );
  SDFFRX1M sampled_bit_reg ( .D(n40), .SI(DONE), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(sampled_bit), .QN(n31) );
  SDFFRQX2M samples_reg_0_ ( .D(n41), .SI(n31), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(samples_0_) );
  SDFFRQX2M samples_reg_1_ ( .D(n42), .SI(samples_0_), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(n57) );
  OAI21X2M U17 ( .A0(n45), .A1(n15), .B0(n39), .Y(n44) );
  NAND2X2M U18 ( .A(n45), .B(n15), .Y(n39) );
  INVX2M U19 ( .A(n18), .Y(n12) );
  INVX2M U20 ( .A(enable), .Y(n14) );
  OAI21X2M U21 ( .A0(Prescale[4]), .A1(n39), .B0(Prescale[5]), .Y(n46) );
  NOR2X2M U22 ( .A(Prescale[2]), .B(Prescale[1]), .Y(n45) );
  NAND2X2M U23 ( .A(enable), .B(n47), .Y(n18) );
  INVX2M U24 ( .A(n38), .Y(n13) );
  INVX2M U25 ( .A(Prescale[3]), .Y(n15) );
  OAI32X1M U26 ( .A0(n31), .A1(n47), .A2(n14), .B0(n48), .B1(n18), .Y(n40) );
  AOI21X2M U27 ( .A0(n57), .A1(test_so), .B0(n49), .Y(n48) );
  AOI2BB1X2M U28 ( .A0N(n57), .A1N(test_so), .B0(n9), .Y(n49) );
  NOR3X2M U29 ( .A(n36), .B(n13), .C(n37), .Y(n35) );
  XNOR2X2M U30 ( .A(n28), .B(Prescale[1]), .Y(n37) );
  OAI31X1M U31 ( .A0(n39), .A1(Prescale[5]), .A2(Prescale[4]), .B0(n11), .Y(
        n36) );
  INVX2M U32 ( .A(edge_cnt[5]), .Y(n11) );
  NOR4X1M U33 ( .A(edge_cnt[5]), .B(n14), .C(n28), .D(n29), .Y(n22) );
  NAND4X2M U34 ( .A(n32), .B(n33), .C(n34), .D(n35), .Y(n17) );
  CLKXOR2X2M U35 ( .A(n39), .B(n29), .Y(n34) );
  XNOR2X2M U36 ( .A(edge_cnt[2]), .B(n44), .Y(n33) );
  CLKXOR2X2M U37 ( .A(n46), .B(edge_cnt[4]), .Y(n32) );
  OAI2BB2X1M U38 ( .B0(n10), .B1(n19), .A0N(n19), .A1N(n57), .Y(n42) );
  NAND4X2M U39 ( .A(n20), .B(n13), .C(n21), .D(n22), .Y(n19) );
  XNOR2X2M U40 ( .A(Prescale[5]), .B(edge_cnt[4]), .Y(n20) );
  XNOR2X2M U41 ( .A(Prescale[3]), .B(edge_cnt[2]), .Y(n21) );
  OAI2BB2X1M U42 ( .B0(n16), .B1(n10), .A0N(n16), .A1N(test_so), .Y(n43) );
  NAND2X2M U43 ( .A(n12), .B(n17), .Y(n16) );
  OAI2BB2X1M U44 ( .B0(n30), .B1(n9), .A0N(RX_IN), .A1N(n30), .Y(n41) );
  NOR2X2M U45 ( .A(n17), .B(n14), .Y(n30) );
  AND4X2M U46 ( .A(n38), .B(n50), .C(n51), .D(n52), .Y(n47) );
  XNOR2X2M U47 ( .A(edge_cnt[2]), .B(N18), .Y(n50) );
  XNOR2X2M U48 ( .A(edge_cnt[5]), .B(N21), .Y(n51) );
  NOR3X2M U49 ( .A(n54), .B(n55), .C(n56), .Y(n52) );
  CLKXOR2X2M U50 ( .A(Prescale[4]), .B(edge_cnt[3]), .Y(n29) );
  CLKXOR2X2M U51 ( .A(Prescale[2]), .B(edge_cnt[1]), .Y(n28) );
  CLKXOR2X2M U52 ( .A(Prescale[1]), .B(edge_cnt[0]), .Y(n38) );
  CLKXOR2X2M U53 ( .A(edge_cnt[4]), .B(N20), .Y(n56) );
  CLKXOR2X2M U54 ( .A(edge_cnt[3]), .B(N19), .Y(n55) );
  CLKXOR2X2M U55 ( .A(edge_cnt[1]), .B(N17), .Y(n54) );
  INVX2M U56 ( .A(RX_IN), .Y(n10) );
  INVX2M U57 ( .A(samples_0_), .Y(n9) );
endmodule


module deserializer_parityCalc_test_1 ( sampled_bit, bit_cnt, deser_en, 
        PAR_TYP, par_chk_en, data_valid_en, CLK, RST, P_DATA, 
        calculated_par_bit, test_si2, test_si1, test_so1, test_se );
  input [3:0] bit_cnt;
  output [7:0] P_DATA;
  input sampled_bit, deser_en, PAR_TYP, par_chk_en, data_valid_en, CLK, RST,
         test_si2, test_si1, test_se;
  output calculated_par_bit, test_so1;
  wire   registers_3_, registers_2_, registers_1_, registers_0_, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n24,
         n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38,
         n39, n40, n41, n63, n64, n65, n66, n67, n68, n69, n70, n83, n84;

  SDFFRQX2M registers_reg_2_ ( .D(n52), .SI(registers_1_), .SE(test_se), .CK(
        CLK), .RN(n83), .Q(registers_2_) );
  SDFFRQX2M registers_reg_1_ ( .D(n51), .SI(registers_0_), .SE(test_se), .CK(
        CLK), .RN(n83), .Q(registers_1_) );
  SDFFRQX2M registers_reg_0_ ( .D(n50), .SI(P_DATA[6]), .SE(test_se), .CK(CLK), 
        .RN(n83), .Q(registers_0_) );
  SDFFRQX2M registers_reg_3_ ( .D(n53), .SI(registers_2_), .SE(test_se), .CK(
        CLK), .RN(n83), .Q(registers_3_) );
  INVX2M U31 ( .A(deser_en), .Y(n27) );
  NOR2BX2M U32 ( .AN(n33), .B(n25), .Y(n31) );
  NAND2X2M U33 ( .A(data_valid_en), .B(n27), .Y(n41) );
  INVX2M U34 ( .A(n84), .Y(n83) );
  INVX2M U35 ( .A(RST), .Y(n84) );
  NOR2BX2M U36 ( .AN(par_chk_en), .B(n63), .Y(calculated_par_bit) );
  XOR3XLM U37 ( .A(n64), .B(PAR_TYP), .C(n65), .Y(n63) );
  XOR3XLM U38 ( .A(n69), .B(n70), .C(n66), .Y(n65) );
  NOR3X2M U39 ( .A(bit_cnt[2]), .B(bit_cnt[3]), .C(n27), .Y(n38) );
  NOR3BX2M U40 ( .AN(bit_cnt[2]), .B(n27), .C(bit_cnt[3]), .Y(n33) );
  NOR2BX2M U41 ( .AN(n33), .B(bit_cnt[1]), .Y(n35) );
  XNOR2X2M U42 ( .A(n68), .B(registers_0_), .Y(n66) );
  INVX2M U43 ( .A(bit_cnt[1]), .Y(n25) );
  XOR3XLM U44 ( .A(registers_2_), .B(registers_1_), .C(n67), .Y(n64) );
  CLKXOR2X2M U45 ( .A(test_so1), .B(registers_3_), .Y(n67) );
  OAI2BB2X1M U46 ( .B0(n24), .B1(n36), .A0N(n36), .A1N(registers_3_), .Y(n53)
         );
  NAND2X2M U47 ( .A(n35), .B(n26), .Y(n36) );
  OAI2BB2X1M U48 ( .B0(n24), .B1(n37), .A0N(n37), .A1N(registers_2_), .Y(n52)
         );
  NAND3X2M U49 ( .A(bit_cnt[0]), .B(bit_cnt[1]), .C(n38), .Y(n37) );
  OAI2BB2X1M U50 ( .B0(n24), .B1(n40), .A0N(n40), .A1N(registers_0_), .Y(n50)
         );
  NAND3X2M U51 ( .A(bit_cnt[0]), .B(n25), .C(n38), .Y(n40) );
  OAI2BB2X1M U52 ( .B0(n24), .B1(n39), .A0N(n39), .A1N(registers_1_), .Y(n51)
         );
  NAND3X2M U53 ( .A(bit_cnt[1]), .B(n26), .C(n38), .Y(n39) );
  OAI2BB2X1M U54 ( .B0(n24), .B1(n32), .A0N(n32), .A1N(n69), .Y(n55) );
  NAND2X2M U55 ( .A(n31), .B(n26), .Y(n32) );
  OAI2BB2X1M U56 ( .B0(n24), .B1(n30), .A0N(n30), .A1N(n70), .Y(n56) );
  NAND2X2M U57 ( .A(bit_cnt[0]), .B(n31), .Y(n30) );
  OAI2BB2X1M U58 ( .B0(n24), .B1(n34), .A0N(n34), .A1N(n68), .Y(n54) );
  NAND2X2M U59 ( .A(n35), .B(bit_cnt[0]), .Y(n34) );
  INVX2M U60 ( .A(bit_cnt[0]), .Y(n26) );
  INVX2M U61 ( .A(sampled_bit), .Y(n24) );
  OAI2BB2X1M U62 ( .B0(n28), .B1(n24), .A0N(n28), .A1N(test_so1), .Y(n57) );
  NAND4X2M U63 ( .A(deser_en), .B(bit_cnt[3]), .C(n29), .D(n26), .Y(n28) );
  NOR2X2M U64 ( .A(bit_cnt[2]), .B(bit_cnt[1]), .Y(n29) );
  AO2B2X2M U65 ( .B0(P_DATA[3]), .B1(n41), .A0(registers_3_), .A1N(n41), .Y(
        n45) );
  AO2B2X2M U66 ( .B0(P_DATA[4]), .B1(n41), .A0(n68), .A1N(n41), .Y(n46) );
  AO2B2X2M U67 ( .B0(P_DATA[5]), .B1(n41), .A0(n69), .A1N(n41), .Y(n47) );
  AO2B2X2M U68 ( .B0(P_DATA[6]), .B1(n41), .A0(n70), .A1N(n41), .Y(n48) );
  AO2B2X2M U69 ( .B0(P_DATA[0]), .B1(n41), .A0(registers_0_), .A1N(n41), .Y(
        n42) );
  AO2B2X2M U70 ( .B0(P_DATA[1]), .B1(n41), .A0(registers_1_), .A1N(n41), .Y(
        n43) );
  AO2B2X2M U71 ( .B0(P_DATA[2]), .B1(n41), .A0(registers_2_), .A1N(n41), .Y(
        n44) );
  AO2B2X2M U72 ( .B0(P_DATA[7]), .B1(n41), .A0(test_so1), .A1N(n41), .Y(n49)
         );
  SDFFRQX2M registers_reg_7_ ( .D(n57), .SI(n70), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(test_so1) );
  SDFFRQX2M registers_reg_5_ ( .D(n55), .SI(n68), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(n69) );
  SDFFRQX2M registers_reg_4_ ( .D(n54), .SI(registers_3_), .SE(test_se), .CK(
        CLK), .RN(n83), .Q(n68) );
  SDFFRQX2M registers_reg_6_ ( .D(n56), .SI(n69), .SE(test_se), .CK(CLK), .RN(
        n83), .Q(n70) );
  SDFFRHQX8M P_DATA_reg_6_ ( .D(n48), .SI(P_DATA[5]), .SE(test_se), .CK(CLK), 
        .RN(n83), .Q(P_DATA[6]) );
  SDFFRHQX8M P_DATA_reg_5_ ( .D(n47), .SI(P_DATA[4]), .SE(test_se), .CK(CLK), 
        .RN(n83), .Q(P_DATA[5]) );
  SDFFRHQX8M P_DATA_reg_4_ ( .D(n46), .SI(P_DATA[3]), .SE(test_se), .CK(CLK), 
        .RN(n83), .Q(P_DATA[4]) );
  SDFFRHQX8M P_DATA_reg_3_ ( .D(n45), .SI(P_DATA[2]), .SE(test_se), .CK(CLK), 
        .RN(n83), .Q(P_DATA[3]) );
  SDFFRHQX8M P_DATA_reg_2_ ( .D(n44), .SI(P_DATA[1]), .SE(test_se), .CK(CLK), 
        .RN(n83), .Q(P_DATA[2]) );
  SDFFRHQX8M P_DATA_reg_1_ ( .D(n43), .SI(P_DATA[0]), .SE(test_se), .CK(CLK), 
        .RN(n83), .Q(P_DATA[1]) );
  SDFFRHQX8M P_DATA_reg_0_ ( .D(n42), .SI(test_si1), .SE(test_se), .CK(CLK), 
        .RN(n83), .Q(P_DATA[0]) );
  SDFFRHQX8M P_DATA_reg_7_ ( .D(n49), .SI(test_si2), .SE(test_se), .CK(CLK), 
        .RN(n83), .Q(P_DATA[7]) );
endmodule


module strt_checker_test_1 ( sampled_bit, strt_chk_en, CLK, RST, DONE, 
        clearFlag, strt_glitch, test_si, test_se );
  input sampled_bit, strt_chk_en, CLK, RST, DONE, clearFlag, test_si, test_se;
  output strt_glitch;
  wire   n3, n2;

  SDFFRQX2M strt_glitch_reg ( .D(n3), .SI(test_si), .SE(test_se), .CK(CLK), 
        .RN(RST), .Q(strt_glitch) );
  OAI2BB1X2M U4 ( .A0N(strt_glitch), .A1N(clearFlag), .B0(n2), .Y(n3) );
  OAI211X2M U5 ( .A0(sampled_bit), .A1(strt_glitch), .B0(DONE), .C0(
        strt_chk_en), .Y(n2) );
endmodule


module par_checker_test_1 ( sampled_bit, par_chk_en, calculated_par_bit, CLK, 
        RST, clearFlag, DONE, par_err, test_si, test_se );
  input sampled_bit, par_chk_en, calculated_par_bit, CLK, RST, clearFlag, DONE,
         test_si, test_se;
  output par_err;
  wire   n6, n3, n4, n5, n7;

  SDFFRQX2M par_err_reg ( .D(n6), .SI(test_si), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(par_err) );
  NOR2BX2M U5 ( .AN(clearFlag), .B(n4), .Y(n6) );
  AOI22X1M U6 ( .A0(n3), .A1(n5), .B0(par_err), .B1(n7), .Y(n4) );
  INVX2M U7 ( .A(n7), .Y(n3) );
  NAND2X2M U8 ( .A(par_chk_en), .B(DONE), .Y(n7) );
  CLKXOR2X2M U9 ( .A(sampled_bit), .B(calculated_par_bit), .Y(n5) );
endmodule


module stp_checker_test_1 ( sampled_bit, stp_chk_en, CLK, RST, clearFlag, DONE, 
        stp_err, test_si, test_se );
  input sampled_bit, stp_chk_en, CLK, RST, clearFlag, DONE, test_si, test_se;
  output stp_err;
  wire   n4, n2, n3;

  SDFFRQX2M stp_err_reg ( .D(n4), .SI(test_si), .SE(test_se), .CK(CLK), .RN(
        RST), .Q(stp_err) );
  OAI21X2M U5 ( .A0(sampled_bit), .A1(n2), .B0(n3), .Y(n4) );
  NAND3X2M U6 ( .A(clearFlag), .B(n2), .C(stp_err), .Y(n3) );
  NAND2X2M U7 ( .A(stp_chk_en), .B(DONE), .Y(n2) );
endmodule


module UART_RX ( RX_IN, Prescale, PAR_EN, PAR_TYP, CLK, RST, SI, SE, scan_clk, 
        scan_rst, test_mode, SO, P_DATA, data_valid );
  input [5:0] Prescale;
  output [7:0] P_DATA;
  input RX_IN, PAR_EN, PAR_TYP, CLK, RST, SI, SE, scan_clk, scan_rst,
         test_mode;
  output SO, data_valid;
  wire   strt_chk_en_wire, strt_glitch_wire, par_chk_en_wire, par_err_wire,
         stp_chk_en_wire, stp_err_wire, enable_wire, sampled_bit_wire,
         deser_en_wire, calculated_par_bit_wire, data_valid_en_wire,
         dft_clk_wire, dft_rst_wire, DONE_wire, n6, n7, n8, n9, n10, n12, n13;
  wire   [5:0] edge_cnt_wire;
  wire   [3:0] bit_cnt_wire;
  assign SO = P_DATA[7];

  BUFX2M U1 ( .A(Prescale[2]), .Y(n7) );
  BUFX2M U2 ( .A(Prescale[1]), .Y(n6) );
  BUFX2M U3 ( .A(Prescale[4]), .Y(n9) );
  BUFX2M U4 ( .A(Prescale[3]), .Y(n8) );
  BUFX2M U5 ( .A(Prescale[5]), .Y(n10) );
  mux2X1_1 CLK_mux2x1 ( .IN_0(CLK), .IN_1(scan_clk), .SEL(test_mode), .OUT(
        dft_clk_wire) );
  mux2X1_0 RST_mux2x1 ( .IN_0(RST), .IN_1(scan_rst), .SEL(test_mode), .OUT(
        dft_rst_wire) );
  FSM_test_1 FSM ( .RX_IN(RX_IN), .PAR_EN(PAR_EN), .bit_cnt(bit_cnt_wire), 
        .par_err(par_err_wire), .strt_glitch(strt_glitch_wire), .stp_err(
        stp_err_wire), .CLK(dft_clk_wire), .RST(dft_rst_wire), .enable(
        enable_wire), .deser_en(deser_en_wire), .data_valid(data_valid), 
        .strt_chk_en(strt_chk_en_wire), .par_chk_en(par_chk_en_wire), 
        .stp_chk_en(stp_chk_en_wire), .data_valid_en(data_valid_en_wire), 
        .test_si(SI), .test_se(SE) );
  edge_bit_counter_test_1 counter ( .enable(enable_wire), .Prescale({n10, n9, 
        n8, n7, n6, Prescale[0]}), .CLK(dft_clk_wire), .RST(dft_rst_wire), 
        .bit_cnt(bit_cnt_wire), .edge_cnt(edge_cnt_wire), .test_si(data_valid), 
        .test_se(SE) );
  data_sampling_test_1 sampler ( .RX_IN(RX_IN), .edge_cnt(edge_cnt_wire), 
        .enable(enable_wire), .Prescale({n10, n9, n8, n7, n6, Prescale[0]}), 
        .CLK(dft_clk_wire), .RST(dft_rst_wire), .sampled_bit(sampled_bit_wire), 
        .DONE(DONE_wire), .test_si(par_err_wire), .test_so(n12), .test_se(SE)
         );
  deserializer_parityCalc_test_1 deserializer_parityCalc ( .sampled_bit(
        sampled_bit_wire), .bit_cnt(bit_cnt_wire), .deser_en(deser_en_wire), 
        .PAR_TYP(PAR_TYP), .par_chk_en(par_chk_en_wire), .data_valid_en(
        data_valid_en_wire), .CLK(dft_clk_wire), .RST(dft_rst_wire), .P_DATA(
        P_DATA), .calculated_par_bit(calculated_par_bit_wire), .test_si2(
        strt_glitch_wire), .test_si1(edge_cnt_wire[5]), .test_so1(n13), 
        .test_se(SE) );
  strt_checker_test_1 strt_checker ( .sampled_bit(sampled_bit_wire), 
        .strt_chk_en(strt_chk_en_wire), .CLK(dft_clk_wire), .RST(dft_rst_wire), 
        .DONE(DONE_wire), .clearFlag(enable_wire), .strt_glitch(
        strt_glitch_wire), .test_si(stp_err_wire), .test_se(SE) );
  par_checker_test_1 par_checker ( .sampled_bit(sampled_bit_wire), 
        .par_chk_en(par_chk_en_wire), .calculated_par_bit(
        calculated_par_bit_wire), .CLK(dft_clk_wire), .RST(dft_rst_wire), 
        .clearFlag(enable_wire), .DONE(DONE_wire), .par_err(par_err_wire), 
        .test_si(n13), .test_se(SE) );
  stp_checker_test_1 stp_checker ( .sampled_bit(sampled_bit_wire), 
        .stp_chk_en(stp_chk_en_wire), .CLK(dft_clk_wire), .RST(dft_rst_wire), 
        .clearFlag(enable_wire), .DONE(DONE_wire), .stp_err(stp_err_wire), 
        .test_si(n12), .test_se(SE) );
endmodule

