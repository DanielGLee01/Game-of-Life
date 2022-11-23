module hazard_lights (clk, reset, SW0, SW1, RLight, MLight, LLight);
 input  logic  clk, reset, SW0, SW1;
 output logic  RLight, MLight, LLight;

 // State variables
 enum { OUTSIDE, MIDDLE, RIGHT, LEFT, NONE } ps, ns;
// Next State logic
 always_comb begin
  case (ps)
   OUTSIDE: if (~SW1 & ~SW0)                    ns = MIDDLE; // Calm Winds (Alternate Lights)
            else if (~SW1 & SW0)                ns = RIGHT;
				else if (SW1 & ~SW0)                ns = LEFT;
				else                                ns = NONE;
	MIDDLE:  if (ps == MIDDLE)                   //ps check
				 if (~SW1 & ~SW0)                   ns = OUTSIDE; // Calm Winds (Alternate Lights)
				 else if (~SW1 & SW0)               ns = LEFT;
				 else if (SW1 & ~SW0)               ns = RIGHT;
				else                                ns = NONE;
   RIGHT:   if (~SW1 & ~SW0)                    ns = OUTSIDE;
            else if (ps == RIGHT)               //ps check
				 if (~SW1 & SW0)                    ns = MIDDLE;
				 else if (SW1 & ~SW0)               ns = LEFT; // Transition from Right to Left
				else                     			   ns = NONE;
	LEFT:    if (~SW1 & ~SW0)                    ns = OUTSIDE;
            else if (ps == LEFT)                //ps check
				 if (~SW1 & SW0)                    ns = RIGHT; // Transition from Left to Right
				 else if (SW1 & ~SW0)               ns = MIDDLE;
				else                     			   ns = NONE;			
	// DEFAULT Position: Sets the state based on inputs (RESET Position)
	NONE:    if (~SW1 & ~SW0)                    ns = OUTSIDE;
            else if (~SW1 & SW0)                ns = RIGHT;
				else if (SW1 & ~SW0)                ns = LEFT;
				else                                ns = NONE;
  endcase
  // default ns = NONE;
 end

 // Output logic - could also be another always_comb block.
 assign RLight = (ps == OUTSIDE | ps == RIGHT);
 assign MLight = (ps == MIDDLE);
 assign LLight = (ps == OUTSIDE | ps == LEFT);
 
 // DFFs
 always_ff @(posedge clk) begin
  if (reset)
   ps <= NONE;
  else
   ps <= ns;
 end
endmodule

module hazard_lights_testbench();
 logic  clk, reset, SW0, SW1;
 logic  RLight, MLight, LLight;

 hazard_lights dut (clk, reset, SW0, SW1, RLight, MLight, LLight);
 
 // Set up a simulated clock.
 parameter CLOCK_PERIOD=100;
 initial begin
  clk <= 0;
  forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock
 end

// Set up the inputs to the design.  Each line is a clock cycle.
initial begin
 	 					         @(posedge clk);
  reset <= 1;              @(posedge clk); // Always reset FSMs at start
  reset <= 0;              @(posedge clk);
  SW1 <= 0; SW0 <= 0;      @(posedge clk);
						         @(posedge clk);
						         @(posedge clk);
  SW1 <= 0; SW0 <= 1;      @(posedge clk);
	                        @(posedge clk);
				               @(posedge clk);
  SW1 <= 1; SW0 <= 0;      @(posedge clk);
                           @(posedge clk);
						         @(posedge clk);
  $stop; // End the simulation.
 end
endmodule