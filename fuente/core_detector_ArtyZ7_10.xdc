# Arty Z7 Pin Assignments
	
############################
## Clock signal

set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS33 } [get_ports { clk_i }]; #IO_L13P_T2_MRCC_35 Sch=SYSCLK
#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }];#set


##LEDs

#set_property -dict { PACKAGE_PIN R14    IOSTANDARD LVCMOS33 } [get_ports { led[0] }]; #IO_L6N_T0_VREF_34 Sch=LED0
#set_property -dict { PACKAGE_PIN P14    IOSTANDARD LVCMOS33 } [get_ports { led[1] }]; #IO_L6P_T0_34 Sch=LED1

##ChipKit Digital I/O Low

set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { sig_secuencia_i }]; #IO_L5P_T0_34 Sch=CK_IO0
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { sig_detec_o }]; #IO_L2N_T0_34 Sch=CK_IO1
set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { fail_o }]; #IO_L3P_T0_DQS_PUDC_B_34 Sch=CK_IO2