class vlsi;
  int data;
  bit [7:0]data1;
  shortint data2;
  function new(input int datain=0,input bit[7:0] datain1=8'h00,input shortint datain2=0);
    data = datain;
    data1 = datain1;
    data2 = datain2;
  endfunction
endclass

module tb;
  vlsi v;
  initial begin
    v=new(60,31,29);
    $display("data = %0d , data1 = %0d , data2 = %0d",v.data,v.data1,v.data2);
  end
endmodule

/*
Output:
# KERNEL: data = 60 , data1 = 31 , data2 = 29
