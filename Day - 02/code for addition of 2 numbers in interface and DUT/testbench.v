interface  inter;
  logic [2:0]a;
  logic [2:0]b;
  logic [3:0]c;
endinterface
 module tb;
   inter aif();
   add dut(.a(aif.a),.b(aif.b),.c(aif.c));
   initial begin
     aif.a=5;
     aif.b=7;
     #10;
     aif.a=6;
     aif.b=7;
   end
   initial begin
     $monitor ("a=%0d;b=%0d;c=%0d",aif.a,aif.b,aif.c);
     #100;
     $finish;
   end
   endmodule

/*
OUTPUT:
a=5;b=7;c=12
a=6;b=7;c=13
*/
