interface  inter;
  logic [1:0]a;
  logic [1:0]b;
  logic [2:0]sum;
  logic [2:0]carry;
endinterface

 module tb;
   inter aif();
   hadd dut(.a(aif.a),.b(aif.b),.sum(aif.sum),.carry(aif.carry));
   initial begin
     aif.a=0;
     aif.b=0;
     #10;
     aif.a=0;
     aif.b=1;
     #10;
     aif.a=1;
     aif.b=0;
     #10;
     aif.a=1;
     aif.b=1;
   end
   initial begin
     $monitor("a=%0b,b=%0b,sum=%0b,carry=%0b",aif.a,aif.b,aif.sum,aif.carry);
     #100;
     $finish;
   end
   endmodule

/*
OUTPUT:
a=0,b=0,sum=0,carry=0
a=0,b=1,sum=1,carry=0
a=1,b=0,sum=1,carry=0
a=1,b=1,sum=0,carry=1
*/
