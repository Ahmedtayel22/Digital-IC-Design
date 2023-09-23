
# Constraints
# ----------------------------------------------------------------------------
#
# 1. Master Clock Definitions
#
# 2. Generated Clock Definitions
#
# 3. Clock Uncertainties
#
# 4. Clock Latencies 
#
# 5. Clock Relationships
#
# 6. set input/output delay on ports
#
# 7. Driving cells
#
# 8. Output load

####################################################################################
           #########################################################
                  #### Section 1 : Clock Definition ####
           #########################################################
#################################################################################### 

# 1. Master Clock Definitions 
set Tperiod 100
create_clock -name "SysCLK" -period $Tperiod [get_ports CLK]
#
# 2. Generated Clock Definitions
###########No generated clocks #########
#
# 3. Clock Latencies
set_clock_latency 0 [get_clocks "SysCLK"]
#
# 4. Clock Uncertainties
set_clock_uncertainty -setup 0.25 [get_clocks SysCLK]
set_clock_uncertainty -hold 0.05 [get_clocks SysCLK]
#
# 4. Clock Transitions
set_clock_transition 0.1 [get_clocks SysCLK]
#

####################################################################################
           #########################################################
                  #### Section 2 : Clocks Relationships ####
           #########################################################
####################################################################################

#

####################################################################################
           #########################################################
             #### Section 3 : set input/output delay on ports ####
           #########################################################
####################################################################################

set in_delay  [expr 0.3*$Tperiod]
set out_delay [expr 0.3*$Tperiod]
#
#Constrain Input Paths
set_input_delay $in_delay -clock "SysCLK" [get_ports P_DATA]
set_input_delay $in_delay -clock "SysCLK" [get_ports DATA_VALID]
set_input_delay $in_delay -clock "SysCLK" [get_ports PAR_EN]
set_input_delay $in_delay -clock "SysCLK" [get_ports PAR_TYP]
#
#Constrain Output Paths
set_output_delay $out_delay -clock "SysCLK" [get_ports TX_OUT]
set_output_delay $out_delay -clock "SysCLK" [get_ports BUSY]
#

####################################################################################
           #########################################################
                  #### Section 4 : Driving cells ####
           #########################################################
####################################################################################

set slow "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"
#
set_driving_cell -library $slow -lib_cell BUFX2M [get_ports P_DATA]
set_driving_cell -library $slow -lib_cell BUFX2M [get_ports DATA_VALID]
set_driving_cell -library $slow -lib_cell BUFX2M [get_ports PAR_EN]
set_driving_cell -library $slow -lib_cell BUFX2M [get_ports PAR_TYP]
#
set_dont_touch_network SysCLK
#

####################################################################################
           #########################################################
                  #### Section 5 : Output load ####
           #########################################################
####################################################################################

set_load 0.5 [get_ports TX_OUT]
set_load 0.5 [get_ports BUSY]
#

####################################################################################
           #########################################################
                 #### Section 6 : Operating Condition ####
           #########################################################
####################################################################################

# Define the Worst Library for Max(#setup) analysis
# Define the Best Library for Min(hold) analysis

set_operating_conditions -max_library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" -max "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c" -min_library "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c" -min "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c"
#

####################################################################################
           #########################################################
                  #### Section 7 : wireload Model ####
           #########################################################
####################################################################################

#set_wire_load_model -name "tsmc13_wl10" -library "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c"
#

####################################################################################
           #########################################################
                  #### Section 8 : multicycle path ####
           #########################################################
####################################################################################

#

####################################################################################
           #########################################################
                  #### Section 9 : Case analysis for DFT ####
           #########################################################
####################################################################################

set_case_analysis 0 [get_ports test_mode]
#



