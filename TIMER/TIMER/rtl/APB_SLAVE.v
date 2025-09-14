module apb_slave(input  clk,
		        rst_n,
	       	        psel,
	       	        penable,
		        pwrite,
		 output pready,
			wr_en,
       			rd_en			
	        );
	assign pready = 1'b1;
	assign wr_en = psel & penable &  pwrite;
	assign rd_en = psel & penable & ~pwrite;



endmodule
