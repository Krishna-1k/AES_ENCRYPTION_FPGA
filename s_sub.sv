module s_sub(

    input clk,
	 input rst,
	 input logic i_en,
	 input logic [127:0] data_in,
	 output logic [127:0] data_out,
	 output logic o_en

);

    logic [7:0] data_in_byte;
	 logic [7:0] data_out_byte;
    logic [3:0] sel_byte;
	 logic [3:0] temp_sel_byte;
	 logic assert_o_en;
	 
	 s_box s_box_transform(.data_in(data_in_byte), .data_out(data_out_byte));
	 
    always@(posedge clk or posedge rst) begin
	 
	     if(rst) begin
		  
		  data_out <= 0;
		  sel_byte <= 0;
		  data_in_byte <= 0;
        temp_sel_byte <= 0;
		  o_en <= 0;
		  assert_o_en <= 0;
		  end else begin
	 
				//read output in same cycle as s box transform. This allowed since s_box is combinational TODO REVIEW?
				if(i_en) begin
					data_in_byte <= data_in[temp_sel_byte*8 +: 8];
					temp_sel_byte <= temp_sel_byte + 1;
					sel_byte <= temp_sel_byte;
					data_out[sel_byte*8 +: 8] <= data_out_byte;
				end else begin
					temp_sel_byte <= 0;
					sel_byte <= 0;
				
				end
				
				if(i_en && sel_byte == 4'b1111) begin
					 assert_o_en <= 1;
				end else begin
				    assert_o_en <= 0;
				end

				o_en <= assert_o_en;
		  
		  end
	 end





endmodule



	 /*
           				
				case(sel_byte)
				
					 4'd0: begin
					 
					 data_in_byte <= data_in[7-:8];
					 data_out[7 -: 8] <= data_out_byte;

					 end
					 
					 4'd1: begin
					 
					 data_in_byte <= data_in[15-:8];
					 data_out[15 -: 8] <= data_out_byte;
					 
					 end
					 
					 2'd2: begin
					 
					 data_in_byte <= data_in[23-:8];
					 data_out[23 -: 8] <= data_out_byte;
					 
					 end
					 
					 4'd3: begin
					 
					 data_in_byte <= data_in[31-:8];
					 data_out[31 -: 8] <= data_out_byte;
					 
					 end
					 
					 4'd4: begin
					 
					 data_in_byte <= data_in[39-:8];
					 data_out[39 -: 8] <= data_out_byte;
					 
					 end
					 
					 
					 4'd5: begin
					 
					 data_in_byte <= data_in[47-:8];
					 data_out[47 -: 8] <= data_out_byte;
					 
					 end
					 
					 
					 4'd6: begin
					 
					 data_in_byte <= data_in[55-:8];
					 data_out[55 -: 8] <= data_out_byte;
					 
					 end					
					
				    4'd7: begin
					 
					 data_in_byte <= data_in[63-:8];
					 data_out[63 -: 8] <= data_out_byte;
					 
					 end
					 4'd8: begin
					 
					 data_in_byte <= data_in[71-:8];
					 data_out[71 -: 8] <= data_out_byte;
					 
					 end
				
					 4'd9: begin
					 
					 data_in_byte <= data_in[79-:8];
					 data_out[79 -: 8] <= data_out_byte;
					 
					 end
				
					 4'd10: begin
					 
					 data_in_byte <= data_in[87-:8];
					 data_out[87 -: 8] <= data_out_byte;
					 
					 end
				
					 4'd11: begin
					 
					 data_in_byte <= data_in[95-:8];
					 data_out[95 -: 8] <= data_out_byte;
					 
					 end
				
					 4'd12: begin
					 
					 data_in_byte <= data_in[103-:8];
					 data_out[103 -: 8] <= data_out_byte;
					 
					 end		
				
					 
					 4'd13: begin
					 
					 data_in_byte <= data_in[111-:8];
					 data_out[111 -: 8] <= data_out_byte;

					 end
					 
					 4'd14: begin
					 
					 data_in_byte <= data_in[119-:8];
					 data_out[119 -: 8] <= data_out_byte;

					 end
					 
					 4'd15: begin
					 
					 data_in_byte <= data_in[127-:8];
					 data_out[127 -: 8] <= data_out_byte;

				    end
					 
					 endcase
	 */