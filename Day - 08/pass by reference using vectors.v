module tb;
  task automatic arr(ref bit[2:0] a[8]);
    for(int i=0;i<=7;i++)begin
      a[i]=i;
    end 
  endtask
  bit [2:0] a[8];
  initial begin
    arr(a);
    for(int i=0;i<=7;i++) begin
      $display("a[%0d]=%0d",i,a[i]);
  end 
  end
endmodule

/*
Output:
# KERNEL: a[0]=0
# KERNEL: a[1]=1
# KERNEL: a[2]=2
# KERNEL: a[3]=3
# KERNEL: a[4]=4
# KERNEL: a[5]=5
# KERNEL: a[6]=6
# KERNEL: a[7]=7
