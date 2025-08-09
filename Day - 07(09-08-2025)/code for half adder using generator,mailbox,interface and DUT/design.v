module half_adder(
  input  logic a,
  input  logic b,
  output logic sum,
  output logic carry
);
  assign sum   = a ^ b;   // XOR for sum
  assign carry = a & b;   // AND for carry
endmodule

interface inter;
  logic a;
  logic b;
  logic sum;
  logic carry;
endinterface
