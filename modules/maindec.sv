module maindec(input logic [6:0] op,
                output logic [1:0] ResultSrc,
                output logic nop,
                output logic Branch, ALUSrc,
                output logic RegWrite, Jump,
                output logic [1:0] ImmSrc,
                output logic [1:0] ALUOp,
                output logic PCTargetSRC, cp_op, IO
                );
logic [13:0] controls;
assign {IO ,cp_op, RegWrite, ImmSrc, ALUSrc, nop,ResultSrc, Branch, ALUOp, Jump,PCTargetSRC} = controls;
always_comb
case(op)
// RegWrite_ImmSrc_ALUSrc_MemWrite_ResultSrc_Branch_ALUOp_Jump
7'b0000011: controls = 14'b0_x_1_00_1_0_01_0_00_0_x; // lw
7'b0100011: controls = 14'b0_x_0_01_1_1_xx_0_00_0_x; // sw
7'b0110011: controls = 14'b0_x_1_xx_0_0_00_0_10_0_x; // R–type
7'b1100011: controls = 14'b0_x_0_10_0_0_xx_1_01_0_0; // beq/bne
7'b0010011: controls = 14'b0_x_1_00_1_0_00_0_10_0_x; // I–type 
7'b1101111: controls = 14'b0_x_1_11_x_0_10_0_xx_1_0; // jal
7'b1100111: controls = 14'b0_x_0_00_1_0_10_0_xx_1_1; // jalr

7'b0000000: controls = 14'b1_0_1_xx_x_0_11_0_xx_0_0; // GCD
7'b1111111: controls = 14'b1_1_1_xx_x_0_11_0_xx_0_0; // LCM

default: controls = 14'bx_x_xx_x_x_xx_x_xx_x_x; // ???
endcase
endmodule