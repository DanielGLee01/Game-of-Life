module dotManager (Clock, G, RowSelect, ColumnSelect, SWNINE, SWEIGHT, Q);
 input logic Clock, G, RowSelect, ColumnSelect, SWNINE, SWEIGHT;
 output logic Q;
 logic D, control, A0;
 
 assign control = (RowSelect & ColumnSelect) | SWNINE;
 
 mux2_1 m0 (.out(A0), .i0(SWEIGHT), .i1(G), .sel(SWNINE));
 mux2_1 m1 (.out(D), .i0(Q), .i1(A0), .sel(control));
 
 always_ff @(posedge Clock) begin
  Q <= D;
 end
endmodule

module dotManager_testbench();
 logic CLOCK_50;
 logic G, RowSelect, ColumnSelect, SWNINE, Q;

 dotManager dut (.Clock(CLOCK_50), .G, .RowSelect, .ColumnSelect, .SWNINE, .Q);

 parameter CLOCK_PERIOD = 100;
  initial begin
	 CLOCK_50 <= 0;
	 forever #(CLOCK_PERIOD / 2)
	 CLOCK_50 <= ~CLOCK_50;
  end
  
  initial begin
   															           @(posedge CLOCK_50);
	RowSelect <= 1; ColumnSelect <= 1; G <= 1; SWNINE <= 0; @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	RowSelect <= 0; G <= 0;  							           @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	ColumnSelect <= 0;						                    @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	RowSelect <= 1;   							                 @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	ColumnSelect <= 1;		                                @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	RowSelect <= 0; G <= 1;  							           @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	ColumnSelect <= 0;						                    @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	RowSelect <= 1; 							                    @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	ColumnSelect <= 1; G <= 1; SWNINE <= 1; 		           @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	RowSelect <= 0; G <= 0;  							           @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	ColumnSelect <= 0;						                    @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	RowSelect <= 1;   							                 @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	ColumnSelect <= 1;		                                @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	RowSelect <= 0; G <= 1;  							           @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	ColumnSelect <= 0;						                    @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	RowSelect <= 1; 							                    @(posedge CLOCK_50);
   															           @(posedge CLOCK_50);
	$stop;
	end
endmodule 