module ALUControl(ALUCtrl, ALUop, Opcode);
  input [1:0] ALUop;
  input [10:0] Opcode;
  output [3:0] ALUCtrl;

  /* intermediate nets */
  reg [3:0] ctrl_out;  // to be wired to ALUCtrl

  always @ (ALUop or Opcode) begin
    case (ALUop)
      2'b00: ctrl_out = 4'b0010;  // LDUR/STUR
      2'b01: ctrl_out = 4'b0111;  // CBZ
      2'b10: begin  // R-Type
        case ({ Opcode[9], Opcode[8], Opcode[3] })  // These are the only r-type opcode bits that differ among 4 instructions listed.
          3'b001: ctrl_out = 4'b0010;  // ADD
          3'b101: ctrl_out = 4'b0110;  // SUB
          3'b000: ctrl_out = 4'b0000;  // AND
          3'b010: ctrl_out = 4'b0001;  // ORR
        endcase
       end
    endcase
  end

  assign #2 ALUCtrl = ctrl_out;

endmodule
