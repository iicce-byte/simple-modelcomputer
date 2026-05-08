module PCin_gen
  (
    input wire [15:0] instr_in,
    input wire [15:0] R2in,
    input wire PCin,
    output y
   );
   wire [5:0] opcode = instr_in[15:10];
   wire       JMP = (opcode == 6'b010011);
   wire       JNZ = (opcode == 6'b010100);
   wire       NZ = (R2in == 16'b0) ? 1'b0 : 1'b1;
   assign y = ((NZ & JNZ) | JMP) & PCin;
endmodule // PCin_gen

module or3
  (
   input a,
   input b,
   input c,
   output d
   );
   assign d = a | b | c;
endmodule // or3

