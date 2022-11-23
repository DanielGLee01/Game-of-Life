module playerInput(wireout, Clock, Reset, key);
 input logic Clock, Reset;
 input logic key;
 output logic wireout;
 
 enum {on, off} ps, ns;
 
 always_comb begin
  case(ps)
	on: 	if(key) ns = on;
			else ns = off;
	off: 	if(key) ns = on;				
			else ns = off;
  endcase
 end
	
 assign wireout = (ps == on & ns == off);
	
	always_ff @(posedge Clock) begin
		if(Reset) 
			ps <= off;
		else
			ps <= ns;
	end
endmodule

module playerInput_testbench();
 logic Clock, Reset;
 logic key;
 logic wireout;
	
 playerInput dut (.wireout, .Clock, .Reset, .key);
	
 parameter CLOCK_PERIOD = 100;
 initial begin
	Clock <= 0;
	forever #(CLOCK_PERIOD / 2) 
	Clock <= ~Clock;
 end
	
	initial begin
		Reset <= 1;					@(posedge Clock);
									   @(posedge Clock);
		Reset <= 0;				   @(posedge Clock);
										@(posedge Clock);
		key <= 1;					@(posedge Clock);
										@(posedge Clock);
		key <= 0;					@(posedge Clock);
										@(posedge Clock);
		key <= 1;					@(posedge Clock);
										@(posedge Clock);
		key <= 0;					@(posedge Clock);
										@(posedge Clock);
		key <= 1;					@(posedge Clock);
										@(posedge Clock);
		key <= 0;					@(posedge Clock);
										@(posedge Clock);
		key <= 1;					@(posedge Clock);
										@(posedge Clock);
		$stop;
	end
endmodule 