//////////////////decoder_2x4///////////////////
module decoder2x4 (decoder_fun, enable_1, enable_2, enable_3, enable_4);

    input [1:0] decoder_fun;

    output enable_1;
    output enable_2;
    output enable_3;
    output enable_4;

    reg enable_1;
    reg enable_2;
    reg enable_3;
    reg enable_4;

    always @(*) 
    begin
        enable_1=0;
        enable_2=0;
        enable_3=0;
        enable_4=0;
        case (decoder_fun)
        2'b00:enable_1=1;
        2'b01:enable_2=1;
        2'b10:enable_3=1;
        2'b11:enable_4=1;
        endcase

    end
endmodule

/******//////////////////////////////////////////////
////////////////arithmatic_unit//////////////////////
//////////////////////////////////////////////******/

module arithmatic_unit #(parameter width = 16) (a, b, clk, rst,
    arith_fun, arith_enable, arith_out, carry_out, arith_flag);

    input [width-1:0] a;
    input [width-1:0] b;
    input [1:0] arith_fun;
    input  clk,rst;
    input arith_enable;
    output [2*width-1:0] arith_out;
    output carry_out;
    output arith_flag;

    reg [2*width-1:0] arith_out;
    wire carry_out;
    reg arith_flag;
    assign carry_out = arith_out[16];

    always@(posedge clk or negedge rst)
    begin
        if(!rst) 
        begin
            arith_out<=0;
            arith_flag<=0;
        end
        else if (arith_enable==1)
        begin
            case (arith_fun)
            2'b00:begin arith_out <= a+b;  arith_flag<=1; end
            2'b01:begin arith_out <= a-b;  arith_flag<=1; end
            2'b10:begin arith_out <= a*b;  arith_flag<=1; end
            2'b11:begin arith_out <= a/b;  arith_flag<=1; end
            endcase
        end
        else begin arith_out<=0; arith_flag<=0; end
    end
endmodule

/******//////////////////////////////////////////////
//////////////////logic_unit/////////////////////////
//////////////////////////////////////////////******/

module logic_unit #(parameter width = 16) (a, b, clk, rst,
    logic_fun, logic_enable, logic_out, logic_flag);

    input [width-1:0] a;
    input [width-1:0] b;
    input [1:0] logic_fun;
    input  clk,rst;
    input logic_enable;
    output [2*width-1:0] logic_out;
    output logic_flag;

    reg [2*width-1:0] logic_out;
    reg logic_flag;

    always@(posedge clk or negedge rst)
    begin
        if(!rst)
        begin
            logic_out<=0;
            logic_flag<=0;
        end
        else if (logic_enable==1)
        begin
            case (logic_fun)
            2'b00:begin  logic_out <= a&b;       logic_flag<=1; end
            2'b01:begin  logic_out <= a|b;       logic_flag<=1; end
            2'b10:begin  logic_out <= ~(a&b);    logic_flag<=1; end
            2'b11:begin  logic_out <= ~(a|b);    logic_flag<=1; end
            endcase
        end
        else begin logic_out<=0; logic_flag<=0;  end
    end
endmodule

/******//////////////////////////////////////////////
//////////////////CMP_unit///////////////////////////
//////////////////////////////////////////////******/

module cmp_unit #(parameter width = 16) (a, b, clk, rst,
    cmp_fun, cmp_enable, cmp_out, cmp_flag);

    input [width-1:0] a;
    input [width-1:0] b;
    input [1:0] cmp_fun;
    input  clk,rst;
    input cmp_enable;
    output [2*width-1:0] cmp_out;
    output cmp_flag;

    reg [2*width-1:0] cmp_out;
    reg cmp_flag;

    always@(posedge clk or negedge rst)
    begin
        if(!rst)
        begin  
            cmp_out<=0;
            cmp_flag<=0;
        end
        else if (cmp_enable==1)
            begin
            case (cmp_fun)
            2'b00:begin  cmp_out <= 0;          cmp_flag<=1; end
            2'b01:begin  cmp_out <= a==b? 1:0;  cmp_flag<=1; end
            2'b10:begin  cmp_out <= a>b?  2:0;  cmp_flag<=1; end
            2'b11:begin  cmp_out <= a<b?  3:0;  cmp_flag<=1; end
            endcase
            end
        else begin cmp_out<=0; cmp_flag<=0;  end
    end
endmodule

/******//////////////////////////////////////////////
//////////////////shift_unit/////////////////////////
//////////////////////////////////////////////******/

module shift_unit #(parameter width = 16) (a, b, clk, rst,
 shift_fun, shift_enable, shift_out, shift_flag);

    input [width-1:0] a;
    input [width-1:0] b;
    input [1:0] shift_fun;
    input  clk,rst;
    input shift_enable;
    output [2*width-1:0] shift_out;
    output shift_flag;

    reg [2*width-1:0] shift_out;
    reg shift_flag;

    always@(posedge clk or negedge rst)
    begin
        if(!rst)
        begin
            shift_out<=0;
            shift_flag<=0;
        end
        else if (shift_enable==1)
        begin
            case (shift_fun)
            2'b00:begin  shift_out <= a >> 1;    shift_flag<=1; end
            2'b01:begin  shift_out <= a << 1;    shift_flag<=1; end
            2'b10:begin  shift_out <= b >> 1;    shift_flag<=1; end
            2'b11:begin  shift_out <= b << 1;    shift_flag<=1; end
            endcase
        end
        else begin shift_out<=0; shift_flag<=0;  end
    end
endmodule








