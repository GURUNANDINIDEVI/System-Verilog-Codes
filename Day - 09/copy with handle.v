class vlsi;
  int a;
  int b;
endclass
module tb;
  vlsi v1,v2;
  initial begin
  v1=new();
  v2=new();
  v2.a=10;
    v1=v2;
  $display("v1=%0d",v1.a);
  $display("v1=%0p",v1);
  v2.a=20;
  $display("v1=%0p",v1);
  end
endmodule

/*
Output:
# KERNEL: v1=10
# KERNEL: v1=10 0
# KERNEL: v1=20 0
