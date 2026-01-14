/* Copyright (C) 2025 AGH University of Krakow */

module fsm #(
    parameter logic [6:0] MAX_COUNT = 7'b0010100,
    parameter logic [6:0] ST1_COUNTER = 7'b0100111
) (
    input logic clk,
    input logic rst_n,
    output logic done,
    output logic led,
    input logic trigger,
    input logic en
);


/* User defined types and constants */

typedef enum logic [1:0] {
    IDLE,
    ACTIVE,
    ST1
} state_t;


/* Local variables and signals */

state_t state, state_nxt;
logic [6:0] counter, counter_nxt;


/* Module internal logic */

/* State Sequencer Logic */
always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= IDLE;
        counter <= 7'b0;
    end else begin
        state <= state_nxt;
        counter <= counter_nxt;
    end
end

/* Next State Decode Logic */
always_comb begin
    state_nxt = state;
    counter_nxt = counter;

    case (state)
        IDLE: begin
            if (trigger) begin
                state_nxt = ACTIVE;
            end
        end
        ACTIVE: begin
            if (counter == MAX_COUNT) begin
                state_nxt = ST1;
                counter_nxt = 7'b0;
            end else begin
                counter_nxt = counter + 1;
            end
        end
        ST1: begin
            if (counter == ST1_COUNTER) begin
                counter_nxt = 7'b0;
                state_nxt = IDLE;
            //end else if (counter[3] == 1) begin

            end
            else begin
                counter_nxt = counter + 1;
            end
        end
    endcase
end

/* Output Decode Logic */
always_comb begin
    done = 1'b0;
    led = 1'b0;
    case (state)
        IDLE: ;
        ACTIVE: ;
        ST1: begin
            done = 1'b1;
            led = ((~counter[2]) & en);
        end
    endcase
end

endmodule
