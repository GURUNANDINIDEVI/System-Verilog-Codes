class first;
  int data=50;
endclass
class second;
  first f;
  function new();
    f=new();
  endfunction
endclass

module tb;
second s;
initial begin
  s=new();
  $display("Data = %0d",s.f.data);
  s.f.data=60;
  $display("Data = %0d",s.f.data);
end 
endmodule

/*output:
# KERNEL: Data = 50
# KERNEL: Data = 60
*/
