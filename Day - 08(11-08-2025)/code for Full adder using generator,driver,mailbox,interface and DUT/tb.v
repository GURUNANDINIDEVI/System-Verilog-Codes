//T.Guru Nandini Devi
//23A91A0460

class generator;
  mailbox mbx;
  bit a;
  bit b;
  bit c;
  
  task run();
    for( int i=0;i<8;i++)begin
      {a,b,c}=i;
      mbx.put({a,b,c});
      $display("generator test cases : a=%0b, b=%0b c=%0b",a,b,c);
    end
  endtask
endclass
 
class driver;
  mailbox mbx;
  virtual inter vif;
  task run();
    bit [2:0]temp;
    bit a,b;
    forever begin
     
    mbx.get(temp);
      vif.a=temp[2];
      vif.b=temp[1];
      vif.c=temp[0];
      
    #10;
      $display("Driver applied test cases : a=%0b,b=%0b c=%0b and output from dut sum =%0b, carry=%0b",vif.a,vif.b,vif.c,vif.sum,vif.carry);
    end
  endtask
endclass

module tb;

  full_add u1(aif.a,aif.b,aif.c,aif.sum,aif.carry);
  inter aif();
  generator gen;
  mailbox mbx;
  driver div;
  initial begin
    gen=new();
    mbx=new();
    div=new();
    gen.mbx=mbx;
    div.mbx=mbx;
    div.vif=aif;
    
    gen.run();
    div.run();
  end
endmodule

/*
Output:
# KERNEL: generator test cases : a=0, b=0 c=0
# KERNEL: generator test cases : a=0, b=0 c=1
# KERNEL: generator test cases : a=0, b=1 c=0
# KERNEL: generator test cases : a=0, b=1 c=1
# KERNEL: generator test cases : a=1, b=0 c=0
# KERNEL: generator test cases : a=1, b=0 c=1
# KERNEL: generator test cases : a=1, b=1 c=0
# KERNEL: generator test cases : a=1, b=1 c=1
# KERNEL: Driver applied test cases : a=0,b=0 c=0 and output from dut sum =0, carry=0
# KERNEL: Driver applied test cases : a=0,b=0 c=1 and output from dut sum =1, carry=0
# KERNEL: Driver applied test cases : a=0,b=1 c=0 and output from dut sum =1, carry=0
# KERNEL: Driver applied test cases : a=0,b=1 c=1 and output from dut sum =0, carry=1
# KERNEL: Driver applied test cases : a=1,b=0 c=0 and output from dut sum =1, carry=0
# KERNEL: Driver applied test cases : a=1,b=0 c=1 and output from dut sum =0, carry=1
# KERNEL: Driver applied test cases : a=1,b=1 c=0 and output from dut sum =0, carry=1
# KERNEL: Driver applied test cases : a=1,b=1 c=1 and output from dut sum =1, carry=1*/
