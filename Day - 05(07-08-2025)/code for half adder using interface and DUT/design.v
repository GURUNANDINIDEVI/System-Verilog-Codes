module hadd(
  input [1:0]a,b,
  output [2:0]sum,carry
);
  assign sum=a^b;
  assign carry=a&b;
endmodule
