module check_counter();

test_bench top();
           reg[31:0] register_tmp;
	   reg[63:0] cnt, cnt_cmp;
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
		$display("\n===========================================NORMAL MODE COUNTING CHECK============================\n");
		#100;	
				$display("\n\t\t=================CHECK COUNTING OF TDR0==================\n");
				top.write(TDR0_OFFSET, 32'h0);
				top.write(TDR1_OFFSET, 32'h0);

				$display("\ntimer_en is asserted\n");
				// timer_en = 1;
				top.write(TCR_OFFSET, 32'h1);
				//counting
				repeat(254) @(posedge top.sys_clk);

				top.read(TDR0_OFFSET, register_tmp);
				cnt[31:0] = register_tmp;
				top.read(TDR1_OFFSET, register_tmp);
				cnt[63:32] = register_tmp;

				if((cnt[63:32] === 32'h0) && (cnt[31:0] <= 32'h0000_0100)) begin
					$display("\n t = %10d PASS: CNT MATCHES WITH EXPECTED VALUE = %x\n", $time, cnt);
				end else begin
					$display("\n t = %10d FAIL: CNT DOESN'T MATCH WITH EXPECTED VALUE = %x\n", $time, cnt);
				end
				
				// timer_en = 0;
				$display("\ntimer_en is desserted\n");
				top.write(TCR_OFFSET, 32'h0);
				$display("\n\t\t===========================END=========================\n");
				
				$display("\n\t\t=================CHECK COUNTING OF TDR1==================\n");
				top.write(TDR0_OFFSET, 32'hFFFF_FF00);
				top.write(TDR1_OFFSET, 32'h0);

				$display("\ntimer_en is asserted\n");
				// timer_en = 1;
				top.write(TCR_OFFSET, 32'h1);
				//counting
				repeat(254) @(posedge top.sys_clk);

				top.read(TDR0_OFFSET, register_tmp);
				cnt[31:0] = register_tmp;
				top.read(TDR1_OFFSET, register_tmp);
				cnt[63:32] = register_tmp;

				if((cnt[63:32] === 32'h1) && (cnt[31:0] <= 32'h0000_0001)) begin
					$display("\n t = %10d PASS: CNT MATCHES WITH EXPECTED VALUE = %x\n", $time, cnt);
				end else begin
					$display("\n t = %10d FAIL: CNT DOESN'T MATCH WITH EXPECTED VALUE = %x\n", $time, cnt);
				end
				
				// timer_en = 0;
				$display("\ntimer_en is desserted\n");
				top.write(TCR_OFFSET, 32'h0);
				$display("\n\t\t\t===========================END=========================\n");


				$display("\n========CHECK WRITING TO TDR0 AND TDR1 WHILE COUNTING==========\n");

				top.write(TDR0_OFFSET, 32'h0);
				top.write(TDR1_OFFSET, 32'h0);

				$display("\ntimer_en is asserted");
				// timer_en = 1;
				top.write(TCR_OFFSET, 32'h1);
				//counting
				repeat(254) @(posedge top.sys_clk);

				top.read(TDR0_OFFSET, register_tmp);
				cnt[31:0] = register_tmp;
				top.read(TDR1_OFFSET, register_tmp);
				cnt[63:32] = register_tmp;

				if((cnt[63:32] === 32'h0) && (cnt[31:0] <= 32'h0000_0100)) begin
					$display("\n t = %10d PASS: CNT MATCHES WITH EXPECTED VALUE = %x\n", $time, cnt);
				end else begin
					$display("\n t = %10d FAIL: CNT DOESN'T MATCH WITH EXPECTED VALUE = %x\n", $time, cnt);
				end
				
				$display("\n=================== WRITING TO TDR0=============\n");
				top.write(TDR0_OFFSET, 32'hFFFF_FF00);
				repeat(254) @(posedge top.sys_clk);

				top.read(TDR0_OFFSET, register_tmp);
				cnt[31:0] = register_tmp;
				top.read(TDR1_OFFSET, register_tmp);
				cnt[63:32] = register_tmp;

				if((cnt[63:32] === 32'h1) && (cnt[31:0] <= 32'h0000_0001)) begin
					$display("\n t = %10d PASS: CNT MATCHES WITH EXPECTED VALUE = %x\n", $time, cnt);
				end else begin
					$display("\n t = %10d FAIL: CNT DOESN'T MATCH WITH EXPECTED VALUE = %x\n", $time, cnt);
				end
				
				$display("\n=================== WRITING TO TDR1=============\n");
				top.write(TDR1_OFFSET, 32'h1);
				repeat(254) @(posedge top.sys_clk);
				
				top.read(TDR0_OFFSET, register_tmp);
				cnt[31:0] = register_tmp;
				top.read(TDR1_OFFSET, register_tmp);
				cnt[63:32] = register_tmp;

				if((cnt[63:32] === 32'h1) && (cnt[31:0] <= 32'h0000_0110)) begin
					$display("\n t = %10d PASS: CNT MATCHES WITH EXPECTED VALUE = %x\n", $time, cnt);
				end else begin
					$display("\n t = %10d FAIL: CNT DOESN'T MATCH WITH EXPECTED VALUE = %x\n", $time, cnt);
				end
				
					
				$display("\n\t\t\t===========================END=========================\n");
				
		$display("\n\t\t\t===========================TIMER IS NOT COUNTING WHEN TIMER ENABLE IS DISABLED=========================\n");
				
				// timer_en = 0;
				$display("\ntimer_en is desserted\n");
				top.write(TCR_OFFSET, 32'h0);

				// newest value	
				top.read(TDR0_OFFSET, register_tmp);
				cnt[31:0] = register_tmp;
				top.read(TDR1_OFFSET, register_tmp);
				cnt[63:32] = register_tmp;
		
				// counting
				repeat(254) @(posedge top.sys_clk);
				top.read(TDR0_OFFSET, register_tmp);
				cnt_cmp[31:0] = register_tmp;
				top.read(TDR1_OFFSET, register_tmp);
				cnt_cmp[63:32] = register_tmp;
				if(cnt_cmp === cnt) $display("\nt = %10d PASS: CNT ISN'T COUNTING WHEN TIMER ENABLE IS DESSERTED\n", $time);
				else $display("\nt = %10d FAIL: CNT IS COUNTING WHEN TIMER ENABLE IS DESSERTED\n", $time);
				
				$display("\n==========================================END================================================\n");

				$display("\n==================TIMER CONTINUES COUNTING WHEN TIMER ENABLE IS ASSERTED======================\n");
				top.write(TDR0_OFFSET, 32'h0);
				top.write(TDR1_OFFSET, 32'h0);

				$display("\ntimer_en is asserted\n");
				// timer_en = 1;
				top.write(TCR_OFFSET, 32'h1);
				//counting
				repeat(254) @(posedge top.sys_clk);

				top.read(TDR0_OFFSET, register_tmp);
				cnt[31:0] = register_tmp;
				top.read(TDR1_OFFSET, register_tmp);
				cnt[63:32] = register_tmp;

				if((cnt[63:32] === 32'h0) && (cnt[31:0] <= 32'h0000_0100)) begin
					$display("\n t = %10d PASS: CNT MATCHES WITH EXPECTED VALUE = %x\n", $time, cnt);
				end else begin
					$display("\n t = %10d FAIL: CNT DOESN'T MATCH WITH EXPECTED VALUE = %x\n", $time, cnt);
				end

				$display("\n============================================END====================================\n");
				

				$display("\n=============================TIMER IS CONTINUING COUNT WHEN INTERRUPT OCCURS============================\n");
				top.write(TCMP0_OFFSET, 32'h0000_000F);
				top.write(TCMP1_OFFSET, 32'h0);
				top.write(TIER_OFFSET, 32'h1);
				top.write(TDR0_OFFSET, 32'h0);
				top.write(TDR1_OFFSET, 32'h0);
				$display("\ntimer_en is asserted\n");
				// timer_en = 1;
				top.write(TCR_OFFSET, 32'h1);
				wait(top.tim_int === 1);
				top.read(TDR0_OFFSET, register_tmp);
				cnt[31:0] = register_tmp;
				top.read(TDR1_OFFSET, register_tmp);
				cnt[63:32] = register_tmp;

				if((cnt[63:32] === 32'h0) && (cnt[31:0] !== 32'h0000_000F)) begin
				      	$display("\nPASS: TIMER IS CONTINUING COUNT WHEN INTERRUPT OCCURS\n");
				end else begin 
					$display("\nFAIL: TIMER ISN'T COUNTING WHEN INTERRUPT OCCURS\n");
				end


				$display("\ntimer_en is desserted\n");
				top.write(TCR_OFFSET, 32'h0);
				

				$display("\n============================================END====================================\n");
				
				$display("\n===========================TIMER IS CONTINUING COUNT WHEN OVERFLOW OCCURS==========================\n");
				
				top.write(TDR0_OFFSET, 32'hFFFF_FF00);
				top.write(TDR1_OFFSET, 32'hFFFF_FFFF);
				$display("\ntimer_en is asserted\n");
				// timer_en = 1;
				top.write(TCR_OFFSET, 32'h1);
				repeat(254) @(posedge top.sys_clk);
				top.read(TDR0_OFFSET, register_tmp);
				top.read(TDR1_OFFSET, register_tmp);

				if((cnt[63:32] === 32'h0) && (cnt[31:0] !== 32'h0000_0000)) begin
				      	$display("\nPASS: TIMER IS CONTINUING COUNT WHEN OVERFLOW OCCURS\n");
				end else begin 
					$display("\nFAIL: TIMER ISN'T COUNTING WHEN OVERFLOW OCCURS\n");
		  	        end
		$display("\n=======================================================END TEST=============================================\n");
	end
endmodule
