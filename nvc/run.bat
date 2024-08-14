@REM ------------------------------------------------------
@REM Simple DOS batch file to compile and run the testbench
@REM on Nick Gasson's nvc VHDL simulator
@REM Ver 1.0 HT-Lab 2006
@REM ------------------------------------------------------


@REM Compile HTL80186
nvc --std=1993 --work=i80186 -a ../rtl/cpu86instr.vhd
nvc --std=1993 --work=i80186 -a ../rtl/cpu86pack.vhd
nvc --std=1993 --work=i80186 -a ../rtl/newbiufsm_fsm.vhd
nvc --std=1993 --work=i80186 -a ../rtl/a_table.vhd
nvc --std=1993 --work=i80186 -a ../rtl/d_table.vhd
nvc --std=1993 --work=i80186 -a ../rtl/n_table.vhd
nvc --std=1993 --work=i80186 -a ../rtl/r_table.vhd
nvc --std=1993 --work=i80186 -a ../rtl/m_table.vhd
nvc --std=1993 --work=i80186 -a ../rtl/formatter_rtl.vhd
nvc --std=1993 --work=i80186 -a --relaxed ../rtl/newbiushift.vhd
nvc --std=1993 --work=i80186 -a ../rtl/rise_edge.vhd
nvc --std=1993 --work=i80186 -a ../rtl/biuirq_rtl.vhd
nvc --std=1993 --work=i80186 -a ../rtl/newbiu_rtl.vhd
nvc --std=1993 --work=i80186 -a ../rtl/dataregfile_rtl.vhd
nvc --std=1993 --work=i80186 -a ../rtl/segregfile_rtl.vhd
nvc --std=1993 --work=i80186 -a --relaxed ../rtl/divider_rtl_ser.vhd
nvc --std=1993 --work=i80186 -a ../rtl/multiplier_rtl.vhd
nvc --std=1993 --work=i80186 -a --relaxed ../rtl/alu_rtl.vhd
nvc --std=1993 --work=i80186 -a ../rtl/ipregister_rtl.vhd
nvc --std=1993 --work=i80186 -a --relaxed ../rtl/datapath_rtl.vhd
nvc --std=1993 --work=i80186 -a --relaxed ../rtl/proc_rtl.vhd

nvc --std=1993 --work=i80186 -a ../rtl/I80188/cpu188_rtl.vhd

@REM Compile Testbench

nvc --std=1993 --work=i80186 -a ../testbench/utils.vhd
nvc --std=1993 --work=i80186 -a --relaxed sram_behavior.vhd
nvc --std=1993 --work=i80186 -a ../testbench/port_mon.vhd
nvc --std=1993 --work=i80186 -a bootstrap.vhd
nvc --std=1993 --work=i80186 -a demo188.vhd
nvc --std=1993 --work=i80186 -a demo188_tb.vhd

@REM Run simulation	Modelsim PE/DE (full 2300ms)
nvc --std=1993 --work=i80186 -e demo188_tb -r --ieee-warnings=off --stop-time=2300ms

