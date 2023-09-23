onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color White /CLKDiv_tb/DUT/i_rst_n
add wave -noupdate -color Cyan /CLKDiv_tb/DUT/i_clk_en
add wave -noupdate -color Blue -radix unsigned /CLKDiv_tb/DUT/i_div_ratio
add wave -noupdate -color {Orange Red} /CLKDiv_tb/DUT/i_ref_clk
add wave -noupdate -color Gold /CLKDiv_tb/DUT/o_div_clk
add wave -noupdate -color White /CLKDiv_tb/DUT/rst_mux
add wave -noupdate /CLKDiv_tb/DUT/o_div_clk_wire
add wave -noupdate -color Magenta -radix unsigned /CLKDiv_tb/DUT/counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1827 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 289
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ns} {24885 ns}
