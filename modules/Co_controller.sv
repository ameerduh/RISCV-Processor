module Co_controller(
    input logic clk,
    input logic reset,
    input logic start,
    input logic [7:0] x,
    input logic [7:0] y,
    input logic Op, // 0 for GCD, 1 for LCM
    output logic load_x,
    output logic load_y,
    output logic subtract_x,
    output logic subtract_y,
    output logic add_x,
    output logic add_y,
    output logic Done,
    output logic [7:0] result
);
    typedef enum logic [2:0] {
        IDLE1, COMPARE_LCM, COMPARE_GCD, SUBTRACT_X, SUBTRACT_Y, ADD_X, ADD_Y
    } state_t;

    state_t state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE1;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        load_x = 0;
        load_y = 0;
        subtract_x = 0;
        subtract_y = 0;
        add_x = 0;
        add_y = 0;
        Done = 0;
        result = 8'b0;
        next_state = state;

        if (start) begin
            case (state)
                IDLE1: begin
                    load_x = 1;
                    load_y = 1;
                    if (Op)
                        next_state = COMPARE_LCM; // LCM mode
                    else
                        next_state = COMPARE_GCD; // GCD mode
                end
                COMPARE_GCD: begin
                    if (x == y) begin
                        result = x; // GCD computation
                        next_state = IDLE1;
                        Done = 1;
                    end else if (x > y) begin
                        subtract_x = 1;
                        next_state = SUBTRACT_X;
                    end else begin
                        subtract_y = 1;
                        next_state = SUBTRACT_Y;
                    end
                end
                COMPARE_LCM: begin
                    if (x == y) begin
                        result = x; // LCM computation
                        next_state = IDLE1;
                        Done = 1;
                    end else if (x < y) begin
                        add_x = 1;
                        next_state = ADD_X;
                    end else begin
                        add_y = 1;
                        next_state = ADD_Y;
                    end
                end
                SUBTRACT_X: begin
                    next_state = COMPARE_GCD;
                end
                SUBTRACT_Y: begin
                    next_state = COMPARE_GCD;
                end
                ADD_X: begin
                    next_state = COMPARE_LCM;
                end
                ADD_Y: begin
                    next_state = COMPARE_LCM;
                end
                default: next_state = IDLE1;
            endcase
        end
    end
endmodule
