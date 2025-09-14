module reg_write_read();

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

			$display("\n=======================================TEST WRITE-READ TCR===========================\n");
			$display("\n=======================================WRITE READ NORMAL===========================\n");
				
			top.write(TCR_OFFSET  	, 32'h0000_0802, 4'hF)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0802)  	;

			$display("\n=================================================END======================================\n");

			$display("\n=======================================TEST WRITE-READ TCR===========================\n");
			$display("\n=======================================WRITE READ NORMAL===========================\n");
			top.write(TCR_OFFSET  	, 32'hffff_f5f0, 4'hF)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0500) 	;
			top.write(TCR_OFFSET  	, 32'hffff_f6f3, 4'hF)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0603) 	;
			$display("\n=================================================END======================================\n");
			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
		        #10;
		        $display("\n=======================================TEST WRITE-READ TCR===========================\n");
		        $display("\n=======================================SETTING PROHIBIT VALUE TO DIV_VAL===========================\n");
		        top.write(TCR_OFFSET  	, 32'h5555_5955, 4'hF)	;
		        top.verify(TCR_OFFSET  	, 32'h0000_0100)  	;
		        $display("\n=================================================END======================================\n");

		        $display("\n=======================================TEST WRITE-READ TCR===========================\n");
		        $display("\n=======================================SETTING PROHIBIT VALUE TO DIV_VAL===========================\n");
		        top.write(TCR_OFFSET  	, 32'h5555_5a55, 4'hF)	;
		        top.verify(TCR_OFFSET  	, 32'h0000_0100)  	;
		        $display("\n=================================================END======================================\n");

		        $display("\n=======================================TEST WRITE-READ TCR===========================\n");
		        $display("\n=======================================SETTING PROHIBIT VALUE TO DIV_VAL===========================\n");
		        top.write(TCR_OFFSET  	, 32'h5555_5b55, 4'hF)	;
		        top.verify(TCR_OFFSET  	, 32'h0000_0100)  	;
		        $display("\n=================================================END======================================\n");

		        $display("\n=======================================TEST WRITE-READ TCR===========================\n");
		        $display("\n=======================================SETTING PROHIBIT VALUE TO DIV_VAL===========================\n");
		        top.write(TCR_OFFSET  	, 32'h5555_5c55, 4'hF)	;
		        top.verify(TCR_OFFSET  	, 32'h0000_0100)  	;
		        $display("\n=================================================END======================================\n");

		        $display("\n=======================================TEST WRITE-READ TCR===========================\n");
		        $display("\n=======================================SETTING PROHIBIT VALUE TO DIV_VAL===========================\n");
		        top.write(TCR_OFFSET  	, 32'h5555_5d55, 4'hF)	;
		        top.verify(TCR_OFFSET  	, 32'h0000_0100)  	;
		        $display("\n=================================================END======================================\n");

		        $display("\n=======================================TEST WRITE-READ TCR===========================\n");
		        $display("\n=======================================SETTING PROHIBIT VALUE TO DIV_VAL===========================\n");
		        top.write(TCR_OFFSET  	, 32'h5555_5e55, 4'hF)	;
		        top.verify(TCR_OFFSET  	, 32'h0000_0100)  	;
		        $display("\n=================================================END======================================\n");

		        $display("\n=======================================TEST WRITE-READ TCR===========================\n");
		        $display("\n=======================================SETTING PROHIBIT VALUE TO DIV_VAL===========================\n");
		        top.write(TCR_OFFSET  	, 32'h5555_5f55, 4'hF)	;
		        top.verify(TCR_OFFSET  	, 32'h0000_0100)  	;
		        $display("\n=================================================END======================================\n");

			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			#10;
			$display("\n=======================================TEST WRITE-READ TCR===========================\n");
			$display("\n=======================================NO ERROR===========================\n");
	
			top.write(TCR_OFFSET  	, 32'habcd_0302, 4'hF)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0302)  	;
			$display("\n=================================================END======================================\n");
		      
			$display("\n=======================================TEST WRITE-READ TCR===========================\n");
			$display("\n=======================================SET TIMER_EN===========================\n");
			top.write(TCR_OFFSET  	, 32'h5AA5_A553, 4'hF)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0503)  	;
			$display("\n=================================================END======================================\n");

			$display("\n=======================================TEST WRITE-READ TCR===========================\n");
			$display("\n==================DIV_VAL IS PROHIBITED TO CHANGE WHEN TIMER_EN IS HIGH=====================\n");
			top.write(TCR_OFFSET  	, 32'h2222_A653, 4'hF)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0503)  	;
			$display("\n=================================================END======================================\n");
			
			$display("\n=======================================TEST WRITE-READ TCR===========================\n");
			$display("\n==================DIV_EN IS PROHIBITED TO CHANGE WHEN TIMER_EN IS HIGH=====================\n");
			top.write(TCR_OFFSET  	, 32'h2222_A851, 4'hF)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0503 )  	;
			$display("\n=================================================END======================================\n");
			
			top.sys_rst_n = 1'b0;
			#100 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;

			 $display("\n=======================================TEST WRITE-READ TCR===========================\n");
			top.write(TCR_OFFSET  	, 32'h2222_2725, 4'hF)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0701 )  	;

			$display("\n=================================================END======================================\n");
			top.sys_rst_n = 1'b0;
			#100 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			/*
			$display("\n=======================================TEST WRITE-READ TCR===========================\n");
			top.write(TCR_OFFSET  	, 32'h2222_2622, 4'hF)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0501 )  	;
			$display("\n=================================================END======================================\n");

			$display("\n=======================================TEST WRITE-READ TCR===========================\n");
			top.write(TCR_OFFSET  	, 32'h2222_2424, 4'hF)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0501 )  	;

			$display("\n=================================================END======================================\n");
			
			$display("\n=======================================TEST WRITE-READ TCR===========================\n");
			top.write(TCR_OFFSET  	, 32'h2222_2122, 4'hF)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0102 )  	;
			$display("\n=================================================END======================================\n");
