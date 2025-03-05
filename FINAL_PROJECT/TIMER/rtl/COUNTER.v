module counter(	input wire 		clk		,
       		input wire 		rst_n		,
		input wire 		cnt_en		,
		input wire 		tdr0_wr_sel	,
		input wire 		tdr1_wr_sel	,
		input wire 	[31:0] 	pwdata		,
		output reg	[63:0]	cnt		);


		always @(posedge clk or negedge rst_n) begin
			if(!rst_n) 		cnt 		<= 64'h0	;
			else if(tdr0_wr_sel) 	cnt	[31: 0] <= pwdata	;
			else if(tdr1_wr_sel) 	cnt	[63:32] <= pwdata	;
			else if(cnt_en)		cnt 		<= cnt + 1'b1	;
			else 			cnt 		<= cnt		;

		end



endmodule
