module Coprocessor(
    input logic clk,
    input logic reset,
    input logic start,
    input logic [7:0] x0,
    input logic [7:0] y0,
    input logic Op, // 0 for GCD, 1 for LCM
    output logic Done,
    output logic [7:0] result
);
    logic [7:0] x, y;
    logic load_x, load_y, subtract_x, subtract_y, add_x, add_y;

    Co_datapath datapath_inst (
        .clk(clk),
        .reset(reset),
        .x0(x0),
        .y0(y0),
        .load_x(load_x),
        .load_y(load_y),
        .subtract_x(subtract_x),
        .subtract_y(subtract_y),
        .add_x(add_x),
        .add_y(add_y),
        .x(x),
        .y(y)
    );

    Co_controller controller_inst (
        .clk(clk),
        .reset(reset),
        .start(start),
        .x(x),
        .y(y),
        .Op(Op),
        .load_x(load_x),
        .load_y(load_y),
        .subtract_x(subtract_x),
        .subtract_y(subtract_y),
        .add_x(add_x),
        .add_y(add_y),
        .Done(Done),
        .result(result)
    );
endmodule
