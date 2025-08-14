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
      $display("Driver applied test cases : a=%0b,b=%0b c=%0b and output from dut diff =%0b, borrow=%0b",vif.a,vif.b,vif.c,vif.diff,vif.borrow);
    end
  endtask
endclass

module tb;

  full_add u1(aif.a,aif.b,aif.c,aif.diff,aif.borrow);
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
OUTPUT:
# generator test cases : a=0, b=0 c=0
# generator test cases : a=0, b=0 c=1
# generator test cases : a=0, b=1 c=0
# generator test cases : a=0, b=1 c=1
# generator test cases : a=1, b=0 c=0
# generator test cases : a=1, b=0 c=1
# generator test cases : a=1, b=1 c=0
# generator test cases : a=1, b=1 c=1
# Driver applied test cases : a=0,b=0 c=0 and output from dut diff =0, borrow=0
# Driver applied test cases : a=0,b=0 c=1 and output from dut diff =1, borrow=1
# Driver applied test cases : a=0,b=1 c=0 and output from dut diff =1, borrow=1
# Driver applied test cases : a=0,b=1 c=1 and output from dut diff =0, borrow=1
# Driver applied test cases : a=1,b=0 c=0 and output from dut diff =1, borrow=0
# Driver applied test cases : a=1,b=0 c=1 and output from dut diff =0, borrow=0
# Driver applied test cases : a=1,b=1 c=0 and output from dut diff =0, borrow=0
# Driver applied test cases : a=1,b=1 c=1 and output from dut diff =1, borrow=1
*/




