module aes_key_expand
 (input logic clk,
	  input logic rst,
	  input logic [31:0] rnd_constant,
	  input logic [127:0] key_in,
	  output logic [127:0] key_out);
	  
	  logic [31:0] w3_transform;
	  logic [31:0] w0, w1, w2, w3;
  	  logic [31:0] w4, w5, w6, w7;

	  assign w0 = key_in[96+:32];
	  assign w1 = key_in[64+:32];
	  assign w2 = key_in[32+:32];
	  assign w3 = key_in[0+:32];
	  
	  
	  
	  assign w4 = w0 ^ w3_transform;
	  assign w5 = w1 ^ w4;
	  assign w6 = w2 ^ w5;
	  assign w7 = w3 ^ w6;
	  assign key_out = {w4, w5, w6, w7};

	  
	  
	  g_op g_inst(.clk(clk), .rst(rst), .word_in({w3[16+:8], w3[8+:8], w3[0+:8], w3[24+:8]}), .word_out(w3_transform), .rnd_constant(rnd_constant));
endmodule



module g_op
 (input logic clk,
	  input logic rst,
	  input logic [31:0] word_in,
	  input logic [31:0] rnd_constant,
	  output logic [31:0] word_out);
	
		
	 logic [7:0] data_in_byte;
	 logic [7:0] data_out_byte;
    logic [3:0] sel_byte;
	 logic [3:0] temp_sel_byte;
	 logic [31:0] temp_word_out;
	 s_box s_box_key_expand(.data_in(data_in_byte), .data_out(data_out_byte));

	 
	  always @(posedge clk or posedge rst) begin
	      if(rst) begin
				 data_in_byte <= 0;
				 sel_byte <= 0;
				 temp_sel_byte <= 0;
				 temp_word_out <= 0;
			end else begin
	          data_in_byte <= word_in[temp_sel_byte*8 +: 8];
				 temp_sel_byte <= temp_sel_byte + 1;
             sel_byte <= temp_sel_byte;
				 temp_word_out[sel_byte*8 +: 8] <= data_out_byte;
			end
	 
	  end 
	  
	  assign word_out[31:24] = temp_word_out[31:24] ^ rnd_constant;
     assign word_out[23:0] = temp_word_out[23:0];
    

endmodule