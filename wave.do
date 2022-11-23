onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/CLOCK_PERIOD
add wave -noupdate /DE1_SoC_testbench/CLOCK_50
add wave -noupdate /DE1_SoC_testbench/LEDR
add wave -noupdate -expand /DE1_SoC_testbench/KEY
add wave -noupdate -expand /DE1_SoC_testbench/SW
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[4]/genColumn[2]/dot/m0/out}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[4]/genColumn[2]/dot/m0/i0}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[4]/genColumn[2]/dot/m0/i1}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[4]/genColumn[2]/dot/m0/sel}
add wave -noupdate /DE1_SoC_testbench/dut/DOT
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[4]/genColumn[2]/dot/m1/out}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[4]/genColumn[2]/dot/m1/i0}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[4]/genColumn[2]/dot/m1/i1}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[4]/genColumn[2]/dot/m1/sel}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[7]/genColumn[3]/dot/Clock}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[7]/genColumn[3]/dot/G}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[7]/genColumn[3]/dot/RE}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[7]/genColumn[3]/dot/CE}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[7]/genColumn[3]/dot/NINE}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[7]/genColumn[3]/dot/EIGHT}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[7]/genColumn[3]/dot/Q}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[7]/genColumn[3]/dot/D}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[7]/genColumn[3]/dot/control}
add wave -noupdate {/DE1_SoC_testbench/dut/game/genRow[7]/genColumn[3]/dot/A0}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {735 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 231
configure wave -valuecolwidth 154
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {361 ps} {2560 ps}
