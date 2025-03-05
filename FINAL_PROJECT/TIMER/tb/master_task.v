module master_task(	input wire 		sys_clk		,
			input wire 		sys_rst_n	,
			output reg 		tim_psel	,
			output reg 		tim_pwrite	,
			output reg 		tim_penable	,
			output reg 	[31:0]	tim_paddr	,
			output reg 	[31:0]	tim_pwdata	,
			input wire 	[31:0]	tim_prdata	,
			input wire 		tim_pready	);

		// write tranfer
		task write(input [31:0] in_addr, in_data);
			begin
				$display("t = %10d DATA IS WRITTEN IN: addr = %x IS data = %x", $time, in_addr, in_data);
				@(posedge sys_clk);
				#1;
				tim_paddr = in_addr;
				tim_pwrite = 1;
				tim_psel = 1;
				tim_pwdata = in_data;
				@(posedge sys_clk);
				#1;
				tim_penable = 1;
				wait(tim_pready == 1)
				@(posedge sys_clk)
				tim_paddr = 0;
				tim_psel = 0;
				tim_pwrite = 0;
				tim_penable = 0;
				tim_pwdata = 0;
			//	tim_pready = 0;
			end
		endtask

		// read tranfer
		task read(input [31:0]in_addr, out_data);
			begin
				@(posedge sys_clk);
				#1;
				tim_paddr = in_addr;
				tim_pwrite = 0;
				tim_psel = 1;
				@(posedge sys_clk);
				#1;
				tim_penable = 1;
				wait(tim_pready == 1);
				#1 out_data = tim_prdata;
				@(posedge sys_clk);
				tim_paddr = 0;
				tim_pwrite = 0;
				tim_penable = 0;
				tim_psel = 0;
			$display("t = %10d REGISTER WITH addr = %x HAVE data = %x", $time, in_addr, out_data);
			end

		endtask

endmodule
