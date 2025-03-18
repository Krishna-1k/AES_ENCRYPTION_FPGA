module shift_rows
    (input logic clk,
	  input logic rst,
	  input logic [127:0] data_in,
	  input logic i_en,
	  output logic [127:0] data_shift_out,
	  output logic o_en);
	  
	  logic [127:0] data_shift_temp_out;
	  logic assert_o_en;
	  
	  always @(posedge clk or posedge rst) begin
	    if(rst) begin
	  
			  data_shift_temp_out <= 0;
			  assert_o_en <= 0;
	    end else begin

			  //first row
			  data_shift_temp_out[24+:8] <= data_in[24+:8];
			  data_shift_temp_out[56+:8] <= data_in[56+:8];
			  data_shift_temp_out[88+:8] <= data_in[88+:8];
			  data_shift_temp_out[120+:8] <= data_in[120+:8];
		 
		     //second row
			  data_shift_temp_out[16+:8] <= data_in[112+:8];
			  data_shift_temp_out[48+:8] <= data_in[16+:8];
			  data_shift_temp_out[80+:8] <= data_in[48+:8];
			  data_shift_temp_out[112+:8] <= data_in[80+:8]; 
			  
			  //third row
			  data_shift_temp_out[8+:8] <= data_in[72+:8];
			  data_shift_temp_out[40+:8] <= data_in[104+:8];
			  data_shift_temp_out[72+:8] <= data_in[8+:8];
			  data_shift_temp_out[104+:8] <= data_in[40+:8]; 
		
		     //fourth row
			  data_shift_temp_out[0+:8] <= data_in[32+:8];
			  data_shift_temp_out[32+:8] <= data_in[64+:8];
			  data_shift_temp_out[64+:8] <= data_in[96+:8];
			  data_shift_temp_out[96+:8] <= data_in[0+:8]; 		
			  if(i_en) begin
			      assert_o_en <= 1;
			  end else begin
			      assert_o_en <= 0;
			  end
			  
	    end
	  end
	  assign o_en = assert_o_en && i_en;
	  assign data_shift_out = data_shift_temp_out;
	  
endmodule



/* sTATE ARRAY
|24|56|88|120|
|16|48|80|112|
|08|40|72|104|
|00|32|64|096|
*/  
/* STATE ARRAY FOR S
|120|88|56|24|
|112|80|48|16|
|104|72|40|08|
|096|64|32|00|
*/ 

 
