# Description
A Full Adder is a combinational circuit that adds two 1-bit binary numbers along with a carry input and produces a Sum and Carry-out. It is the fundamental building block of all arithmetic circuits like ALUs, multipliers, and processors.

# Boolean Equations
Sum  = A ⊕ B ⊕ Cin
Cout = (A·B) + (B·Cin) + (A·Cin)

# Tool Credits
Tool names appearing in generated files belong to their respective authors:

University of Toronto → VPR (Place & Route)
University of Utah → OpenFPGA framework
YosysHQ → Yosys Synthesis Tool

The Verilog design (adder.v) and project setup are original work by the repository author.
