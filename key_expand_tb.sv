`timescale 1ns/1ns

module key_expand_tb();

logic [127:0] data_input;
logic clk;
logic rst;
logic [127:0] data_out;
logic [127:0] expect_data_out;
logic [127:0] key_in;
logic [127:0] key_out;
logic [127:0] expect_key_out;
aes_key_expand_revamped aes_key_expand_dut(

	 .key_in(key_in), 
	 .clk(clk),
	 .rst(rst),
	 .key_out(key_out),
	 .rnd_constant(1)
	 );

initial begin

  rst = 1; #10; rst = 0;
  key_in = 128'h6bc1bee22e409f96e93d7e117393172a;
  expect_key_out = 128'hb6315b6d9871c4fb714cbaea02dfadc0;
  data_input = 128'hf69f2445df4f9b17ad2b417bddccbbaa;
  expect_data_out = 128'h2cfaee30f8e08480064389704477d44a;
  #200;
  $display("Input Data: %h", key_in);
  $display("Output Data: %h", expect_key_out);

  if(key_out == expect_key_out) begin
  
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