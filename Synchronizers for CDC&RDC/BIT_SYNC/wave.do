onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color White -itemcolor White /BIT_SYNC_tb/DUT/BUS_WIDTH
add wave -noupdate -color White -itemcolor White /BIT_SYNC_tb/DUT/NUM_STAGES
add wave -noupdate -color White -itemcolor White /BIT_SYNC_tb/DUT/RST
add wave -noupdate -divider {Domain ONE}
add wave -noupdate -color {Cornflower Blue} -itemcolor {Cornflower Blue} -radix hexadecimal /BIT_SYNC_tb/DUT/ASYNC
add wave -noupdate -color {Cornflower Blue} -itemcolor {Cornflower Blue} /BIT_SYNC_tb/CLK1
add wave -noupdate -divider {Domain TWO}
add wave -noupdate -color Gold -itemcolor Gold -radix hexadecimal /BIT_SYNC_tb/DUT/SYNC
add wave -noupdate -color Gold -itemcolor Gold /BIT_SYNC_tb/DUT/CLK
add wave -noupdate -divider {FF Stage}
add wave -noupdate -color Cyan -itemcolor Cyan -subitemconfig {{/BIT_SYNC_tb/DUT/Multi_ff[0]} {-color Cyan -itemcolor Cyan} {/BIT_SYNC_tb/DUT/Multi_ff[1]} {-color Cyan -itemcolor Cyan} {/BIT_SYNC_tb/DUT/Multi_ff[2]} {-color Cyan -itemcolor Cyan} {/BIT_SYNC_tb/DUT/Multi_ff[3]} {-color Cyan -itemcolor Cyan} {/BIT_SYNC_tb/DUT/Multi_ff[4]} {-color Cyan -itemcolor Cyan} {/BIT_SYNC_tb/DUT/Multi_ff[5]} {-color Cyan -itemcolor Cyan} {/BIT_SYNC_tb/DUT/Multi_ff[6]} {-color Cyan -itemcolor Cyan} {/BIT_SYNC_tb/DUT/Multi_ff[7]} {-color Cyan -itemcolor Cyan}} /BIT_SYNC_tb/DUT/Multi_ff
add wave -noupdate -color Cyan -itemcolor Cyan /BIT_SYNC_tb/DUT/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2606 ns} 0}
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
WaveRestoreZoom {0 ns} {2745 ns}
