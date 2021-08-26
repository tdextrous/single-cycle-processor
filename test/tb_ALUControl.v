`timescale 1ns / 1ps

`define STRLEN 32
module tb_ALUControl;

	task passTest;
		input [63:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask

  // Inputs 
  reg [1:0] ALUop;
  reg [10:0] Opcode;
	reg [7:0] passed;

  // Outputs
  wire [3:0] ALUCtrl;

  // Instantiate UUT
  ALUControl uut (
    .ALUCtrl(ALUCtrl),
    .ALUop(ALUop),
    .Opcode(Opcode)
  );

  initial begin
    // Initialize Inputs
    ALUop = 0;
    Opcode = 0;
    passed = 0;

    // Add stimulus here.
    #10; {ALUop, Opcode} = {2'b00, 11'd0}; #10;
    $display("ALUop: %2b, Opcode: %11b, ALUCtrl: %4b", ALUop, Opcode, ALUCtrl);
    passTest(ALUCtrl, 4'b0010, "LDUR/STUR", passed);

    #10; {ALUop, Opcode} = {2'b01, 11'd49}; #10;
    $display("ALUop: %2b, Opcode: %11b, ALUCtrl: %4b", ALUop, Opcode, ALUCtrl);
    passTest(ALUCtrl, 4'b0111, "CBZ", passed);

    #10; {ALUop, Opcode} = {2'b10, 11'b11001011000}; #10;
    $display("ALUop: %2b, Opcode: %11b, ALUCtrl: %4b", ALUop, Opcode, ALUCtrl);
    passTest(ALUCtrl, 4'b0110, "SUB", passed);

    #10; {ALUop, Opcode} = {2'b10, 11'b10101010000}; #10;
    $display("ALUop: %2b, Opcode: %11b, ALUCtrl: %4b", ALUop, Opcode, ALUCtrl);
    passTest(ALUCtrl, 4'b0001, "ORR", passed);

    #10; {ALUop, Opcode} = {2'b10, 11'b10001010000}; #10;
    $display("ALUop: %2b, Opcode: %11b, ALUCtrl: %4b", ALUop, Opcode, ALUCtrl);
    passTest(ALUCtrl, 4'b0000, "AND", passed);

    #10; {ALUop, Opcode} = {2'b10, 11'b10001011000}; #10;
    $display("ALUop: %2b, Opcode: %11b, ALUCtrl: %4b", ALUop, Opcode, ALUCtrl);
    passTest(ALUCtrl, 4'b0010, "ADD", passed);

    #10; {ALUop, Opcode} = {2'b10, 11'b10101010000}; #10;
    $display("ALUop: %2b, Opcode: %11b, ALUCtrl: %4b", ALUop, Opcode, ALUCtrl);
    passTest(ALUCtrl, 4'b0001, "ORR", passed);

    #10; {ALUop, Opcode} = {2'b10, 11'b10001011000}; #10;
    $display("ALUop: %2b, Opcode: %11b, ALUCtrl: %4b", ALUop, Opcode, ALUCtrl);
    passTest(ALUCtrl, 4'b0010, "ADD", passed);

    #10; {ALUop, Opcode} = {2'b10, 11'b11001011000}; #10;
    $display("ALUop: %2b, Opcode: %11b, ALUCtrl: %4b", ALUop, Opcode, ALUCtrl);
    passTest(ALUCtrl, 4'b0110, "SUB", passed);

		allPassed(passed, 9);
    $finish;
  end
endmodule
