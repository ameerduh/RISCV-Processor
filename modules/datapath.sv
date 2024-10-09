module datapath(input logic clk, reset,
                input logic [1:0] ResultSrc,
                input logic PCSrc, ALUSrc,
                input logic RegWrite,
                input logic [1:0] ImmSrc,
                input logic [2:0] ALUControl,
                output logic Zero,
                output logic [31:0] PC,
                input logic [31:0] Instr,
                output logic [31:0] ALUResult, WriteData,
                input logic [31:0] ReadData,
                input logic PCTargetSRC, cp_op, IO);
logic [31:0] PCNext, PCPlus4, PCTarget,JalLogic;
logic [31:0] ImmExt;
logic [31:0] SrcA, SrcB;
logic [31:0] Result;

logic [31:0] cp_result;
logic cp_r=0;
logic cp_s=0;
logic cp_done;

logic enable=1;

mux2 #(32) jumper(PCTarget,ALUResult,PCTargetSRC,JalLogic);
// next PC logic
flopr #(32) pcreg(clk, reset, enable, PCNext, PC);
adder pcadd4(PC, 32'd4, PCPlus4);
adder pcaddbranch(PC, ImmExt, PCTarget);
mux2 #(32) pcmux(PCPlus4, JalLogic, PCSrc, PCNext);
// register file logic
regfile rf(clk, RegWrite, Instr[19:15], Instr[24:20],
Instr[11:7], Result, SrcA, WriteData);
extend ext(Instr[31:7], ImmSrc, ImmExt);
// ALU logic
mux2 #(32) srcbmux(WriteData, ImmExt, ALUSrc, SrcB);
alu alu(SrcA, SrcB, ALUControl, ALUResult, Zero);
mux4 #(32) resultmux( ALUResult, ReadData, PCPlus4, cp_result,
ResultSrc, Result);

Coprocessor cop(clk, cp_r, cp_s, SrcA, WriteData, cp_op, cp_done, cp_result);

logic reset_done=0;
logic start_done=0;
always_ff @(posedge clk) begin
	if(IO) begin
	$display("IO is 1");
		if(!reset_done) begin
			cp_r = 1;
			reset_done = 1;
			$display("reset signal sent");
		end else if(!start_done) begin
			$display("src A: %b", SrcA);
			$display("src B: %b", SrcB);
			cp_r = 0;
			cp_s = 1;
			start_done = 1;
			$display("start signal sent");
			end
	
	end	
	
end

always_comb begin
	if(IO) begin
		if(!cp_done)begin
			enable = 0;
			$display("pc is halted");
		end	else begin 
			enable = 1;
			$display("pc is started");
			end
	end else enable =1;

end


endmodule