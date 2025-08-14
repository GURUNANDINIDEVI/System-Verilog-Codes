//T.Guru Nandini Devi
//23A91A0460
class generator;
    mailbox mbx;
    bit [1:0] a;
    task run();
        for (int i = 0; i < 4; i++) begin
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
        bit [1:0] temp;
        forever begin
            mbx.get(temp);
            vif.a = temp;
            #5;
            $display("DRIVER: a=%0b => y=%0b", vif.a, vif.y);
        end
    endtask
endclass

module tb;
    decoder_if dif();
    decoder2to4 dut (.a(dif.a), .y(dif.y));
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
        join_none
        #50 $finish;
    end
endmodule

/*OUTPUT:
GENERATOR: a=0
GENERATOR: a=1
GENERATOR: a=10
GENERATOR: a=11
DRIVER: a=0 => y=1
DRIVER: a=1 => y=10
DRIVER: a=10 => y=100
DRIVER: a=11 => y=1000
