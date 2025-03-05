module check_pstrb();
	test_bench top();
	reg[31:0] register_tmp;
  
                  //address
                  parameter TCR_OFFSET   = 12'h00;
                  parameter TDR0_OFFSET  = 12'h04;
                  parameter TDR1_OFFSET  = 12'h08;
                  parameter TCMP0_OFFSET = 12'h0C;
                  parameter TCMP1_OFFSET = 12'h10;
                  parameter TIER_OFFSET  = 12'h14;
                  parameter TISR_OFFSET  = 12'h18;
                  parameter THCSR_OFFSET = 12'h1C;
  
                  initial begin
                          #100;
			
			$display("\n=======================================TEST WITH TCR===========================\n");
				
			top.write(TCR_OFFSET  	, 32'habcd_1233, 4'b0010)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0200)  		;

			top.write(TCR_OFFSET  	, 32'habcd_1233, 4'b0001)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0203)  		;
			
			top.write(TCR_OFFSET  	, 32'habcd_1233, 4'b0100)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0203)  		;
			
			top.write(TCR_OFFSET  	, 32'habcd_1233, 4'b1000)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0203)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			top.write(TCR_OFFSET  	, 32'h7777_7777, 4'b0011)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0703)  		;
			
			top.write(TCR_OFFSET  	, 32'habcd_1233, 4'b1100)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0703)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			top.write(TCR_OFFSET  	, 32'habcd_1233, 4'b0110)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0200)  		;

			top.write(TCR_OFFSET  	, 32'habcd_1533, 4'b1111)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0503)  		;

			$display("\n=================================================END======================================\n");
	
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;
			$display("\n=======================================TEST WITH TDR0===========================\n");
				
			 top.write(TDR0_OFFSET  	, 32'habcd_1233, 4'b0001)	;
			top.verify(TDR0_OFFSET  	, 32'h0000_0033)  		;

			 top.write(TDR0_OFFSET  	, 32'habcd_1240, 4'b0010)	;
			top.verify(TDR0_OFFSET  	, 32'h0000_1233)  		;
			
			 top.write(TDR0_OFFSET  	, 32'habcd_1233, 4'b0100)	;
			top.verify(TDR0_OFFSET  	, 32'h00cd_1233)  		;
			
			 top.write(TDR0_OFFSET  	, 32'habcd_1233, 4'b1000)	;
			top.verify(TDR0_OFFSET  	, 32'habcd_1233)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			 top.write(TDR0_OFFSET  	, 32'h7777_7777, 4'b0011)	;
			top.verify(TDR0_OFFSET  	, 32'h0000_7777)  		;
			
			 top.write(TDR0_OFFSET  	, 32'habcd_1233, 4'b1100)	;
			top.verify(TDR0_OFFSET  	, 32'habcd_7777)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			 top.write(TDR0_OFFSET  	, 32'habcd_1233, 4'b0110)	;
			top.verify(TDR0_OFFSET  	, 32'h00cd_1200)  		;

			 top.write(TDR0_OFFSET  	, 32'habcd_1533, 4'b1111)	;
			top.verify(TDR0_OFFSET  	, 32'habcd_1533)  		;

			$display("\n=================================================END======================================\n");

			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;
			$display("\n=======================================TEST WITH TDR1===========================\n");
				
			 top.write(TDR1_OFFSET  	, 32'habcd_1233, 4'b0001)	;
			top.verify(TDR1_OFFSET  	, 32'h0000_0033)  		;

			 top.write(TDR1_OFFSET  	, 32'habcd_1240, 4'b0010)	;
			top.verify(TDR1_OFFSET  	, 32'h0000_1233)  		;
			
			 top.write(TDR1_OFFSET  	, 32'habcd_1233, 4'b0100)	;
			top.verify(TDR1_OFFSET  	, 32'h00cd_1233)  		;
			
			 top.write(TDR1_OFFSET  	, 32'habcd_1233, 4'b1000)	;
			top.verify(TDR1_OFFSET  	, 32'habcd_1233)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			 top.write(TDR1_OFFSET  	, 32'h7777_7777, 4'b0011)	;
			top.verify(TDR1_OFFSET  	, 32'h0000_7777)  		;
			
			 top.write(TDR1_OFFSET  	, 32'habcd_1233, 4'b1100)	;
			top.verify(TDR1_OFFSET  	, 32'habcd_7777)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			 top.write(TDR1_OFFSET  	, 32'habcd_1233, 4'b0110)	;
			top.verify(TDR1_OFFSET  	, 32'h00cd_1200)  		;

			 top.write(TDR1_OFFSET  	, 32'habcd_1533, 4'b1111)	;
			top.verify(TDR1_OFFSET  	, 32'habcd_1533)  		;

			$display("\n=================================================END======================================\n");

			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;
			$display("\n=======================================TEST WITH TCMP0===========================\n");
				
			 top.write(TCMP0_OFFSET  	, 32'habcd_1233, 4'b0001)	;
			top.verify(TCMP0_OFFSET  	, 32'hffff_ff33)  		;

			 top.write(TCMP0_OFFSET  	, 32'habcd_1240, 4'b0010)	;
			top.verify(TCMP0_OFFSET  	, 32'hffff_1233)  		;
			
			 top.write(TCMP0_OFFSET  	, 32'habcd_1233, 4'b0100)	;
			top.verify(TCMP0_OFFSET  	, 32'hffcd_1233)  		;
			
			 top.write(TCMP0_OFFSET  	, 32'habcd_1233, 4'b1000)	;
			top.verify(TCMP0_OFFSET  	, 32'habcd_1233)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			 top.write(TCMP0_OFFSET  	, 32'h7777_7777, 4'b0011)	;
			top.verify(TCMP0_OFFSET  	, 32'hffff_7777)  		;
			
			 top.write(TCMP0_OFFSET  	, 32'habcd_1233, 4'b1100)	;
			top.verify(TCMP0_OFFSET  	, 32'habcd_7777)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			 top.write(TCMP0_OFFSET  	, 32'habcd_1233, 4'b0110)	;
			top.verify(TCMP0_OFFSET  	, 32'hffcd_12ff)  		;

			 top.write(TCMP0_OFFSET  	, 32'habcd_1533, 4'b1111)	;
			top.verify(TCMP0_OFFSET  	, 32'habcd_1533)  		;

			$display("\n=================================================END======================================\n");

			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;
			$display("\n=======================================TEST WITH TCMP1===========================\n");
				
			 top.write(TCMP1_OFFSET  	, 32'habcd_1233, 4'b0001)	;
			top.verify(TCMP1_OFFSET  	, 32'hffff_ff33)  		;

			 top.write(TCMP1_OFFSET  	, 32'habcd_1240, 4'b0010)	;
			top.verify(TCMP1_OFFSET  	, 32'hffff_1233)  		;
			
			 top.write(TCMP1_OFFSET  	, 32'habcd_1233, 4'b0100)	;
			top.verify(TCMP1_OFFSET  	, 32'hffcd_1233)  		;
			
			 top.write(TCMP1_OFFSET  	, 32'habcd_1233, 4'b1000)	;
			top.verify(TCMP1_OFFSET  	, 32'habcd_1233)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			 top.write(TCMP1_OFFSET  	, 32'h7777_7777, 4'b0011)	;
			top.verify(TCMP1_OFFSET  	, 32'hffff_7777)  		;
			
			 top.write(TCMP1_OFFSET  	, 32'habcd_1233, 4'b1100)	;
			top.verify(TCMP1_OFFSET  	, 32'habcd_7777)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			 top.write(TCMP1_OFFSET  	, 32'habcd_1233, 4'b0110)	;
			top.verify(TCMP1_OFFSET  	, 32'hffcd_12ff)  		;

			 top.write(TCMP1_OFFSET  	, 32'habcd_1533, 4'b1111)	;
			top.verify(TCMP1_OFFSET  	, 32'habcd_1533)  		;

			$display("\n=================================================END======================================\n");

			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;
			$display("\n=======================================TEST WITH TIER===========================\n");
				
			 top.write(TIER_OFFSET  	, 32'habcd_1233, 4'b0001)	;
			top.verify(TIER_OFFSET  	, 32'h0000_0001)  		;

			 top.write(TIER_OFFSET  	, 32'habcd_1240, 4'b0010)	;
			top.verify(TIER_OFFSET  	, 32'h0000_0001)  		;
			
			 top.write(TIER_OFFSET  	, 32'habcd_1233, 4'b0100)	;
			top.verify(TIER_OFFSET  	, 32'h0000_0001)  		;
			
			 top.write(TIER_OFFSET  	, 32'habcd_1233, 4'b1000)	;
			top.verify(TIER_OFFSET  	, 32'h0000_0001)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			 top.write(TIER_OFFSET  	, 32'h7777_7776, 4'b0011)	;
			top.verify(TIER_OFFSET  	, 32'h0)  		;
			
			 top.write(TIER_OFFSET  	, 32'habcd_1233, 4'b1100)	;
			top.verify(TIER_OFFSET  	, 32'h0)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			 top.write(TIER_OFFSET  	, 32'habcd_1233, 4'b0110)	;
			top.verify(TIER_OFFSET  	, 32'h0)  		;

			 top.write(TIER_OFFSET  	, 32'habcd_1533, 4'b1111)	;
			top.verify(TIER_OFFSET  	, 32'h1)  		;

			$display("\n=================================================END======================================\n");

			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;
			$display("\n=======================================TEST WITH TISR===========================\n");
				
			 top.write(TISR_OFFSET  	, 32'habcd_1233, 4'b0001)	;
			top.verify(TISR_OFFSET  	, 32'h0000_0000)  		;

			 top.write(TISR_OFFSET  	, 32'habcd_1240, 4'b0010)	;
			top.verify(TISR_OFFSET  	, 32'h0000_0000)  		;
			
			 top.write(TISR_OFFSET  	, 32'habcd_1233, 4'b0100)	;
			top.verify(TISR_OFFSET  	, 32'h0000_0000)  		;
			
			 top.write(TISR_OFFSET  	, 32'habcd_1233, 4'b1000)	;
			top.verify(TISR_OFFSET  	, 32'h0000_0000)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			 top.write(TISR_OFFSET  	, 32'h7777_7776, 4'b0011)	;
			top.verify(TISR_OFFSET  	, 32'h0)  		;
			
			 top.write(TISR_OFFSET  	, 32'habcd_1233, 4'b1100)	;
			top.verify(TISR_OFFSET  	, 32'h0)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			 top.write(TISR_OFFSET  	, 32'habcd_1233, 4'b0110)	;
			 top.verify(TISR_OFFSET  	, 32'h0)  			;
			 top.write(TDR0_OFFSET  	, 32'habcd_1233, 4'b1111)	;
			 top.write(TDR1_OFFSET  	, 32'habcd_1233, 4'b1111)	;
			 top.write(TCMP0_OFFSET  	, 32'habcd_1233, 4'b1111)	;
			 top.write(TCMP1_OFFSET  	, 32'habcd_1233, 4'b1111)	;
			 top.write(TIER_OFFSET  	, 32'habcd_1233, 4'b1111)	;
			 
			top.verify(TISR_OFFSET  	, 32'h1)  		;

			$display("\n=================================================END======================================\n");

			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;
			$display("\n=======================================TEST WITH THCSR===========================\n");
				
			 top.write(THCSR_OFFSET  	, 32'habcd_1233, 4'b0001)	;
			top.verify(THCSR_OFFSET  	, 32'h0000_0001)  		;

			 top.write(THCSR_OFFSET  	, 32'habcd_1240, 4'b0010)	;
			top.verify(THCSR_OFFSET  	, 32'h0000_0001)  		;
			
			 top.write(THCSR_OFFSET  	, 32'habcd_1233, 4'b0100)	;
			top.verify(THCSR_OFFSET  	, 32'h0000_0001)  		;
			
			 top.write(THCSR_OFFSET  	, 32'habcd_1233, 4'b1000)	;
			top.verify(THCSR_OFFSET  	, 32'h0000_0001)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			 top.write(THCSR_OFFSET  	, 32'h7777_7776, 4'b0011)	;
			top.verify(THCSR_OFFSET  	, 32'h0)  		;
			
			 top.write(THCSR_OFFSET  	, 32'habcd_1233, 4'b1100)	;
			top.verify(THCSR_OFFSET  	, 32'h0)  		;
			
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;

			 top.write(THCSR_OFFSET  	, 32'habcd_1233, 4'b0110)	;
			top.verify(THCSR_OFFSET  	, 32'h0)  		;

			 top.write(THCSR_OFFSET  	, 32'habcd_1533, 4'b1111)	;
			top.verify(THCSR_OFFSET  	, 32'h1)  		;

			$display("\n=================================================END======================================\n");
		  end

endmodule
