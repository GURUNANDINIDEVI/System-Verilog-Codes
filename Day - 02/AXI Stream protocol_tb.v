module axi_stream_tb;

  reg clk;
  reg resetn;

  // Write channel
  wire        tvalid;
  wire [15:0] tdata;
  wire        tlast;
  wire        tready;

  // Read channel
  wire        tvalid_r;
  wire [15:0] tdata_r;
  wire        tlast_r;
  wire        tready_r;

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    clk = 0;
    resetn = 0;
    #20 resetn = 1;
    #500 $finish;
  end

  // DUTs
  axi_stream_master u_master (
    .clk(clk),
    .resetn(resetn),
    .tvalid(tvalid),
    .tdata(tdata),
    .tlast(tlast),
    .tready(tready),
    .tvalid_in(tvalid_r),
    .tdata_in(tdata_r),
    .tlast_in(tlast_r),
    .tready_out(tready_r)
  );

  axi_stream_slave u_slave (
    .clk(clk),
    .resetn(resetn),
    .tvalid(tvalid),
    .tdata(tdata),
    .tlast(tlast),
    .tready(tready),
    .tvalid_out(tvalid_r),
    .tdata_out(tdata_r),
    .tlast_out(tlast_r),
    .tready_in(tready_r)
  );

endmodule
