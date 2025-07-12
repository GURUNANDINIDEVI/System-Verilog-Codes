//T.Guru Nandini Devi
//nandinidevitekumudi@gmail.com
module tb_axi_lite_master_slave;

  logic aclk = 0;
  logic aresetn;

  always #5 aclk = ~aclk;  // 100 MHz clock

  logic [31:0] awaddr, wdata;
  logic        awvalid, wvalid;
  logic        awready, wready, bvalid;
  logic [1:0]  bresp;
  logic [31:0] reg_out;
  logic        bready;

  axi_lite_master u_master (
    .AWADDR  (awaddr),
    .WDATA   (wdata),
    .AWVALID (awvalid),
    .WVALID  (wvalid),
    .BREADY  (bready),
    .AWREADY (awready),
    .WREADY  (wready),
    .BVALID  (bvalid)
  );

  axi_lite_slave u_slave (
    .ACLK    (aclk),
    .ARESETN (aresetn),
    .AWADDR  (awaddr),
    .WDATA   (wdata),
    .AWVALID (awvalid),
    .WVALID  (wvalid),
    .BREADY  (bready),
    .AWREADY (awready),
    .WREADY  (wready),
    .BVALID  (bvalid),
    .BRESP   (bresp),
    .reg_out (reg_out)
  );

  initial begin
    aresetn  = 0;
    //bready  = 1;
    #20 aresetn = 1;

    @(posedge bvalid);
    @(posedge aclk);
    $display("[Time %0t] write Adrress: %0h, Write data: reg_out = %0h", $time,awaddr, reg_out);
    #40 $finish;
  end

  initial begin
    $dumpfile("axi_lite_tb.vcd");
    $dumpvars(0, tb_axi_lite_master_slave);
  end

endmodule
