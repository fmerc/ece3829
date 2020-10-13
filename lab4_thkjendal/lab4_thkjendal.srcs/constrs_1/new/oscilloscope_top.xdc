## Clock
set_property PACKAGE_PIN W5 [get_ports clk_fpga]
    set_property IOSTANDARD LVCMOS33 [get_ports clk_fpga]
    create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk_fpga]


## Buttons
set_property PACKAGE_PIN U18 [get_ports reset]
    set_property IOSTANDARD LVCMOS33 [get_ports reset]

## Switches
set_property PACKAGE_PIN V17 [get_ports sw]
    set_property IOSTANDARD LVCMOS33 [get_ports sw]


## PmodALS Light Sensor (SPI interface JB)
# master-in-slave-out
set_property PACKAGE_PIN N17 [get_ports ls_sdo]
    set_property IOSTANDARD LVCMOS33 [get_ports ls_sdo]
# chip select
set_property PACKAGE_PIN K17 [get_ports ls_cs]
    set_property IOSTANDARD LVCMOS33 [get_ports ls_cs]
# slow clock
set_property PACKAGE_PIN P18 [get_ports ls_sclk]
    set_property IOSTANDARD LVCMOS33 [get_ports ls_sclk]


## VGA
# red
set_property PACKAGE_PIN G19 [get_ports {vga_r[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[0]}]
set_property PACKAGE_PIN H19 [get_ports {vga_r[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[1]}]
set_property PACKAGE_PIN J19 [get_ports {vga_r[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[2]}]
set_property PACKAGE_PIN N19 [get_ports {vga_r[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_r[3]}]
# green
set_property PACKAGE_PIN J17 [get_ports {vga_g[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[0]}]
set_property PACKAGE_PIN H17 [get_ports {vga_g[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[1]}]
set_property PACKAGE_PIN G17 [get_ports {vga_g[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[2]}]
set_property PACKAGE_PIN D17 [get_ports {vga_g[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_g[3]}]
# blue
set_property PACKAGE_PIN N18 [get_ports {vga_b[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[0]}]
set_property PACKAGE_PIN L18 [get_ports {vga_b[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[1]}]
set_property PACKAGE_PIN K18 [get_ports {vga_b[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[2]}]
set_property PACKAGE_PIN J18 [get_ports {vga_b[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {vga_b[3]}]
# hsync, vsync
set_property PACKAGE_PIN P19 [get_ports vga_hs]
    set_property IOSTANDARD LVCMOS33 [get_ports vga_hs]
set_property PACKAGE_PIN R19 [get_ports vga_vs]
    set_property IOSTANDARD LVCMOS33 [get_ports vga_vs]


## 7 Segment Display
set_property PACKAGE_PIN W7 [get_ports {sseg_seg[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_seg[0]}]
set_property PACKAGE_PIN W6 [get_ports {sseg_seg[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_seg[1]}]
set_property PACKAGE_PIN U8 [get_ports {sseg_seg[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_seg[2]}]
set_property PACKAGE_PIN V8 [get_ports {sseg_seg[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_seg[3]}]
set_property PACKAGE_PIN U5 [get_ports {sseg_seg[4]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_seg[4]}]
set_property PACKAGE_PIN V5 [get_ports {sseg_seg[5]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_seg[5]}]
set_property PACKAGE_PIN U7 [get_ports {sseg_seg[6]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_seg[6]}]

set_property PACKAGE_PIN U2 [get_ports {sseg_an[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_an[0]}]
set_property PACKAGE_PIN U4 [get_ports {sseg_an[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_an[1]}]
set_property PACKAGE_PIN V4 [get_ports {sseg_an[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_an[2]}]
set_property PACKAGE_PIN W4 [get_ports {sseg_an[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {sseg_an[3]}]
    

## CFGBVS-1#1 Warning
#   Missing CFGBVS and CONFIG_VOLTAGE Design Properties
set_property CFGBVS VCCO [current_design]           
set_property CONFIG_VOLTAGE 3.3 [current_design]