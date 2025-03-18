module aes_key_expand_revamped
 (input logic clk,
	  input logic rst,
	  input logic [31:0] rnd_constant,
	  input logic [127:0] key_in,
	  output logic [127:0] key_out);
	
	  //Module to compute the next key
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

	  
	  
	  g_op_revamped g_inst(.clk(clk), .rst(rst), .word_in({w3[16+:8], w3[8+:8], w3[0+:8], w3[24+:8]}), .word_out(w3_transform), .rnd_constant(rnd_constant));
endmodule



module g_op_revamped
 (input logic clk,
	  input logic rst,
	  input logic [31:0] word_in,
	  input logic [31:0] rnd_constant,
	  output logic [31:0] word_out);
	
		
	 logic [31:0] data_in_bytes;
	 logic [31:0] data_out_bytes;
    logic [3:0] sel_byte;
	 logic [3:0] temp_sel_byte;
	 logic [31:0] temp_word_out;
	 
	 genvar i;
	 generate
	    for(i= 0; i < 4; i=i+1) begin: s_box_key_expand_gen
		     s_box s_box_key_expand(.data_in(data_in_bytes[i*8 +: 8]), .data_out(data_out_bytes[i*8 +: 8]));
    
		 end
	 
	 endgenerate
	 
	  always @(posedge clk or posedge rst) begin
	      if(rst) begin
				 word_out <= 0;
			end else begin
				 word_out[0+:8] <= data_out_bytes[0+:8];
 				 word_out[8+:8] <= data_out_bytes[8+:8];
				 word_out[16+:8] <= data_out_bytes[16+:8];
				 word_out[24+:8] <= data_out_bytes[24+:8] ^ rnd_constant;

			end
	 
	  end 
	  
	  assign data_in_bytes = word_in;
    

endmodule
