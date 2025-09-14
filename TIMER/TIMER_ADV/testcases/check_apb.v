module check_apb();

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

			$display("===========================================WRITE READ NORMAL========================================");
			top.write(TCMP0_OFFSET, 32'h1234_5678, 4'hF);
			top.verify(TCMP0_OFFSET, 32'h1234_5678);
			$display("===============================================END=============================================\n");	

			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
		        #10;

			$display("===========================================WRITE FAILED========================================\n");

			$display("===========================================1.ERROR OF PSEL========================================\n");
			top.psel_err = 1'b1;
			top.write(TCMP0_OFFSET, 32'h6666_9999, 4'hF);
			top.psel_err = 1'b0;
			top.verify(TCMP0_OFFSET, 32'hFFFF_FFFF);
			$display("===============================================END=============================================");	
			$display("===========================================2.ERROR OF PENABLE========================================\n");
			
			top.penable_err = 1'b1;
			top.write(TCMP0_OFFSET, 32'h6666_9999, 4'hF);
			top.penable_err = 1'b0;
			top.verify(TCMP0_OFFSET, 32'hFFFF_FFFF);
			$display("===============================================END=============================================");
			
			$display("===========================================READ FAILED========================================\n");

			$display("===========================================1.ERROR OF PSEL========================================\n");
			top.psel_err = 1'b1;
			top.read(TCMP0_OFFSET, register_tmp);
			top.verify(TCMP0_OFFSET, 32'h0);
			top.psel_err = 1'b0;
			$display("===============================================END=============================================");	

			$display("===========================================2.ERROR OF PENABLE========================================\n");
			
			top.penable_err = 1'b1;
			top.read(TCMP0_OFFSET, register_tmp);
			top.verify(TCMP0_OFFSET, 32'h0);
			top.penable_err = 1'b0;
			$display("===============================================END=============================================");

			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
		        #10;

			$display("===========================================MULTIPLE WRITE========================================\n");
					// set up phase
				@(posedge top.sys_clk)		;
				#1				;
				top.tim_paddr  = TCMP0_OFFSET	;
				top.tim_pwrite = 1		;
				top.tim_psel   = 1 		;
				top.tim_pwdata = 32'h1111_1111	;
				top.tim_pstrb  = 4'hF		;
				// access phase
				@(posedge top.sys_clk)		;
				#1				;
				top.tim_penable = 1		;
				wait(top.tim_pready === 1)  	;// wait finish tranfer
				// set up phase
				@(posedge top.sys_clk)		;
				#1				;
				top.tim_penable = 0		;
				top.tim_paddr  = TCMP1_OFFSET	;
				top.tim_pwdata = 32'h2222_2222	;
				// access phase
				@(posedge top.sys_clk)		;
				#1				;
				top.tim_penable = 1		;
				wait(top.tim_pready === 1)  	;// wait finish tranfer
				@(posedge top.sys_clk)		;
				// end of access
				#1				;
				top.tim_paddr   = 0			;
				top.tim_psel    = 0			;
				top.tim_pwrite  = 0			;
				top.tim_penable = 0			;
				top.tim_pwdata  = 0			;

			$display("===============================================END=============================================");


			$display("===========================================MULTIPLE READ========================================\n");
					// set up phase
				@(posedge top.sys_clk)		;
				#1				;
				top.tim_paddr  = TCMP0_OFFSET	;
				top.tim_pwrite = 0		;
				top.tim_psel   = 1 		;
				// access phase
				@(posedge top.sys_clk)		;
				#1				;
				top.tim_penable = 1		;
				wait(top.tim_pready === 1)  	;// wait finish tranfer
				#1				;
				top.verify(TCMP0_OFFSET, 32'h1111_1111);
				// set up phase
				@(posedge top.sys_clk)		;
				#1				;
				top.tim_penable = 0		;
				top.tim_paddr  = TCMP1_OFFSET	;
				// access phase
				@(posedge top.sys_clk)		;
				#1				;
				top.tim_penable = 1		;
				wait(top.tim_pready === 1)  	;// wait finish tranfer
				#1				;
				top.verify(TCMP1_OFFSET, 32'h2222_2222);
				@(posedge top.sys_clk)		;
				// end of access
				#1				;
				top.tim_paddr   = 0		;
				top.tim_psel    = 0		;
				top.tim_pwrite  = 0		;
				top.tim_penable = 0		;
				top.tim_pwdata  = 0		;

			$display("===============================================END=============================================");

		end
endmodule
