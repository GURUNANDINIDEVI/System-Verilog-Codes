//T.Guru Nandini Devi
//23A91A0460

module full_sub(
  input  logic a,
  input  logic b,
  input  logic c,
  output logic sum,
  output logic carry
);
  assign diff   = a ^ b ^ c;   // XOR for difference
  assign borrow = (~a&b) | (b&c) | (c& ~a);   // AND for borrow
endmodule

interface inter;
  logic a;
  logic b;
  logic c;
  logic diff;
  logic borrow;
endinterface
