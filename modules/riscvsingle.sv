module riscvsingle(input logic clk, reset,
                    output logic [31:0] PC,
                    input logic [31:0] Instr,
                    output logic nop,
                    output logic [31:0] ALUResult, WriteData,
                    input logic [31:0] ReadData);

logic ALUSrc, RegWrite, PCSrc, Zero;
logic [1:0] ResultSrc, ImmSrc;
logic [2:0] ALUControl;
logic PCTargetSRC;

logic cp_op;
logic IO;

controller c(Instr[6:0], Instr[14:12], Instr[30], Zero,
            ResultSrc, nop, PCSrc,
            ALUSrc, RegWrite,
            ImmSrc, ALUControl,PCTargetSRC, cp_op, IO);

datapath dp(clk, reset, ResultSrc, PCSrc,
            ALUSrc, RegWrite,
            ImmSrc, ALUControl,
            Zero, PC, Instr,
            ALUResult, WriteData, ReadData,PCTargetSRC, cp_op, IO);
endmodule