//T.Guru Nandini Devi
//nandinidevitekumudi@gmail.com
module tb;
  task one();
    $display("Task1 is started: %0t",$time);
    #10;
    $display("Task1 is completed: %0t",$time);
  endtask
  
   task two();
     $display("Task2 is started: %0t",$time);
    #20;
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
    join_none  //initially the none atatement executes first then which are going with fast delay they will be executed later in delay wise
      three();
    
  end
endmodule



output:
Task3 is started: 0
Task1 is started: 0
Task2 is started: 0
Task1 is completed: 10
Task2 is completed: 20
Task3 is completed: 30
