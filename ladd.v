module rgst #(
	parameter w = 8	//register's width
)(
	input clk, 
	input rst_b,	//asynchronous reset; active low
	input [w-1:0] d, 
	input ld, 
	input clr,	//synchronous reset; active high
	output reg [w-1:0] q
);

	always @ (posedge clk, negedge rst_b)
		if (!rst_b)
			q <= 1'd0;
		else if (clr)
			q <= 1'd0;
		else if (ld)
			q <= d;
endmodule


module ladd(
  input clk,rst_b,
  input [7:0] x,
  output [7:0] a
  );
  wire [3:0]i1,i2,i4,i6;
  wire i3,i5;
  rgst #(.w(4))
   regsitru1(
  .clk(clk),
  .rst_b(rst_b),
  .d(x[3:0]),
  .ld(1'd1),
  .clr(1'd0),
  .q(i1)
  );
  
  rca_4 adder1(
  .x(a[3:0]),
  .y(i1),
  .ci(1'd0),
  .z(i2),
  .co(i3));
  
  rgst #(.w(4))
   regsitru2(
  .clk(clk),
  .rst_b(rst_b),
  .d(i2),
  .ld(1'd1),
  .clr(1'd0),
  .q(a[3:0])
  );
  
  rgst #(.w(1))
   regsitru3(
  .clk(clk),
  .rst_b(rst_b),
  .d(i3),
  .ld(1'd1),
  .clr(1'd0),
  .q(i5)
  );
  
    rca_4 adder2(
  .x(a[7:4]),
  .y(i4),
  .ci(i5),
  .z(i6),
  .co());
  
   rgst #(.w(4))
   regsitru4(
  .clk(clk),
  .rst_b(rst_b),
  .d(x[7:4]),
  .ld(1'd1),
  .clr(1'd0),
  .q(i4)
  );
  
   rgst #(.w(4))
   regsitru5(
  .clk(clk),
  .rst_b(rst_b),
  .d(i6),
  .ld(1'd1),
  .clr(1'd0),
  .q(a[7:4])
  );
endmodule
  
  module ladd_tb(
    output reg clk,rst_b,
    output reg [7:0]x,
    output [7:0]a);
    
    
    ladd cut (
    .clk(clk),
    .rst_b(rst_b),
    .x(x),
    .a(a)
    );
    
    
  initial begin
     clk =1'd0;
  repeat (100) #50 clk=~clk;
end
   initial begin
   rst_b = 1'd0;
   #10 rst_b = 1'd1;
end
  integer i;
  initial begin 
    x=8'd1;
    for(i=2;i<23;i=i+1)
      #100 x=i[7:0];
    #100 x = 8'd0;
     end
     
   endmodule
   
    
  
  
  