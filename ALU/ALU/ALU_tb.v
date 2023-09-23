`timescale 1us/1us 

module ALU_TB #(parameter WIDTH_TB = 16)();
  
  //Declare testbench signals
  reg [WIDTH_TB-1:0] a_tb;
  reg [WIDTH_TB-1:0] b_tb;
  reg [3:0] alu_fun_tb;
  reg clk_tb;
  reg rst_tb;
  wire arith_flag_tb, logic_flag_tb, cmp_flag_tb, shift_flag_tb;
  wire [2*WIDTH_TB-1:0] alu_out_tb;
  
  //DUT instantiation (port mapping)
  ALU #(.WIDTH(WIDTH_TB)) DUT (
    .a(a_tb),
    .b(b_tb),
    .alu_fun(alu_fun_tb),
    .CLK(clk_tb),
    .RST(rst_tb),
    .alu_out(alu_out_tb),
    .arith_flag(arith_flag_tb),
    .logic_flag(logic_flag_tb),
    .cmp_flag(cmp_flag_tb),
    .shift_flag(shift_flag_tb));
  
  //clk generator, frequency 100kHZ
  always #5 clk_tb=~clk_tb; 
  
  initial
  begin
    $dumpfile("ALU_TEST.vcd");
    $dumpvars;
    a_tb=0;
    b_tb=0;
    clk_tb=0;
    rst_tb=1;
    alu_fun_tb=0;

    #10 rst_tb=0;
    #10 rst_tb=1;

    //////////////TEST CASES//////////////
    #10 a_tb=5; b_tb=3; alu_fun_tb=4'b0000;
    #10 if (alu_out_tb==8) $display("Addition is PASSED");
    
    #10 a_tb=5; b_tb=3; alu_fun_tb=4'b0001; 
    #10 if (alu_out_tb==2) $display("Subsraction is PASSED");
    
    #10 a_tb=10; b_tb=2; alu_fun_tb=4'b0010;
    #10 if (alu_out_tb==20) $display("Multiplication is PASSED");
    
    #10 a_tb=500; b_tb=10; alu_fun_tb=4'b0011;
    #10 if (alu_out_tb==50) $display("Dividing is PASSED");
    
    #10 a_tb='b1010; b_tb='b1111; alu_fun_tb=4'b0100;
    #10 if (alu_out_tb=='b1010) $display("AND GATE is PASSED");
    
    #10 a_tb='b1010; b_tb='b1111; alu_fun_tb=4'b0101;
    #10 if (alu_out_tb=='b1111) $display("OR GATE is PASSED");
    
    #10 a_tb='b1010; b_tb='b1111; alu_fun_tb=4'b0110;
    #10 if (alu_out_tb=='b1111111111110101) $display("NAND GATE is PASSED");
    
    #10 a_tb='b1010; b_tb='b1111; alu_fun_tb=4'b0111;
    #10 if (alu_out_tb=='b1111111111110000) $display("NOR GATE is PASSED");
    
    #10 a_tb='b1010; b_tb='b1111; alu_fun_tb=4'b1000;
    #10 if (alu_out_tb=='b0101) $display("XOR GATE is PASSED");
    
    #10 a_tb='b1010; b_tb='b1111; alu_fun_tb=4'b1001;
    #10 if (alu_out_tb=='b1111111111111010) $display("XNOR GATE is PASSED");
    
    #10 a_tb=10; b_tb=10; alu_fun_tb=4'b1010;
    #10 if (alu_out_tb==1) $display("CMP:A=B is PASSED");
    
    #10 a_tb=50; b_tb=10; alu_fun_tb=4'b1011;
    #10 if (alu_out_tb==2) $display("CMP:A>B is PASSED");
    
    #10 a_tb=9; b_tb=10; alu_fun_tb=4'b1100;
    #10 if (alu_out_tb==3) $display("CMP:A<B is PASSED");
    
    #10 a_tb='b11010; alu_fun_tb=4'b1101;
    #10 if (alu_out_tb=='b1101) $display("SHIFT RIGHT is PASSED");
    
    #10 a_tb='b11010; alu_fun_tb=4'b1110;
    #10 if (alu_out_tb=='b110100) $display("SHIFT LEFT is PASSED");
    
    #10 a_tb=50; b_tb=100; alu_fun_tb=4'b1111;
    #10 if (alu_out_tb==0) $display("DEFAULT is PASSED");
    
    #20
    $stop;
  end
endmodule