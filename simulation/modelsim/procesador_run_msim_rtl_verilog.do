transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Memory {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Memory/DataMem.v}
vlog -vlog01compat -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/InstructionFetch {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/InstructionFetch/IMem.v}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/InstructionFetch {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/InstructionFetch/sumador.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/InstructionFetch {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/InstructionFetch/program_counter.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/InstructionFetch {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/InstructionFetch/mux2_1.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/InstructionFetch {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/InstructionFetch/IF_ID_Reg.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1 {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/procesador.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Docode {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Docode/extend.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Docode {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Docode/register_file.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Docode {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Docode/Control_Unit.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Execute {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Execute/EXE_MEM_Reg.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Execute {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Execute/alu.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Execute {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Execute/mux_Exe.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Execute {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Execute/compuerta.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Docode {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Docode/ID_EXE_Reg.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Memory {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Memory/MEM_WB_Reg.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/WriteBack {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/WriteBack/mux_WB.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/vga {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/vga/vga.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/vga {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/vga/pll.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/vga {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/vga/vgaController.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/vga {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/vga/videoGen.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Docode {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Docode/shiftLPC.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Docode {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Docode/muxDeco.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Docode {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Docode/muxSrc.sv}
vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Execute {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/Execute/aluFlags.sv}

vlog -sv -work work +incdir+C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/testbench {C:/Users/mario/Documents/GitHub/Proyecto-2-Arqui1/testbench/procesador_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  procesador_tb

add wave *
view structure
view signals
run -all
