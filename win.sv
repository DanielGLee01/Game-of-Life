module win(Clock, Reset, P1LED9, P2LED1, L, R, HEX5, HEX0, gameReset);
  input logic Clock, Reset;
  input logic P1LED9, P2LED1;
  input logic L, R;
  output logic [6:0] HEX5, HEX0;
  output logic gameReset;
  
  logic [2:0] P1Count;
  logic [2:0] P2Count;
  
 enum {off, Player1, Player2} ps, ns;
 
 always_comb begin
  case(ps)
   off: if (P1LED9 & L & ~R) ns = Player1;
	     else if (P2LED1 & ~L & R) ns = Player2;
		  else ns = off;
	Player1: ns = Player1;
	Player2: ns = Player2;
  endcase
 end

 always_comb begin
  if(P1Count == 3'b000) 			
   HEX0 = 7'b1000000;
  else if(P1Count == 3'b001)		
	HEX0 = 7'b1111001;
  else if(P1Count == 3'b010)		
	HEX0 = 7'b0100100;
  else if(P1Count == 3'b011)		
	HEX0 = 7'b0110000;
  else if(P1Count == 3'b100)		
	HEX0 = 7'b0011001;
  else if(P1Count == 3'b101)		
	HEX0 = 7'b0010010;
  else if(P1Count == 3'b110)		
	HEX0 = 7'b0000010;
  else 									
	HEX0 = 7'b1111000;
			
 if(P2Count == 3'b000) 			
	HEX5 = 7'b1000000;
 else if(P2Count == 3'b001)		
	HEX5 = 7'b1111001;
 else if(P2Count == 3'b010)		
	HEX5 = 7'b0100100;
 else if(P2Count == 3'b011)		
	HEX5 = 7'b0110000;
 else if(P2Count == 3'b100)		
	HEX5 = 7'b0011001;
 else if(P2Count == 3'b101)		
	HEX5 = 7'b0010010;
 else if(P2Count == 3'b110)		
	HEX5 = 7'b0000010;
 else 									
	HEX5 = 7'b1111000;
 end
	
 always_ff @(posedge Clock) begin
  if(ps == off & ns == Player1) begin
   P2Count <= P2Count + 3'b001;
  end
  else if(ps == off & ns == Player2) begin
   P1Count <= P1Count + 3'b001;
  end
  else begin
	P2Count <= P2Count;
	P1Count <= P1Count;
  end
		
  if(Reset) begin
	P1Count <= 3'b000;
	P2Count <= 3'b000;
	ps <= off;
	gameReset <= 0;
  end
  else if(gameReset) begin
	ps <= off;
	gameReset <= 0;
  end
  else
	ps <= ns;
	if(ps == Player1 | ps == Player2)
	 gameReset <= 1;
	else
	 gameReset <= 0;
  end
endmodule

module win_testbench();
 logic Clock, Reset;
 logic L, R;
 logic P1LED9, P2LED1;
 logic gameReset;
 
 win dut (.Clock, .Reset, .P1LED9, .P2LED1, .L, .R, .HEX5(HEX5), .HEX0(HEX0), .gameReset);
 
 // Set up a simulated clock.
 parameter CLOCK_PERIOD=100;
 initial begin
  Clock <= 0;
  forever #(CLOCK_PERIOD/2) Clock <= ~Clock; // Forever toggle the clock
 end
 
 // Set up the inputs to the design.  Each line is a clock cycle.
 initial begin
												           @(posedge Clock);
  Reset <= 1;              				        @(posedge Clock); // Always reset FSMs at start
													        @(posedge Clock);
  Reset <= 0;              				        @(posedge Clock);
													        @(posedge Clock);
  L <= 1; R <= 0; P1LED9 <= 1; P2LED1 <= 0;    @(posedge Clock);
													        @(posedge Clock);
  L <= 1; R <= 0; P1LED9 <= 0; P2LED1 <= 1;    @(posedge Clock);
													        @(posedge Clock);
  L <= 0; R <= 1; P1LED9 <= 1; P2LED1 <= 0;    @(posedge Clock);
													        @(posedge Clock);
  L <= 0; R <= 1; P1LED9 <= 0; P2LED1 <= 1;    @(posedge Clock);
													        @(posedge Clock);
  L <= 1; R <= 0; P1LED9 <= 1; P2LED1 <= 1;    @(posedge Clock);
													        @(posedge Clock);
  L <= 0; R <= 1; P1LED9 <= 1; P2LED1 <= 1;    @(posedge Clock);
													        @(posedge Clock);
  $stop; // End the simulation.
 end
endmodule