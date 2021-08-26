`timescale 1ns / 1ps

`define STRLEN 32
module tb_NextPCLogic;

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
  reg [63:0] CurrentPC, SignExtImm64;
  reg Branch, ALUZero, Uncondbranch;
  reg [7:0] passed;
  
  // Outputs
  wire [63:0] NextPC;
  
  // Instantiate UUT
  NextPCLogic uut (
    .NextPC(NextPC),
    .CurrentPC(CurrentPC),
    .SignExtImm64(SignExtImm64),
    .Branch(Branch),
    .ALUZero(ALUZero),
    .Uncondbranch(Uncondbranch)
  );

  initial begin
    // Initialize inputs
    CurrentPC = 0;
    SignExtImm64 = 0;
    Branch = 0;
    ALUZero = 0;
    Uncondbranch = 0;
    passed = 0;

    // Add stimulus.
    #10; {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'd0, 64'd0, 3'b000}; #10;
    $display("CurrentPC: %16h, SignExtImm64: %16h, Branch: %1b, ALUZero: %1b, UncondBranch: %1b", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
    $display("NextPC: %16h", NextPC);
    passTest(NextPC, 64'd4, "PC+4", passed);

    #10; {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'd180, 64'd3, 3'b001}; #10;
    $display("CurrentPC: %16h, SignExtImm64: %16h, Branch: %1b, ALUZero: %1b, UncondBranch: %1b", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
    $display("NextPC: %16h", NextPC);
    passTest(NextPC, 64'd192, "Uncondbranch", passed);

    #10; {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'd180, -64'd3, 3'b110}; #10;
    $display("CurrentPC: %16h, SignExtImm64: %16h, Branch: %1b, ALUZero: %1b, UncondBranch: %1b", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
    $display("NextPC: %16h", NextPC);
    passTest(NextPC, 64'd168, "CBZ - branch taken", passed);

    #10; {CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch} = {64'd180, -64'd3, 3'b100}; #10;
    $display("CurrentPC: %16h, SignExtImm64: %16h, Branch: %1b, ALUZero: %1b, UncondBranch: %1b", CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
    $display("NextPC: %16h", NextPC);
    passTest(NextPC, 64'd184, "CBZ - branch not taken", passed);

		allPassed(passed, 4);
    $finish;
  end
endmodule
