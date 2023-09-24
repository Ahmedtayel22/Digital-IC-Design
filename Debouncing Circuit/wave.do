onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color Green /Debouncer_tb/DUT/no_sync_stages
add wave -noupdate -color Green /Debouncer_tb/DUT/Delay
add wave -noupdate -divider BIT_SYNC
add wave -noupdate -color White -itemcolor White /Debouncer_tb/DUT/DUT3/RST
add wave -noupdate -color Red -itemcolor White /Debouncer_tb/DUT/DUT3/CLK
add wave -noupdate -color Cyan -itemcolor White /Debouncer_tb/DUT/noisy_IN
add wave -noupdate -color Cyan -itemcolor White /Debouncer_tb/DUT/DUT3/sync_sig
add wave -noupdate -color Gold -itemcolor White /Debouncer_tb/DUT/Debouncer_out
add wave -noupdate -color Gold -itemcolor White /Debouncer_tb/DUT/DUT3/timer_DONE
add wave -noupdate -divider <NULL>
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {551 ns} 0}
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
WaveRestoreZoom {0 ns} {3682 ns}
