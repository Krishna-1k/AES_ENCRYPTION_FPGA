module round_tb();

logic [127:0] data_input;
logic clk;
logic rst;
logic [127:0] data_out;
logic [127:0] expect_data_out;
logic [127:0] key_in;
logic [127:0] key_out;
logic [127:0] expect_key_out;
logic encrypt_data_out_rdy;
//round round_dut(

//	 .key(key_in), 
//	 .clk(clk),
//	 .rst(rst),
//	 .data_in(data_input),
//	 .data_out(data_out)
//	 );
	 
	 
aes_wrapper dut(

    .key(key_in), 
	 .data_in(data_input), 
	 .clk(clk),
	 .rst(rst),
	 .encrypt_data_out(data_out),
	 .encrypt_data_out_rdy(encrypt_data_out_rdy)
	 );

initial begin

  rst = 1; #10; rst = 0;
  key_in = 128'h7b0c785e27e8ad3f8223207104725dd4;
  data_input = 128'h6bc1bee22e409f96e93d7e117393172a;
  expect_data_out = 128'h3ad77bb40d7a3660a89ecaf32466ef97;
  $monitor("Output Data %h", data_out);

  wait(encrypt_data_out_rdy);
  if(data_out == expect_data_out) begin
  
      $display("PASSED!");

  
  end


end

initial begin

   clk = 0;

   forever begin
       #2
       clk = ~clk;
   end	

end


initial begin

#1000;
$display("max cycle count reached");
$finish();



end

endmodule 