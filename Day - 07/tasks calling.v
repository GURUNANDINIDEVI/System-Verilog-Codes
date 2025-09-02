module top;
  bit [2:0] x;
  bit [2:0] y;
  bit [3:0] z;
  bit clk=0;
  always #10 clk=~clk;
  task add();
    //function void add);
    z=x+y;
    $display(" clk=%0d , x=%0d , y=%0d , z=%0d ",clk,x,y,z);
  endtask
  //endfunction
  initial begin
    x=5;
    y=5;
    add();
  end
  task simulation;
    x=6;
    y=6;
    add();
    #10;
    x=7;
    y=7;
    add();
    #10;
    x=4;
    y=4;
    add();
     #10;
  endtask
  task run();
    x=$urandom;
    y=$urandom;
    add();
  endtask
  task clock();
   x=$urandom;
    y=$urandom;
    @(posedge clk)
    add();
    clock();
  endtask
  initial begin
    simulation();
    run();
    clock();
  end
  initial begin
    #200;
    $finish;
  end
endmodule

/*
OUTPUT:
# KERNEL:  clk=0 , x=5 , y=5 , z=10 
# KERNEL:  clk=0 , x=6 , y=6 , z=12 
# KERNEL:  clk=1 , x=7 , y=7 , z=14 
# KERNEL:  clk=0 , x=4 , y=4 , z=8 
# KERNEL:  clk=1 , x=6 , y=3 , z=9 
# KERNEL:  clk=1 , x=6 , y=7 , z=13 
# KERNEL:  clk=1 , x=4 , y=3 , z=7 
# KERNEL:  clk=1 , x=4 , y=3 , z=7 
# KERNEL:  clk=1 , x=5 , y=3 , z=8 
# KERNEL:  clk=1 , x=3 , y=6 , z=9 
# KERNEL:  clk=1 , x=5 , y=0 , z=5 
# KERNEL:  clk=1 , x=1 , y=5 , z=6 
# KERNEL:  clk=1 , x=1 , y=2 , z=3 
*/
