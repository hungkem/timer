module register(input wire 		clk        ,
		input wire 		rst_n      ,
		input wire 		wr_en      ,
		input wire 		rd_en      ,
//		input wire 		halt_ack   ,
		input wire      	int_st     ,
		input wire	[63:0]  cnt        ,
		input wire	[11:0]  paddr      ,
//		input wire	[3 :0]  pstrb      ,
		input wire  	[31:0]  pwdata     ,
		output reg    	[31:0]  prdata     ,
		output reg    	[3 :0]  div_val    ,
		output reg 	       	div_en     ,
		output wire	       	tdr0_wr_sel,
		output wire	       	tdr1_wr_sel,
		output reg	       	timer_en   ,	       
		output wire	       	pslverr    ,
		output reg	       	halt_req   ,
		output reg		int_en     ,	 
		output wire 		tisr_wr_sel,
		output wire[63:0]	tcmp
	);
		
	//address
	parameter TCR_OFFSET   = 12'h00;
	parameter TDR0_OFFSET  = 12'h04;
	parameter TDR1_OFFSET  = 12'h08;
	parameter TCMP0_OFFSET = 12'h0C;
	parameter TCMP1_OFFSET = 12'h10;
	parameter TIER_OFFSET  = 12'h14;
	parameter TISR_OFFSET  = 12'h18;	
	parameter THCSR_OFFSET = 12'h1C;

	// no error
	assign pslverr = 0;

	//select register
	wire tcr_sel  	;
	wire tdr0_sel 	;
	wire tdr1_sel 	;
	wire tcmp0_sel	;
	wire tcmp1_sel	;
	wire tier_sel 	;
	wire tisr_sel 	;
	wire thcsr_sel	;

	assign tcr_sel   = wr_en & (paddr == TCR_OFFSET  )	; 
	assign tdr0_sel  = wr_en & (paddr == TDR0_OFFSET )	;
	assign tdr1_sel  = wr_en & (paddr == TDR1_OFFSET )	; 
	assign tcmp0_sel = wr_en & (paddr == TCMP0_OFFSET)	; 
	assign tcmp1_sel = wr_en & (paddr == TCMP1_OFFSET)	; 
	assign tier_sel  = wr_en & (paddr == TIER_OFFSET )	; 
	assign tisr_sel  = wr_en & (paddr == TISR_OFFSET )	; 
	assign thcsr_sel = wr_en & (paddr == THCSR_OFFSET)	; 
	
	// change IO to register value
	reg[31:0] tcmp0, tcmp1;
	/*
	reg int_st_tmp, halt_ack_tmp  	;
	assign int_st   = int_st_tmp    ;
	assign halt_ack = halt_ack_tmp	;
	
	always @(*) begin
		timer_en     = tcr[0]     	;
	        div_en       = tcr[1]     	;
		div_val      = tcr[11:8]  	;
		int_en	     = tier[0]    	;
		int_st_tmp   = tisr[0]    	;
		halt_req     = thcsr[0]   	;
		halt_ack_tmp = thcsr[1]   	;		
	end
*/


	// write tranfer	
	always @(posedge clk or negedge rst_n) begin
		//default value
		if(!rst_n) begin
			div_val  <= 4'h1		;
			div_en   <= 1'b0		;
			timer_en <= 1'b0		;
			tcmp0    <= 32'hFFFF_FFFF	;
			tcmp1    <= 32'hFFFF_FFFF	;
			int_en   <= 1'b0		;
			halt_req <= 1'b0		;	
		end else if(wr_en) begin
                        case(paddr)
				 TCR_OFFSET: begin                                         
				 	// div_en && timer_en
                                         {div_en, timer_en}  <= pwdata[1:0]				;
                                         //div_val
                                         if(pwdata[11:8] <= 4'h8) div_val[3:0] <= pwdata[11:8]    	;
                                         else                     div_val[3:0] <= div_val[3:0]         	;
                                 end
                                 TCMP0_OFFSET: begin
                                         tcmp0  <= pwdata	;
                                 end
                                 TCMP1_OFFSET: begin
                                         tcmp1  <= pwdata	;
                                 end
                                 TIER_OFFSET: begin
                                         int_en <= pwdata[0]	;
                                 end
                                 THCSR_OFFSET: begin
                                         halt_req <= pwdata[0]	;
                                 end
                                 default: begin
 					  div_val  <= div_val      ;
                                          div_en   <= div_en       ;
                                          timer_en <= timer_en     ;
                                          tcmp0    <= tcmp0        ;
                                          tcmp1    <= tcmp1        ;
                                          int_en   <= int_en       ;
                                          halt_req <= halt_req     ;
                                 end
                        endcase
		end else begin
 					  div_val  <= div_val      ;
                                          div_en   <= div_en       ;
                                          timer_en <= timer_en     ;
                                          tcmp0    <= tcmp0        ;
                                          tcmp1    <= tcmp1        ;
                                          int_en   <= int_en       ;
                                          halt_req <= halt_req     ;

		end
	end
	
	
	//read tranfer
	always @(*) begin
		if(rd_en) begin
			case(paddr) 	
				TCR_OFFSET  	: prdata = {20'b0, div_val[3:0], 6'b0, div_en, timer_en};
				TDR0_OFFSET 	: prdata = cnt[31: 0] ;
		       		TDR1_OFFSET 	: prdata = cnt[63:32] ;
				TCMP0_OFFSET	: prdata = tcmp0;
				TCMP1_OFFSET	: prdata = tcmp1;
				TIER_OFFSET 	: prdata = {31'h0, int_en};	
				TISR_OFFSET 	: prdata = {31'h0, int_st};	
				THCSR_OFFSET	: prdata = {31'h0, halt_req};
				default     	: prdata = 32'h0; 
			endcase
		end else 	  	      	  prdata = 32'h0;
	end		
	
	// TDR select
	assign tdr0_wr_sel = tdr0_sel;
	assign tdr1_wr_sel = tdr1_sel;

	// TISR select
	assign tisr_wr_sel = tisr_sel;

	//tcmp
	assign tcmp = {tcmp1, tcmp0};


endmodule
