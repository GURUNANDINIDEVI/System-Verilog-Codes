//T.Guru Nandini Devi
//nandinidevitekumudi@gmail.com
//code for genertor  and driver using fork join to overcome the race condition due to many number of initial begin statements
module tb;
  int data1,data2;
  event done;
  
  //Generator
  task generator();
    for(int i=0;i<8;i++)begin
      data1=$random();
    $display("Generated data=%0d",data1);
    #1;
    #9;
  end
  ->done;
  endtask
  //Driver
    task driver();
   forever begin
     #10;
     data2=data1;
    $display("Received data=%0d",data2);
  end
    endtask
  //Hold_condition
      task hold_condition();
    wait(done.triggered);
    $finish;
      endtask 
  initial begin
  fork
    generator();
    driver();
    hold_condition();
  join
  end
endmodule

output:
Generated data=303379748
Received data=303379748
Generated data=-1064739199
Received data=-1064739199
Generated data=-2071669239
Received data=-2071669239
Generated data=-1309649309
Received data=-1309649309
Generated data=112818957
Received data=112818957
Generated data=1189058957
Received data=1189058957
Generated data=-1295874971
Received data=-1295874971
Generated data=-1992863214
Received data=-1992863214
