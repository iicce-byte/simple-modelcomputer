module crom_1024x36
  (
    input         inclock,
    input [9:0]   address,
    output [35:0] q
   );

   crom crom_i
     (
      .clka(inclock),
      .address(address),
      .douta(q)
      );
endmodule // crom_1024x36

module Memory
  (
    input [15:0]  data,
    output [15:0] q,
    input [7:0] address,
    input wren,
    input inclock
   );

   ram ram_i
     (
      .clka(inclock),
      .wea(wren),
      .address(address),
      .dina(data),
      .douta(q)
      );
endmodule
