/* Copyright (C) 2025  AGH University of Krakow */

module ring_counter #(
    parameter logic [2:0] SIZE = 3'b100,
    parameter logic  TYPE = 1'b0
)(
    input logic clk,
    input logic rst_n,
    input logic enabled,
    output logic [SIZE-1:0] value
);


/* Local variables and signals */

logic [SIZE-1:0] value_nxt;

/* Module internal logic */

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        value <= {{SIZE-1{~TYPE}}, TYPE};
    end else if (enabled) begin      
        value <= value_nxt;
    end
end

always_comb begin
    value_nxt = {value[0], value[SIZE-1:1]};
end
endmodule
