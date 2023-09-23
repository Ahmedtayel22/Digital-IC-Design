###################################################################

# Created by write_sdc on Sun Sep 24 02:16:38 2023

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_operating_conditions -max scmetro_tsmc_cl013g_rvt_ss_1p08v_125c            \
-max_library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c\
                         -min scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c            \
-min_library scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c
set_driving_cell -lib_cell BUFX2M -library                                     \
scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [get_ports RX_IN]
set_driving_cell -lib_cell BUFX2M -library                                     \
scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [get_ports {Prescale[5]}]
set_driving_cell -lib_cell BUFX2M -library                                     \
scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [get_ports {Prescale[4]}]
set_driving_cell -lib_cell BUFX2M -library                                     \
scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [get_ports {Prescale[3]}]
set_driving_cell -lib_cell BUFX2M -library                                     \
scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [get_ports {Prescale[2]}]
set_driving_cell -lib_cell BUFX2M -library                                     \
scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [get_ports {Prescale[1]}]
set_driving_cell -lib_cell BUFX2M -library                                     \
scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [get_ports {Prescale[0]}]
set_driving_cell -lib_cell BUFX2M -library                                     \
scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [get_ports PAR_EN]
set_driving_cell -lib_cell BUFX2M -library                                     \
scmetro_tsmc_cl013g_rvt_ss_1p08v_125c [get_ports PAR_TYP]
set_load -pin_load 0.5 [get_ports {P_DATA[7]}]
set_load -pin_load 0.5 [get_ports {P_DATA[6]}]
set_load -pin_load 0.5 [get_ports {P_DATA[5]}]
set_load -pin_load 0.5 [get_ports {P_DATA[4]}]
set_load -pin_load 0.5 [get_ports {P_DATA[3]}]
set_load -pin_load 0.5 [get_ports {P_DATA[2]}]
set_load -pin_load 0.5 [get_ports {P_DATA[1]}]
set_load -pin_load 0.5 [get_ports {P_DATA[0]}]
set_load -pin_load 0.5 [get_ports data_valid]
set_case_analysis 0 [get_ports test_mode]
create_clock [get_ports CLK]  -name SysCLK  -period 5  -waveform {0 2.5}
set_clock_latency 0  [get_clocks SysCLK]
set_clock_uncertainty -setup 0.25  [get_clocks SysCLK]
set_clock_uncertainty -hold 0.05  [get_clocks SysCLK]
set_clock_transition -max -rise 0.1 [get_clocks SysCLK]
set_clock_transition -max -fall 0.1 [get_clocks SysCLK]
set_clock_transition -min -rise 0.1 [get_clocks SysCLK]
set_clock_transition -min -fall 0.1 [get_clocks SysCLK]
group_path -name INOUT  -from [list [get_ports RX_IN] [get_ports {Prescale[5]}] [get_ports            \
{Prescale[4]}] [get_ports {Prescale[3]}] [get_ports {Prescale[2]}] [get_ports  \
{Prescale[1]}] [get_ports {Prescale[0]}] [get_ports PAR_EN] [get_ports         \
PAR_TYP] [get_ports CLK] [get_ports RST] [get_ports SI] [get_ports SE]         \
[get_ports scan_clk] [get_ports scan_rst] [get_ports test_mode]]  -to [list [get_ports SO] [get_ports {P_DATA[7]}] [get_ports {P_DATA[6]}]      \
[get_ports {P_DATA[5]}] [get_ports {P_DATA[4]}] [get_ports {P_DATA[3]}]        \
[get_ports {P_DATA[2]}] [get_ports {P_DATA[1]}] [get_ports {P_DATA[0]}]        \
[get_ports data_valid]]
group_path -name INREG  -from [list [get_ports RX_IN] [get_ports {Prescale[5]}] [get_ports            \
{Prescale[4]}] [get_ports {Prescale[3]}] [get_ports {Prescale[2]}] [get_ports  \
{Prescale[1]}] [get_ports {Prescale[0]}] [get_ports PAR_EN] [get_ports         \
PAR_TYP] [get_ports CLK] [get_ports RST] [get_ports SI] [get_ports SE]         \
[get_ports scan_clk] [get_ports scan_rst] [get_ports test_mode]]
group_path -name REGOUT  -to [list [get_ports SO] [get_ports {P_DATA[7]}] [get_ports {P_DATA[6]}]      \
[get_ports {P_DATA[5]}] [get_ports {P_DATA[4]}] [get_ports {P_DATA[3]}]        \
[get_ports {P_DATA[2]}] [get_ports {P_DATA[1]}] [get_ports {P_DATA[0]}]        \
[get_ports data_valid]]
set_input_delay -clock SysCLK  1.5  [get_ports RX_IN]
set_input_delay -clock SysCLK  1.5  [get_ports {Prescale[5]}]
set_input_delay -clock SysCLK  1.5  [get_ports {Prescale[4]}]
set_input_delay -clock SysCLK  1.5  [get_ports {Prescale[3]}]
set_input_delay -clock SysCLK  1.5  [get_ports {Prescale[2]}]
set_input_delay -clock SysCLK  1.5  [get_ports {Prescale[1]}]
set_input_delay -clock SysCLK  1.5  [get_ports {Prescale[0]}]
set_input_delay -clock SysCLK  1.5  [get_ports PAR_EN]
set_input_delay -clock SysCLK  1.5  [get_ports PAR_TYP]
set_output_delay -clock SysCLK  1.5  [get_ports {P_DATA[7]}]
set_output_delay -clock SysCLK  1.5  [get_ports {P_DATA[6]}]
set_output_delay -clock SysCLK  1.5  [get_ports {P_DATA[5]}]
set_output_delay -clock SysCLK  1.5  [get_ports {P_DATA[4]}]
set_output_delay -clock SysCLK  1.5  [get_ports {P_DATA[3]}]
set_output_delay -clock SysCLK  1.5  [get_ports {P_DATA[2]}]
set_output_delay -clock SysCLK  1.5  [get_ports {P_DATA[1]}]
set_output_delay -clock SysCLK  1.5  [get_ports {P_DATA[0]}]
set_output_delay -clock SysCLK  1.5  [get_ports data_valid]
