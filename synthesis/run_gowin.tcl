set a1 [lindex $argv 0] 
set a2 [lindex $argv 1] 
puts "Place Option $a1"
puts "Route Option $a2"
set basename cpu186$a1$a2

add_file -type vhdl "../rtl/cpu86instr.vhd"
set_file_prop       "../rtl/cpu86instr.vhd" -lib {I80186}
add_file -type vhdl "../rtl/cpu86pack.vhd"
set_file_prop       "../rtl/cpu86pack.vhd" -lib {I80186}
add_file -type vhdl "../rtl/newbiufsm_fsm.vhd"
add_file -type vhdl "../rtl/rise_edge.vhd"
add_file -type vhdl "../rtl/a_table.vhd"
add_file -type vhdl "../rtl/d_table.vhd"
add_file -type vhdl "../rtl/n_table.vhd"
add_file -type vhdl "../rtl/r_table.vhd"
add_file -type vhdl "../rtl/m_table.vhd"
add_file -type vhdl "../rtl/formatter_rtl.vhd"
add_file -type vhdl "../rtl/newbiushift.vhd"
add_file -type vhdl "../rtl/biuirq_rtl.vhd"
add_file -type vhdl "../rtl/newbiu_rtl.vhd"
add_file -type vhdl "../rtl/dataregfile_rtl.vhd"
add_file -type vhdl "../rtl/segregfile_rtl.vhd"
add_file -type vhdl "../rtl/divider_rtl_ser.vhd"
add_file -type vhdl "../rtl/multiplier_rtl.vhd"
add_file -type vhdl "../rtl/alu_rtl.vhd"
add_file -type vhdl "../rtl/ipregister_rtl.vhd"
add_file -type vhdl "../rtl/datapath_rtl.vhd"
add_file -type vhdl "../rtl/proc_rtl.vhd"
add_file -type vhdl "../rtl/cpu186_rtl.vhd"


#add_file -type cst  "HTL80186.cst"
add_file -type sdc  "htl80186.sdc"
#set_device GW1NR-LV9LQ144PC6/I5 -name GW1NR-9
set_device GW2A-LV18PG256C8/I7 -name GW2A-18C
set_option -synthesis_tool gowinsynthesis
set_option -output_base_name HTL80186$a1$a2
set_option -rpt_auto_place_io_info 1
set_option -gen_text_timing_rpt 1
set_option -top_module cpu186
set_option -vhdl_std vhd2008
set_option -use_mspi_as_gpio 1
set_option -use_sspi_as_gpio 1
set_option -print_all_synthesis_warning 1


#default 1, option 0
set_option -timing_driven 1

# default 0, option 1
set_option -place_option $a1

#default 0 option 1,2
set_option -route_option $a2

#set_option -gen_vhdl_sim_netlist 1
#set_option -gen_sdf 1 
run all
