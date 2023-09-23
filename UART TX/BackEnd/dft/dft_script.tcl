
#################################################################
####################### Define Top Module #######################
#################################################################
                                    
set top_module UART_TX
#

#################################################################
################ Define Working Library Directory ###############
#################################################################
                                                   
define_design_lib work -path ./work
set_svf UART_TX_dft.svf
#

#################################################################
############## Design Compiler Library Files #setup #############
#################################################################

lappend search_path "/home/IC/SYSTEM/UART_TX/std_cells"
lappend search_path "/home/IC/SYSTEM/UART_TX/rtl"
#
set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"
#
###### Standard Cell libraries ###### 
set target_library [list $SSLIB $TTLIB $FFLIB]
#
###### Standard Cell & Hard Macros libraries ######
set link_library [list * $SSLIB $TTLIB $FFLIB]  
#

##################################################################
#################### Reading RTL Files  ##########################
##################################################################

set file_format verilog
#
read_file -format $file_format TX_FSM.v
read_file -format $file_format TX_MUX.v
read_file -format $file_format TX_Serializer&parityCalc.v
read_file -format $file_format mux2X1.v
read_file -format $file_format UART_TX.v
#

##################################################################
################## Defining toplevel #############################
##################################################################

current_design $top_module
#

##################################################################
############### Liniking All The Design Parts ####################
##################################################################

link 

##################################################################
################ checking design consistency #####################
##################################################################

check_design

##################################################################
########################## Path groups ###########################
##################################################################

group_path -name INREG -from [all_inputs]
group_path -name REGOUT -to [all_outputs]
group_path -name INOUT -from [all_inputs] -to [all_outputs]

####################################################################
################ Define Design Constraints #########################
####################################################################

source -echo ./cons.tcl
#

##################################################################
############## Configure scan chains for "DFT" ###################
##################################################################

set_scan_configuration -clock_mixing no_mix -style multiplexed_flip_flop -replace true -max_length 100
compile -scan
#

####################################################################
#################### Mapping and optimization ######################
####################################################################

compile -map_effort high
set_svf -off
#
################################################################### 
# Setting Test Timing Variables
################################################################### 

# Preclock Measure Protocol (default protocol)
set test_default_period 100
set test_default_delay 0
set test_default_bidir_delay 0
set test_default_strobe 20
set test_default_strobe_width 0
#

##################################################################
######################## DFT Section #############################
##################################################################

##################### Define DFT Signals ########################

set_dft_signal -port [get_ports scan_clk] -type ScanClock -view existing_dft -timing {30 60}
set_dft_signal -port [get_ports scan_rst] -type Reset -view existing_dft -active_state 0 
set_dft_signal -port [get_ports test_mode] -type TestMode -view existing_dft -active_state 1
set_dft_signal -port [get_ports test_mode] -type Constant -view spec -active_state 1
set_dft_signal -port [get_ports SE] -type ScanEnable -view spec -active_state 1 -usage scan
set_dft_signal -port [get_ports SI] -type ScanDataIn -view spec 
set_dft_signal -port [get_ports SO] -type ScanDataOut -view spec
#

##################### Create Test Protocol #####################

create_test_protocol
#

##################### Pre-DFT Design Rule Checking #####################

dft_drc -verbose
#

##################### Preview DFT #####################

preview_dft -show scan_summary
#

##################### Insert DFT #####################

insert_dft
#

##################### Optimize Logic post DFT #####################

compile -scan -incremental
#

###################### Design Rule Checking post DFT ###################

dft_drc -verbose -coverage_estimate
#

#############################################################################
###################### Write out Design after compile #######################
#############################################################################

#Avoid Writing assign statements in the netlist
change_name -hier -rule verilog

write_file -format verilog -hierarchy -output UART_TX_TOP_dft.v
write_file -format ddc -hierarchy -output UART_TX_TOP_dft.ddc
write_sdc UART_TX_TOP_dft.sdc
write_sdf UART_TX_TOP_dft.sdf
#

#############################################################################
############################# Reporting #####################################
#############################################################################

report_area -hierarchy > area_dft.rpt
report_power -hierarchy > power_dft.rpt
#

report_timing -max_paths 5 -delay_type min > hold_dft.rpt
report_timing -max_paths 5 -delay_type max > setup_dft.rpt
#

report_clock -attributes > clock_dft.rpt
report_constraint -all_violators > constraints_dft.rpt
#

report_port > ports.rpt
dft_drc -verbose -coverage_estimate > coverage_dft.rpt
#
######################################################################
####################### Starting GUI #################################
######################################################################

gui_start
#exit




