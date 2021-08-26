`timescale 1ns / 1ps

`define LDUROPCODE 11'b11111000010
`define STUROPCODE 11'b11111000000
`define ADDOPCODE  11'b10001011000
`define SUBOPCODE  11'b11001011000
`define ANDOPCODE  11'b10001010000
`define ORROPCODE  11'b10101010000
`define CBZOPCODE  11'b10110100???
`define BOPCODE    11'b000101?????

module SingleCycleControl(Reg2Loc, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Uncondbranch, ALUOp, Opcode);
  input [10:0] Opcode;
  output Reg2Loc;
  output ALUSrc;
  output MemToReg;
  output RegWrite;
  output MemRead;
  output MemWrite;
  output Branch;
  output Uncondbranch;

  output [1:0] ALUOp;

  // Output registers.
  reg Reg2Loc, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Uncondbranch;
  reg [1:0] ALUOp;

  always @ (Opcode) begin
    casez (Opcode)
      `LDUROPCODE: begin
        Reg2Loc      <= #2 1'bx;
        Uncondbranch <= #2 1'b0;
        Branch       <= #2 1'b0;
        MemRead      <= #2 1'b1;
        MemToReg     <= #2 1'b1;
        MemWrite     <= #2 1'b0;
        ALUSrc       <= #2 1'b1;
        RegWrite     <= #2 1'b1;
        ALUOp        <= #2 2'b00;
      end

      `STUROPCODE: begin
        Reg2Loc      <= #2 1'b1;
        Uncondbranch <= #2 1'b0;
        Branch       <= #2 1'b0;
        MemRead      <= #2 1'b0;
        MemToReg     <= #2 1'bx;
        MemWrite     <= #2 1'b1;
        ALUSrc       <= #2 1'b1;
        RegWrite     <= #2 1'b0;
        ALUOp        <= #2 2'b00;
      end

      `ADDOPCODE: begin
        Reg2Loc      <= #2 1'b0;
        Uncondbranch <= #2 1'b0;
        Branch       <= #2 1'b0;
        MemRead      <= #2 1'b0;
        MemToReg     <= #2 1'b0;
        MemWrite     <= #2 1'b0;
        ALUSrc       <= #2 1'b0;
        RegWrite     <= #2 1'b1;
        ALUOp        <= #2 2'b10;
      end

      `SUBOPCODE: begin
        Reg2Loc      <= #2 1'b0;
        Uncondbranch <= #2 1'b0;
        Branch       <= #2 1'b0;
        MemRead      <= #2 1'b0;
        MemToReg     <= #2 1'b0;
        MemWrite     <= #2 1'b0;
        ALUSrc       <= #2 1'b0;
        RegWrite     <= #2 1'b1;
        ALUOp        <= #2 2'b10;
      end

      `ANDOPCODE: begin
        Reg2Loc      <= #2 1'b0;
        Uncondbranch <= #2 1'b0;
        Branch       <= #2 1'b0;
        MemRead      <= #2 1'b0;
        MemToReg     <= #2 1'b0;
        MemWrite     <= #2 1'b0;
        ALUSrc       <= #2 1'b0;
        RegWrite     <= #2 1'b1;
        ALUOp        <= #2 2'b10;
      end

      `ORROPCODE: begin
        Reg2Loc      <= #2 1'b0;
        Uncondbranch <= #2 1'b0;
        Branch       <= #2 1'b0;
        MemRead      <= #2 1'b0;
        MemToReg     <= #2 1'b0;
        MemWrite     <= #2 1'b0;
        ALUSrc       <= #2 1'b0;
        RegWrite     <= #2 1'b1;
        ALUOp        <= #2 2'b10;
      end

      `CBZOPCODE: begin
        Reg2Loc      <= #2 1'b1;
        Uncondbranch <= #2 1'b0;
        Branch       <= #2 1'b1;
        MemRead      <= #2 1'b0;
        MemToReg     <= #2 1'bx;
        MemWrite     <= #2 1'b0;
        ALUSrc       <= #2 1'b0;
        RegWrite     <= #2 1'b0;
        ALUOp        <= #2 2'b01;
      end

      `BOPCODE: begin
        Reg2Loc      <= #2 1'bx;
        Uncondbranch <= #2 1'b1;
        Branch       <= #2 1'b0;
        MemRead      <= #2 1'b0;
        MemToReg     <= #2 1'bx;
        MemWrite     <= #2 1'b0;
        ALUSrc       <= #2 1'bx;
        RegWrite     <= #2 1'b0;
        ALUOp        <= #2 2'bxx;
      end

      // don't care about any values if opcode not specified.
      default: begin
        Reg2Loc      <= #2 1'bx;
        Uncondbranch <= #2 1'bx;
        Branch       <= #2 1'bx;
        MemRead      <= #2 1'bx;
        MemToReg     <= #2 1'bx;
        MemWrite     <= #2 1'bx;
        ALUSrc       <= #2 1'bx;
        RegWrite     <= #2 1'bx;
        ALUOp        <= #2 2'bxx;
      end
    endcase
  end
endmodule
