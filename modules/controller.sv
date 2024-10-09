module controller(input logic [6:0] op,
                    input logic [2:0] funct3,
                    input logic funct7b5,
                    input logic Zero,
                    output logic [1:0] ResultSrc,
                    output logic nop,
                    output logic PCSrc, ALUSrc,
                    output logic RegWrite,
                    output logic [1:0] ImmSrc,
                    output logic [2:0] ALUControl,
                    output logic PCTargetSRC,cp_op, IO
                    );
logic [1:0] ALUOp;
logic Branch;
logic Jump;
maindec md(op, ResultSrc, nop, Branch,
ALUSrc, RegWrite, Jump, ImmSrc, ALUOp,PCTargetSRC, cp_op, IO);
aludec ad(op[5], funct3, funct7b5, ALUOp, ALUControl);
assign PCSrc = (funct3[0] ^ Zero) & Branch | Jump;
endmodule