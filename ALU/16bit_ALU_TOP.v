module ALU_TOP #(parameter width_top = 16) (A, B, ALU_FUN,
    CLK,RST,
    ARITH_OUT,
    LOGIC_OUT,
    CMP_OUT,
    SHIFT_OUT,
    CARRY_OUT,
    ARITH_FLAG_OUT,
    LOGIC_FLAG_OUT,
    CMP_FLAG_OUT,
    SHIFT_FLAG_OUT
    );

    input [width_top-1:0] A;
    input [width_top-1:0] B;
    input [3:0] ALU_FUN;
    input CLK;
    input RST;
    
    output [2*width_top-1:0] ARITH_OUT;
    output LOGIC_OUT;
    output CMP_OUT;
    output SHIFT_OUT;
    output CARRY_OUT;

    output ARITH_FLAG_OUT;
    output LOGIC_FLAG_OUT;
    output CMP_FLAG_OUT;
    output SHIFT_FLAG_OUT;
    
    wire [2*width_top-1:0] ARITH_OUT;
    wire [2*width_top-1:0] LOGIC_OUT;
    wire [2*width_top-1:0] CMP_OUT;
    wire [2*width_top-1:0] SHIFT_OUT;
    wire CARRY_OUT;

    wire ARITH_EN;
    wire LOGIC_EN;
    wire CMP_EN;
    wire SHIFT_EN;
    
    wire [1:0] DECODER_FUN;
    wire [1:0] UNITS_FUN;
    
    assign {DECODER_FUN,UNITS_FUN}=ALU_FUN;

    decoder2x4 decoder2x4_TOP (
        .decoder_fun(DECODER_FUN),
        .enable_1(ARITH_EN),
        .enable_2(LOGIC_EN),
        .enable_3(CMP_EN),
        .enable_4(SHIFT_EN)
    );

    arithmatic_unit #(.width(width_top)) arithmatic_unit_TOP (
        .a(A),
        .b(B),
        .arith_fun(UNITS_FUN),
        .clk(CLK),
        .rst(RST),
        .arith_enable(ARITH_EN),
        .arith_out(ARITH_OUT),
        .carry_out(CARRY_OUT),
        .arith_flag(ARITH_FLAG_OUT)
    );

        logic_unit #(.width(width_top)) logic_unit_TOP (
        .a(A),
        .b(B),
        .logic_fun(UNITS_FUN),
        .clk(CLK),
        .rst(RST),
        .logic_enable(LOGIC_EN),
        .logic_out(LOGIC_OUT),
        .logic_flag(LOGIC_FLAG_OUT)
    );

        cmp_unit #(.width(width_top)) cmp_unit_TOP (
        .a(A),
        .b(B),
        .cmp_fun(UNITS_FUN),
        .clk(CLK),
        .rst(RST),
        .cmp_enable(CMP_EN),
        .cmp_out(CMP_OUT),
        .cmp_flag(CMP_FLAG_OUT)
    );

        shift_unit #(.width(width_top)) shift_unit_TOP (
        .a(A),
        .b(B),
        .shift_fun(UNITS_FUN),
        .clk(CLK),
        .rst(RST),
        .shift_enable(SHIFT_EN),
        .shift_out(SHIFT_OUT),
        .shift_flag(SHIFT_FLAG_OUT)
    );
endmodule

