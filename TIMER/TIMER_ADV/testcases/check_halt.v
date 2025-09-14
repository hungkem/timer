module check_halt();
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
			#100;				
			$display("==================CHECK VALUE OF HALT_ACK WHEN DEBUG_MODE AND HALT_REQ ARE HIGH==============================");
			top.write(THCSR_OFFSET, 32'h1, 4'hF);
			top.verify(THCSR_OFFSET, 32'h1);
			top.dbg_mode = 1'b1;
			repeat(5) @(posedge top.sys_clk);
			top.verify(THCSR_OFFSET, 32'h3);
			top.write(THCSR_OFFSET, 32'h0, 4'hF);
			repeat(5) @(posedge top.sys_clk);
			top.verify(THCSR_OFFSET, 32'h0);



			$display("=================================================END============================================");

			top.sys_rst_n = 1'b0;
			#10 @(posedge top.sys_clk);
			top.sys_rst_n = 1'b1;
		        #10;

			$display("================================CHECK COUNTER HALTED AND RESUMED==============================");
			top.dbg_mode = 1'b1;
			top.write(TCR_OFFSET	, 32'hffff_f203, 4'hF);
			repeat(100) @(posedge top.sys_clk);
			top.read(TDR0_OFFSET	, register_tmp);
			top.read(TDR1_OFFSET	, register_tmp);
			top.write(THCSR_OFFSET	, 32'hffff_ffff, 4'hF);		
			repeat(100) @(posedge top.sys_clk);
			top.read(TDR0_OFFSET	, cnt_cmp[31:0]);
			top.read(TDR1_OFFSET	, cnt_cmp[63:32]);
			repeat(100) @(posedge top.sys_clk);
			top.read(TDR0_OFFSET	, cnt[31:0]);
			top.read(TDR1_OFFSET	, cnt[63:32]);
			if(cnt === cnt_cmp) $display("PASS: COUNTER IS COUNTING NORMALLY WHEN TIMER_EN IS HIGH AND HALTED WHEN DBG_MODE AND HALT_REQ ARE HIGH");
			else $display("FAIL: COUNTER ISN'T HALTED WHEN DBG_MODE AND HALT_REQ ARE HIGH");
			top.write(THCSR_OFFSET	, 32'hffff_fff4, 4'hF);		
			$display("COUNTER IS COUNTING NORMALLY WHEN HALT_REQ IS DESSERTED");
			repeat(100) @(posedge top.sys_clk);
			top.read(TDR0_OFFSET	, cnt_cmp[31:0]);
			top.read(TDR1_OFFSET	, cnt_cmp[63:32]);
			if(cnt !== cnt_cmp) 			$display("PASS: COUNTER IS COUNTING NORMALLY WHEN HALT_REQ IS DESSERTED");
			else $display("FAIL: COUNTER ISN'T RESUMED");

			$display("=================================================END============================================");
		end
endmodule
