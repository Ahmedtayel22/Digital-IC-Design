`timescale 1ns/1ps
module UART_RX_tb ();
//**** portDecleration ****//
  reg         RX_IN_tb;
  reg  [5:0]  Prescale_tb;
  reg         PAR_EN_tb;
  reg         PAR_TYP_tb;
  reg         CLK_tb;
  reg         RST_tb;
  wire [7:0]  P_DATA_tb;
  wire        data_valid_tb;
  


parameter CLK_Period = 5.0;
parameter EVEN = 0;
parameter ODD  = 1;
integer   i;

//**** designInstantiation ****//
UART_RX DUT(
.RX_IN(RX_IN_tb),
.Prescale(Prescale_tb),
.PAR_EN(PAR_EN_tb),
.PAR_TYP(PAR_TYP_tb),
.CLK(CLK_tb),
.RST(RST_tb),
.P_DATA(P_DATA_tb),
.data_valid(data_valid_tb)
);

//**** CLK_generator with Tperiod == 5.0 ns ****//
always
begin
   CLK_tb=~CLK_tb;
   #2.5;
    CLK_tb=~CLK_tb;
   #2.5;
end

//******** TASKS *********//
task frame_test_parity;
input [2:0]  case_no;
input [10:0] IN_FRAME;
input [7:0]  expec_out;
begin
    for (i=0; i<11; i=i+1)
    begin
        #(Prescale_tb*CLK_Period);
        RX_IN_tb = IN_FRAME[i];
    end
    #((Prescale_tb + 4)*CLK_Period);
    if (P_DATA_tb == expec_out) 
    begin
        $display ("FRAME.(%d) ----------------------------> [PASSED]   \n\n\n", case_no);
    end
    else
    begin
        $display ("FRAME.(%d) ----------------------------> [IGNORED]  \n\n\n", case_no);
    end
end
endtask


task frame_test_no_parity;
input [2:0]  case_no;
input [9:0]  IN_FRAME;
input [7:0]  expec_out;
begin
    for(i=0; i<10; i=i+1)
    begin
        #(Prescale_tb*CLK_Period);
        RX_IN_tb = IN_FRAME[i];
    end
    RX_IN_tb = 1; //TX BACK TO IDLE
    #((Prescale_tb + 4)*CLK_Period);
    if (P_DATA_tb == expec_out) 
    begin
        $display ("FRAME.(%d) ----------------------------> [PASSED]   \n\n\n", case_no);
    end
    else
    begin
        $display ("FRAME.(%d) ----------------------------> [IGNORED]  \n\n\n", case_no);
    end
    #(4*Prescale_tb*CLK_Period);
end
endtask


//****Initial_Block****//
initial
begin
   $dumpfile("UART_RX.vcd");
   $dumpvars;
   CLK_tb = 0;
   RST_tb = 1;
   RX_IN_tb = 1;
   Prescale_tb = 8;

    //****************************** RESETING UART_TX ********************************//
    #(CLK_Period) RST_tb = 0;
    #(5*CLK_Period) RST_tb = 1;

    //********************* Glitching the start bit --> IGNORED *********************//
    #(3*CLK_Period) RX_IN_tb = 0;
    #(2*CLK_Period) RX_IN_tb = 1;
    #(3*CLK_Period);


    //#########################################################################//
    //*************************** EXPECTED WAVE FORM *************************//
    //** P_DATA = 8'h00 --> 8'hf0 --> 8'haa --> 8'hf0 -- > 8'h9b -- > 8'h5a ---> 8'hff **//

    //*************************** EXPECTED TRANSCRIPT ************************//
    //************ FRAMES (1),(2),(4),(6),(7),(8) --> PASSED *************//
    //************ FRAMES (3),(5) --------------- --> IGNORED ************//
    //*************** CHECK THE DATA VALID FROM THE WAVE FORM **************//
    //#####################################################################//


    //***************************** Test Case.(1) ******************************//
    //***************************** PARITY FRAME ******************************//
    //RX_IN = 11'b11 11110000 0 && ODD PARITY
    //P_DATA = 8'b11110000 = 8'hf0

    $display ("*** FRAME.(1) (ODD PARITY FRAME)*** ");
    $display ("-----------------------------------");
    PAR_EN_tb = 1;
    PAR_TYP_tb = ODD;
    frame_test_parity(1,11'b11111100000, 8'b11110000);


    //***************************** Test Case.(2) ******************************//
    //***************************** PARITY FRAME ******************************//
    //RX_IN = 11'b10 10101010 0 && EVEN PARITY
    //P_DATA = 8'b10101010 = 8'haa

    $display ("*** FRAME.(2) (EVEN PARITY FRAME)*** ");
    $display ("------------------------------------");
    PAR_EN_tb = 1;
    PAR_TYP_tb = EVEN;
    frame_test_parity(2,11'b10101010100, 8'b10101010);


    //***************************** Test Case.(3) ******************************//
    //***************************** PARITY FRAME ******************************//
    //**********MISTAKE IN PARITY BIT***********//
    //RX_IN = 11'b10 10111110 0 && ODD PARITY
    //P_DATA = 8'b10111110 = 8'hbe

    $display ("*** FRAME.(3) (MISTAKE IN SAMPLING PARITY BIT) ***");
    $display ("-------------------------------------------------");
    PAR_EN_tb = 1;
    PAR_TYP_tb = ODD;
    frame_test_parity(3,11'b10101111100, 8'b10111110);


    //***************************** Test Case.(4) ******************************//
    //***************************** NO PARITY FRAME ****************************//
    //RX_IN = 10'b1 11110000 0 
    //P_DATA = 8'b11110000 = 8'hf0

    $display ("*** FRAME.(4) (NO PARITY FRAME) ***");
    $display ("-----------------------------------");
    PAR_EN_tb = 0;
    frame_test_no_parity(4,10'b1111100000,8'b11110000);


    //***************************** Test Case.(5) ******************************//
    //****************************** PARITY FRAME ******************************//
    //********************** MISTAKE IN PARITY & STOP BIT **********************//
    //RX_IN = 11'b01 10101010 0 && ODD PARITY
    //P_DATA = 8'b10101010 = 8'haa

    PAR_EN_tb = 1;
    PAR_TYP_tb = ODD;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 1;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 1;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 1;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 1;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;

    //***************************** Test Case.(6) ******************************//
    //***************************** PARITY FRAME *******************************//
    //***************************** BACK TO BACK FRAME *************************//
    //RX_IN = 11'b10 10011011 0 && ODD PARITY
    //P_DATA = 8'b10011011 = 8'h9b

    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 1;

     $display ("*** FRAME.(5) (MISTAKE IN SAMPLING STOP BIT) ***");
     $display ("------------------------------------------------");
    if (P_DATA_tb == 8'b10101010) 
        $display ("FRAME.(5) ----------------------------> [PASSED]   \n\n\n");
    else
        $display ("FRAME.(5) ----------------------------> [IGNORED]  \n\n\n");

    $display ("*** FRAME.(6) (SENDING BACK TO BACK FRAME) ***");
    $display ("----------------------------------------------");
    #(Prescale_tb*CLK_Period) RX_IN_tb = 1;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 1;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 1;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 1;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 1;

    #((Prescale_tb + 10)*CLK_Period)
    if (P_DATA_tb == 8'b10011011) 
        $display ("FRAME.(6) ----------------------------> [PASSED]   \n\n\n");
    else
        $display ("FRAME.(6) ----------------------------> [IGNORED]  \n\n\n");

    //***************************** Test Case.(7) ******************************//
    //***************************** PARITY FRAME ******************************//
    //RX_IN = 11'b10 01011010 0 && EVEN PARITY
    //P_DATA = 8'b01011010 = 8'h5a

    $display ("*** FRAME.(7) (EVEN PARITY FRAME)*** ");
    $display ("------------------------------------");
    PAR_EN_tb = 1;
    PAR_TYP_tb = EVEN;
    frame_test_parity(7,11'b10010110100, 8'b01011010);

    //***************************** Test Case.(8) ******************************//
    //***************************** PARITY FRAME ******************************//
    //RX_IN = 11'b11 11111111 0 && ODD PARITY
    //P_DATA = 8'b11111111 = 8'hbe

    $display ("*** FRAME.(8) (MISTAKE IN SAMPLING PARITY BIT) ***");
    $display ("-------------------------------------------------");
    PAR_EN_tb = 1;
    PAR_TYP_tb = ODD;
    frame_test_parity(8,11'b11111111110, 8'b11111111);

    //********************* Glitching the start bit --> IGNORED *********************//
    RX_IN_tb = 0;
    #(3*CLK_Period) RX_IN_tb = 1;
    #(8*Prescale_tb*CLK_Period)
    $stop;
    
end
endmodule

















    //***************************** Test Case.(7) ******************************//
    //***************************** NO PARITY FRAME ****************************//
    //***************************** BACK TO BACK FRAME *************************//
    //RX_IN = 11'b1 11110000 0 
    //P_DATA = 8'b11110000 = 8'hf0

    /*$display ("*** FRAME.(7) (SENDING BACK TO BACK FRAME) ***");
    $display ("----------------------------------------------");

    PAR_EN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 0;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 1;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 1;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 1;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 1;
    #(Prescale_tb*CLK_Period) RX_IN_tb = 1;
    RX_IN_tb = 1;//TX BACK TO IDLE
    
    @(posedge data_valid_tb)
    if (P_DATA_tb == 8'b11110000) 
        $display ("FRAME.(7) ----------------------------> [PASSED]   \n\n");
    else
        $display ("FRAME.(7) ----------------------------> [IGNORED]  \n\n");*/
