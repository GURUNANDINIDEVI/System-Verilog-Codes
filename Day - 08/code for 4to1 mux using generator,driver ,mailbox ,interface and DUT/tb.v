//T.Guru Nandini Devi
//23A91A0460

class generator;
  mailbox mbx;
  task run();
    logic [3:0] d;
    logic [1:0] sel;
    int count = 0;
    for (int s = 0; s < 4; s++) begin
      for (int pattern = 0; pattern < 2; pattern++) begin // only 2 patterns per sel
        sel = s;
        case (pattern)
          0: d = 4'b1010; // pattern 1
          1: d = 4'b0101; // pattern 2
        endcase
        mbx.put({sel, d});
        $display("[GENERATOR] Test %0d -> d=%b sel=%b", ++count, d, sel);
      end
    end
  endtask
endclass


// Driver Class
class driver;
  mailbox mbx;
  virtual mux_if vif;

  task run();
    logic [5:0] temp; 
    forever begin
      mbx.get(temp);
      vif.sel = temp[5:4]; 
      vif.d   = temp[3:0]; 
      #1;
      $display("[DRIVER] Driving: d=%b sel=%b => y=%b", vif.d, vif.sel, vif.y);
    end
  endtask
endclass

// Testbench
module tb;
  mux_if mif();
  mux4to1 dut(.d(mif.d), .sel(mif.sel), .y(mif.y));

  generator gen;
  driver drv;
  mailbox mbx;

  initial begin
    gen = new();
    drv = new();
    mbx = new();

    gen.mbx = mbx;
    drv.mbx = mbx;
    drv.vif = mif;

    fork
      gen.run();
      drv.run();
    join_none

    #50 $finish;
  end
endmodule
