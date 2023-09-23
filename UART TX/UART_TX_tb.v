`timescale 1ns/1ps
module UART_TX_tb ();
//****portDecleration****//
  reg   [7:0]  P_DATA_tb;
  reg          DATA_VALID_tb;
  reg          PAR_EN_tb;
  reg          PAR_TYP_tb;
  reg          CLK_tb;
  reg          RST_tb;
  wire         TX_OUT_tb;
  wire         BUSY_tb;
  reg   [10:0] transmitted_frame;
 
  parameter even = 0;
  parameter odd = 1;
  parameter CLK_Period = 5.0;
  

//****designInstantiation****//
UART_TX DUT(
.P_DATA(P_DATA_tb),
.DATA_VALID(DATA_VALID_tb),
.PAR_EN(PAR_EN_tb),
.PAR_TYP(PAR_TYP_tb),
.CLK(CLK_tb),
.RST(RST_tb),
.TX_OUT(TX_OUT_tb),
.BUSY(BUSY_tb)
);

//****CLK generator with Tperiod == 5 ns****//
always
begin
    CLK_tb=~CLK_tb;
   #(CLK_Period/2);
    CLK_tb=~CLK_tb;
   #(CLK_Period/2);
end


/*********Initial_Block**********/
initial
begin
      $dumpfile("UART_TX.vcd");
      $dumpvars;
      initialization();
      $display ("********UART_TX FRAMES TEST********");
      $display ("-----------------------------------");


   /************************ DATA Frame. (1) ************************/
   /*Data Frame (in case of Parity is enabled & Parity Type is EVEN)*/
   // P_DATA = 8'b     10101011 
   // TX_OU  = 11'b 11 10101011 0  

      P_DATA_tb = 8'b10101011;
      PAR_EN_tb = 1;
      PAR_TYP_tb = even;
      DATA_VALID_tb = 1;
      #(CLK_Period) 
      DATA_VALID_tb = 0;
      
      #(CLK_Period) transmitted_frame [0]  = TX_OUT_tb;
      #(CLK_Period) transmitted_frame [1]  = TX_OUT_tb;              
      #(CLK_Period) transmitted_frame [2]  = TX_OUT_tb;               
      #(CLK_Period) transmitted_frame [3]  = TX_OUT_tb;    
      #(CLK_Period) transmitted_frame [4]  = TX_OUT_tb;
      #(CLK_Period) transmitted_frame [5]  = TX_OUT_tb;                  
      #(CLK_Period) transmitted_frame [6]  = TX_OUT_tb;                 
      #(CLK_Period) transmitted_frame [7]  = TX_OUT_tb;             
      #(CLK_Period) transmitted_frame [8]  = TX_OUT_tb;          
      #(CLK_Period) transmitted_frame [9]  = TX_OUT_tb;

      P_DATA_tb = 8'b01001100;
      PAR_EN_tb = 1;
      PAR_TYP_tb = odd;
      DATA_VALID_tb = 1;

      #(CLK_Period) transmitted_frame [10] = TX_OUT_tb; 
      DATA_VALID_tb = 0;

      if(transmitted_frame == 11'b11101010110) 
      $display ("FRAME.(1) -------> PASSED\n");
      else
      $display ("FRAME.(1) -------> FAILED\n");
      

   /************************ DATA Frame. (2) ************************/
   /*Data Frame (in case of Parity is enabled & Parity Type is ODD)*/
   /****************** Testing Back to Back Frames *****************/
   // P_DATA  = 8'b     01001100
   // TX_OUT  = 11'b 10 01001100 0

      transmitted_frame = 11'bx;

      #(CLK_Period) transmitted_frame [0]  = TX_OUT_tb;
      #(CLK_Period) transmitted_frame [1]  = TX_OUT_tb;              
      #(CLK_Period) transmitted_frame [2]  = TX_OUT_tb;               
      #(CLK_Period) transmitted_frame [3]  = TX_OUT_tb;    
      #(CLK_Period) transmitted_frame [4]  = TX_OUT_tb;
      #(CLK_Period) transmitted_frame [5]  = TX_OUT_tb;                  
      #(CLK_Period) transmitted_frame [6]  = TX_OUT_tb;                 
      #(CLK_Period) transmitted_frame [7]  = TX_OUT_tb;             
      #(CLK_Period) transmitted_frame [8]  = TX_OUT_tb;          
      #(CLK_Period) transmitted_frame [9]  = TX_OUT_tb;
      #(CLK_Period) transmitted_frame [10] = TX_OUT_tb; 

      if(transmitted_frame == 11'b10010011000) 
      $display ("FRAME.(2) -------> PASSED\n");
      else
      $display ("FRAME.(2) -------> FAILED\n");
     
   /************************* DATA Frame. (3) *************************/
   /********** Data Frame (in case of Parity is NOT Enabled) **********/
   // P_DATA  = 8'b    00001111
   // TX_OUT  = 10'b 1 00001111 0 

      #(3*CLK_Period);
      transmitted_frame = 11'bx;
      P_DATA_tb = 8'b00001111;
      PAR_EN_tb = 0;
      PAR_TYP_tb = even;
      DATA_VALID_tb = 1;
      #(CLK_Period) 
      DATA_VALID_tb = 0;

      #(CLK_Period) transmitted_frame [0]  = TX_OUT_tb;
      #(CLK_Period) transmitted_frame [1]  = TX_OUT_tb;              
      #(CLK_Period) transmitted_frame [2]  = TX_OUT_tb;               
      #(CLK_Period) transmitted_frame [3]  = TX_OUT_tb;    
      #(CLK_Period) transmitted_frame [4]  = TX_OUT_tb;
      #(CLK_Period) transmitted_frame [5]  = TX_OUT_tb;                  
      #(CLK_Period) transmitted_frame [6]  = TX_OUT_tb;                 
      #(CLK_Period) transmitted_frame [7]  = TX_OUT_tb;             
      #(CLK_Period) transmitted_frame [8]  = TX_OUT_tb;          
      #(CLK_Period) transmitted_frame [9]  = TX_OUT_tb; transmitted_frame [10] = 0;

      if(transmitted_frame == 11'b 1000011110) 
      $display ("FRAME.(3) -------> PASSED\n");
      else
      $display ("FRAME.(3) -------> FAILED\n");


   /*********************** DATA Frame. (4) ***********************/
   /*Data Frame (in case of Parity is enabled & Parity Type is ODD)*/
   /********* Testing interuptting DATA during processing *********/
   // P_DATA  = 8'b     10000011 
   // TX_OUT  = 11'b 10 10000011 0 

      #(3*CLK_Period);
      transmitted_frame = 11'bx;
      P_DATA_tb = 8'b10000011;
      PAR_EN_tb = 1;
      PAR_TYP_tb = odd;
      DATA_VALID_tb = 1;
      #(CLK_Period)
      DATA_VALID_tb=1'b0; 

      #(CLK_Period) transmitted_frame [0]  = TX_OUT_tb;
      #(CLK_Period) transmitted_frame [1]  = TX_OUT_tb;              
      #(CLK_Period) transmitted_frame [2]  = TX_OUT_tb;               
      #(CLK_Period) transmitted_frame [3]  = TX_OUT_tb;  
      #(CLK_Period) transmitted_frame [4]  = TX_OUT_tb;
      #(CLK_Period) transmitted_frame [5]  = TX_OUT_tb;                  
      #(CLK_Period) transmitted_frame [6]  = TX_OUT_tb;                 
      #(CLK_Period) transmitted_frame [7]  = TX_OUT_tb;  
      #(CLK_Period) transmitted_frame [8]  = TX_OUT_tb; 

      DATA_VALID_tb = 1; P_DATA_tb = 8'b11110000; //interuptting DATA during processing.
      #(CLK_Period) 
      DATA_VALID_tb=1'b0; 

               
                  transmitted_frame   [9]  = TX_OUT_tb;               
      #(CLK_Period) transmitted_frame [10] = TX_OUT_tb;   

      if(transmitted_frame == 11'b10100000110) 
      $display ("FRAME.(4) -------> PASSED");
      else
      $display ("FRAME.(4) -------> FAILED");
   
   //***********RST UART_TX***********//
      $display ("-----------------------------------\n");
      $display ("************RST UART_TX************");
      $display ("-----------------------------------\n");
      #(4*CLK_Period)
      RST_tb = 0;
      #(2*CLK_Period) 
      RST_tb = 1;
      #(2*CLK_Period) if(TX_OUT_tb==1) $display ("TX_OUT = STOP BIT, WAITING FOR DATA VALID.");
      $stop;
end

task initialization; 
   begin
   CLK_tb = 0;
   RST_tb = 1;
   #(CLK_Period) RST_tb = 0;
   #(CLK_Period) RST_tb = 1;
   #(2*CLK_Period);
   end
   endtask
endmodule



