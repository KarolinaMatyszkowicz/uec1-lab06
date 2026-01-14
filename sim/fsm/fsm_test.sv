/* Copyright (C) 2025  AGH University of Krakow */

module fsm_test;


/* Local variables and signals */

localparam logic [6:0] MAX_COUNT = 7'b10100;
localparam logic [6:0] ST1_COUNTER = 7'b100111;

logic clk, rst_n;

logic trigger, done, led, en;


/* Submodules placement */

fsm #(
    .MAX_COUNT(MAX_COUNT),
    .ST1_COUNTER(ST1_COUNTER)
) dut (
    .clk,
    .rst_n,
    .done,
    .led,
    .trigger,
    .en
    
);


/* Tasks and functions definitions */

task reset();
    for (int i = 0; i < 2; ++i) begin
        @(negedge clk);
        rst_n = i[0];
    end
endtask

task test_non_triggered_fsm();
    for (int i = 0; i < 15; ++i) begin
        assert (!done) else begin
            $error("done: exp: %b, rcv: %b", 1'b0, done);
        end
        @(negedge clk);
    end
endtask

task test_triggered_fsm();
    @(negedge clk);
    trigger = 1'b1;

    fork
        begin
            @(negedge clk);
            trigger = 1'b0;
        end
        begin
            for (int i = 0; i < MAX_COUNT ; ++i) begin
                @(negedge clk);
                assert (!done) else begin
                    $error("done: exp: %b, rcv: %b", 1'b0, done);
                end
            end

            @(negedge clk);
            assert (done) else begin
                $error("done: exp: %b, rcv: %b", 1'b1, done);
            end
        end
    join
endtask


/* Clock generation */

initial begin
    clk = 1'b0;

    forever begin
        clk = #5ns ~clk;
    end
end


/* Test */

initial begin
    trigger = 1'b0;
    en = 1'b1;
    reset();

    test_non_triggered_fsm();
    test_triggered_fsm();
    
    #500ns;
    en = ~en;
    test_triggered_fsm();
    #500ns;
    $finish();
end

endmodule
