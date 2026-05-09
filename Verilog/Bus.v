module Bus_Collector_16bit
  (
    input wire [15:0] IR_data,
    input wire        IR_en,
    input wire [15:0] R0_data,
    input wire        R0_en,
    input wire [15:0] R1_data,
    input wire        R1_en,
    input wire [15:0] R2_data,
    input wire        R2_en,
    input wire [15:0] PC_data,
    input wire        PC_en,
    input wire [15:0] MDR_data,
    input wire        MDR_en,
    input wire [15:0] Z_data,
    input wire        Z_en,
    output reg [15:0] Bus_out
   );
   always @* begin
      Bus_out = 16'h0000;
      case (1'b1)
        (IR_en  === 1'b1): Bus_out = IR_data;
        (R0_en  === 1'b1): Bus_out = R0_data;
        (R1_en  === 1'b1): Bus_out = R1_data;
        (R2_en  === 1'b1): Bus_out = R2_data;
        (PC_en  === 1'b1): Bus_out = PC_data;
        (MDR_en === 1'b1): Bus_out = MDR_data;
        (Z_en   === 1'b1): Bus_out = Z_data;
        default;
      endcase // case (1'b1)
   end // always @ *
endmodule
