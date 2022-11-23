module computerIn(Clock, Reset, Q, SW, comp_out);
	output logic comp_out;
	input logic Clock, Reset;
	input logic [9:0] Q;
	input logic [8:0] SW;
	
	logic [9:0] compDiff_SW;
	
	assign compDiff_SW = {1'b0, SW}; 
	
	comparator computer(.Clock, .Reset, .A(compDiff_SW), .B(Q), .OUT_FINAL(comp_out));
endmodule

module computerIn_testbench();
	logic comp_out;
	logic Clock, Reset;
	logic [9:0] Q;
	logic [8:0] SW;
	logic [9:0] compDiff_SW;
	
	computerIn dut(.Clock, .Reset, .Q, .SW, .comp_out);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD / 2) 
		Clock <= ~Clock;
	end
	
	initial begin
		Reset <= 1;											@(posedge Clock);
																@(posedge Clock);
		Reset <= 0;											@(posedge Clock);
																@(posedge Clock);
		Q = 10'b0011001000;	SW = 9'b0100101100;	@(posedge Clock);
																@(posedge Clock);
		Q = 10'b0110010000;								@(posedge Clock);
																@(posedge Clock);
		$stop;
	end
endmodule
