`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.03.2026 11:23:27
// Design Name: 
// Module Name: adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module adder(
 input A,
 input B,
 input Cin,
 output Sum,
 output Cout
    );
assign Sum= A^B^Cin;
assign Cout= (A&B)|(B&Cin)|(A&Cin);
endmodule