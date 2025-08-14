//T.Guru Nandini Devi
//nandinidevitekumudi@gmail.com
module tb;
  task one();
    $display("Task1 is started: %0t",$time);
    #20;
    $display("Task1 is completed: %0t",$time);
  endtask
  
   task two();
     $display("Task2 is started: %0t",$time);
    #10;
     $display("Task2 is completed: %0t",$time);
  endtask
  
  task three();
    $display("Task3 is started: %0t",$time);
    #30;
    $display("Task3 is completed: %0t",$time);
  endtask
  
  initial begin
    fork
      one();
      two();
    join_any  //initially the join satatements triggers and any one task completes first then join_any statements triggers next then which are low in delays they will be executes in delay wise.
      three();
    
  end
endmodule


output:
Task1 is started: 0
Task2 is started: 0
Task2 is completed: 10
Task3 is started: 10
Task1 is completed: 20
Task3 is completed: 40
