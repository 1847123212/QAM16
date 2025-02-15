transcript on
if ![file isdirectory myqam_iputf_libs] {
	file mkdir myqam_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
vlib myqam_iputf_libs/nco_ii_0
vmap nco_ii_0 ./myqam_iputf_libs/nco_ii_0
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 

file copy -force C:/class/class36/prj/ip/nco/simulation/submodules/nco_nco_ii_0_sin.hex ./
file copy -force C:/class/class36/prj/ip/nco/simulation/submodules/nco_nco_ii_0_cos.hex ./

vlog "C:/class/class36/prj/ip/nco/simulation/submodules/mentor/sid_2c_1p.v"                -work nco_ii_0
vlog "C:/class/class36/prj/ip/nco/simulation/submodules/mentor/asj_nco_mob_rw.v"           -work nco_ii_0
vlog "C:/class/class36/prj/ip/nco/simulation/submodules/mentor/asj_gar.v"                  -work nco_ii_0
vlog "C:/class/class36/prj/ip/nco/simulation/submodules/mentor/asj_nco_isdr.v"             -work nco_ii_0
vlog "C:/class/class36/prj/ip/nco/simulation/submodules/mentor/asj_nco_apr_dxx.v"          -work nco_ii_0
vlog "C:/class/class36/prj/ip/nco/simulation/submodules/mentor/segment_arr_tdl.v"          -work nco_ii_0
vlog "C:/class/class36/prj/ip/nco/simulation/submodules/mentor/segment_sel.v"              -work nco_ii_0
vlog "C:/class/class36/prj/ip/nco/simulation/submodules/mentor/asj_dxx_g.v"                -work nco_ii_0
vlog "C:/class/class36/prj/ip/nco/simulation/submodules/mentor/asj_dxx.v"                  -work nco_ii_0
vlog "C:/class/class36/prj/ip/nco/simulation/submodules/mentor/asj_xnqg.v"                 -work nco_ii_0
vlog "C:/class/class36/prj/ip/nco/simulation/submodules/mentor/asj_nco_as_m_cen.v"         -work nco_ii_0
vlog "C:/class/class36/prj/ip/nco/simulation/submodules/mentor/asj_altqmcpipe.v"           -work nco_ii_0
vlog "C:/class/class36/prj/ip/nco/simulation/submodules/nco_nco_ii_0.v"                    -work nco_ii_0
vlog "C:/class/class36/prj/ip/nco/simulation/nco.v"                                                      
vcom "C:/class/class36/prj/ip/fir_lpf_sim/dspba_library_package.vhd"                                     
vcom "C:/class/class36/prj/ip/fir_lpf_sim/dspba_library.vhd"                                             
vcom "C:/class/class36/prj/ip/fir_lpf_sim/auk_dspip_math_pkg_hpfir.vhd"                                  
vcom "C:/class/class36/prj/ip/fir_lpf_sim/auk_dspip_lib_pkg_hpfir.vhd"                                   
vcom "C:/class/class36/prj/ip/fir_lpf_sim/auk_dspip_avalon_streaming_controller_hpfir.vhd"               
vcom "C:/class/class36/prj/ip/fir_lpf_sim/auk_dspip_avalon_streaming_sink_hpfir.vhd"                     
vcom "C:/class/class36/prj/ip/fir_lpf_sim/auk_dspip_avalon_streaming_source_hpfir.vhd"                   
vcom "C:/class/class36/prj/ip/fir_lpf_sim/auk_dspip_roundsat_hpfir.vhd"                                  
vlog "C:/class/class36/prj/ip/fir_lpf_sim/altera_avalon_sc_fifo.v"                                       
vcom "C:/class/class36/prj/ip/fir_lpf_sim/fir_lpf_rtl_core.vhd"                                          
vcom "C:/class/class36/prj/ip/fir_lpf_sim/fir_lpf_ast.vhd"                                               
vcom "C:/class/class36/prj/ip/fir_lpf_sim/fir_lpf.vhd"                                                   
vcom "C:/class/class36/prj/ip/fir_lpf_sim/fir_lpf_tb.vhd"                                                

vlog -vlog01compat -work work +incdir+C:/class/class36/rtl {C:/class/class36/rtl/nco_top.v}
vlog -vlog01compat -work work +incdir+C:/class/class36/prj/ip {C:/class/class36/prj/ip/bit_source.v}
vlog -vlog01compat -work work +incdir+C:/class/class36/rtl {C:/class/class36/rtl/source.v}
vlog -vlog01compat -work work +incdir+C:/class/class36/rtl {C:/class/class36/rtl/BitTrans.v}
vlog -vlog01compat -work work +incdir+C:/class/class36/testbench {C:/class/class36/testbench/tb_BitTrans.v}
vlog -vlog01compat -work work +incdir+C:/class/class36/rtl {C:/class/class36/rtl/CodeMap.v}
vlog -vlog01compat -work work +incdir+C:/class/class36/prj/ip {C:/class/class36/prj/ip/mult19_10.v}
vlog -vlog01compat -work work +incdir+C:/class/class36/rtl {C:/class/class36/rtl/myqam.v}
vlog -vlog01compat -work work +incdir+C:/class/class36/rtl {C:/class/class36/rtl/upsample.v}
vlog -vlog01compat -work work +incdir+C:/class/class36/rtl {C:/class/class36/rtl/BoardTst.v}
vlog -vlog01compat -work work +incdir+C:/class/class36/prj/ip {C:/class/class36/prj/ip/pll.v}
vlog -vlog01compat -work work +incdir+C:/class/class36/prj/db {C:/class/class36/prj/db/pll_altpll.v}

vlog -vlog01compat -work work +incdir+C:/class/class36/prj/../testbench {C:/class/class36/prj/../testbench/tb_BoardTst.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L nco_ii_0 -voptargs="+acc"  tb_BoardTst

add wave *
view structure
view signals
run -all