*/
			top.write(TCR_OFFSET  	, 32'h0, 4'hF)	; 
			$display("\n=======================================TEST WRITE-READ TDR0===========================\n");
			top.write(TDR0_OFFSET 	, 32'h3333_3333, 4'hF)	;
			top.verify(TDR0_OFFSET 	, 32'h3333_3333)  	;

			$display("\n=================================================END======================================\n");
		
			$display("\n=======================================TEST WRITE-READ TDR0===========================\n");
			top.write(TDR0_OFFSET 	, 32'h1111_1111, 4'hF)	;
			top.verify(TDR0_OFFSET 	, 32'h1111_1111)  	;

			$display("\n=================================================END======================================\n");

			$display("\n=======================================TEST WRITE-READ TDR0===========================\n");
			top.write(TDR0_OFFSET 	, 32'h2222_2222, 4'hF)	;
			top.verify(TDR0_OFFSET 	, 32'h2222_2222)  	;

			$display("\n=================================================END======================================\n");

			$display("\n=======================================TEST WRITE-READ TDR0===========================\n");
			top.write(TDR0_OFFSET 	, 32'hAAAA_AAAA, 4'hF)	;
			top.verify(TDR0_OFFSET 	, 32'hAAAA_AAAA)  	;

			$display("\n=================================================END======================================\n");

			$display("\n=======================================TEST WRITE-READ TDR0===========================\n");
			top.write(TDR0_OFFSET 	, 32'h0, 4'hF)	;
			top.verify(TDR0_OFFSET 	, 32'h0)  	;

			$display("\n=================================================END======================================\n");


			$display("\n=======================================TEST WRITE-READ TDR0===========================\n");
			top.write(TDR0_OFFSET 	, 32'h9999_9999, 4'hF)	;
			top.verify(TDR0_OFFSET 	, 32'h9999_9999)  	;

			$display("\n=================================================END======================================\n");


			$display("\n=======================================TEST WRITE-READ TDR0===========================\n");
			top.write(TDR0_OFFSET 	, 32'h7777_7777, 4'hF)	;
			top.verify(TDR0_OFFSET 	, 32'h7777_7777)  	;

			$display("\n=================================================END======================================\n");


			$display("\n=======================================TEST WRITE-READ TDR1===========================\n");
			top.write(TDR1_OFFSET 	, 32'h4444_4444, 4'hF)	;
			top.verify(TDR1_OFFSET 	, 32'h4444_4444)  	;

			$display("\n=================================================END======================================\n");
			
			$display("\n=======================================TEST WRITE-READ TDR1===========================\n");
			top.write(TDR1_OFFSET 	, 32'h0, 4'hF)	;
			top.verify(TDR1_OFFSET 	, 32'h0)  	;

			$display("\n=================================================END======================================\n");

			$display("\n=======================================TEST WRITE-READ TDR1===========================\n");
			top.write(TDR1_OFFSET 	, 32'h4444_AAAA, 4'hF)	;
			top.verify(TDR1_OFFSET 	, 32'h4444_AAAA)  	;

			$display("\n=================================================END======================================\n");

			$display("\n=======================================TEST WRITE-READ TDR1===========================\n");
			top.write(TDR1_OFFSET 	, 32'h9999_9999, 4'hF)	;
			top.verify(TDR1_OFFSET 	, 32'h9999_9999)  	;

			$display("\n=================================================END======================================\n");


			$display("\n=======================================TEST WRITE-READ TDR1===========================\n");
			top.write(TDR1_OFFSET 	, 32'hCCCC_CCCC, 4'hF)	;
			top.verify(TDR1_OFFSET 	, 32'hCCCC_CCCC)  	;

			$display("\n=================================================END======================================\n");


			$display("\n=======================================TEST WRITE-READ TDR1===========================\n");
			top.write(TDR1_OFFSET 	, 32'h1111_2222, 4'hF)	;
			top.verify(TDR1_OFFSET 	, 32'h1111_2222)  	;

			$display("\n=================================================END======================================\n");


			$display("\n=======================================TEST WRITE-READ TDR1===========================\n");
			top.write(TDR1_OFFSET 	, 32'hABCD_1234, 4'hF)	;
			top.verify(TDR1_OFFSET 	, 32'hABCD_1234)  	;

			$display("\n=================================================END======================================\n");


			$display("\n=======================================TEST WRITE-READ TDR1===========================\n");
			top.write(TDR1_OFFSET 	, 32'hFFFF_FF88, 4'hF)	;
			top.verify(TDR1_OFFSET 	, 32'hFFFF_FF88)  	;

			$display("\n=================================================END======================================\n");


			$display("\n=======================================TEST WRITE-READ TDR1===========================\n");
			top.write(TDR1_OFFSET 	, 32'h1234_5678, 4'hF)	;
			top.verify(TDR1_OFFSET 	, 32'h1234_5678)  	;

			$display("\n=================================================END==================================\n");

			$display("\n=======================================TEST WRITE-READ TCMP0===========================\n");
			top.write(TCMP0_OFFSET	, 32'h5555_5555, 4'hF)	;
			top.verify(TCMP0_OFFSET	, 32'h5555_5555)  	;

			$display("\n=================================================END======================================\n");
		
			$display("\n=======================================TEST WRITE-READ TCMP0===========================\n");
			top.write(TCMP0_OFFSET	, 32'h1234_ABCD, 4'hF)	;
			top.verify(TCMP0_OFFSET	, 32'h1234_ABCD)  	;

			$display("\n=================================================END======================================\n");

			$display("\n=======================================TEST WRITE-READ TCMP0===========================\n");
			top.write(TCMP0_OFFSET	, 32'h5568_5725, 4'hF)	;
			top.verify(TCMP0_OFFSET	, 32'h5568_5725)  	;

			$display("\n=================================================END======================================\n");

			$display("\n=======================================TEST WRITE-READ TCMP0===========================\n");
			top.write(TCMP0_OFFSET	, 32'h0, 4'hF)	;
			top.verify(TCMP0_OFFSET	, 32'h0)  	;

			$display("\n=================================================END======================================\n");


			$display("\n=======================================TEST WRITE-READ TCMP1===========================\n");
			top.write(TCMP1_OFFSET	, 32'h6666_6666, 4'hF)	;
			top.verify(TCMP1_OFFSET	, 32'h6666_6666)  	;

			$display("\n=================================================END======================================\n");

			$display("\n=======================================TEST WRITE-READ TCMP1===========================\n");
			top.write(TCMP1_OFFSET	, 32'h1244_6600, 4'hF)	;
			top.verify(TCMP1_OFFSET	, 32'h1244_6600)  	;

			$display("\n=================================================END======================================\n");

			$display("\n=======================================TEST WRITE-READ TCMP1===========================\n");
			top.write(TCMP1_OFFSET	, 32'hCCfA_6677, 4'hF)	;
			top.verify(TCMP1_OFFSET	, 32'hCCfA_6677)  	;

			$display("\n=================================================END======================================\n");

			$display("\n=======================================TEST WRITE-READ TCMP1===========================\n");
			top.write(TCMP1_OFFSET	, 32'h6677_8866, 4'hF)	;
			top.verify(TCMP1_OFFSET	, 32'h6677_8866)  	;

			$display("\n=================================================END======================================\n");

			$display("\n=======================================TEST WRITE-READ TCMP1===========================\n");
			top.write(TCMP1_OFFSET	, 32'h6326_6596, 4'hF)	;
			top.verify(TCMP1_OFFSET	, 32'h6326_6596)  	;

			$display("\n=================================================END======================================\n");




			$display("\n=======================================TEST WRITE-READ TIER===========================\n");
			top.write(TIER_OFFSET 	, 32'h7777_7777, 4'hF)	;
			top.verify(TIER_OFFSET 	, 32'h1)  	;

			$display("\n=================================================END======================================\n");
		

			$display("\n=======================================TEST WRITE-READ TIER===========================\n");
			top.write(TIER_OFFSET 	, 32'h0, 4'hF)	;
			top.verify(TIER_OFFSET 	, 32'h0)  	;

			$display("\n=================================================END======================================\n");



			$display("\n=======================================TEST WRITE-READ TIER===========================\n");
			top.write(TIER_OFFSET 	, 32'h7777_7773, 4'hF)	;
			top.verify(TIER_OFFSET 	, 32'h1)  	;

			$display("\n=================================================END======================================\n");



			$display("\n=======================================TEST WRITE-READ TIER===========================\n");
			top.write(TIER_OFFSET 	, 32'h7777_777D, 4'hF)	;
			top.verify(TIER_OFFSET 	, 32'h1)  	;

			$display("\n=================================================END======================================\n");





			$display("\n=======================================TEST WRITE-READ TISR===========================\n");
			top.write(TISR_OFFSET 	, 32'h1111_1111, 4'hF)	;
			top.verify(TISR_OFFSET 	, 32'h0)  	;

			$display("\n=================================================END======================================\n");
			

			$display("\n=======================================TEST WRITE-READ TISR===========================\n");
			top.write(TISR_OFFSET 	, 32'hACCC_1110, 4'hF)	;
			top.verify(TISR_OFFSET 	, 32'h0)  	;

			$display("\n=================================================END======================================\n");


			$display("\n=======================================TEST WRITE-READ TISR===========================\n");
			top.write(TISR_OFFSET 	, 32'h11EF_6789, 4'hF)	;
			top.verify(TISR_OFFSET 	, 32'h0)  	;

			$display("\n=================================================END======================================\n");


			$display("\n=======================================TEST WRITE-READ TISR===========================\n");
			top.write(TISR_OFFSET 	, 32'h1111_AAFF, 4'hF)	;
			top.verify(TISR_OFFSET 	, 32'h0)  	;

			$display("\n=================================================END======================================\n");




			$display("\n=======================================TEST WRITE-READ THCSR===========================\n");
			top.write(THCSR_OFFSET	, 32'h8888_8888, 4'hF)	;
			top.verify(THCSR_OFFSET	, 32'h0)  	;

			$display("\n=================================================END======================================\n");
		

			$display("\n=======================================TEST WRITE-READ THCSR===========================\n");
			top.write(THCSR_OFFSET	, 32'h1234_FFF8, 4'hF)	;
			top.verify(THCSR_OFFSET	, 32'h0)  	;

			$display("\n=================================================END======================================\n");


			$display("\n=======================================TEST WRITE-READ THCSR===========================\n");
			top.write(THCSR_OFFSET	, 32'h6969_9696, 4'hF)	;
			top.verify(THCSR_OFFSET	, 32'h0)  	;

			$display("\n=================================================END======================================\n");



			$display("\n=======================================TEST WRITE-READ THCSR===========================\n");
			top.write(THCSR_OFFSET	, 32'hCCDE_8885, 4'hF)	;
			top.verify(THCSR_OFFSET	, 32'h1)  	;

			$display("\n=================================================END======================================\n");


			$display("\n=======================================TEST WRITE-READ THCSR===========================\n");
			top.write(THCSR_OFFSET	, 32'h3223_1293, 4'hF)	;
			top.verify(THCSR_OFFSET	, 32'h1)  	;

			$display("\n=================================================END======================================\n");

			top.sys_rst_n = 1'b0;
			#100 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
			$display("\n===============CHECK VALUE OF COUNTER WHEN TIMER ENABLE FROM HIGH TO LOW====================\n");
			top.write(TCR_OFFSET	, 32'h3223_1001, 4'hF)	;
			top.read(TDR0_OFFSET	, register_tmp);
			top.read(TDR1_OFFSET	, register_tmp);
			top.write(TCR_OFFSET	, 32'h0, 4'hF);
			repeat(100) @(posedge top.sys_clk);
			top.verify(TDR0_OFFSET	, 32'h0)  	;
			top.verify(TDR1_OFFSET	, 32'h0)  	;

			$display("\n=================================================END======================================\n");
				top.write (12'h00 + 1	,32'h1234_ABCD, 4'hF);
				top.verify(12'h00 + 1	,32'h0	      );	


			$display("\n=======================================TEST WITH TCR===========================\n");
				
			top.write(TCR_OFFSET  	, 32'habcd_1233, 4'b0010)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0200)  		;
			//case1
			top.write(TCR_OFFSET  	, 32'habcd_1233, 4'b0001)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0203)  		;
			
			top.write(TCR_OFFSET  	, 32'habcd_1233, 4'b0100)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0203)  		;
			
			top.write(TCR_OFFSET  	, 32'habcd_1233, 4'b1000)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0203)  		;
			//case2
			top.write(TCR_OFFSET  	, 32'habcd_1933, 4'b1000)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0203)  		;

			top.write(TCR_OFFSET  	, 32'habcd_1933, 4'b0010)	;
			top.verify(TCR_OFFSET  	, 32'h0000_0203)  		;

			top.write(TCR_OFFSET  	, 32'habcd_1a33, 4'b0001)	;
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
