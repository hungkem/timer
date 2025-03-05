module counter_mode(
			input wire 		clk		,
			input wire 		rst_n		,
			input wire 		div_en		,
		    	input wire	[3:0]	div_val		,
			input wire		halt_req	,
		    	input wire 		timer_en	,
			input wire		dbg_mode	,
			output reg		halt_ack	,
    			output wire 		cnt_en		);

	wire 		init_cnt	;// = 0 (value of ctrl_cnt)
	wire		normal_mode	;
	wire 		mode0		;//div_val = 0
	wire 		ctrl_mode	;//div_val != 0
	reg	[7:0] 	limit		;
	reg	[7:0]	cnt_limit	;// count to limit and reset to initial count
	
	always @(*) begin
		case(div_val)
			// div_val = 0 <=> normal_mode
			4'b0001:	limit = 1	;
			4'b0010:	limit = 3	;
			4'b0011:	limit = 7	;
			4'b0100:	limit = 15	;
			4'b0101:	limit = 31	;
			4'b0110:	limit = 63	;
			4'b0111:	limit = 127	;
			4'b1000:	limit = 255	;
			default: 	limit = 0	;
		endcase
	end
	wire halt_mode;
	assign halt_mode   = halt_req & dbg_mode;
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) halt_ack <= 1'b0	;
		else 	   halt_ack <= halt_mode;
	end	
	assign init_cnt    = ((cnt_limit == limit) & ~halt_mode) | ~div_en | ~timer_en	;
	assign normal_mode = timer_en & ~div_en						;
	assign mode0       = timer_en & div_en & (div_val == 0)				;
       	assign ctrl_mode   = timer_en & div_en & (div_val != 0) & ~halt_mode		;


	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) 		cnt_limit <= 8'h0		;
		else if(init_cnt)	cnt_limit <= 8'h0		;
		else if(halt_mode) 	cnt_limit <= cnt_limit		;
		else if(ctrl_mode) 	cnt_limit <= cnt_limit + 1'b1	;
		else 			cnt_limit <= cnt_limit		;
	end


	assign cnt_en = (normal_mode | mode0 | (ctrl_mode & (cnt_limit == limit))) & ~halt_mode;

endmodule
