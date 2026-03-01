//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Netlist Summary
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sun Mar  1 07:15:59 2026
//-------------------------------------------
//----- Time scale -----
`timescale 1ns / 1ps

// ------ Include fabric top-level netlists -----
`include "./SRC/fabric_netlists.v"

`include "adder_output_verilog.v"

`include "./SRC/adder_top_formal_verification.v"
`include "./SRC/adder_formal_random_top_tb.v"
