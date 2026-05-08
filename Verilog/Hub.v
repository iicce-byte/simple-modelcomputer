module Bus_Splitter_16to16x1
  (
    input wire [15:0] Data_in,
    output wire Out_0,
    output wire Out_1,
    output wire Out_2,
    output wire Out_3,
    output wire Out_4,
    output wire Out_5,
    output wire Out_6,
    output wire Out_7,
    output wire Out_8,
    output wire Out_9,
    output wire Out_10,
    output wire Out_11,
    output wire Out_12,
    output wire Out_13,
    output wire Out_14,
    output wire Out_15
   );
   assign Out_0  = Data_in[0];
   assign Out_1  = Data_in[1];
   assign Out_2  = Data_in[2];
   assign Out_3  = Data_in[3];
   assign Out_4  = Data_in[4];
   assign Out_5  = Data_in[5];
   assign Out_6  = Data_in[6];
   assign Out_7  = Data_in[7];
   assign Out_8  = Data_in[8];
   assign Out_9  = Data_in[9];
   assign Out_10 = Data_in[10];
   assign Out_11 = Data_in[11];
   assign Out_12 = Data_in[12];
   assign Out_13 = Data_in[13];
   assign Out_14 = Data_in[14];
   assign Out_15 = Data_in[15];
endmodule // Bus_Splitter_16to16x1

module Data_Hub_16to8x2
  (
    input wire [15:0]  Data_16in,
    output wire [15:0] Data_16out,

    input wire [7:0]  Data_High_8in,
    input wire [7:0]  Data_Low_8in,

    output wire [7:0] Data_High_8out,
    output wire [7:0] Data_Low_8out
   );
   assign Data_High_8out = Data_16in[15:8];
   assign Data_Low_8out = Data_16in[7:0];
   assign Data_16out = {Data_High_8in, Data_Low_8in};
endmodule // Data_Hub_16to8x2

module Bus_Splitter_10to10x1
  (
    input wire [9:0] addr_next,
    output wire ad0,
    output wire ad1,
    output wire ad2,
    output wire ad3,
    output wire ad4,
    output wire ad5,
    output wire ad6,
    output wire ad7,
    output wire ad8,
    output wire ad9
   );
   assign ad0 = addr_next[0];
   assign ad1 = addr_next[1];
   assign ad2 = addr_next[2];
   assign ad3 = addr_next[3];
   assign ad4 = addr_next[4];
   assign ad5 = addr_next[5];
   assign ad6 = addr_next[6];
   assign ad7 = addr_next[7];
   assign ad8 = addr_next[8];
   assign ad9 = addr_next[9];
endmodule
