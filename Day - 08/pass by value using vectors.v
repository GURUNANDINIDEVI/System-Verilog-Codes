module tb;
  task arr(input bit[2:0] a[8]);
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
# KERNEL: a[1]=0
# KERNEL: a[2]=0
# KERNEL: a[3]=0
# KERNEL: a[4]=0
# KERNEL: a[5]=0
# KERNEL: a[6]=0
# KERNEL: a[7]=0
