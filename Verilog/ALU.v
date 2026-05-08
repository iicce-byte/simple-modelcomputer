/**********************
 * Module ALU
 * Description: A输入，B输入，M运算模式（0算术运算，1逻辑运算），S运算编码
 * 乘法、除法使用 8 位运算：
 * MUL：8bit * 8bit = 16bit
 * DIV：16bit / 8bit → 高8位商，低8位余数
 * {M, S}=='b00100 => ADD
 * {M, S}=='b00101 => SUB
 * {M, S}=='b00110 => MUL
 * {M, S}=='b00111 => DIV
 * {M, S}=='b01000 => INC
 * {M, S}=='b01001 => DEC
 * {M, S}=='b01010 => SAL
 * {M, S}=='b01011 => SAR
 * {M, S}=='b11100 => AND
 * {M, S}=='b11101 => OR
 * {M, S}=='b11110 => XOR
 * {M, S}=='b10000 => NOT
 * {M, S}=='b10001 => SHL
 * {M, S}=='b10010 => SHR
 *********************/
module ALU
(
 input wire [15:0] A,
 input wire [15:0] B,
 input wire [3:0] S,
 input wire M,
 output reg [15:0] Data_out  // 输出保持16位
);
wire [4:0] op;
assign op = {M, S};
// 提取 8 位操作数（乘法、除法专用）
wire [7:0] A8 = A[7:0];
wire [7:0] B8 = B[7:0];

always @(*) begin
    case (op)
        // 算术运算 M=0
        5'b00100: Data_out = A + B;        // ADD
        5'b00101: Data_out = A - B;        // SUB
        5'b00110: Data_out = A8 * B8;     
        5'b00111: Data_out = { A8 / B8, A8 % B8 };
        5'b01000: Data_out = A + 1'b1;     // INC
        5'b01001: Data_out = A - 1'b1;     // DEC
        5'b01010: Data_out = A <<< 1;      // SAL
        5'b01011: Data_out = A >>> 1;      // SAR

        // 逻辑运算 M=1
        5'b11100: Data_out = A & B;        // AND
        5'b11101: Data_out = A | B;        // OR
        5'b11110: Data_out = A ^ B;        // XOR
        5'b10000: Data_out = ~A;           // NOT
        5'b10001: Data_out = A << 1;       // SHL
        5'b10010: Data_out = A >> 1;       // SHR

        default: Data_out = 16'd0;
    endcase
end

endmodule
