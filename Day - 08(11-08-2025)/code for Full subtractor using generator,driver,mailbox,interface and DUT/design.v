//T.Guru Nandini Devi
//23A91A0460

module full_add(
  input  logic a,
  input  logic b,
  input  logic c,
  output logic sum,
  output logic carry
);
  assign sum   = a ^ b ^ c;   // XOR for sum
  assign carry = (~a&b) | (b&c) | (c& ~a);   // AND for carry
endmodule

interface inter;
  logic a;
  logic b;
  logic c;
  logic sum;
  logic carry;
endinterface
