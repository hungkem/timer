module counter(	input wire 		clk		,
       		input wire 		rst_n		,
		input wire 		cnt_en		,
		input wire 		tdr0_wr_sel	,
		input reg 	[3 :0]  pstrb		,
		input wire 		tdr1_wr_sel	,
		input wire 	[31:0] 	pwdata		,
		input wire		cnt_clr		,
		output reg	[63:0]	cnt		);


		always @(posedge clk or negedge rst_n) begin
			if(!rst_n) 		cnt 		<= 64'h0					;
			else if(cnt_clr)	cnt 		<= 64'h0					;
			else if(tdr0_wr_sel) begin 	
						cnt	[7 : 0] <= pstrb[0] ? pwdata[7 : 0] : cnt[7 : 0]	;
						cnt	[15: 8] <= pstrb[1] ? pwdata[15: 8] : cnt[15: 8]	;
						cnt	[23:16] <= pstrb[2] ? pwdata[23:16] : cnt[23:16]	;
						cnt	[31:24] <= pstrb[3] ? pwdata[31:24] : cnt[31:24]	;

			end else if(tdr1_wr_sel) begin 	
						cnt	[39:32] <= pstrb[0] ? pwdata[7 : 0] : cnt[39:32]	;
						cnt	[47:40] <= pstrb[1] ? pwdata[15: 8] : cnt[47:40]	;
						cnt	[55:48] <= pstrb[2] ? pwdata[23:16] : cnt[55:48]	;
						cnt	[63:56] <= pstrb[3] ? pwdata[31:24] : cnt[63:56]	;

			end else if(cnt_en)	cnt 		<= cnt + 1'b1					;
			else 			cnt 		<= cnt						;

		end



endmodule
