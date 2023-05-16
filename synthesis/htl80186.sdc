// 27.008MHz 
create_clock -name clk -period 25 -waveform {0 12.5} [get_ports {clk}]
