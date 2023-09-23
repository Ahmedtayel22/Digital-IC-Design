onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider counters
add wave -noupdate -color White /CRC_tb/DUT/sead
add wave -noupdate -color White /CRC_tb/DUT/LSFRs
add wave -noupdate -color Blue -format Literal -itemcolor Blue -radix unsigned /CRC_tb/DUT/data
add wave -noupdate -color Blue -itemcolor Blue /CRC_tb/DUT/active
add wave -noupdate -color Gold -format Literal -itemcolor Gold /CRC_tb/DUT/crc
add wave -noupdate -color Gold -itemcolor Gold /CRC_tb/DUT/valid
add wave -noupdate -color {Pale Green} -itemcolor {Green Yellow} /CRC_tb/DUT/registers
add wave -noupdate -divider counter
add wave -noupdate -color Magenta -itemcolor Magenta -radix unsigned /CRC_tb/DUT/i
add wave -noupdate -color Magenta -itemcolor Magenta -radix unsigned /CRC_tb/DUT/j
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6039 ns} 0}
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
WaveRestoreZoom {2723 ns} {12278 ns}
