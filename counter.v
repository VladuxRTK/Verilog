module counter(
  input clk,
  input clr,
  input rst_b,
  input c_up,
  output dclk);
  
  reg [5:0] st;
  wire [5:0] st_nxt;
  
  assign st_nxt[0] = (st[0] & (~c_up|clr)) | clr |
                    (st[5] & (clr |c_up));
  assign st_nxt[1] = (st[0] & (c_up& ~clr)) | (st[1] & (~c_up & ~clr));
  assign st_nxt[2] = (st[1] & (c_up&~clr)) | (st[2] & (~c_up & ~clr));
  assign st_nxt[3] = (st[2] & (c_up& ~clr)) | (st[3] & (~c_up & ~clr));
  assign st_nxt[4] = (st[3] & (c_up& ~clr)) | (st[4] & (~c_up & ~clr));
  assign st_nxt[5] = (st[4] & (c_up& ~clr))| (st[5] & (~c_up & ~clr));
  
  assign dclk = st[0] | st[1] |st[2] | st[3];
  
  always @ (posedge clk,negedge rst_b)
  if(!rst_b) st = 6'd1;
  else st <= st_nxt;
  endmodule
  
  module counter_tb(
    output reg clk,clr,rst_b,c_up,
    output dclk);
    
    counter cut(
    .clk(clk),
    .clr(clr),
    .rst_b(rst_b),
    .c_up(c_up),
    .dclk(dclk));
    
    
    initial begin
      clk=0;
      repeat(40) #50 clk=~clk;
    end
    
    initial begin 
      rst_b = 0;
      #50 rst_b = 1;
       
    end
    
    initial begin 
      c_up=1;
      #300 c_up = 0;
      #100 c_up = 1;
      //#100 c_up = 1;
    end
    initial begin 
      clr = 0;
      #200 clr = 0;
      #500 clr =1;
      #100 clr = 0;
    end
    
  endmodule
      
 