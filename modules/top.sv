module top(input logic clk, reset,
           output logic [31:0] WriteData, DataAdr,
           output logic MemWrite);

logic [31:0] PC, Instr, ReadData;
// instantiate processor and memories

logic nop;

addressD ad(Instr[6:0],MemWrite);

riscvsingle rvsingle( clk, reset, PC, Instr, nop,
                      DataAdr, WriteData, ReadData);
imem imem(PC, Instr);
dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
endmodule