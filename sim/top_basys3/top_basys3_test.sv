module top_basys3_test;
    logic clk;
    logic btnC;
    logic [15:0] sw;
    wire [6:0] seg;
    wire [3:0] an;

top_basys3 u_dut (
    .clk,
    .btnC,
    .sw,
    .an(an),
    .seg(seg)

);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin 

    btnC = 1;
    sw = 16'h0000;
    #100;
    btnC = 0;
    sw = 16'h1234;
    #500;
    sw = 16'hABCD;
    #500;
    $finish;

end

endmodule