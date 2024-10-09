module addressD(
input logic [6:0] op,
output logic MemWrite
);

logic control;
assign MemWrite = control;
always_comb
case(op)

7'b0000011: control = 0; // lw
7'b0100011: control = 1; // sw
7'b0110011: control = 0; // R–type
7'b1100011: control = 0; // beq/bne
7'b0010011: control = 0; // I–type 
7'b1101111: control = 0; // jal
7'b1100111: control = 0; // jalr

7'b0000000: control = 0; // GCD
7'b1111111: control = 0; // LCM

default: control = 0; // ???
endcase

endmodule