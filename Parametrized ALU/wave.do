onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color White /ALU_TB/DUT/WIDTH
add wave -noupdate -color White /ALU_TB/DUT/RST
add wave -noupdate -color Blue -itemcolor Blue /ALU_TB/DUT/a
add wave -noupdate -color Blue -itemcolor Blue /ALU_TB/DUT/b
add wave -noupdate -color {Lime Green} -itemcolor {Lime Green} /ALU_TB/DUT/alu_fun
add wave -noupdate -color Red -itemcolor Red /ALU_TB/DUT/CLK
add wave -noupdate -color Gold -itemcolor Gold /ALU_TB/DUT/alu_out
add wave -noupdate -divider Flags
add wave -noupdate -color Cyan -itemcolor Cyan /ALU_TB/DUT/arith_flag
add wave -noupdate -color Cyan -itemcolor Cyan /ALU_TB/DUT/logic_flag
add wave -noupdate -color Cyan -itemcolor Cyan /ALU_TB/DUT/cmp_flag
add wave -noupdate -color Cyan -itemcolor Cyan /ALU_TB/DUT/shift_flag
add wave -noupdate -color Cyan -itemcolor Cyan /ALU_TB/DUT/flags
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {267 us} 0}
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
WaveRestoreZoom {0 us} {378 us}
