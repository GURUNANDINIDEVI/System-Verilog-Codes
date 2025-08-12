//T.Guru Nandini Devi
//23A91A0460
class generator;
    mailbox mbx;
  bit [2:0] a;
    task run();
      for (int i = 0; i < 8; i++) begin
            a = i;
            mbx.put(a);
            $display("GENERATOR: a=%0b", a);
        end
    endtask
endclass

class driver;
    mailbox mbx;
    virtual decoder_if vif;
    task run();
      bit [2:0] temp;
        forever begin
            mbx.get(temp);
            vif.a = temp;
            #10;
            $display("DRIVER: a=%0b => y=%0b", vif.a, vif.y);
        end
    endtask
endclass

module tb;
    decoder_if dif();
    decoder3to8 dut (.a(dif.a), .y(dif.y));
    generator gen;
    driver    drv;
    mailbox   mbx;
    initial begin
        gen = new();
        drv = new();
        mbx = new();
        gen.mbx = mbx;
        drv.mbx = mbx;
        drv.vif = dif;
        fork
            gen.run();
            drv.run();
        join
       //#50 $finish;
    end
endmodule
