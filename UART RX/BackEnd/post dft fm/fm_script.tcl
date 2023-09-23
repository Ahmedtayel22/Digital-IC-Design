##################################################################################
############################## Formality Setup File ##############################
##################################################################################
set synopsys_auto_setup true
set verification_set_undriven_signals 0:x
set verification_verify_directly_undriven_output false
set_svf "/home/IC/SYSTEM/UART_RX/dft/UART_RX_dft.svf"

set SSLIB "/home/IC/Labs/Lab_Formal_2/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/IC/Labs/Lab_Formal_2/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/IC/Labs/Lab_Formal_2/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

#################################################################################
############################## Reference Container ##############################
#################################################################################
## Read Design Files
read_verilog -container Ref "/home/IC/SYSTEM/UART_RX/rtl/data_sampling.v"
read_verilog -container Ref "/home/IC/SYSTEM/UART_RX/rtl/deserializer_parityCalc.v"
read_verilog -container Ref "/home/IC/SYSTEM/UART_RX/rtl/edge_bit_counter.v"
read_verilog -container Ref "/home/IC/SYSTEM/UART_RX/rtl/FSM.v"
read_verilog -container Ref "/home/IC/SYSTEM/UART_RX/rtl/parr_checker.v"
read_verilog -container Ref "/home/IC/SYSTEM/UART_RX/rtl/stp_checker.v"
read_verilog -container Ref "/home/IC/SYSTEM/UART_RX/rtl/strt_checker.v"
read_verilog -container Ref "/home/IC/SYSTEM/UART_RX/rtl/mux2X1.v"
read_verilog -container Ref "/home/IC/SYSTEM/UART_RX/rtl/UART_RX.v"


## Load Libraries
read_db -container Ref [list $SSLIB $TTLIB $FFLIB]

## set_top design
set_reference_design "UART_RX"
set_top "UART_RX"
######################################################################################
############################## Implementation Container ##############################
######################################################################################
## Read Design Files
read_verilog -container Imp -netlist "/home/IC/SYSTEM/UART_RX/dft/UART_RX_TOP_dft.v"

## Load Libraries
read_db -container Imp [list $SSLIB $TTLIB $FFLIB]

## set_top design
set_implementation_design "UART_RX"
set_top "UART_RX"


######################################################################################
########################## Don't verify ##############################################
######################################################################################

# do not verify scan in & scan out ports as a compare point as it is existed only after synthesis and not existed in the RTL

#scan in
set_dont_verify_points -type port Ref:/WORK/*/SI
set_dont_verify_points -type port Imp:/WORK/*/SI

#scan_out
set_dont_verify_points -type port Ref:/WORK/*/SO
set_dont_verify_points -type port Imp:/WORK/*/SO



######################################################################################
############################### contants #############################################
######################################################################################

# all atpg enable (test_mode, scan_enable) are zero during formal compare

#test_mode
set_constant Ref:/WORK/*/SE 0
set_constant Imp:/WORK/*/SE 0

#scan_enable
set_constant Imp:/WORK/*/SE 0
######################################################################################
######################### Matching Compare Points & Verify ###########################
######################################################################################
set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

####################################################################################
################################## Reporting #######################################
####################################################################################
report_passing_points > "passing_points.rpt"
report_failing_points > "failing_psoints.rpt"
report_aborted_points > "aborted_points.rpt"
report_unverified_points > "unverified_points.rpt"

####################################################################################
################################## Start GUI #######################################
####################################################################################
start_gui
exit




