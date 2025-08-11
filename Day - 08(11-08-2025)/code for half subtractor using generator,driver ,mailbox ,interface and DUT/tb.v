// T.Guru Nandini Devi
// nandinidevitekumudi@gmail.com
class generator;
  mailbox mbx;
  task run();
    bit a, b; 
    for (int i = 0; i < 4; i++) begin
      {a, b} = i; 
      mbx.put({a, b});
      $display("[GENERATOR] Sent a=%0d b=%0d", a, b);
    end
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
  half_sub u1(.a(aif.a),.b(aif.b),.sum(aif.sum),.carry(aif.carry));

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
