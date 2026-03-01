//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: FPGA Verilog Testbench for Formal Top-level netlist of Design: adder
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sun Mar  1 07:15:59 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype none

module adder_top_formal_verification_random_tb;
// ----- Default clock port is added here since benchmark does not contain one -------
	reg [0:0] clk;

// ----- Shared inputs -------
	reg [0:0] A;
	reg [0:0] B;
	reg [0:0] Cin;

// ----- FPGA fabric outputs -------
	wire [0:0] Sum_gfpga;
	wire [0:0] Cout_gfpga;

// ----- Benchmark outputs -------
	wire [0:0] Sum_bench;
	wire [0:0] Cout_bench;

// ----- Output vectors checking flags -------
	reg [0:0] Sum_flag;
	reg [0:0] Cout_flag;

// ----- Error counter -------
	integer nb_error= 0;

// ----- FPGA fabric instanciation -------
	adder_top_formal_verification FPGA_DUT(
		.A(A),
		.B(B),
		.Cin(Cin),
		.Sum(Sum_gfpga),
		.Cout(Cout_gfpga)
	);
// ----- End FPGA Fabric Instanication -------

// ----- Reference Benchmark Instanication -------
	adder REF_DUT(
		.A(A),
		.B(B),
		.Cin(Cin),
		.Sum(Sum_bench),
		.Cout(Cout_bench)
	);
// ----- End reference Benchmark Instanication -------

// ----- Clock 'clk' Initialization -------
	initial begin
		clk[0] <= 1'b0;
		while(1) begin
			#1.075218201
			clk[0] <= !clk[0];
		end
	end

// ----- Begin reset signal generation -----
// ----- End reset signal generation -----

// ----- Input Initialization -------
	initial begin
		A <= 1'b0;
		B <= 1'b0;
		Cin <= 1'b0;

		Sum_flag[0] <= 1'b0;
		Cout_flag[0] <= 1'b0;
	end

// ----- Input Stimulus -------
	always@(negedge clk[0]) begin
		A <= $random;
		B <= $random;
		Cin <= $random;
	end

// ----- Begin checking output vectors -------
// ----- Skip the first falling edge of clock, it is for initialization -------
	reg [0:0] sim_start;

	always@(negedge clk[0]) begin
		if (1'b1 == sim_start[0]) begin
			sim_start[0] <= ~sim_start[0];
		end else 
begin
			if(!(Sum_gfpga === Sum_bench) && !(Sum_bench === 1'bx)) begin
				Sum_flag <= 1'b1;
			end else begin
				Sum_flag<= 1'b0;
			end
			if(!(Cout_gfpga === Cout_bench) && !(Cout_bench === 1'bx)) begin
				Cout_flag <= 1'b1;
			end else begin
				Cout_flag<= 1'b0;
			end
		end
	end

	always@(posedge Sum_flag) begin
		if(Sum_flag) begin
			nb_error = nb_error + 1;
			$display("Mismatch on Sum_gfpga at time = %t", $realtime);
		end
	end

	always@(posedge Cout_flag) begin
		if(Cout_flag) begin
			nb_error = nb_error + 1;
			$display("Mismatch on Cout_gfpga at time = %t", $realtime);
		end
	end


// ----- Begin output waveform to VCD file-------
	initial begin
		$dumpfile("adder_formal.vcd");
		$dumpvars(1, adder_top_formal_verification_random_tb);
	end
// ----- END output waveform to VCD file -------

initial begin
	sim_start[0] <= 1'b1;
	$timeformat(-9, 2, "ns", 20);
	$display("Simulation start");
// ----- Can be changed by the user for his/her need -------
	#4.300872803
	if(nb_error == 0) begin
		$display("Simulation Succeed");
	end else begin
		$display("Simulation Failed with %d error(s)", nb_error);
	end
	$finish;
end

endmodule
// ----- END Verilog module for adder_top_formal_verification_random_tb -----

