onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color White -radix hexadecimal /regFile_WidthxDepth_tb/DUT/width
add wave -noupdate -color White /regFile_WidthxDepth_tb/DUT/depth
add wave -noupdate -color White /regFile_WidthxDepth_tb/DUT/addressBus
add wave -noupdate -color Blue -itemcolor Blue -radix hexadecimal /regFile_WidthxDepth_tb/DUT/wr_data
add wave -noupdate -color Blue -itemcolor Blue -radix unsigned /regFile_WidthxDepth_tb/DUT/address
add wave -noupdate -color {Medium Sea Green} -itemcolor {Medium Sea Green} /regFile_WidthxDepth_tb/DUT/wr_en
add wave -noupdate -color {Medium Sea Green} -itemcolor {Medium Sea Green} /regFile_WidthxDepth_tb/DUT/rd_en
add wave -noupdate -color Gold -itemcolor Gold -radix hexadecimal /regFile_WidthxDepth_tb/DUT/rd_data
add wave -noupdate -divider Memory
add wave -noupdate -color Orchid -itemcolor Orchid -radix hexadecimal -childformat {{{/regFile_WidthxDepth_tb/DUT/reg_file[0]} -radix hexadecimal} {{/regFile_WidthxDepth_tb/DUT/reg_file[1]} -radix hexadecimal} {{/regFile_WidthxDepth_tb/DUT/reg_file[2]} -radix hexadecimal} {{/regFile_WidthxDepth_tb/DUT/reg_file[3]} -radix hexadecimal} {{/regFile_WidthxDepth_tb/DUT/reg_file[4]} -radix hexadecimal} {{/regFile_WidthxDepth_tb/DUT/reg_file[5]} -radix hexadecimal} {{/regFile_WidthxDepth_tb/DUT/reg_file[6]} -radix hexadecimal} {{/regFile_WidthxDepth_tb/DUT/reg_file[7]} -radix hexadecimal}} -expand -subitemconfig {{/regFile_WidthxDepth_tb/DUT/reg_file[0]} {-color Orchid -height 15 -itemcolor Orchid -radix hexadecimal} {/regFile_WidthxDepth_tb/DUT/reg_file[1]} {-color Orchid -height 15 -itemcolor Orchid -radix hexadecimal} {/regFile_WidthxDepth_tb/DUT/reg_file[2]} {-color Orchid -height 15 -itemcolor Orchid -radix hexadecimal} {/regFile_WidthxDepth_tb/DUT/reg_file[3]} {-color Orchid -height 15 -itemcolor Orchid -radix hexadecimal} {/regFile_WidthxDepth_tb/DUT/reg_file[4]} {-color Orchid -height 15 -itemcolor Orchid -radix hexadecimal} {/regFile_WidthxDepth_tb/DUT/reg_file[5]} {-color Orchid -height 15 -itemcolor Orchid -radix hexadecimal} {/regFile_WidthxDepth_tb/DUT/reg_file[6]} {-color Orchid -height 15 -itemcolor Orchid -radix hexadecimal} {/regFile_WidthxDepth_tb/DUT/reg_file[7]} {-color Orchid -height 15 -itemcolor Orchid -radix hexadecimal}} /regFile_WidthxDepth_tb/DUT/reg_file
add wave -noupdate -color Orchid -itemcolor Orchid /regFile_WidthxDepth_tb/DUT/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {45 us} 0}
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
WaveRestoreZoom {0 us} {137 us}
