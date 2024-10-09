module flopr #(parameter WIDTH = 8) (
    input logic clk, 
    input logic reset, 
    input logic enable,
    input logic [WIDTH-1:0] d,
    output logic [WIDTH-1:0] q
);

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 0;
    end else if (enable) begin
        q <= d;
    end
end

endmodule