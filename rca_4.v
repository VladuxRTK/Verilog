module fac(
  input x, y ,ci,
  output z,co
);

 /*assign z = (~x&~y&ci) | (~x&y&~ci) | (x&~y&~ci) | (x&y&ci);
 assign co=(x&y) | (x&ci);*/
assign {co,z} = x+y+ci;
  
endmodule

module rca_4(
  input [3:0] x,y,
  input ci,
  output [3:0] z,
  output co);
  
  wire c1,c2,c3;
  
  fac f1(
  .x(x[0]),
  .y(y[0]),
  .ci(ci),
  .z(z[0]),
  .co(c1));
  
  fac f2(
  .x(x[1]),
  .y(y[1]),
  .ci(c1),
  .z(z[1]),
  .co(c2));
  
  fac f3(
  .x(x[2]),
  .y(y[2]),
  .ci(c2),
  .z(z[2]),
  .co(c3));
  
  fac f4(
  .x(x[3]),
  .y(y[3]),
  .ci(c3),
  .z(z[3]),
  .co(co));
  
endmodule 

module rca_4_tb(
  output reg [3:0] x,y,
  output reg ci,
  output [3:0] z,
  output co);
  
  
  rca_4 cut(
  .x(x),
  .y(y),
  .ci(ci),
  .z(z),
  .co(co));
  
  integer i;
  
  initial begin
    {x,y,ci}=9'd0;
    for(i=1;i<512;i=i+1)
       #20  {x,y,ci} = i[8:0];
      end
    endmodule