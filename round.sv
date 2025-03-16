module round(

    input clk,
	 input rst,
	 input logic [127:0] data_in,
	 input logic [127:0] key,
	 input i_en,
	 input skip_mix_cols,
	 output o_en,
	 output logic [127:0] data_out

);

    logic [127:0] after_sub_bytes;
    logic [127:0] after_shift_rows;
    logic [127:0] after_mix_columns;
	 logic [127:0] temp_data_out;
    logic shift_rows_o_en;
	 logic s_sub_o_en;
	 logic mix_cols_o_en;
	 
	 s_sub_revamped s(.clk(clk), .rst(rst), .data_in(data_in), .i_en(i_en), .data_out(after_sub_bytes), .o_en(s_sub_o_en));
	 shift_rows r(.clk(clk), .rst(rst), .data_in(after_sub_bytes), .i_en(s_sub_o_en), .data_shift_out(after_shift_rows), .o_en(shift_rows_o_en));
	 mix_cols m(.clk(clk), .rst(rst), .data_in(after_shift_rows), .i_en(shift_rows_o_en), .data_out(after_mix_columns), .o_en(mix_cols_o_en));
	 
	 assign temp_data_out = (skip_mix_cols) ? after_shift_rows : after_mix_columns;
	 assign data_out = temp_data_out ^ key;
	 assign o_en = mix_cols_o_en && i_en;
endmodule
