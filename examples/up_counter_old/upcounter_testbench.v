module upcounter_testbench();
reg clk, reset;
wire [3:0] counter;

up_counter dut(clk, reset, counter);
initial begin
clk=0;
forever #5 clk=~clk;
end

/*
initial begin
 #150;
 $display("simulación finalizada");
 $finish;
end;
*/

initial begin
 $dumpfile("upcounter.vcd");
 $dumpvars(1,upcounter_testbench);
end

initial begin
reset=1;
#20;
reset=0;
end
endmodule
