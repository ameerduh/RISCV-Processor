module alu (
    input logic [31:0]a,
    input logic [31:0]b,
    input logic [2:0]c, 
    output logic [31:0]d,
    output logic e 
);

always_comb
case(c)
3'b000 : d= a+b;
3'b001 : d= a-b;
3'b101 : d= (a<b)? 1 : 0;
3'b011 : d= a|b;
3'b010 : d= a & b;
3'b100 : d= a ^ b;
default : d= 0;
endcase

assign e = (d===0)? 1 : 0;
    
endmodule