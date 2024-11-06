//`include "fulladder.sv"
module carry_lookahead_adder#(parameter N=4)(
  input logic[N-1:0] A, B,
  input logic CIN,
  output logic[N:0] result
);
  logic[N-1:0] sum;
  logic[N:0] carry;
  logic[N-1:0] prop;
  logic[N-1:0] gen;

  assign carry[0] = CIN;
 // Add code for carry lookahead adder 
  genvar i;
  generate
    for(i = 0; i < N; i++) begin:adders
    fulladder adder_inst(
    .a(A[i]), .b(B[i]), .cin(carry[i]),
    .sum(sum[i]), .cout());
    end:adders
  endgenerate

  genvar j;
  generate
    for(j = 0; j < N; j++) begin:carry_loop
    assign prop[j] = A[j] | B[j];
    assign gen[j] = A[j] & B[j];
    assign carry[j+1] = gen[j] | (prop[j] & carry[j]);
    end:carry_loop
  endgenerate
assign result = {carry[N], sum};

  
endmodule: carry_lookahead_adder

