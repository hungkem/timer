`define TCR   32'h4000_1000
`define TDR0  32'h4000_1004
`define TDR1  32'h4000_1008
`define TCMP0 32'h4000_100C
`define TCMP1 32'h4000_1010
`define TIER  32'h4000_1014
`define TISR  32'h4000_1018
`define THCSR 32'h4000_101C

module counter_normal();

reg [31:0] addr;
reg [31:0] wdata;
reg [31:0] rdata;
integer exp_time;

reg [31:0] temp_tdr0;
reg [31:0] temp_tdr1;
reg [31:0] temp_cmp0;
reg [31:0] temp_cmp1;
reg [3:0]  temp_div_val;



test_bench top();


initial begin
	/*
	* thu tu config thanh ghi de dieu khien counter (normal hoac control mode) va kiem tra interrupt
	* 0/ clear thanh ghi TCR va TIER
	* 1/ ghi thanh ghi TDR0/1
	* 2/ ghi thanh ghi TCMP0/1
	* 3/ clear thanh ghi TISR -> write 1 -> read -> kiem tra da ve 0 chua
	* 4/ 
		* enable timer -> write TCR (bit tim_en=1) --- normal mode
		* enable timer/ enable divide clock -> write TCR --- control mode
			* bit tim_en =1
			* bit div_en =1
			* bit [] div_val = ... (tuy y)
		* enable interrupt -> write TIER
	*  
	* 5/ tinh toan expect thoi gian interrupt: dua tren che do normal hoac control
	*    => exp_time = bao nhieu clock sys_clk
	*    => vi du: 
		*    tim_en =1; div_en =1; div_val =2 (meaning: f/4 hoac T*4)
		*    {TDR1,TDR0}   = 64'h05;
		*    {TCMP1,TCMP0} = 64'h0FF;
		*    (255 - 5) * 4 = 1000
		*    => exp_time = 1000 posedge sys_clk 
	* 
	* 6/ wait so clock < exp_time -> kiem tra TISR = 0 ?
	* 7/ wait so clock > exp_time -> kiem tra TISR = 1 ?
	* 6/ va 7/ minh dung fork ... join de thuc hien song song
	* 
	* neu khong biet dung fork ... join thi chi can thuc hien 7/
	*
	* 8/ sau khi TISR = 1 -> write TIER -> interrupt_en = 0 
		* -> kiem tra output interrupt = 0 ?
		* -> kiem tra TISR = 1 ? (khong bi anh huong boi tim_en) 
	*
	* 9/ clear TISR -> kiem tra TISR = 0 ?
	* 
	*/

        #200; // wait reset done	
	$display("********************** COUNTER CONTROL MODE ************************");
	// Step 0
	$display("Step 0: Clear TCR/TIER ");
	$display("---");
	addr  = `TCR; 
	wdata = 32'h0;
	top.apb.apb_write(addr, wdata);

	addr  = `TIER;
	wdata = 32'h0;
	top.apb.apb_write(addr, wdata);

	$display("Step 1: Config initial data for counter - TDR0 TDR1");
	$display("---");
	addr  = `TDR0;
        wdata = 32'h05;
	temp_tdr0 = 32'h05;
        top.apb.apb_write(addr, wdata);

        addr  = `TDR1;
        wdata = 32'h00;
	temp_tdr1 = 32'h0;
        top.apb.apb_write(addr, wdata);

	$display("Step 2: Config compared data for counter - TCMP0 TCMP1");
	$display("---");
        addr  = `TCMP0;
        wdata = 32'h0FF;
	temp_cmp0 = 32'h0FF;
        top.apb.apb_write(addr, wdata);

        addr  = `TCMP1;
        wdata = 32'h00;
	temp_cmp1 = 32'h00;
        top.apb.apb_write(addr, wdata);	

	$display("Step 3: Check TISR -> must be zero");
	$display("---");
        addr  = `TISR;
        top.apb.apb_read(addr, rdata);
	if (rdata == 32'h01) begin
		$display("TISR still non-zero after reset ---> Write 1 to clear TISR");
		$display("---");
	        addr  = `TISR;
	        wdata = 32'h01;
         	top.apb.apb_write(addr, wdata);
		top.apb.apb_read(addr, rdata);
		if (rdata == 32'h01) begin
			$display("TISR still non-zero after writing 1 ---> RTL need to be check");
			$display("---");
			top.report(0);
			$finish;
		end
	end else begin
		$display("TISR is matched with zero");
		$display("---");
	end

	$display("Step 4: Config TCR - control mode - divide clock by 4");
        $display("---");
        addr  = `TIER;
        wdata = 32'h01;
        top.apb.apb_write(addr, wdata);

	addr  = `TCR;
        wdata = {24'h0,4'b0010,6'h0,1'b1,1'b1}; // tim_en = 1; div_en = 1; div_val = 2;
	temp_div_val = 4'b0010;
        top.apb.apb_write(addr, wdata);
	
	exp_time = ({temp_cmp1,temp_cmp0} - {temp_tdr1,temp_tdr0}) * (1 << temp_div_val); // xem cong thuc tren vi du
	$display("Step 5: Calculate expected time %0d", exp_time);
	$display("---");
	repeat (exp_time + 20) begin // +20 la con so tuy chon
    		@(posedge top.sys_clk);
	end
	$display("Step 6: Finish waiting time > %0d sys_clk cycle -> check interrupt flag", exp_time + 20);
	$display("---");
        addr  = `TISR;
        top.apb.apb_read(addr, rdata);
        if (rdata[0] == 1) begin
		$display("Step 6: Timer_Int interrupted --- passed");
		$display("---");
	end
	else begin
		$display("Step 6: Timer_Int does not interrupted --- failed");
		$display("---");
		top.report(0);
		$finish();
	end

	$display("Step 7: Do it yourself !!!");
	$display("---");
        $display("Step 8: Timer disabled -> check interrupt output (must be zero)");
	$display("---");
	addr  = `TIER;
	top.apb.apb_read(addr,rdata);
        wdata = {rdata[31:1],1'b0}; // interrupt_en=0
        top.apb.apb_write(addr, wdata);
	@(posedge top.sys_clk);
	if (top.tim_int == 0) begin
		$display("Step 8: Interrupt output is zero --- passed");
	        $display("---");
	end
	else begin
		$display("Step 8: Interrupt output is non-zero --- failed");
		$display("---");
		top.report(0);
                $finish();
	end

        addr  = `TISR;
        top.apb.apb_read(addr,rdata);
        if (rdata[0] == 1) begin
                $display("Step 8: Interrupt still remain --- passed");
		$display("---");
        end
        else begin
                $display("Step 8: Interrupt is zero --- failed");
		$display("---");
                top.report(0);
                $finish();
        end
	
        addr  = `TISR;
	wdata = 32'h01;
	top.apb.apb_write(addr,wdata);
        top.apb.apb_read(addr,rdata);
        if (rdata[0] == 0) begin
                $display("Step 9: Interrupt cleared --- passed");
		$display("---");
        end
        else begin
                $display("Step 9: Interrupt is un-cleared --- failed");
                $display("---");
		top.report(0);
                $finish();
        end

	$display(" --- End of Test --- ");
	$display("---");
	top.report(1);
	$finish;
end

endmodule
