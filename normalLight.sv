module normalLight (Clock, Reset, L, R, NL, NR, lightOn, gameReset); 
 input logic Clock, Reset; 
 input logic gameReset;
 
 // L is true when left key is pressed, R is true when the right key 
 // is pressed, NL is true when the light on the left is on, and NR 
 // is true when the light on the right is on.  
 input logic L, R, NL, NR; 
 
 // when lightOn is true, the normal light should be on. 
 output logic lightOn; 
 
 // Your code goes here!! 
 enum {on, off} ps, ns;
 
 always_comb begin
  case(ps)
	on: if (R & ~L | L & ~R) ns = off;
	    else ns = on;
	off: if (NL & R & ~L | NR & L & ~R) ns = on;
		  else ns = off;
  endcase
  
  case(ps)
   on: lightOn = 1;
	off: lightOn = 0;
  endcase
 end
 
 always_ff @(posedge Clock) begin
  if(Reset | gameReset) 
   ps <= off;
  else
	ps <= ns;
 end
endmodule

module normalLight_testbench();
 logic Clock, Reset;
 logic L, R, NL, NR;
 logic lightOn;
 logic gameReset;

 normalLight dut (.lightOn, .Clock, .Reset, .L, .R, .NL, .NR, .gameReset);
 
 // Set up a simulated clock.
 parameter CLOCK_PERIOD = 100;
 initial begin
  Clock <= 0;
  forever #(CLOCK_PERIOD / 2) Clock <= ~Clock; // Forever toggle the clock
 end
 
 // Set up the inputs to the design.  Each line is a clock cycle.
initial begin
												      @(posedge Clock);
  Reset <= 1; gameReset <= 0;             @(posedge Clock); // Always reset FSMs at start
													   @(posedge Clock);
  Reset <= 0;              				   @(posedge Clock);
													   @(posedge Clock);
  L <= 1; R <= 0; NL <= 1; NR <= 0;	      @(posedge Clock);
														@(posedge Clock);
  L <= 1; R <= 0; NL <= 0; NR <= 1;	      @(posedge Clock);
														@(posedge Clock);
  L <= 0; R <= 1; NL <= 1; NR <= 0;	      @(posedge Clock);
														@(posedge Clock);
  L <= 0; R <= 1; NL <= 0; NR <= 1;	      @(posedge Clock);
														@(posedge Clock);
  L <= 1; R <= 1; NL <= 1; NR <= 0;	      @(posedge Clock);
														@(posedge Clock);
  L <= 1; R <= 1; NL <= 0; NR <= 1;	      @(posedge Clock);
														@(posedge Clock);
  gameReset <= 1;									@(posedge Clock);
														@(posedge Clock);
  L <= 0; R <= 0; NL <= 1; NR <= 0;	      @(posedge Clock);
														@(posedge Clock);
  L <= 0; R <= 0; NL <= 0; NR <= 1;	      @(posedge Clock);
														@(posedge Clock);
  $stop; // End the simulation.
 end
endmodule