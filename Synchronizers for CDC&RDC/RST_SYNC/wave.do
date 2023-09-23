onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color White -itemcolor White /RST_SYNC_tb/DUT/NUM_STAGES
add wave -noupdate -color Red -itemcolor Red /RST_SYNC_tb/DUT/CLK
add wave -noupdate -color White /RST_SYNC_tb/DUT/RST
add wave -noupdate -color Gold -itemcolor Gold /RST_SYNC_tb/DUT/SYNC_RST
add wave -noupdate -divider {FF Stages}
add wave -noupdate -color {Dark Orchid} -itemcolor {Dark Orchid} /RST_SYNC_tb/DUT/Multi_ff
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {350 ns} 0}
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
WaveRestoreZoom {0 ns} {2940 ns}
