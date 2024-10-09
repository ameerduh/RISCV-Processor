module Co_datapath(
    input logic clk,
    input logic reset,
    input logic [7:0] x0,
    input logic [7:0] y0,
    input logic load_x,
    input logic load_y,
    input logic subtract_x,
    input logic subtract_y,
    input logic add_x,
    input logic add_y,
    output logic [7:0] x,
    output logic [7:0] y
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            x <= 8'b0;
            y <= 8'b0;
        end else begin
            if (load_x) x <= x0;
            if (load_y) y <= y0;
            if (subtract_x) x <= x - y;
            if (subtract_y) y <= y - x;
            if (add_x) x <= x + x0;
            if (add_y) y <= y + y0;
        end
    end
endmodule
