@REM ------------------------------------------------------
@REM Simple DOS batch file to compile and run the testbench
@REM Ver 1.0 HT-Lab 2006
@REM ------------------------------------------------------
vlib i80186

@REM Compile HTL80186
vcom -93 -quiet -work i80186 ../rtl/cpu86instr.vhd
vcom -93 -quiet -work i80186 ../rtl/cpu86pack.vhd
vcom -93 -quiet -work i80186 ../rtl/newbiufsm_fsm.vhd
vcom -93 -quiet -work i80186 ../rtl/a_table.vhd
vcom -93 -quiet -work i80186 ../rtl/d_table.vhd
vcom -93 -quiet -work i80186 ../rtl/n_table.vhd
vcom -93 -quiet -work i80186 ../rtl/r_table.vhd
vcom -93 -quiet -work i80186 ../rtl/m_table.vhd
vcom -93 -quiet -work i80186 ../rtl/formatter_rtl.vhd
vcom -93 -quiet -work i80186 ../rtl/newbiushift.vhd
vcom -93 -quiet -work i80186 ../rtl/rise_edge.vhd
vcom -93 -quiet -work i80186 ../rtl/biuirq_rtl.vhd
vcom -93 -quiet -work i80186 ../rtl/newbiu_rtl.vhd
vcom -93 -quiet -work i80186 ../rtl/dataregfile_rtl.vhd
vcom -93 -quiet -work i80186 ../rtl/segregfile_rtl.vhd
vcom -93 -quiet -work i80186 ../rtl/divider_rtl_ser.vhd
vcom -93 -quiet -work i80186 ../rtl/multiplier_rtl.vhd
vcom -93 -quiet -work i80186 ../rtl/alu_rtl.vhd
vcom -93 -quiet -work i80186 ../rtl/ipregister_rtl.vhd
vcom -93 -quiet -work i80186 ../rtl/datapath_rtl.vhd
vcom -93 -quiet -work i80186 ../rtl/proc_rtl.vhd
@REM Simulating the HTL80816, for the HTL80188 change the file to 
@REM vcom -93 -quiet -work i80186 ../rtl/I80188/cpu188_rtl.vhd
vcom -93 -quiet -work i80186 ../rtl/cpu186_rtl.vhd

@REM Compile Testbench

vcom -93 -quiet -work i80186 ../testbench/utils.vhd
vcom -93 -quiet -work i80186 ../testbench/sram_behavior.vhd
vcom -93 -quiet -work i80186 ../testbench/port_mon.vhd
vcom -93 -quiet -work i80186 ../testbench/cpu186_tb.vhd

@REM Run simulation	Modelsim PE/DE/OEM
vsim -c i80186.cpu186_tb -do "set StdArithNoWarnings 1; run 300 us; quit"

@REM Run simulation	Modelsim SE/Questa
rem vsim -c -voptargs="+acc+sram" i80186.cpu186_tb -do "set StdArithNoWarnings 1; run 300 us; quit"
