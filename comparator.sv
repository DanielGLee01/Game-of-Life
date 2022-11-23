module comparator(Clock, Reset, A, B, OUT_FINAL);
 input logic Clock, Reset;
 input logic [9:0] A, B;
 output logic OUT_FINAL;
 logic value;
 always_comb begin
  value = (A > B);
 end

 always_ff @(posedge Clock) begin
  OUT_FINAL <= value;
 end
endmodule

module comparator_testbench();
 logic Clock, Reset;
 logic [9:0] A, B;
 logic OUT_FINAL;

 comparator dut(.Clock, .Reset, .A, .B, .OUT_FINAL);
 
 parameter CLOCK_PERIOD = 100;
 initial begin
	Clock <= 0;
	forever #(CLOCK_PERIOD / 2) 
	Clock <= ~Clock;
 end
 
 initial begin
												      @(posedge Clock);
  Reset <= 1;              				   @(posedge Clock); // Always reset FSMs at start
													   @(posedge Clock);
  Reset <= 0;              				   @(posedge Clock);
													   @(posedge Clock);
  A <= 10'b0000000000; B<= 10'b0000000000;@(posedge Clock);
  													   @(posedge Clock);
  A <= 10'b0111110101; B<= 10'b0111110011;@(posedge Clock);
  													   @(posedge Clock);
  A <= 10'b0111110101; B<= 10'b1001010111;@(posedge Clock);
  													   @(posedge Clock); 
  A <= 10'b1111111111; B<= 10'b1111111111;@(posedge Clock);
  $stop;
 end
endmodule 
 
 