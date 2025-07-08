module tb;
  reg clk;
  reg resetn;
  wire tvalid;
  wire [15:0] tdata;
  wire tlast;
  wire tready;
  
  axi_stream_master u1 (.clk(clk),.resetn(resetn),.tvalid(tvalid),.tdata(tdata),.tlast(tlast),.tready(tready));
  
    
  axi_stream_slave u2 (.clk(clk),.resetn(resetn),.tvalid(tvalid),.tdata(tdata),.tlast(tlast),.tready(tready));
  
  initial clk=0;
  always #5 clk=~clk;
  
  
  initial begin
    resetn=0;
    #20; resetn=1;
  end
   
  always@(posedge clk) begin
    if(tvalid && tready) begin
      $display (" time :%0t,clk=%0b, Received data=%0d,tlast=%0b", $time,clk,tdata, tlast);
    end
  end
   initial begin 
     #1000;
     $finish;
   end
endmodule
