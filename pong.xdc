## Basys 3 Constraints - Pong

## 100 MHz Clock
set_property PACKAGE_PIN W5 [get_ports i_Clk]
set_property IOSTANDARD LVCMOS33 [get_ports i_Clk]
create_clock -period 10.000 -name sys_clk [get_ports i_Clk]

## Buttons (BTNU, BTNR, BTNL, BTND, BTNC)
set_property PACKAGE_PIN T18 [get_ports i_Switch_1]
set_property IOSTANDARD LVCMOS33 [get_ports i_Switch_1]
set_property PACKAGE_PIN U17 [get_ports i_Switch_2]
set_property IOSTANDARD LVCMOS33 [get_ports i_Switch_2]
set_property PACKAGE_PIN W19 [get_ports i_Switch_3]
set_property IOSTANDARD LVCMOS33 [get_ports i_Switch_3]
set_property PACKAGE_PIN T17 [get_ports i_Switch_4]
set_property IOSTANDARD LVCMOS33 [get_ports i_Switch_4]
set_property PACKAGE_PIN U18 [get_ports i_Game_Start]
set_property IOSTANDARD LVCMOS33 [get_ports i_Game_Start]

## VGA Red
set_property PACKAGE_PIN G19 [get_ports {o_VGA_Red[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_Red[0]}]
set_property PACKAGE_PIN H19 [get_ports {o_VGA_Red[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_Red[1]}]
set_property PACKAGE_PIN J19 [get_ports {o_VGA_Red[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_Red[2]}]
set_property PACKAGE_PIN N19 [get_ports {o_VGA_Red[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_Red[3]}]

## VGA Green
set_property PACKAGE_PIN J17 [get_ports {o_VGA_Grn[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_Grn[0]}]
set_property PACKAGE_PIN H17 [get_ports {o_VGA_Grn[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_Grn[1]}]
set_property PACKAGE_PIN G17 [get_ports {o_VGA_Grn[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_Grn[2]}]
set_property PACKAGE_PIN D17 [get_ports {o_VGA_Grn[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_Grn[3]}]

## VGA Blue
set_property PACKAGE_PIN N18 [get_ports {o_VGA_Blu[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_Blu[0]}]
set_property PACKAGE_PIN L18 [get_ports {o_VGA_Blu[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_Blu[1]}]
set_property PACKAGE_PIN K18 [get_ports {o_VGA_Blu[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_Blu[2]}]
set_property PACKAGE_PIN J18 [get_ports {o_VGA_Blu[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {o_VGA_Blu[3]}]

## VGA Sync
set_property PACKAGE_PIN P19 [get_ports o_VGA_HSync]
set_property IOSTANDARD LVCMOS33 [get_ports o_VGA_HSync]
set_property PACKAGE_PIN R19 [get_ports o_VGA_VSync]
set_property IOSTANDARD LVCMOS33 [get_ports o_VGA_VSync]
