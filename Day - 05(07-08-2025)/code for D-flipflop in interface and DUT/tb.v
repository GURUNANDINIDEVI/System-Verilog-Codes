interface  inter;
  logic clk,reset,D,Y;
endinterface

 module tb;
   inter aif();
   dff dut(.clk(aif.clk),.reset(aif.reset),.D(aif.D),.Y(aif.Y));
   initial begin
     aif.clk=0;
     forever #5 aif.clk= ~aif.clk;
   end
   initial begin
     aif.reset=0;aif.D=0;#10;
     aif.reset=1;aif.D=1;#10;
   end
   initial begin
     $monitor("clk=%0b,reset= %0b,D=%0b,Y=%0b",aif.clk,aif.reset,aif.D,aif.Y);
     #20;
     $finish;
   end
   endmodule

/*
OUTPUT:
clk=0,reset= 0,D=0,Y=0
clk=1,reset= 0,D=0,Y=0
clk=0,reset= 1,D=1,Y=0
clk=1,reset= 1,D=1,Y=1
*/
