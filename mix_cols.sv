module mix_cols
    (input logic clk,
	  input logic rst,
	  input logic [127:0] data_in,
	  input logic i_en,
	  output logic [127:0] data_out,
	  output logic o_en);
	  
	  
	  logic [127:0] data_temp_out;
	  logic assert_o_en;
	
	  always @(posedge clk or posedge rst) begin
	    if(rst) begin
	  
			  data_temp_out <= 0;
			  assert_o_en <= 0;
	    end else begin
			  for(int i = 0; i < 4; i++) begin
					data_temp_out[(24 + i*32)+:8] <= gf_mult2(data_in[(24 + i*32)+:8]) ^ gf_mult3(data_in[(16 + i*32)+:8]) ^ data_in[(8 + i*32)+:8] ^ data_in[(0 + i*32)+:8];
					data_temp_out[(16 + i*32)+:8] <= (data_in[(24 + i*32)+:8]) ^ gf_mult2(data_in[(16 + i*32)+:8]) ^ gf_mult3(data_in[(8 + i*32)+:8]) ^ data_in[(0 + i*32)+:8];
					data_temp_out[(8 + i*32)+:8] <= (data_in[(24 + i*32)+:8]) ^ (data_in[(16 + i*32)+:8] ) ^ gf_mult2(data_in[(8 + i*32)+:8]) ^ gf_mult3(data_in[(0 + i*32)+:8]);
					data_temp_out[(0 + i*32)+:8] <= gf_mult3(data_in[(24 + i*32)+:8]) ^ (data_in[(16 + i*32)+:8]) ^ (data_in[(8 + i*32)+:8]) ^ gf_mult2(data_in[(0 + i*32)+:8]);
			  end
			  if(i_en) begin
               assert_o_en <= 1;
			  end else begin
               assert_o_en <= 0;
			  end
	    end
	  end
	  
	  assign data_out = data_temp_out;
	  assign o_en = assert_o_en && i_en;
	  
	  //multiply by 3 is just multiply by 2 + multiplicand
	  function [7:0] gf_mult3;
	      input [7:0] multiplicand;
			begin
			    gf_mult3 = gf_mult2(.multiplicand(multiplicand)) ^ multiplicand;
	      end
	  endfunction
	  
	  //multiply by 2. If MSB is 1, then we need to xor with irreducible polynomial 
	  function [7:0] gf_mult2;
	      input [7:0] multiplicand;
			begin
			    if(multiplicand[7]) begin
				    gf_mult2 = {multiplicand[6:0], 1'b0} ^ 8'b00011011;			
			    end else begin
				    gf_mult2 = {multiplicand[6:0], 1'b0};
			    end
			end
	  
	  endfunction
	  

	  
endmodule : mix_cols

