module tb;
  int a,b;
  initial begin
    a=9;
    b=6;
    $display("a=%0d,b=%0d", a,b);
    b=a;
    $display("a=%0d,b=%0d", a,b);
    a=20;
    $display("a=%0d,b=%0d", a,b);
  end 
endmodule
//stores in separate memory locations

/*
Output:
# KERNEL: a=9,b=6
# KERNEL: a=9,b=9
# KERNEL: a=20,b=9
