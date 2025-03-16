`timescale 1ns/1ns

module s_sub_tb();

logic [127:0] data_input;
logic clk;
logic rst;
logic [127:0] data_out;
logic [127:0] expect_data_out;
logic i_en;

s_sub_revamped s_sub_dut(

	 .data_in(data_input), 
	 .clk(clk),
	 .rst(rst),
	 .data_out(data_out),
	 .i_en(i_en)
	 );

initial begin

  rst = 1; #10; rst = 0; i_en = 1;
  data_input = 128'h40bfabf406ee4d3042ca6b997a5c5816; 
  expect_data_out = 128'h090862bf6f28e3042c747feeda4a6a47;
  #200;
  $display("Input Data: %h", data_input);
  $display("Output Data: %h", data_out);

  if(data_out == expect_data_out) begin
  
      $display("PASSED!");

  
  end


end

initial begin

   clk = 0;

   forever begin
       #5
       clk = ~clk;
   end	

end


initial begin

#500;
$display("max cycle count reached");
$finish();



end

endmodule 