onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider <NULL>
add wave -noupdate -color {Lime Green} /I2c_tb/DUT/rst
add wave -noupdate -color Red /I2c_tb/DUT/clk
add wave -noupdate -divider <NULL>
add wave -noupdate -divider INTERNALS
add wave -noupdate -color Gray70 -radix unsigned /I2c_tb/DUT/current_state
add wave -noupdate -color Gray70 -radix unsigned /I2c_tb/DUT/next_state
add wave -noupdate -color Gray70 -radix unsigned /I2c_tb/DUT/counter
add wave -noupdate -color Gray70 -radix unsigned /I2c_tb/DUT/bit_cnt
add wave -noupdate -divider <NULL>
add wave -noupdate -divider {MASTER to SLAVE}
add wave -noupdate -color Blue -radix unsigned /I2c_tb/DUT/cmd
add wave -noupdate -color Blue /I2c_tb/wr_i2c
add wave -noupdate -color Blue -radix hexadecimal /I2c_tb/DUT/din
add wave -noupdate -color Magenta -format Literal /I2c_tb/DUT/sda_out
add wave -noupdate -color Gold /I2c_tb/DUT/scl
add wave -noupdate -color Gold /I2c_tb/DUT/done_tick
add wave -noupdate -color Gold -radix hexadecimal /I2c_tb/DUT/dout
add wave -noupdate -color Gold /I2c_tb/DUT/ack
add wave -noupdate -color Gold /I2c_tb/DUT/ready
add wave -noupdate -divider <NULL>
add wave -noupdate -divider {SLAVE to MASTER}
add wave -noupdate -color Magenta -format Literal /I2c_tb/sda_in
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1339927027 ps} 0}
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
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {1394961750 ps}
