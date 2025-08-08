class generator;
  int a=5;
  int b=6;
  mailbox mbx;
  task run();
    mbx.put({a[2:0],b[2:0]});
    $display(" stored a=%0d,b=%0d", a,b);
  endtask
endclass

  class driver;
    mailbox mbx;
    virtual inter vif;
      task run();
        bit [5:0]temp;
        bit [2:0]a,b;
        
        mbx.get(temp);  
         a = temp[5:3];     
         b = temp[2:0];
        vif.a = a;
        vif.b = b;
        #10;
        $display("Driver outputs a=%0d,b=%0d,c=%0d", a,b,vif.c);
      endtask
  endclass

 module tb;
   inter aif();
   add dut(.a(aif.a),.b(aif.b),.c(aif.c));
   
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
    div.vif=aif;
   
     fork 
       gen.run();
       div.run();
     join
     end
   endmodule

/* output:
# KERNEL:  stored a=5,b=6
# KERNEL: Driver outputs a=5,b=6,c=11
*/
