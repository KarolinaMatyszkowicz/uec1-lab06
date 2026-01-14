/* Copyright (C) 2025  AGH University of Krakow */

module counter #(
    parameter WIDTH = 4,
    parameter logic [WIDTH-1:0] MAX_VALUE = {WIDTH{1'b1}}
) (
    input logic clk,
    input logic rst_n,
    input logic enabled,
    output logic [WIDTH-1:0] value,
    output logic overflow
);


/* Local variables and signals */

logic [WIDTH-1:0] value_nxt;
logic overflow_nxt;

/* Module internal logic */

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        value <= 'b0;
        overflow <= 'b0;
    end else begin
        value <= value_nxt;
        overflow <= overflow_nxt;
    end
end

always_comb begin
    value_nxt = value;
    overflow_nxt = overflow;
    if (enabled) begin
        value_nxt = value + 1;
        overflow_nxt = 'b0;
        if (value == MAX_VALUE) begin
            overflow_nxt = 'b1;
            value_nxt = 'b0;
        end
    end
end

endmodule
