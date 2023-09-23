`timescale 1us/1us
module ALU_TOP_TB #(parameter width = 16)();
reg [width-1:0] A_tb;
reg [width-1:0] B_tb;
reg [3:0] ALU_FUN_tb;
reg CLK_tb;
reg RST_tb;

wire [2*width-1:0] ARITH_OUT_tb;
wire [2*width-1:0] LOGIC_OUT_tb;
wire [2*width-1:0] CMP_OUT_tb;
wire [2*width-1:0] SHIFT_OUT_tb;
wire CARRY_OUT_tb;

wire ARITH_FLAG_tb;
wire LOGIC_FLAG_tb;
wire CMP_FLAG_tb;
wire SHIFT_FLAG_tb;
wire [3:0] flags;
assign flags = {SHIFT_FLAG_tb,CMP_FLAG_tb,LOGIC_FLAG_tb,ARITH_FLAG_tb};

ALU_TOP DUT ( 
.A(A_tb),
.B(B_tb),
.ALU_FUN(ALU_FUN_tb),
.CLK(CLK_tb),
.RST(RST_tb),

.ARITH_OUT(ARITH_OUT_tb),
.LOGIC_OUT(LOGIC_OUT_tb),
.CMP_OUT(CMP_OUT_tb),
.SHIFT_OUT(SHIFT_OUT_tb),
.CARRY_OUT(CARRY_OUT_tb),

.ARITH_FLAG_OUT(ARITH_FLAG_tb),
.LOGIC_FLAG_OUT(LOGIC_FLAG_tb),
.CMP_FLAG_OUT(CMP_FLAG_tb),
.SHIFT_FLAG_OUT(SHIFT_FLAG_tb)
);

always 
begin 
    CLK_tb=~CLK_tb;
    #4;
    CLK_tb=~CLK_tb;
    #6;
end 

initial 
begin
    $dumpfile("ALU_TOP_MODULE.vcd");
    $dumpvars;
    A_tb='bx;
    B_tb='bx;
    RST_tb=1;
    ALU_FUN_tb=4'bx;
    CLK_tb=0;
   

   ////////////////ARITHMATIC_Cases////////////////
    #10 A_tb='b1111111111111111; B_tb=1; ALU_FUN_tb=4'b0000;
    #10 if (ARITH_OUT_tb[15:0] == 0  && CARRY_OUT_tb== 1)
    $display("Addition + Carry is PASSED");

    #10 A_tb=5; B_tb=3; ALU_FUN_tb=4'b0001; 
    #10 if (ARITH_OUT_tb == (A_tb - B_tb)) $display("Subsraction is PASSED");

    #10 A_tb=10; B_tb=2; ALU_FUN_tb=4'b0010;
    #10 if (ARITH_OUT_tb == (A_tb*B_tb)) $display("Multiplication is PASSED");
    
    #10 A_tb=500; B_tb=10; ALU_FUN_tb=4'b0011;
    #20 if (ARITH_OUT_tb == (A_tb/B_tb)) $display("Dividing is PASSED");

    ////////////////LOGIC_Cases////////////////
    #10 A_tb='b1010; B_tb='b1111; ALU_FUN_tb=4'b0100;
    #10 if (LOGIC_OUT_tb == (A_tb&B_tb)) $display("AND GATE is PASSED");
    
    #10 A_tb='b1010; B_tb='b1111; ALU_FUN_tb=4'b0101;
    #10 if (LOGIC_OUT_tb == (A_tb|B_tb)) $display("OR GATE is PASSED");
    
    #10 A_tb='b1010; B_tb='b1111; ALU_FUN_tb=4'b0110;
    #20 if (LOGIC_OUT_tb == ~(A_tb&B_tb)) $display("NAND GATE is PASSED");
    
    #10 A_tb='b1010; B_tb='b1111; ALU_FUN_tb=4'b0111;
    #10 if (LOGIC_OUT_tb == ~(A_tb|B_tb)) $display("NOR GATE is PASSED");

    ////////////////CMP_Cases////////////////
    #10 A_tb=10; B_tb=10; ALU_FUN_tb=4'b1000;
    #10 if (CMP_OUT_tb == 0) $display("NO OPERATION is PASSED");

    #10 A_tb=10; B_tb=10; ALU_FUN_tb=4'b1001;
    #10 if (CMP_OUT_tb == 1) $display("CMP:A=B is PASSED");
    
    #10 A_tb=50; B_tb=10; ALU_FUN_tb=4'b1010;
    #10 if (CMP_OUT_tb == 2) $display("CMP:A>B is PASSED");
    
    #10 A_tb=9; B_tb=10; ALU_FUN_tb=4'b1011;
    #10 if (CMP_OUT_tb == 3) $display("CMP:A<B is PASSED");


    ////////////////SHIFT_Cases////////////////
    #10 A_tb='b11010; B_tb='b0; ALU_FUN_tb=4'b1100;
    #10 if (SHIFT_OUT_tb == (A_tb>>1)) $display("A>>1 is PASSED");
    
    #10 A_tb='b11010; B_tb='b0; ALU_FUN_tb=4'b1101;
    #10 if (SHIFT_OUT_tb == (A_tb<<1)) $display("A<<1 is PASSED");

    #10 B_tb='b11010; A_tb='b0; ALU_FUN_tb=4'b1110;
    #10 if (SHIFT_OUT_tb == (B_tb>>1)) $display("B>>1 is PASSED");
    
    #10 B_tb='b11010; A_tb='b0; ALU_FUN_tb=4'b1111;
    #10 if (SHIFT_OUT_tb == (B_tb<<1)) $display("B<<1 is PASSED");

    ////////////////RESET_Case////////////////
    #10 RST_tb=0; 
    #10 if (flags==0 && ARITH_OUT_tb==0 && LOGIC_OUT_tb==0 
    && CMP_OUT_tb==0 && SHIFT_OUT_tb ==0) 
    $display("RST is PASSED");
    $stop;
end
endmodule

