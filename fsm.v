module fsm(input [3:0] in,clk, output reg[4:0] out=5'b00000);

reg [2:0] state, next_state;
parameter start=0, one=1, two=2, three=3, four=4;
integer count_1s=0;

always @(posedge clk)
	state<=next_state;


always @(*)
case(state)
		start: begin
					out[0]=0;
					out[1]=0;
					out[2]=0;
					out[3]=0;
					out[4]=0;
					if(in==9)
						next_state=one;
				 end
						
		one:   begin
					out[0]=1;
					if(in==8)
						next_state=two;
					else
					   next_state=start;
				 end
						
						
						
		two:   begin
					out[1]=1;
					if(in==7)
						next_state=three;
					else
					   next_state=start;
				 end
						
		three: begin
					out[2]=1;
					if(in==6)
						next_state=four;
					else
					   next_state=start;
				 end
			
		four:  begin
					out[3]=1;
					out[4]=1;
					count_1s=count_1s+1;
					if(count_1s==30)
						next_state=start;
				end
				
		default: next_state=start;
endcase

endmodule
		
						
		