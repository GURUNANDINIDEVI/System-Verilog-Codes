module dff(
  input clk,reset,D,
  output reg Y
);
  always@(posedge clk or negedge reset)begin
    if(!reset )
      Y<=0;
    else
      Y<=D;
  end
    
endmodule
