module round_tb();

logic [127:0] data_input;
logic clk;
logic rst;
logic [127:0] data_out;
logic [127:0] expect_data_out;
logic [127:0] key_in;
logic [127:0] key_out;
logic [127:0] expect_key_out;
logic i_en;
logic o_en;
logic skip_mix_cols;

round round_dut(
	 .key(key_in), 
	 .clk(clk),
	 .rst(rst),
	 .data_in(data_input),
	 .data_out(data_out),
	 .i_en(i_en),
	 .skip_mix_cols(skip_mix_cols),
	 .o_en(o_en)	 
	 );
	 
	 

initial begin

  rst = 1; #10; rst = 0; #10; i_en = 1; skip_mix_cols = 0;
  key_in = 128'ha1a135b8bc09a82b238215c9b87bf5ff;
  data_input = 128'h0b465e1e3a49f6fe150b279245d88517;
  expect_data_out = 128'h8643adc93f0fa0e8d14a4b76872894cb;
  $monitor("Output Data %h", data_out);

  wait(o_en);
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
