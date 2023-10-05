`timescale 1ns/1ps
module I2c_tb ();
//****portDecleration****//
  reg         wr_i2c;
  reg [2:0]   cmd;
  reg [7:0]   din;
  reg [15:0]  dvsr;
  reg         clk;
  reg         rst;
  reg         sda_in;


  wire [7:0]  dout;
  wire         ack;
  wire         ready;
  wire         done_tick;
  wire         sda_out;
  wire         scl;

parameter clk_Period = 10.0;

parameter IDLE      =  0;
parameter START_1   =  1;
parameter START_2   =  2;
parameter HOLD      =  3;
parameter DATA_1    =  4;
parameter DATA_2    =  5;
parameter DATA_3    =  6;
parameter DATA_4    =  7;
parameter ACK_1     =  8;
parameter ACK_2     =  9;
parameter ACK_3     =  10;
parameter ACK_4     =  11;
parameter STOP_1    =  12;
parameter STOP_2    =  13;
parameter RESTART   =  14;

parameter START_CMD   = 3'b000;
parameter WR_CMD      = 3'b001;
parameter RD_CMD      = 3'b010;
parameter STOP_CMD    = 3'b011;
parameter RESTART_CMD = 3'b100;

//****designInstantiation****//
I2c DUT(
.wr_i2c(wr_i2c),
.cmd(cmd),
.din(din),
.dvsr(dvsr),
.clk(clk),
.rst(rst),
.sda_in(sda_in),
.dout(dout),
.ack(ack),
.ready(ready),
.done_tick(done_tick),
.sda_out(sda_out),
.scl(scl)
);

//****clk generator with Tperiod == 10.0 ns****//
always
begin
   clk=~clk;
   #5.0;
    clk=~clk;
   #5.0;
end

//****Initial_Block****//

initial
begin
   $dumpfile("I2c.vcd");
   $dumpvars;
//########################## Initialization #########################//

   clk = 0;
   rst = 1;
   dvsr = 250;
   sda_in = 1'b1;
   #(clk_Period) rst = 0;
   #(clk_Period) rst = 1;
   #(20000*clk_Period);

//############################ WRITE OP [1]############################//
//FRAME [1] = 8'h55 "SLAVE ADDRESS + WR bit"
//FRAME [2] = 8'haa

   //START_CMD
   wr_i2c = 1'b1;
   cmd = START_CMD;
    
   //ACCESSING SLAVE ADDRESS [7'b1010101]--[1'b0 FOR WRITE_OP]
   @(posedge ready) din = 8'b0_1010101;  cmd = WR_CMD; //slave address + write
   @(DUT.current_state == DATA_1) wr_i2c = 1'b0; //disable write enable

   @(DUT.current_state == ACK_1) sda_in = 1'b0; //ack DONE

   //BYTE TO WRITE INTO THE SLAVE
   @(posedge ready) din = 8'haa; //byte to send
   @(DUT.current_state == ACK_1) sda_in = 1'b0; //ack DONE

   //MASTER TERMINATE THE CONNECTION WITH "STOP_CMD"
   @(posedge ready) cmd = STOP_CMD;
   @(DUT.current_state == IDLE)  sda_in = 1'b1; 
   #(1500*clk_Period);

//############################ READ OP [1] ############################//
   //FRAME [1] = 8'hd5 "SLAVE ADDRESS + RD bit"
   //FRAME [2] = 8'hcc

   //START_CMD
   wr_i2c = 1'b1;
   cmd = START_CMD;

   //ACCESSING SLAVE ADDRESS [7'b0_1010101]--[1'b1 FOR READ-OP]
   @(posedge ready) din = 8'b1_1010101;  cmd = WR_CMD; //slave address + read
   @(DUT.current_state == DATA_1) wr_i2c = 1'b0; //disable write enable

   @(DUT.current_state == ACK_1) sda_in = 1'b0; //ack DONE

   //BYTE TO READ FROM SLAVE
   @(posedge ready) cmd = RD_CMD; 
   @(DUT.current_state == 4) sda_in = 1'b1; 
  
   @(DUT.bit_cnt == 1) sda_in = 1'b1; 

   @(DUT.bit_cnt == 2) sda_in = 1'b0; 
  
   @(DUT.bit_cnt == 3) sda_in = 1'b0; 
 
   @(DUT.bit_cnt == 4) sda_in = 1'b1; 
  
   @(DUT.bit_cnt == 5) sda_in = 1'b1; 
   
   @(DUT.bit_cnt == 6) sda_in = 1'b0; 
  
   @(DUT.bit_cnt == 7) sda_in = 1'b0; 

   @(DUT.current_state == 8) sda_in = 1'bz;

   //MASTER TERMINATE THE CONNECTION WITH "STOP_CMD"
   @(posedge ready) cmd = STOP_CMD;
   @(DUT.current_state == 0) sda_in = 1'b1; 
   #(1500*clk_Period);

//############################ READ OP [2] ############################//
   //FRAME [1] = 8'hd5 "SLAVE ADDRESS + RD bit"
   //FRAME [2] = 8'hdd

   //START_CMD
   wr_i2c = 1'b1;
   cmd = START_CMD;

   //ACCESSING SLAVE ADDRESS [7'b0_1010101]--[1'b1 FOR READ-OP]
   @(posedge ready) din = 8'b1_1010101;  cmd = WR_CMD; //slave address + read
   @(DUT.current_state == DATA_1) wr_i2c = 1'b0; //disable write enable

   @(DUT.current_state == ACK_1) sda_in = 1'b0; //ack DONE

   //BYTE TO READ FROM SLAVE
   @(posedge ready) cmd = RD_CMD; 
   @(DUT.current_state == 4) sda_in = 1'b1; 
  
   @(DUT.bit_cnt == 1) sda_in = 1'b1; 

   @(DUT.bit_cnt == 2) sda_in = 1'b0; 
  
   @(DUT.bit_cnt == 3) sda_in = 1'b1; 
 
   @(DUT.bit_cnt == 4) sda_in = 1'b1; 
  
   @(DUT.bit_cnt == 5) sda_in = 1'b1; 
   
   @(DUT.bit_cnt == 6) sda_in = 1'b0; 
  
   @(DUT.bit_cnt == 7) sda_in = 1'b1; 

   @(DUT.current_state == 8) sda_in = 1'bz;

   //MASTER TERMINATE THE CONNECTION WITH "STOP_CMD"
   @(posedge ready) cmd = STOP_CMD;
   @(DUT.current_state == 0) sda_in = 1'b1; 
   #(1500*clk_Period);

//############################ WRITE OP [2]############################//
  //FRAME [1] = 8'h55 "SLAVE ADDRESS + WR bit"
  //FRAME [2] = 8'hee

   wr_i2c = 1'b1;
   cmd = START_CMD;
    
   //ACCESSING SLAVE ADDRESS [7'b1010101]--[1'b0 FOR WRITE_OP]
   @(posedge ready) din = 8'b0_1010101;  cmd = WR_CMD; //slave address + write
   @(DUT.current_state == DATA_1) wr_i2c = 1'b0; //disable write enable

   @(DUT.current_state == ACK_1) sda_in = 1'b0; //ack DONE

   //BYTE TO WRITE INTO THE SLAVE
   @(posedge ready) din = 8'hee; //byte to send
   @(DUT.current_state == ACK_1) sda_in = 1'b0; //ack DONE

   //MASTER TERMINATE THE CONNECTION WITH "STOP_CMD"
   @(posedge ready) cmd = STOP_CMD;
   @(DUT.current_state == IDLE)  sda_in = 1'b1; 
   #(20000*clk_Period);

   $stop;
end
endmodule
