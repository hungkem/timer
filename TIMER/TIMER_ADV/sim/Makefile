##################################################################################################
#This file created by Huy Nguyen and modified by Hung Pham
#Updated date: 1/30/2024
#Example run string: make TESTNAME={name_of_testcase} {optional}
#		     make TESTNAME=counter_test all 
##################################################################################################
#Define variables
TESTNAME 	?= 
RADIX		?= decimal
REGRESS_LIST	?= 

#==============================
all: build run

all_wave: build run wave

all_cov: build_cov group

build:
	mkdir -p log
	vlib work
	vmap work work
	vlog  -f compile.f | tee compile.log
build_cov:
	mkdir -p log
	mkdir -p coverage
	vlib work
	vmap work work
	vlog +cover=bcesft -f compile.f
run:
	vsim -debugDB -l $(TESTNAME).log -voptargs=+access -assertdebug -c work.$(TESTNAME) -do "log -r /*;run -all;"
	cp $(TESTNAME).log ./log
	mv $(TESTNAME).log sim.log
run_cov:
	vsim -coverage -l $(TESTNAME).log -c work.$(TESTNAME) -voptargs="+cover=bcesft" -assertdebug -do "coverage save -onexit $(TESTNAME).ucdb; log -r /*;run -all"
	cp $(TESTNAME).log ./log
	mv $(TESTNAME).ucdb ./coverage
	mv $(TESTNAME).log sim.log
wave:
	vsim -i -view vsim.wlf -do "add wave vsim:/$(TESTNAME)/*; radix -$(RADIX)" &
group:
	make run_cov TESTNAME=reg_default 
	make run_cov TESTNAME=reg_write_read
	make run_cov TESTNAME=check_counter 
	make run_cov TESTNAME=check_counter_mode 
	make run_cov TESTNAME=check_interrupt 
	make run_cov TESTNAME=check_onehot
	make run_cov TESTNAME=check_pstrb
	make run_cov TESTNAME=check_halt 
	make run_cov TESTNAME=reserved_and_aligned 
	make run_cov TESTNAME=check_apb 

gen_cov:
	vcover merge coverage/IP.ucdb coverage/*.ucdb
	vcover report coverage/IP.ucdb -output coverage/summary_report.txt
	vcover report -zeros -details -code bcesft -annotate -All -codeAll coverage/IP.ucdb -output coverage/detail_report.txt
gen_html:
	vcover merge coverage/IP.ucdb coverage/*.ucdb
	vcover report -zeros -details -code bcesft -annotate -testhitdataAll -html coverage/IP.ucdb 
clean:
	rm -rf work
	rm -rf vsim.dbg
	rm -rf *.ini
	rm -rf *.log
	rm -rf *.wlf
	rm -rf wlf*
	rm -rf transcript
	rm -rf *.ucdb
	rm -rf run_test.v
	rm -rf coverage
	rm -rf log
cov_view:
	vsim -gui -viewcov coverage/IP.ucdb
help:
	@echo ""
	@echo "****************************************"
	@echo "** make clean    : clean all compiled data"
	@echo "** make build    : build the design"
	@echo "** make build_cov: build the design in coverage mode"
	@echo "** make run      : run simulation"
	@echo "** make run_cov  : run simulation in coverage mode"
	@echo "** make all      : build and run simulation"
	@echo "** make all_cov  : build and run simulation in coverage mode"
	@echo "** make wave     : open waveform"
	@echo "** make gen_cov  : merge, generate coverage data base and text coverage report"
	@echo "** make gen_cov  : merge, gemerate coverage data base and html coverage report"
	@echo "****************************************"
	@echo ""
