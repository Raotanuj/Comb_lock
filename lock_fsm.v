module lock_fsm(input [17:0] SW, input CLOCK_50, output reg[17:0] LEDR, output [6:0] HEX0);

reg [2:0] state, next_state;
parameter start=0, one=1, two=2, three=3, four=4;
integer count=0;
reg [3:0] count_1s;
reg clk_1s;


always @(posedge CLOCK_50)
  begin
	if(SW[17]==1)                  //reset
	    state<=start;
	else 
	    begin
        	state<=next_state;
        	count<=count+1;
        	if(count==50*1000000/2)
        	  begin 
        	    count<=0;
	            clk_1s<=~clk_1s;
	          end
         end
end

SEG77 S(count_1s, HEX0);

	    
always @(posedge clk_1s)
begin
case(state)

	start: begin
					count_1s=0;
					LEDR[0]=0;
					LEDR[2]=0;
					LEDR[4]=0;
					LEDR[6]=0;
					LEDR[8]=0;
					if(SW[9]==1 && SW[8]==0  && SW[7]==0  && SW[6]==0 )
						next_state=one;
					else
					    next_state=start;
					
				    end
				    
						
		one:   begin
					
					LEDR[0]=1;
					LEDR[2]=0;
					LEDR[4]=0;
					LEDR[6]=0;
					LEDR[8]=0;
					
					if(SW[9]==1 && SW[8]==1  &&  SW[7]==0  && SW[6]==0)
						next_state=two;
					
	    				
			   end
						
						
						
		two:   begin
					LEDR[0]=1;
					LEDR[2]=1;
					LEDR[4]=0;
					LEDR[6]=0;
					LEDR[8]=0;
					if(SW[9]==1 && SW[8]==1 && SW[7]==1 &&  SW[6]==0)
						next_state=three;
				
				end
						
		three: begin
					LEDR[0]=1;
					LEDR[2]=1;
					LEDR[4]=1;
					LEDR[6]=0;
					LEDR[8]=0;
					if(SW[9]==1 && SW[8]==1 && SW[7]==1 && SW[6]==1)
						next_state=four;
					
				    end
			
		four:  begin
					LEDR[0]=1;
					LEDR[2]=1;
					LEDR[4]=1;
					LEDR[6]=1;
					LEDR[8]=1;
					count_1s=count_1s+1;
	    				if(count_1s==10)
					    	next_state=start;
				end
				
		default: next_state=start;
		
		
endcase
end
endmodule



module SEG77(inp,HEX0);

  	parameter a0=4'b0000, a1=4'b0001, a2=4'b0010, a3=4'b0011, a4=4'b0100, a5=4'b0101, a6=4'b0110, a7=4'b0111, a8=4'b1000, a9=4'b1001;

	input [3:0] inp;
	output reg [0:6] HEX0;

	always @(inp)
		case(inp)
		    a0 : HEX0 =7'b1000000;
            a1 : HEX0 = 7'b1111001;
            a2 : HEX0 = 7'b0100100;
            a3 : HEX0 = 7'b0110000;
            a4 : HEX0 = 7'b0011001;
            a5 : HEX0 = 7'b0010010;
            a6 : HEX0 = 7'b0000010;
            a7 : HEX0 = 7'b1111000;
            a8 : HEX0 = 7'b0000000;
            a9 : HEX0 = 7'b0010000;
			default: HEX0= 7'b1111111;
		endcase
endmodule

