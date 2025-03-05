module check_interrupt();
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
		$display("====================================CHECK TIMER INTERRUPT AND INTERRUPT STATUS WHEN COUNTER COUNTING UP TO EQUAL COMPARE VALUE==============================\n");

		top.write(TCMP0_OFFSET	, 32'hFF);
		top.write(TCMP1_OFFSET	, 32'h0);
		top.write(TIER_OFFSET	, 32'h1);
		top.write(TCR_OFFSET	, 32'h1);
		// counting
		repeat(254) @(posedge top.sys_clk);
		top.read(TISR_OFFSET, register_tmp);
		if(top.tim_int === 1 && register_tmp === 32'h1) $display("\nt = %10d PASS: TIMER INTERRUPT AND INTERRUPT STATUS ARE ASSERTED\n", $time);
		else $display("\nt = %10d FAIL: TIMER INTERRUPT AND INTERRUPT STATUS ARE DESSERTING\n", $time);
		$display("\n==============================================END==================================\n");

		$display("\n===================================CHECK REGISTER ATTRIBUTE=============================\n");
		
		$display("\n=============================1.WRITE 0 INTO INTERRUPT STATUS================================\n");
			top.write(TISR_OFFSET, 32'h0);
			top.read(TISR_OFFSET, register_tmp);
			if(top.tim_int === 1 && register_tmp === 32'h1) $display("\n t = %10d PASS: WRITE 0 WHEN THIS BIT IS 1 HAS NO EFFECT. TIMER INTERRUPT AND INTERRUPT STATUS ARE KEPT ASSERTING\n", $time);
			else $display("\nt = 10%d FAIL: TIMER INTERRUPT AND INTERRUPT STATUS ARE DESSERTED\n", $time);

		$display("\n==============================================END==================================\n");
			
		$display("\n=============================2.WRITE 1 INTO INTERRUPT STATUS================================\n");
		
			top.write(TISR_OFFSET, 32'h1);
			top.read(TISR_OFFSET, register_tmp);
			if(top.tim_int === 0 && register_tmp === 32'h0) $display("\n t = %10d PASS: WRITE 1 WHEN THIS BIT IS 1 TO CLEAR IT. TIMER INTERRUPT AND INTERRUPT STATUS ARE DESSERTED\n", $time);
			else $display("\nt = 10%d FAIL: TIMER INTERRUPT AND INTERRUPT STATUS IS KEPT ASSERTING\n", $time);

		$display("\n==============================================END==================================\n");


		top.sys_rst_n = 0;
		#100;
		top.sys_rst_n = 1;
		
		$display("\n========================================CHECK TIMER INTERRUPT AND INTERRUPT STATUS WHEN INTERRUPT ENABLE IS DESSERTED===============================\n");
		
		top.write(TCMP0_OFFSET	, 32'hFF);
		top.write(TCMP1_OFFSET	, 32'h0);
		top.write(TCR_OFFSET	, 32'h1);
		//counting
		repeat(254) @(posedge top.sys_clk); 
		top.write(TIER_OFFSET	, 32'h0);
		top.read(TISR_OFFSET, register_tmp);
		if(top.tim_int === 0 && register_tmp === 32'h1) $display("\nt = %10d PASS: TIMER INTERRUPT IS DESSERTED AND INTERRUPT STATUS IS ASSERTED\n", $time);
		else $display("\nt = %10d FAIL: TIMER INTERRUPT AND INTERRUPT STATUS IS ASSERTED\n", $time);

		$display("\nSET INTERRUPT ENABLE AND CHECK TIMER INTERRUPT AGAIN\n");
		top.write(TIER_OFFSET	, 32'h1);
		top.read(TISR_OFFSET	, register_tmp);
		if(top.tim_int === 1 && register_tmp === 32'h1) $display("\nt = %10d PASS: TIMER INTERRUPT AND INTERRUPT STATUS ARE ASSERTED\n", $time);
		else $display("\nt = %10d FAIL: TIMER INTERRUPT IS KEPT DESSERTING AND INTERRUPT STATUS IS ASSERTED\n", $time);

		$display("\n==============================================END CHECK==================================\n");
		
		top.sys_rst_n = 0;
		#100;
		top.sys_rst_n = 1;

		$display("\n==============================================CHECK TIMER INTERRUPT AND INTERRUPT STATUS WHEN WRITE 2 EQUAL VALUE INTO TCMP AND CNT==================================\n");
		top.write(TCMP0_OFFSET	, 32'h123);
		top.write(TCMP1_OFFSET	, 32'h0);
		top.write(TDR0_OFFSET	, 32'h123);
		top.write(TDR1_OFFSET	, 32'h0);
		// interrupt always occurs
		top.write(TIER_OFFSET	, 32'h1);
		top.read(TISR_OFFSET	, register_tmp);
		if(top.tim_int === 1 && register_tmp === 32'h1) $display("\nt = %10d PASS: TIMER INTERRUPT AND INTERRUPT STATUS ARE ASSERTED\n", $time);
		else $display("\nt = %10d FAIL: TIMER INTERRUPT AND INTERRUPT STATUS ARE KEPT DESSERTING\n", $time);
		$display("\n==============================================END==================================\n");

		$display("\ninterrupt enable is desserted\n");
		top.write(TIER_OFFSET	, 32'h0);
		top.read(TISR_OFFSET	, register_tmp);	
		if(top.tim_int === 0 && register_tmp === 32'h1) $display("\nt = %10d PASS: TIMER INTERRUPT IS DESSERTED AND INTERRUPT STATUS IS KEPT ASSERTING\n", $time);
		else $display("\nt = %10d FAIL: TIMER INTERRUPT AND INTERRUPT STATUS ARE KEPT ASSERTING\n", $time);
		$display("\n==============================================END==================================\n");

		$display("\ninterrupt enable is asserted\n");
		top.write(TIER_OFFSET	, 32'h1);
		top.write(TISR_OFFSET	, 32'h1);
		if(top.tim_int === 0 && top.timer_top_dut.interrupt_dut.int_st === 1'b0) $display("\nt = %10d PASS: TIMER INTERRUPT AND INTERRUPT STATUS ARE DESSERTED\n", $time);
		else $display("\nt = %10d FAIL: TIMER INTERRUPT AND INTERRUPT STATUS ARE ASSERTED\n", $time);
		
		repeat(2) @(posedge top.sys_clk);
		if(top.tim_int === 0 && top.timer_top_dut.interrupt_dut.int_st === 1'b0) $display("\nt = %10d PASS: TIMER INTERRUPT AND INTERRUPT STATUS ARE ASSERTED\n", $time);
		else $display("\nt = %10d FAIL: TIMER INTERRUPT AND INTERRUPT STATUS ARE KEPT DESSERTING\n", $time);




		$display("\n==============================================END CHECK==================================\n");
		
	end

endmodule
