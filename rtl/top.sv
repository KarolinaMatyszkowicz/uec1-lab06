module top (
    input logic rst_n,
    input logic clk,
    input  wire  [3:0] digit0,
    input  wire  [3:0] digit1,
    input  wire  [3:0] digit2,
    input  wire  [3:0] digit3,
    output logic [3:0] sseg_an,
    output logic [6:0] sseg_ca
);
logic int_wire;

sseg u_sseg(
    .digit0,
    .digit1,
    .digit2,
    .digit3,
    .clk,
    .rst_n,
    .enabled(int_wire),
    .sseg_an,
    .sseg_ca
);

counter #(.MAX_VALUE(19'd500000), .WIDTH(19)) u_counter (
    .clk,
    .rst_n,
    .enabled(1'b1),
    .overflow(int_wire),
    .value()
);

endmodule
