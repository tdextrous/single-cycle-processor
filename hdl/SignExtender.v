module SignExtender(BusImm, Instr32);
  /* Instantiate i/o nets */
  output [63:0] BusImm;
  input [31:0] Instr32;

  reg [63:0] ImmSigned64;

  /* Assign extBit based on the instruction format */
  always @ (Instr32) begin
    /* B-Type instruction */
    if (Instr32[31:26] == 6'b000101)
      ImmSigned64 = {{38{Instr32[25]}}, Instr32[25:0]};
    /* D-Type instruction, LDUR and STUR */
    else if (Instr32[31:21] == 11'd1984 || Instr32[31:21] == 11'd1986)
      ImmSigned64 = {{55{Instr32[20]}}, Instr32[20:12]};
    /* CB-Type instruction, CBZ */
    else if (Instr32[31:24] == 8'b10110100)
      ImmSigned64 = {{45{Instr32[23]}}, Instr32[23:5]};
    /* default */
    else ImmSigned64 = 0;
  end

  /* Set output to concatenation of extension bit and immediate value */
  assign BusImm = ImmSigned64;
endmodule
