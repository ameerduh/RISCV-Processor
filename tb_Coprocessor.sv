module tb_Coprocessor;

    // Inputs
    logic clk;
    logic reset;
    logic start;
    logic [7:0] x0;
    logic [7:0] y0;
    logic Op;

    // Outputs
    logic Done;
    logic [7:0] result;

    // Instantiate the Coprocessor module
    Coprocessor dut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .x0(x0),
        .y0(y0),
        .Op(Op),
        .Done(Done),
        .result(result)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Initialize inputs
    initial begin
        clk = 0;
        reset = 1;
        start = 0;
        x0 = 12; // Example input values
        y0 = 18;
        Op = 0; // Compute GCD (change to 1 for LCM)
        #10 reset = 0;
        #10 start = 1;
        #100;
        $display("Result: %d", result);
        $display("Done: %b", Done);
        $finish;
    end

endmodule
