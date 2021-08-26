`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:02:47 03/05/2009
// Design Name:   ALU
// Module Name:   E:/350/Lab8/ALU/ALUTest.v
// Project Name:  ALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 32
module tb_ALU;

	task passTest;
		input [64:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %x should be %x", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

	// Inputs
	reg [63:0] BusA;
	reg [63:0] BusB;
	reg [3:0] ALUCtrl;
	reg [7:0] passed;

	// Outputs
	wire [63:0] BusW;
	wire Zero;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.BusW(BusW), 
		.Zero(Zero), 
		.BusA(BusA), 
		.BusB(BusB), 
		.ALUCtrl(ALUCtrl)
	);

	initial begin
		// Initialize Inputs
		BusA = 0;
		BusB = 0;
		ALUCtrl = 0;
		passed = 0;

                // Here is one example test vector, testing the ADD instruction:
		{BusA, BusB, ALUCtrl} = {64'h1234, 64'hABCD0000, 4'h2}; #40; passTest({Zero, BusW}, 65'h0ABCD1234, "ADD 0x1234,0xABCD0000", passed);
		//Reformate and add your test vectors from the prelab here following the example of the testvector above.	
    
    /* Test vectors */
    // AND
    {ALUCtrl, BusA, BusB} = {4'h0, 64'haa4ae191e382d508, 64'hc}; #40;
    passTest({Zero, BusW}, {1'b0, 64'h8}, "AND1", passed);

    {ALUCtrl, BusA, BusB} = {4'h0, 64'hfc5128fd1a513dd3, 64'h6}; #40;
    passTest({Zero, BusW}, {1'b0, 64'h2}, "AND2", passed);

    {ALUCtrl, BusA, BusB} = {4'h0, 64'h8c5401b5505d55b0, 64'hd}; #40;
    passTest({Zero, BusW}, {1'b1, 64'h0}, "AND3", passed);

    // OR
    {ALUCtrl, BusA, BusB} = {4'h1, 64'h4e9307db84c1baf0, 64'hc}; #40;
    passTest({Zero, BusW}, {1'b0, 64'h4e9307db84c1bafc}, "OR1", passed);

    {ALUCtrl, BusA, BusB} = {4'h1, 64'hacd2d26ca1ac27da, 64'h1}; #40;
    passTest({Zero, BusW}, {1'b0, 64'hacd2d26ca1ac27db}, "OR2", passed);

    {ALUCtrl, BusA, BusB} = {4'h1, 64'h84d0517f63145501, 64'h6}; #40;
    passTest({Zero, BusW}, {1'b0, 64'h84d0517f63145507}, "OR3", passed);

    // ADD
    {ALUCtrl, BusA, BusB} = {4'h2, 64'hc4f7d6a837e8a28, 64'h2}; #40;
    passTest({Zero, BusW}, {1'b0, 64'hc4f7d6a837e8a2a}, "ADD1", passed);

    {ALUCtrl, BusA, BusB} = {4'h2, 64'hfbc37e591daa1028, 64'hf}; #40;
    passTest({Zero, BusW}, {1'b0, 64'hfbc37e591daa1037}, "ADD2", passed);

    {ALUCtrl, BusA, BusB} = {4'h2, 64'h9a2c7e3a667a6957, 64'he}; #40;
    passTest({Zero, BusW}, {1'b0, 64'h9a2c7e3a667a6965}, "ADD3", passed);

    // SUB
    {ALUCtrl, BusA, BusB} = {4'h6, 64'hacf7118e4c75203d, 64'hf}; #40;
    passTest({Zero, BusW}, {1'b0, 64'hacf7118e4c75202e}, "SUB1", passed);

    {ALUCtrl, BusA, BusB} = {4'h6, 64'hb3a7516c8eac3a7c, 64'h2}; #40;
    passTest({Zero, BusW}, {1'b0, 64'hb3a7516c8eac3a7a}, "SUB2", passed);

    {ALUCtrl, BusA, BusB} = {4'h6, 64'h95b93acb4dab4c7c, 64'h3}; #40;
    passTest({Zero, BusW}, {1'b0, 64'h95b93acb4dab4c79}, "SUB3", passed);

    // LSL
    {ALUCtrl, BusA, BusB} = {4'h3, 64'h4e219ad931a99bdf, 64'h2}; #40;
    passTest({Zero, BusW}, {1'b0, 64'h38866b64c6a66f7c}, "LSL1", passed);

    {ALUCtrl, BusA, BusB} = {4'h3, 64'h9ae97eac0f342647, 64'he}; #40;
    passTest({Zero, BusW}, {1'b0, 64'h5fab03cd0991c000}, "LSL2", passed);

    {ALUCtrl, BusA, BusB} = {4'h3, 64'hd79644cbf99158e6, 64'h0}; #40;
    passTest({Zero, BusW}, {1'b0, 64'hd79644cbf99158e6}, "LSL3", passed);

    
    // LSR
    {ALUCtrl, BusA, BusB} = {4'h4, 64'h404e328b85888a92, 64'hc}; #40;
    passTest({Zero, BusW}, {1'b0, 64'h404e328b85888}, "LSR1", passed);

    {ALUCtrl, BusA, BusB} = {4'h4, 64'hc4010b89719c558c, 64'h9}; #40;
    passTest({Zero, BusW}, {1'b0, 64'h620085c4b8ce2a}, "LSR2", passed);

    {ALUCtrl, BusA, BusB} = {4'h4, 64'h664a96a6f38799a2, 64'h6}; #40;
    passTest({Zero, BusW}, {1'b0, 64'h1992a5a9bce1e66}, "LSR3", passed);

    // PassB
    {ALUCtrl, BusA, BusB} = {4'h7, 64'hae2bd3ec88b3c6f4, 64'h0}; #40;
    passTest({Zero, BusW}, {1'b1, 64'h0}, "PassB1", passed);

    {ALUCtrl, BusA, BusB} = {4'h7, 64'h3f323b9511bf414a, 64'h1}; #40;
    passTest({Zero, BusW}, {1'b0, 64'h1}, "PassB2", passed);

    {ALUCtrl, BusA, BusB} = {4'h7, 64'h20d875bed00216d0, 64'hc}; #40;
    passTest({Zero, BusW}, {1'b0, 64'hc}, "PassB3", passed);


		allPassed(passed, 22);
	end
      
endmodule

