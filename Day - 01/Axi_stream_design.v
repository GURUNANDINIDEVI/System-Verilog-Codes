// Code your design here
module axi_stream_master(
  input wire clk,
  input wire resetn,
  output reg tvalid,
  output reg [15:0] tdata,
  output reg tlast,
  input wire tready);
  reg [15:0] count;
  parameter start_count=16'd800;
  parameter end_count=16'd808;
  
  always@(posedge clk or negedge resetn) begin
    if(!resetn) begin
      tvalid<=0;
      tdata<=0;
      tlast<=0;
      count<=start_count;
    end
    else begin
      tvalid<=1;
      
      if(tready==1) begin
        tdata<=count;
        tlast<=(count==end_count);
        if(count == end_count)
          count<=start_count;
        
        else  
        
          count<=count+1;
      end
    end
  end
endmodule

module axi_stream_slave(
  input wire clk,
  input wire resetn,
  input wire tvalid,
  input wire [16:0]tdata,
  input wire tlast,
  output reg tready);
  
  always@(posedge clk or negedge resetn) begin
    if(!resetn)
      tready<=1;
  else
    tready=~tready;
  end
endmodule
