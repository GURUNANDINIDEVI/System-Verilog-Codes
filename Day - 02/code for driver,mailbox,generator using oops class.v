//T.Guru Nandini Devi
//nandinidevitekumudi@gmail.com
//creating generator class
class generator;
  int data=35;
  mailbox mbx;
  task run();
    mbx.put(data);
    $display("Generator Data=%0d", data);
  endtask
endclass
//creating driver class
class driver;
  int data1=0;
  mailbox mbx;
  task run();
    mbx.get(data1);
    $display("Driver Received Data=%0d", data1);
  endtask
endclass
//writing test bench code
module tb;
  generator gen;
  driver div;
  mailbox mbx;
  initial begin
//creating memory to the class
    gen=new();
    div=new();
    mbx=new();
//calling the tasks
    gen.mbx =mbx;
    div.mbx=mbx;
    gen.run();
    div.run();
  end
endmodule

/*
output:
# KERNEL: Generator Data=35
# KERNEL: Driver Received Data=35
*/
