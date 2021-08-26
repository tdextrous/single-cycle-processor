`timescale 1ns / 10ps
`define STRLEN 15

module tb_SignExtender;

	task passTest;
		input actualOut, expectedOut;
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

  // UUT inputs
  reg [31:0] Instr32;
  
  // Test-specific registers
  reg [7:0] passed;

  // UUT Outputs
  wire [63:0] BusImm;

  // Instantiate unit under test (UUT)
  SignExtender uut(
    .BusImm(BusImm),
    .Instr32(Instr32)
  );

  // Start test
  initial begin
    // instantiate test bench inputs
    passed = 0;
    Instr32 = 0;


    // run tests 
    /* unconditional branch tests */
    #5; Instr32 = {6'b00101, 26'b0101}; #5; passTest(BusImm, 64'b101, "B-Type 1 (pos)", passed);
    #5; Instr32 = {6'b00101, -26'b1110}; #5; passTest(BusImm, -64'b1110, "B-Type 2 (neg)", passed);

    /* data type tests */
    // LDUR - LDUR X0, [X0, #15]
    #5; Instr32 = {11'b11111000010, 9'd15, 2'd0, 5'd0, 5'd0}; #5; passTest(BusImm, 64'd15, "D-Type 1 (pos)", passed);
    #5; Instr32 = {11'b11111000010, -9'd9, 2'd0, 5'd0, 5'd0}; #5; passTest(BusImm, -64'd9, "D-Type 2 (neg)", passed);

    // STUR
    #5; Instr32 = {11'b11111000000, 9'd13, 2'd0, 5'd0, 5'd0}; #5; passTest(BusImm, 64'd13, "D-Type 3 (pos)", passed);
    #5; Instr32 = {11'b11111000000, -9'd7, 2'd0, 5'd0, 5'd0}; #5; passTest(BusImm, -64'd7, "D-Type 4 (neg)", passed);

    /* conditional branch tests */
    #5; Instr32 = {8'b10110100, 19'd19, 5'd0}; #5; passTest(BusImm, 64'd19, "CB-Type 1 (pos)", passed);
    #5; Instr32 = {8'b10110100, -19'd3, 5'd0}; #5; passTest(BusImm, -64'd3, "CB-Type 2 (neg)", passed);
    
    #5; allPassed(passed, 8);
    $stop;
  end


endmodule
