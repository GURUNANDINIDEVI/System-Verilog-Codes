module top;
  bit [2:0] x;
  bit [2:0] y;
  //x and y are variables/values
  task automatic swap(ref bit[2:0]x,y);
    //x and y are arguments
    bit[2:0]temp;
    temp=x;
    x=y;
    y=temp;
    #10;
    $display("x=%0d , y=%0d",x,y);
  endtask
  initial begin
    x=3;
    y=4;
    #10;
    swap(x,y);    
     $display("x=%0d , y=%0d",x,y);
  end 
endmodule

/*
OUTPUT:
# KERNEL: x=4 , y=3
# KERNEL: x=4 , y=3
*/
