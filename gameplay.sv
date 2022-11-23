module gameStart (Clock, neighbor, health, reset);
 input logic Clock, reset;
 input logic [7:0] neighbor;
 output logic health;
 
 logic [1:0] count;
 
 counter c0 (neighbor, count);
 
 enum {alive, dead} ps, ns;
 
 always_comb begin
  case(ps)
  alive: if (count[1]) ns = ps;
         else ns = dead;
  dead:  if (count == 2'b11) ns = alive;
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


 assign health = (ps == alive);
endmodule

module gameStart_testbench();
 logic CLOCK_50;
 logic [7:0] neighbor;
 logic health;

 gameplay dut (.Clock(CLOCK_50), .neighbor, .health);

 parameter CLOCK_PERIOD = 100;
  initial begin
	 CLOCK_50 <= 0;
	 forever #(CLOCK_PERIOD / 2)
	 CLOCK_50 <= ~CLOCK_50;
  end
  
  initial begin
   															@(posedge CLOCK_50);
	neighbor <= 8'b00000001; 		               @(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	neighbor <= 8'b00000010;  							@(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	neighbor <= 8'b00000011;  							@(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	neighbor <= 8'b00000100;  							@(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	neighbor <= 8'b00000111;  							@(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	neighbor <= 8'b00000011;  							@(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	neighbor <= 8'b00111111;  							@(posedge CLOCK_50);
   															@(posedge CLOCK_50);
	$stop;
	end
endmodule 