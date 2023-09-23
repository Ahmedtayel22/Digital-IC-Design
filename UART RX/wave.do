onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider interfacePorts
add wave -noupdate -color {Medium Spring Green} -radix unsigned /UART_RX_tb/DUT/Prescale
add wave -noupdate -color {Medium Spring Green} -radix symbolic /UART_RX_tb/DUT/PAR_EN
add wave -noupdate -color {Medium Spring Green} -format Literal -radix symbolic /UART_RX_tb/DUT/PAR_TYP
add wave -noupdate -color Red -radix symbolic /UART_RX_tb/DUT/CLK
add wave -noupdate -color White -radix symbolic /UART_RX_tb/DUT/RST
add wave -noupdate -color Blue -format Literal -radix unsigned /UART_RX_tb/DUT/RX_IN
add wave -noupdate -color Red -radixenum symbolic /UART_RX_tb/DUT/P_DATA
add wave -noupdate -color Red -radix unsigned /UART_RX_tb/DUT/data_valid
add wave -noupdate -divider FSM
add wave -noupdate -color White -radixenum symbolic /UART_RX_tb/DUT/FSM/current_state
add wave -noupdate -color White -radix unsigned /UART_RX_tb/DUT/FSM/next_state
add wave -noupdate -divider counter&sampler
add wave -noupdate -color Gold -radix unsigned /UART_RX_tb/DUT/sampler/middleEdge
add wave -noupdate -color Gold -radix unsigned /UART_RX_tb/DUT/counter/bit_cnt
add wave -noupdate -color Gold -radix unsigned /UART_RX_tb/DUT/counter/edge_cnt
add wave -noupdate -color Gold -format Literal /UART_RX_tb/DUT/sampler/sampled_bit
add wave -noupdate -color Gold /UART_RX_tb/DUT/sampler/DONE
add wave -noupdate -color Gold -format Literal /UART_RX_tb/DUT/deserializer_parityCalc/calculated_par_bit
add wave -noupdate -color Gold /UART_RX_tb/DUT/deserializer_parityCalc/registers
add wave -noupdate -divider errors
add wave -noupdate -color Cyan /UART_RX_tb/DUT/strt_checker/strt_glitch
add wave -noupdate -color Cyan /UART_RX_tb/DUT/par_checker/par_err
add wave -noupdate -color Cyan /UART_RX_tb/DUT/stp_checker/stp_err
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1901010 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 168
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 12
configure wave -datasetprefix 0
configure wave -rowmargin 11
configure wave -childrowmargin 2
configure wave -gridoffset 1
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {4719750 ps}
