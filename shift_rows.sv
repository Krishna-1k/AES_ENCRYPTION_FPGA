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
	      /*  data_shift_temp_out[7:0] <= data_in[7:0];
           data_shift_temp_out[39:32] <= data_in[39:32];
			  data_shift_temp_out[71:64] <= data_in[71:64];
           data_shift_temp_out[103:96] <= data_in[103:96];
			  
			  
			  //second row
	        data_shift_temp_out[15:8] <= data_in[47-:8];
           data_shift_temp_out[47:40] <= data_in[79-:8];
			  data_shift_temp_out[79:72] <= data_in[111-:8];
           data_shift_temp_out[111:104] <= data_in[15-:8];

			  
			  //third row
	        data_shift_temp_out[23:16] <= data_in[87-:8];
           data_shift_temp_out[55:48] <= data_in[119-:8];
			  data_shift_temp_out[87:80] <= data_in[23-:8];
           data_shift_temp_out[119:112] <= data_in[55-:8];
			  
			  //fourth row
	        data_shift_temp_out[31:24] <= data_in[127-:8];
           data_shift_temp_out[63:56] <= data_in[31-:8];
			  data_shift_temp_out[95:88] <= data_in[63-:8];
           data_shift_temp_out[127:120] <= data_in[95-:8];
			  */

			  data_shift_temp_out[24+:8] <= data_in[24+:8];
			  data_shift_temp_out[56+:8] <= data_in[56+:8];
			  data_shift_temp_out[88+:8] <= data_in[88+:8];
			  data_shift_temp_out[120+:8] <= data_in[120+:8];
		 
			  data_shift_temp_out[16+:8] <= data_in[112+:8];
			  data_shift_temp_out[48+:8] <= data_in[16+:8];
			  data_shift_temp_out[80+:8] <= data_in[48+:8];
			  data_shift_temp_out[112+:8] <= data_in[80+:8]; 
			  
			  data_shift_temp_out[8+:8] <= data_in[72+:8];
			  data_shift_temp_out[40+:8] <= data_in[104+:8];
			  data_shift_temp_out[72+:8] <= data_in[8+:8];
			  data_shift_temp_out[104+:8] <= data_in[40+:8]; 
		
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

 


			  /* Where first four bytes fill first row(not correct as not enough scrambling)
			  
			  
			  	        //first row 
	        data_shift_temp_out[31:0] <= data_in[31:0];
			  
			  //second row
			  data_shift_temp_out[55:32] <= data_in[63:40]; 
  			  data_shift_temp_out[63:56] <= data_in[39:32];

			  
			  //third row
  			  data_shift_temp_out[95:80] <= data_in[79:64];
			  data_shift_temp_out[79:64] <= data_in[95:80];
			  
			  //fourth row
			  data_shift_temp_out[103:96] <= data_in[119:96];
			  data_shift_temp_out[127:104] <= data_in[127:120]; */