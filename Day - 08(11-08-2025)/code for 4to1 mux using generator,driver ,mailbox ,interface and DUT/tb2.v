//T.Guru Nandini Devi
//23A91A0460
interface mux_if;
  logic [3:0] d;   
  logic [1:0] sel; 
  logic y;        
endinterface

class generator;
  mailbox mbx;
  task run();
    logic [3:0] d;
    logic [1:0] sel;
    for (int i = 0; i < 15; i++) begin
      d   = $urandom_range(0, 15); // Random 4-bit data
      sel = i % 4;                 // Cycle through select values
    
      mbx.put({sel, d});
      $display("[GENERATOR] d=%b sel=%b", d, sel);
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

    #100 $finish;
  end
endmodule
