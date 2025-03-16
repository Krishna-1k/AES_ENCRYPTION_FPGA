`timescale 1ns/1ns

module mix_cols_tb();

logic [127:0] data_input;
logic clk;
logic rst;
logic [127:0] data_out;
logic [127:0] expect_data_out;


mix_cols mix_cols_dut(

	 .data_in(data_input), 
	 .clk(clk),
	 .rst(rst),
	 .data_out(data_out)
	 
	 );

initial begin

  rst = 1; #10; rst = 0;
  data_input = 128'hf69f2445df4f9b17ad2b417be66c3710 ;
  expect_data_out = 128'h2cfaee30f8e08480064389704477d44a;
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