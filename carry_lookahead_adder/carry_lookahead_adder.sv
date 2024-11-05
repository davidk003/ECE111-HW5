//`include "fulladder.sv"
module carry_lookahead_adder#(parameter N=4)(
  input logic[N-1:0] A, B,
  input logic CIN,
  output logic[N:0] result
);
  logic[N-1:0] sum;
  logic[N-1:0] carry;
  logic[N-1:0] prop;
  logic[N-1:0] gen;
 // Add code for carry lookahead adder 
  genvar i;
  generate
    for(int i = 0; i < N; i++) begin:adders
    fulladder adder_inst(
    .a(A[i]), .b(B[i]), .cin(CIN),
    .sum(sum[i]), .cout(carry[i]))
    end:adders
  endgenerate

  always @(A, B, CIN) begin
    for(int i = 0; i < N; i++) begin
      prop[i] = A[i] | B[i];
      gen[i] = A[i] & B[i];
      carry[i+1] = gen[i] | (prop[i] & carry[i]);
    end
    assign result = {carry[N], sum};
  end

  
endmodule: carry_lookahead_adder

