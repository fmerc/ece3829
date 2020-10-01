## Clock
set_property PACKAGE_PIN W5 [get_ports clk_fpga]
    set_property IOSTANDARD LVCMOS33 [get_ports clk_fpga]
    create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk_fpga]
    
## Buttons
set_property PACKAGE_PIN U18 [get_ports reset]
    set_property IOSTANDARD LVCMOS33 [get_ports reset]
    
## PmodALS Light Sensor (SPI interface JB)
# master-in-slave-out
set_property PACKAGE_PIN N17 [get_ports sdo]
    set_property IOSTANDARD LVCMOS33 [get_ports sdo]
# chip select
set_property PACKAGE_PIN K17 [get_ports cs]
    set_property IOSTANDARD LVCMOS33 [get_ports cs]
# slow clock
set_property PACKAGE_PIN P18 [get_ports sclk]
    set_property IOSTANDARD LVCMOS33 [get_ports sclk]


    
## 7 Segment Display
set_property PACKAGE_PIN W7 [get_ports {sseg_disp[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_disp[0]}]
set_property PACKAGE_PIN W6 [get_ports {sseg_disp[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_disp[1]}]
set_property PACKAGE_PIN U8 [get_ports {sseg_disp[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_disp[2]}]
set_property PACKAGE_PIN V8 [get_ports {sseg_disp[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_disp[3]}]
set_property PACKAGE_PIN U5 [get_ports {sseg_disp[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_disp[4]}]
set_property PACKAGE_PIN V5 [get_ports {sseg_disp[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_disp[5]}]
set_property PACKAGE_PIN U7 [get_ports {sseg_disp[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_disp[6]}]

set_property PACKAGE_PIN U2 [get_ports {sseg_enable[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_enable[0]}]
set_property PACKAGE_PIN U4 [get_ports {sseg_enable[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_enable[1]}]
set_property PACKAGE_PIN V4 [get_ports {sseg_enable[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_enable[2]}]
set_property PACKAGE_PIN W4 [get_ports {sseg_enable[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_enable[3]}]

## CFGBVS-1#1 Warning
#   Missing CFGBVS and CONFIG_VOLTAGE Design Properties
set_property CFGBVS VCCO [current_design]           
set_property CONFIG_VOLTAGE 3.3 [current_design]    