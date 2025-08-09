// Code your testbench here
// or browse Examples
class generator;
  mailbox mbx;

  task run();
    int i;
    bit [1:0] t[4];
    t[0]=2'b00;
    t[1]=2'b01;
    t[2]=2'b10;
    t[3]=2'b11;
    
    for(int i=0;i<4;i++)
   
      mbx.put(t[i]);
        $display("[GENERATOR] Sent a=%0d b=%0d", t[i][1], t[i][0]);
    
  endtask
endclass

class driver;
  mailbox mbx;          
  virtual inter vif;  

  task run();
    bit [1:0] temp;
    forever begin
      mbx.get(temp);
      vif.a = temp[1];
      vif.b = temp[0];
      $display("[DRIVER] Driving a=%0d b=%0d", vif.a, vif.b);
      #1;
      $display("[DRIVER] DUT Output: sum=%0d carry=%0d", vif.sum, vif.carry);
    end
  endtask
endclass

module tb;
  inter aif(); 

  
  half_adder u1(.a(aif.a),.b(aif.b),.sum(aif.sum),.carry(aif.carry));

  generator gen;
  driver drv;
  mailbox mbx;

  initial begin
    gen = new();
    drv = new();
    mbx = new();

    gen.mbx = mbx;
    drv.mbx = mbx;
    drv.vif = aif;
  end

  initial begin
    fork
      gen.run();
      drv.run();
    join
  end
endmodule
