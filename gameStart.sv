module gameStart (Clock, neighborDot, existence, reset);
 input logic Clock, reset;
 input logic [7:0] neighborDot;
 output logic existence;
 
 logic [1:0] counter;
 
 dotCount c0 (neighborDot, counter);
 
 enum {alive, dead} ps, ns;
 
 always_comb begin
  case(ps)
  alive: if (counter[1]) ns = ps;
         else ns = dead;
  dead:  if (counter == 2'b11) ns = alive;
         else ns = ps;
  endcase
 end
 
 always_ff @(posedge Clock) begin
  if (reset) begin
   ps <= dead;
  end 
 
  else
   ps <= ns;
  end

 assign existence = (ps == alive);
endmodule

module gameStart_testbench();
 logic CLOCK_50;
 logic [7:0] neighborDot;
 logic existence;

 gameStart dut (.Clock(CLOCK_50), .neighborDot, .existence);

 parameter CLOCK_PERIOD = 100;
  initial begin
	 CLOCK_50 <= 0;
	 forever #(CLOCK_PERIOD / 2)
	 CLOCK_50 <= ~CLOCK_50;
  end
  
  initial begin
   															   @(posedge CLOCK_50);
	neighborDot <= 8'b00000001; 		               @(posedge CLOCK_50);
   															   @(posedge CLOCK_50);
	neighborDot <= 8'b00000010;  							@(posedge CLOCK_50);
   															   @(posedge CLOCK_50);
	neighborDot <= 8'b00000011;  							@(posedge CLOCK_50);
   															   @(posedge CLOCK_50);
	neighborDot <= 8'b00000100;  							@(posedge CLOCK_50);
   															   @(posedge CLOCK_50);
	neighborDot <= 8'b00000111;  							@(posedge CLOCK_50);
   															   @(posedge CLOCK_50);
	neighborDot <= 8'b00000011;  							@(posedge CLOCK_50);
   															   @(posedge CLOCK_50);
	neighborDot <= 8'b00111111;  							@(posedge CLOCK_50);
   															   @(posedge CLOCK_50);
	$stop;
	end
endmodule 