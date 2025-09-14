module apb_slave(	input wire	clk	,
		        input wire 	rst_n	,
	       	        input wire 	psel	,
	       	        input wire 	penable	,
		        input wire	pwrite	,
		 	output reg	pready	,
			output wire	wr_en	,
       			output wire 	rd_en   );
`define WAIT_STATES 2
	reg [1:0]cnt = 2'b0;
	// wait state 1 cycle
	assign wr_en = psel & pwrite & penable	;
	assign rd_en = psel & ~pwrite & penable	;
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			cnt    <= 2'b0;
			pready <= 1'b0;
		end else if(psel & penable & (cnt == 2'b0)) begin
			pready <= 1'b0;
		end else if(psel) begin
			if(cnt == `WAIT_STATES) begin
				cnt    <= 2'b0;
				pready <= 1'b1;
			end else begin
				cnt    <= cnt + 1'b1;
				pready <= 1'b0;
			end
		end else if(penable) begin
			if(cnt == `WAIT_STATES - 1) begin
				cnt    <= 2'b0;
				pready <= 1'b1;		
			end else begin
				cnt    <= cnt + 1'b1;
				pready <= 0;
			end
		end else begin
			pready <= 1'b0;
		end
	end

endmodule
