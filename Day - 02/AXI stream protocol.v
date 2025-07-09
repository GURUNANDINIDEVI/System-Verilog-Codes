module axi_stream_master (
  input  wire clk,
  input  wire resetn,

  // TX interface to slave
  output reg        tvalid,
  output reg [15:0] tdata,
  output reg        tlast,
  input  wire       tready,

  // RX interface from slave
  input  wire        tvalid_in,
  input  wire [15:0] tdata_in,
  input  wire        tlast_in,
  output reg         tready_out
);

  parameter data_count = 8;
  reg [15:0] data_array [0:data_count-1];
  reg [2:0] tx_index;

  // Initialize data to be sent
  initial begin
    data_array[0] = 16'd10;
    data_array[1] = 16'd100;
    data_array[2] = 16'd125;
    data_array[3] = 16'd130;
    data_array[4] = 16'd150;
    data_array[5] = 16'd165;
    data_array[6] = 16'd180;
    data_array[7] = 16'd240;
  end

  // Transmit (write)
  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      tvalid <= 0;
      tdata  <= 0;
      tlast  <= 0;
      tx_index <= 0;
    end else begin
      tvalid <= 1;
      if (tready) begin
        tdata <= data_array[tx_index];
        tlast <= (tx_index == data_count - 1);
        tx_index <= (tx_index == data_count - 1) ? 0 : tx_index + 1;
      end
    end
  end

  // Receive (read back same data)
  always @(posedge clk or negedge resetn) begin
    if (!resetn)
      tready_out <= 1;
    else
      tready_out <= ~tready_out;
  end

  // Print read data
  always @(posedge clk) begin
    if (tvalid_in && tready_out)
      $display("Time %0t: READ   - MASTER received data = %0d, TLAST = %0b", $time, tdata_in, tlast_in);
  end

endmodule

module axi_stream_slave (
  input  wire clk,
  input  wire resetn,

  // RX interface from master
  input  wire        tvalid,
  input  wire [15:0] tdata,
  input  wire        tlast,
  output reg         tready,

  // TX interface to master
  output reg        tvalid_out,
  output reg [15:0] tdata_out,
  output reg        tlast_out,
  input  wire       tready_in
);

  parameter data_count = 8;
  reg [15:0] buffer [0:data_count-1];
  reg [2:0] write_index;
  reg [2:0] read_index;
  reg       data_ready;

  // Receive from master (write)
  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      tready <= 1;
      write_index <= 0;
      data_ready <= 0;
    end else begin
      if (tvalid && tready) begin
        buffer[write_index] <= tdata;
        $display("Time %0t: WRITE  - SLAVE received data = %0d, TLAST = %0b", $time, tdata, tlast);
        if (tlast)
          data_ready <= 1;
        write_index <= (write_index == data_count - 1) ? 0 : write_index + 1;
      end
    end
  end

  // Send back to master (read)
  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      tvalid_out <= 0;
      tdata_out  <= 0;
      tlast_out  <= 0;
      read_index <= 0;
    end else if (data_ready) begin
      tvalid_out <= 1;
      if (tready_in) begin
        tdata_out <= buffer[read_index];
        tlast_out <= (read_index == data_count - 1);
        read_index <= (read_index == data_count - 1) ? 0 : read_index + 1;
      end
    end
  end

endmodule
