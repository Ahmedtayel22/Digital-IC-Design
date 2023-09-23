`timescale 1ns/1ns
module CLKDiv_tb #(parameter max_div_bits_tb = 4) ();
//****portDecleration****//
  reg                         i_ref_clk_tb;
  reg                         i_rst_n_tb;
  reg                         i_clk_en_tb;
  reg  [max_div_bits_tb-1:0]  i_div_ratio_tb;
  wire                        o_div_clk_tb;

parameter CLK_Period = 100.0;

//****designInstantiation****//
CLKDiv #(.max_div_bits(max_div_bits_tb)) DUT(
.i_ref_clk(i_ref_clk_tb),
.i_rst_n(i_rst_n_tb),
.i_clk_en(i_clk_en_tb),
.i_div_ratio(i_div_ratio_tb),
.o_div_clk(o_div_clk_tb)
);

//****CLK generator with Tperiod == 100.0 ns****//
always
begin
   i_ref_clk_tb=~i_ref_clk_tb;
   #50.0;
    i_ref_clk_tb=~i_ref_clk_tb;
   #50.0;
end

//****Initial_Block****//

initial
begin
   $dumpfile("CLKDiv.vcd");
   $dumpvars;

   i_ref_clk_tb = 0;
   i_rst_n_tb = 1;
   #(3*CLK_Period)
   i_rst_n_tb = 0;
   #(7*CLK_Period)
   i_rst_n_tb = 1;


/*******Test Case.(1)*******/
//div_ratio = 1 "o_div_clk <= i_ref_clk"
   i_clk_en_tb = 1;
   i_div_ratio_tb = 1;
   #(5*CLK_Period)

/*******Test Case.(2)*******/
//div_ratio = 2 "even"
   i_rst_n_tb = 0;
   #(7*CLK_Period)
   i_rst_n_tb = 1;
   i_clk_en_tb = 1;
   i_div_ratio_tb = 2;
   #(15*CLK_Period)

/*******Test Case.(3)*******/
//div_ratio = 3 "odd"
   //i_rst_n_tb = 0;
   //#(7*CLK_Period)
   //i_rst_n_tb = 1;
   i_div_ratio_tb = 3;
   #(22*CLK_Period)

/*******Test Case.(4)*******/
//div_ratio = 4 "even"
   //i_rst_n_tb = 0;
   //#(7*CLK_Period)
   //i_rst_n_tb = 1;
   i_div_ratio_tb = 4;
   #(35*CLK_Period)

/*******Test Case.(5)*******/
//div_ratio = 5 "odd"
   //i_rst_n_tb = 0;
   //#(7*CLK_Period)
   //i_rst_n_tb = 1;
   i_div_ratio_tb = 5;
   #(20*CLK_Period)

/*******Test Case.(6)*******/
//div_ratio = 6 "even"
   //i_rst_n_tb = 0;
   //#(7*CLK_Period)
   //i_rst_n_tb = 1;
   i_div_ratio_tb = 6;
   #(30*CLK_Period)

/*******Test Case.(7)*******/
//div_ratio = 6 "even"
   //i_rst_n_tb = 0;
   //#(7*CLK_Period)
   //i_rst_n_tb = 1;
   i_div_ratio_tb = 7;
   #(25*CLK_Period)

/*******Test Case.(8)*******/
//div_ratio = 6 "even"
   //i_rst_n_tb = 0;
   //#(7*CLK_Period)
   //i_rst_n_tb = 1;
   i_div_ratio_tb = 8;
   #(40*CLK_Period)

/*******Test Case.(9)*******/
//div_ratio = 0  "o_div_clk <= i_ref_clk"
   i_rst_n_tb = 0;
   #(7*CLK_Period)
   i_rst_n_tb = 1;
   i_div_ratio_tb = 0;
   #(30*CLK_Period)   

/*******Test Case.(10)*******/
//i_clk_en = 0 "o_div_clk <= i_ref_clk"
   i_div_ratio_tb = 7;
   i_clk_en_tb = 0;
   i_div_ratio_tb = 1;
   #(20*CLK_Period)

   $stop;
end
endmodule
