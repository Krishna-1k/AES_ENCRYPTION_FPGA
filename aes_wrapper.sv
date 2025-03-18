//main wrapper

module aes_wrapper#(parameter KEY_LENGTH = 128)
    (input logic [KEY_LENGTH:0] key, 
	  input logic [127:0] data_in, 
	  input logic clk,
	  input logic rst,
	  output logic encrypt_data_out_rdy,
	  output logic[127:0] encrypt_data_out);

	  //Used to hold values in between rounds
	  logic[127:0] data_in_temp;
	  logic[127:0] data_out_temp;
	  logic [127:0] key_in_temp;
	  logic[127:0] key_out_temp;

     //FSM variables
	  logic[31:0] rnd_constant;
	  logic skip_mix_cols;
	  logic[3:0] current_round_state;
  	  logic[3:0] current_round_num;

	  //Start done logic
	  logic round_compute_done;
	  logic round_compute_start;
	  
	

	always @(posedge clk or posedge rst) begin
	
       if(rst) begin
			  round_compute_start <= 0;
			  data_in_temp <= 0;
			  current_round_state <= 0;
			  rnd_constant <= 1;
			  current_round_num <= 0;
			  skip_mix_cols <= 0;
		 end else begin
			 case(current_round_state)
		
				  4'd0: begin
				      //initial round we start with input key
						rnd_constant <= 4'd1;
						if(round_compute_done) begin
						    current_round_state <= 1;
							 data_in_temp <= data_out_temp;
							 key_in_temp <= key_out_temp;
							 round_compute_start <= 0;
							 current_round_num <= current_round_num + 1;
							 skip_mix_cols <= 0;
						end else begin
     						 data_in_temp <= data_in ^ key;
                      key_in_temp <= key;
							 round_compute_start <= 1;
							 current_round_state <= 0;
 							 current_round_num <= 0;


						end
				  end
				      //round 1 -> 9, we generate new key, new output round data repeatedly
				  4'd1: begin
						if(current_round_num == 9) begin
						    current_round_state <= 2;
							 skip_mix_cols <= 1;
						end else begin
						    rnd_constant <= rnd_const_calc(current_round_num);
 							 current_round_state <= 1;
						end
						
						if(round_compute_done) begin
							 data_in_temp <= data_out_temp;
							 key_in_temp <= key_out_temp;
							 round_compute_start <= 0;
							 current_round_num <= current_round_num + 1;
						end else begin
							 round_compute_start <= 1;
						end
				  end
				  
				  4'd2: begin //last round we skip mix cols
						rnd_constant <= rnd_const_calc(current_round_num);
						if(round_compute_done) begin
						    current_round_state <= 0;
							 data_in_temp <= data_out_temp;
							 key_in_temp <= key_out_temp;
							 round_compute_start <= 0;
						end else begin
							 round_compute_start <= 1;
							 current_round_state <= 2;
						end
				  
				  end
				  
				  default: begin //default to 0 state
						rnd_constant = 4'd0;
						current_round_state = 0;
	
				  end
				  
		
			 endcase

       end
	
	end
	  
//helper function to calculate round constant based on round number	  
function [7:0] rnd_const_calc;

    input logic [3:0] rnd_num;
	 begin		 
		 case(rnd_num)
		 
			4'h0: rnd_const_calc=8'h01;		
			4'h1: rnd_const_calc=8'h02;		
			4'h2: rnd_const_calc=8'h04;		
			4'h3: rnd_const_calc=8'h08;		
			4'h4: rnd_const_calc=8'h10;		
			4'h5: rnd_const_calc=8'h20;		
			4'h6: rnd_const_calc=8'h40;		
			4'h7: rnd_const_calc=8'h80;		
			4'h8: rnd_const_calc=8'h1b;		
			4'h9: rnd_const_calc=8'h36;	
			 
		 endcase
		
	end
endfunction

	  
//instantiations	  
   aes_key_expand_revamped ake(

       .clk(clk),
	    .rst(rst),
	    .key_in(key_in_temp),
	    .key_out(key_out_temp),
		 .rnd_constant(rnd_constant)

);
    round rnd(
	 	  .clk(clk),
		  .rst(rst),
	     .key(key_out_temp), 
	     .data_in(data_in_temp),
	     .data_out(data_out_temp),
		  .skip_mix_cols(skip_mix_cols),
		  .i_en(round_compute_start),
		  .o_en(round_compute_done)
	 );
	assign encrypt_data_out_rdy = (current_round_state == 2) && round_compute_done;
	assign encrypt_data_out = encrypt_data_out_rdy  ? data_out_temp : 0;

endmodule 
