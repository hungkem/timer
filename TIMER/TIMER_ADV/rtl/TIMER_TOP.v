module timer_top(	input wire 		sys_clk		,
			input wire 		sys_rst_n	,
			input wire 		tim_psel	,
			input wire 		tim_penable	,
			input wire 		tim_pwrite	,
			input wire	[3 :0]	tim_pstrb	,
			input wire 	[31:0]	tim_pwdata	,
			input wire 	[11:0] 	tim_paddr	,
			input wire 		dbg_mode	,
			output wire 	[31:0]  tim_prdata	,
			output wire		tim_int		,
			output wire 		tim_pready	,
			output wire 		tim_pslverr	);

	wire wr_en, rd_en;
	wire timer_en, div_en, cnt_en, cnt_clr;
	wire [63:0] cnt, tcmp;
	wire [3 :0] div_val;
	wire halt_req, int_st, int_en, tdr0_wr_sel, tdr1_wr_sel, tisr_wr_sel, halt_ack;

	//instances module
	apb_slave 	apb_slave_dut(	.clk	(sys_clk)	,
					.rst_n	(sys_rst_n)	,
					.psel	(tim_psel)	,
					.pwrite	(tim_pwrite)	,
					.penable(tim_penable)	,
					.wr_en	(wr_en)		,
					.pready	(tim_pready)	,
					.rd_en	(rd_en)		);

	register 	register_dut(	.clk		(sys_clk)	,
					.rst_n		(sys_rst_n)	,
					.wr_en		(wr_en)		,
					.rd_en		(rd_en)		,
					.paddr		(tim_paddr)	,
					.pwdata		(tim_pwdata)	,
					.tim_pslverr	(tim_pslverr)	,
					.cnt		(cnt)		,
					.pstrb		(tim_pstrb)	,
					.halt_req	(halt_req)	,
					.halt_ack	(halt_ack)	,
					.int_st		(int_st)	,
					.prdata		(tim_prdata)	,
					.div_en		(div_en)	,
					.div_val	(div_val)	,
					.int_en		(int_en)	,
					.timer_en	(timer_en)	,
					.tdr0_wr_sel	(tdr0_wr_sel)	,
					.tdr1_wr_sel	(tdr1_wr_sel)	,
					.tisr_wr_sel	(tisr_wr_sel)	,
					.cnt_clr	(cnt_clr)	,
					.tcmp		(tcmp)		);
	
			
	interrupt 	interrupt_dut(	.clk		(sys_clk)	,
					.rst_n		(sys_rst_n)	,
					.cnt		(cnt)		,
					.tcmp		(tcmp)		,
					.int_en		(int_en)	,
					.tisr_wr_sel	(tisr_wr_sel)	,
					.pwdata		(tim_pwdata)	,
					.int_st		(int_st)	,
					.pstrb		(tim_pstrb)	,
					.tim_int	(tim_int)	);


	counter_mode 	counter_mode_dut(	.clk		(sys_clk)	,
						.rst_n		(sys_rst_n)	,
						.div_en		(div_en)	,
						.div_val	(div_val)	,
						.halt_req	(halt_req)	,
						.halt_ack	(halt_ack)	,
						.dbg_mode	(dbg_mode)	,
						.timer_en	(timer_en)	,
						.cnt_en		(cnt_en)	);


	counter 	counter_dut(	.clk		(sys_clk)	,
					.rst_n		(sys_rst_n)	,
					.cnt_en		(cnt_en)	,
					.tdr0_wr_sel	(tdr0_wr_sel)	,
					.tdr1_wr_sel	(tdr1_wr_sel)	,
					.pwdata		(tim_pwdata)	,
					.cnt_clr	(cnt_clr)	,
					.pstrb		(tim_pstrb)	,
					.cnt		(cnt)		);	

endmodule
