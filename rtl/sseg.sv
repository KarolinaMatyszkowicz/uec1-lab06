module sseg(
    input logic enabled,
    input logic rst_n,
    input logic clk,
    input  wire  [3:0] digit0,
    input  wire  [3:0] digit1,
    input  wire  [3:0] digit2,
    input  wire  [3:0] digit3,
    output logic [3:0] sseg_an,
    output logic [6:0] sseg_ca
);
logic [3:0] int_wire;

sseg_mux u_sseg_mux (
    .digit3,
    .digit2,
    .digit1,
    .digit0,
    .sel(sseg_an),
    .digit_selected(int_wire)
);
ring_counter u_ring_counter(
    .enabled,
    .rst_n,
    .clk,
    .value(sseg_an)
);
hex2sseg u_hex2sseg (
    .hex(int_wire),
    .sseg(sseg_ca)
    );

endmodule