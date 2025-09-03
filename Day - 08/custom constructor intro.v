class vlsi;
  int data;
  //this is an function constructor , used for simplicity by adding the class members along with their memories
  function new(input int datain=0);
    data = datain;
  endfunction
endclass

module tb;
  vlsi v;
  initial begin
    //this new() is an memory creation for handle
    v=new(60);
    $display("data = %0d",v.data);
  end
endmodule

/*
output:
# KERNEL: data = 60
