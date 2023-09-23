onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider interfacePorts
add wave -noupdate -color Blue /UART_TX_tb/DUT/P_DATA
add wave -noupdate -color Yellow /UART_TX_tb/DUT/DATA_VALID
add wave -noupdate -color Yellow /UART_TX_tb/DUT/PAR_EN
add wave -noupdate -color Yellow -format Literal /UART_TX_tb/DUT/PAR_TYP
add wave -noupdate -color Red /UART_TX_tb/DUT/CLK
add wave -noupdate -color White /UART_TX_tb/DUT/RST
add wave -noupdate -color Cyan -format Literal /UART_TX_tb/DUT/TX_OUT
add wave -noupdate -color Cyan /UART_TX_tb/DUT/BUSY
add wave -noupdate -divider FSM
add wave -noupdate -color {Green Yellow} -radix unsigned /UART_TX_tb/DUT/TX_FSM/current_state
add wave -noupdate -color {Green Yellow} -radix unsigned /UART_TX_tb/DUT/TX_FSM/next_state
add wave -noupdate -divider Serializer
add wave -noupdate -color Magenta /UART_TX_tb/DUT/TX_Serializer/registers
add wave -noupdate -color Magenta /UART_TX_tb/DUT/TX_Serializer/ser_done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {164223 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 1
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {347470 ps}
