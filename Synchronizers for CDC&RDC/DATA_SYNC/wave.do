onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Interface Inputs}
add wave -noupdate -color White -itemcolor White /DATA_SYNC_tb/DUT/BUS_WIDTH
add wave -noupdate -color White -itemcolor White /DATA_SYNC_tb/DUT/NUM_STAGES
add wave -noupdate -color White -itemcolor White /DATA_SYNC_tb/DUT/RST
add wave -noupdate -divider {Domain ONE}
add wave -noupdate -color {Cornflower Blue} -itemcolor {Cornflower Blue} -radix hexadecimal /DATA_SYNC_tb/DUT/unsync_bus
add wave -noupdate -color {Cornflower Blue} -itemcolor {Cornflower Blue} /DATA_SYNC_tb/DUT/bus_enable
add wave -noupdate -color {Cornflower Blue} -itemcolor {Cornflower Blue} /DATA_SYNC_tb/CLK1
add wave -noupdate -divider {Domain TWO}
add wave -noupdate -color Gold -itemcolor Gold -radix hexadecimal /DATA_SYNC_tb/DUT/sync_bus
add wave -noupdate -color Gold -itemcolor Gold /DATA_SYNC_tb/DUT/enable_pulse
add wave -noupdate -color Gold -itemcolor Gold /DATA_SYNC_tb/DUT/CLK
add wave -noupdate -divider {Multi_FF Stage}
add wave -noupdate -color {Spring Green} -itemcolor {Spring Green} /DATA_SYNC_tb/DUT/Multi_ff
add wave -noupdate -color {Spring Green} -itemcolor {Spring Green} /DATA_SYNC_tb/DUT/i
add wave -noupdate -divider {Pulse Gen}
add wave -noupdate -color {Orange Red} -format Literal -itemcolor {Orange Red} /DATA_SYNC_tb/DUT/Pulse_Gen_ff
add wave -noupdate -divider {And Gate}
add wave -noupdate -color Cyan -format Literal -itemcolor Cyan /DATA_SYNC_tb/DUT/IN_and_0
add wave -noupdate -color Cyan -format Literal -itemcolor Cyan /DATA_SYNC_tb/DUT/IN_and_1
add wave -noupdate -color Cyan -itemcolor Cyan /DATA_SYNC_tb/DUT/mux_sel
add wave -noupdate -divider Mux
add wave -noupdate -color Magenta -itemcolor Magenta /DATA_SYNC_tb/DUT/mux_sel
add wave -noupdate -color Magenta -itemcolor Magenta -radix hexadecimal /DATA_SYNC_tb/DUT/Mux_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {520 ns} 0}
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
WaveRestoreZoom {0 ns} {7875 ns}
