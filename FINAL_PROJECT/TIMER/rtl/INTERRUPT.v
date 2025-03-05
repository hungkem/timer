module interrupt(input wire 		clk		,
		 input wire 		rst_n		,
		 input wire	[63:0] 	cnt		,
		 input wire 	[63:0]	tcmp		,
		 input wire 		int_en		,
		 input wire 		tisr_wr_sel	,
		 input wire 	[31:0]	pwdata  	,
		 output reg 		int_st		,			
		 output wire 		tim_int		);
	
	
	wire int_set, int_clr;

        assign int_set = (cnt == tcmp) ? 1 : 0;//interrupt occurs
	//write 1 when int_st = 1 --> clear
	assign int_clr = ((int_st == 1'b1) & tisr_wr_sel & (pwdata[0] == 1'b1));

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) 		int_st <= 1'b0	;
		else if(int_clr) 	int_st <= 1'b0	;
		else if(int_set)	int_st <= 1'b1	;
		else 			int_st <= int_st;
	end

	assign tim_int = int_st & int_en;
endmodule
