module RegisterFile(BusA, BusB, BusW, RA, RB, RW, RegWr, Clk);
  /* Instantiate inputs/outputs nets */
  output [63:0] BusA;
  output [63:0] BusB;
  input [63:0] BusW;
  input [4:0] RA;
  input [4:0] RB;
  input [4:0] RW;
  input RegWr;
  input Clk;

  /* Internal array of registers (32 registers 64 bits wide) */
  reg [63:0] registers [0:31];
  
  /* Initialize all registers to 0 */
  reg [4:0] i = 0;
  initial begin
    repeat (32) begin
      registers[i] = 0;
      i = i + 1;
    end
  end

  /* Assign register data to Bus A and Bus B */
  assign #2 BusA = registers[RA];
  assign #2 BusB = registers[RB];

  /* Perform reg write on clock negedge */
  always @ (negedge Clk) begin
    if (RegWr && (RW != 5'b11111)) registers[RW] <= #3 BusW;
  end
endmodule
