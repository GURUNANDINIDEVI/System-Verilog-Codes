//T.Guru Nandini Devi
//nandinidevitekumudi@gmail.com
module tb;
  int data1,data2;
  event done;
  
  //Generator
  initial begin
    for(int i=0;i<8;i++)begin
      data1=$random();
    $display("Generated data=%0d",data1);
    #1;
    #9;
  end
  ->done;
  end
  //Driver
  initial begin
   forever begin
     #10;
     data2=data1;
    $display("Received data=%0d",data2);
  end
  end
  //wait condition
  initial begin
    wait(done.triggered);
    $finish;
  end 
endmodule


Output:
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
