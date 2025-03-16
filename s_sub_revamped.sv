module s_sub_revamped(

    input clk,
	 input rst,
	 input logic i_en,
	 input logic [127:0] data_in,
	 output logic [127:0] data_out,
	 output logic o_en

);
    logic [127:0] data_in_bytes;
	 logic [127:0] data_out_bytes;

	 logic assert_o_en;
	 	 
	 genvar i;
	 generate
	    for(i= 0; i < 16; i=i+1) begin: s_box_transform_gen
		     s_box s_box_transform(.data_in(data_in_bytes[i*8 +: 8]), .data_out(data_out_bytes[i*8 +: 8]));
    
		 end
	 
	 endgenerate
	 
	 
    always@(posedge clk or posedge rst) begin
	 
	     if(rst) begin
		  
		  data_out <= 0;
		  assert_o_en <= 0;
		  end else begin
		      if(i_en) begin
		          o_en <= 1;
	             data_out <= data_out_bytes;
		      end else begin
				    o_en <= 0;
				end
				assert_o_en <= i_en;
		  end
	 end

assign data_in_bytes = data_in;


endmodule