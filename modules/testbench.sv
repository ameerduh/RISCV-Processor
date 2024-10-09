module testbench();
logic clk;
logic reset;
logic [31:0] WriteData, DataAdr;
logic MemWrite;
// instantiate device to be tested
top dut(clk, reset, WriteData, DataAdr, MemWrite);
// initialize test
initial
begin
reset <= 1; # 22; reset <= 0;
end
// generate clock to sequence tests
always
begin
clk <= 1; #500; clk <= 0; #500;
end
// check results
always @(negedge clk)
begin
if(MemWrite) begin
if(DataAdr === 0 & WriteData === 0) begin
$display("Simulation succeeded");

end 
end
end
endmodule