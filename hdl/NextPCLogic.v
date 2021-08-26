module NextPCLogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch);
  input [63:0] CurrentPC, SignExtImm64;
  input Branch, ALUZero, Uncondbranch;
  output [63:0] NextPC;

  /* Setup modules/intermediary nets */
  wire PCSrc;  // Logic to determine whether to branch or not
  wire [63:0] BranchAddr, NextAddr;  // Address from branch offset and pc+4, resp.

  /* Assign intermediary nets */
  assign PCSrc = Uncondbranch | (Branch & ALUZero);
  assign #2 BranchAddr = {SignExtImm64[61:0], 2'b00} + CurrentPC;  // combine shift left 2 with add
  assign #1 NextAddr = CurrentPC + 3'd4;

  /* Determine output based on PCSrc */
  assign #1 NextPC = (PCSrc ? BranchAddr : NextAddr);
endmodule
