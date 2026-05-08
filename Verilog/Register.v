module register_16bit
  (
    input wire         clk,
    input wire         rst,
    input wire         write_en,
    input wire         read_en,
    input wire [15:0]  data_in,
    output wire [15:0] data_out,
    output wire [15:0] debug_out // 用于调试输出
   );
   reg [15:0] data;
   
   always @(posedge clk or negedge rst) begin
      if (!rst) begin
         data <= 16'b0;
      end
      else if (write_en) begin
         data <= data_in;
      end
   end

   assign data_out = read_en ? data : 16'bzzzzzzzzzzzzzzzz;
   assign debug_out = data;
endmodule // register_16bit

module Register_X_16bit
  (
    input wire         clk,
    input wire         rst,
    input wire [15:0]  data_in,
    input wire         Xin,
    output wire [15:0] data_out
   );
   reg [15:0] X_reg;
   always @(posedge clk or negedge rst) begin
      if (-rst) begin
         X_reg <= 16'h0000;
      end else if (Xin) begin
         X_reg <= data_in;
      end
   end
endmodule // Register_X_16bit

module Register_Z_16bit
  (
    input wire         clk,
    input wire         rst,
    input wire         Zin,
    input wire         Zout,
    input wire [15:0]  data_in,
    output wire [15:0] data_out
   );
   reg [15:0] data;
   always @(posedge clk or negedge rst) begin
      if(!rst) begin
         data <= 16'b0;
      end else if (Zin) begin
         data <=data_in;
      end
   end
   assign data_out = Zout ? data : 16'bzzzzzzzzzzzzzzzz;
endmodule // Register_Z_16bit

module UIR
  (
    input        CPUIR,
    input [22:0] d,
    output micorIR22,
    output micorIR21,
    output micorIR20,
    output micorIR19,
    output micorIR18,
    output micorIR17,
    output micorIR16,
    output micorIR15,
    output micorIR14,
    output micorIR13,
    output micorIR12,
    output micorIR11,
    output micorIR10,
    output micorIR9,
    output micorIR8,
    output micorIR7,
    output micorIR6,
    output micorIR5,
    output micorIR4,
    output micorIR3,
    output micorIR2,
    output micorIR1,
    output micorIR0
   );
   assign {
           micorIR22, micorIR21, micorIR20,
           micorIR19, micorIR18, micorIR17, micorIR16, micorIR15,
           micorIR14, micorIR13, micorIR12, micorIR11, micorIR10,
           micorIR9, micorIR8, micorIR7, micorIR6, micorIR5,
           micorIR4, micorIR3, micorIR2, micorIR1, micorIR0
           } = d;
   
endmodule // UIR

module UIR_out
  (
    input wire [35:0] d,
    output wire       R0out,
    output wire       R1out,
    output wire       R2out,
    output wire       R0in,
    output wire       R1in,
    output wire       R2in,
    output wire       Xin,
    output wire       Zout,
    output wire       IRin,
    output wire       IRout,
    output wire       PCin,
    output wire       PCout,
    output wire       DREin,
    output wire       DREout,
    output wire       DRin,
    output wire       DRout,
    output wire       ARin,
    output wire       M,
    output wire [3:0] S,
    output wire       JP,
    output wire       MJP,
    output wire       QJP,
    output wire       G,
    output wire [9:0] addr_next
   );
   // 将 d 的每一位直接赋值给对应的控制信号
   assign addr_next = d[35:26];
   assign G = d[25];
   assign R0out = d[24];
   assign R1out = d[23];
   assign R2out = d[22];
   assign R0in  = d[21];
   assign R1in  = d[20];
   assign R2in  = d[19];
   assign Xin   = d[18];
   assign Zout  = d[17];
   assign IRin  = d[16];
   assign IRout = d[15];
   assign PCin  = d[14];
   assign PCout = d[13];
   assign DREin = d[12];
   assign DREout= d[11];
   assign DRin  = d[10];
   assign DRout = d[9];
   assign ARin  = d[8];
   assign M     = d[7];
   assign S     = d[6:3];   // 取 d[6],d[5],d[4],d[3]
   assign JP    = d[2];
   assign MJP   = d[1];
   assign QJP   = d[0];

endmodule   

module Instruction_Register_16bit
  (
    input wire         clk,
    input wire         rst,
    input wire [15:0]  Bus_in,
    input wire         IRin,
    input wire         IRout,
    output wire [15:0] IR_word_out,
    output wire [15:0] IR_data_out
   );
   reg [15:0] IR_reg;
   assign IR_word_out = IR_reg;
   assign IR_data_out = IRout ? IR_reg : 16'bzzzzzzzzzzzzzzzz;
   always @(posedge clk or negedge rst) begin
      if (~rst) begin
         IR_reg <= 16'h0000;
      end else if (IRin) begin
         IR_reg <= Bus_in;
      end
   end
endmodule // Instruction_Register_16bit

module Memory_Address_Register_8bit
  (
    input wire        clk,
    input wire        rst,
    input wire [7:0]  data_in,
    input wire        MARin,
    output wire       MDRout,
    output wire [7:0] Addr_out
   );
   reg [7:0] MAR_reg;
   assign Addr_out = MAR_reg;
   always @(posedge clk or negedge rst) begin
      if(~rst) begin
         MAR_reg <= 8'h00;
      end else if (MAR_reg) begin
         MAR_reg <=data_in;
      end
   end
   always @(*) begin
      if (MARin && MDRout) begin
         MAR_reg = data_in;
      end
   end
endmodule // Memory_Address_Register_8bit

module upc
  (
    input wire       clk,
    input wire       reset_n,
    input wire       load_en,
    input wire [9:0] data_in,
    output reg [9:0] pc_out
   );
   always @(posedge clk or negedge reset_n) begin
      if (!reset_n) begin              // 异步复位：立即清0，无需等待时钟
         pc_out <= 10'd0;
      end else if (load_en) begin      // 加载使能有效：加载新地址
         pc_out <= data_in;
      end else begin                   // 正常执行：PC自动递增（+1）
         pc_out <= pc_out + 10'd1;
      end
   end

endmodule
