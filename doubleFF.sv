module doubleFF (Clock, Reset, key, stableOut);
 input logic Clock, Reset, key;
 output logic stableOut;
 logic pass;
	
 flipMid m1 (.Clock, .Reset, .key, .stableOut(pass));
 flipMid m2 (.Clock, .Reset, .key(pass), .stableOut);	
endmodule

module flipMid (Clock, Reset, key, stableOut);
 input logic Clock, Reset, key;
 output logic stableOut;
	
 always_ff @(posedge Clock) begin
  if (Reset)
   stableOut <= 1;
  else
   stableOut <= key;
  end
endmodule

module doubleFF_testbench();
 logic Clock, Reset, key;
 logic stableOut;
 DFFs dut (Clock, Reset, key, stableOut);
 // Set up a simulated clock.
 parameter CLOCK_PERIOD=100;
 initial begin
  Clock <= 0;
  forever #(CLOCK_PERIOD/2) Clock <= ~Clock; // Forever toggle the clock
 end
 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
												@(posedge Clock);
	Reset <= 1; 							@(posedge Clock); // Always Reset FSMs at start
	Reset <= 0; key <= 1; 				@(posedge Clock);
					key <= 0; 				@(posedge Clock);
												@(posedge Clock);
												@(posedge Clock);
												@(posedge Clock);
												@(posedge Clock);
					key <= 0; 				@(posedge Clock);
					key <= 1; 				@(posedge Clock);
												@(posedge Clock);
												@(posedge Clock);
												@(posedge Clock);
												@(posedge Clock);
 $stop; // End the simulation.
 end
endmodule
