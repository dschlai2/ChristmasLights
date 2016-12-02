
module Barney(go,finished,clk,rst_n,light1,light2,light3,light4,light5,light6,light7,light8);
    input logic go,clk,rst_n;
    output logic finished,light1,light2,light3,light4,light5,light6,light7,light8;
    
typedef enum logic[8:0]{IDLE,WAIT,B1,B2,B3,B4,B5,B6,B7,B8,B9,B10,B11,B12,B13,B14,B15,B16,B17,B18,B19,B20,B21,B22,B23,B24,B25,B26,B27,B28,B29,B30,B31,B32,B33,B34,B35,B36,B37,B38,B39,B40} state_t;
parameter MILLISECONDS = 1;
parameter DELAY = 5000*MILLISECONDS;
state_t state,next_state;
parameter QUARTER_NOTE=3225;
parameter EIGHTH_NOTE=QUARTER_NOTE/2;
parameter HALF_NOTE=QUARTER_NOTE*2;
parameter WHOLE_NOTE=QUARTER_NOTE*4;
parameter SIXTEENTH_NOTE=QUARTER_NOTE/4;
parameter TRIPLET_QUARTER=QUARTER_NOTE*2/3;
parameter TRIPLET_EIGTH=QUARTER_NOTE/3;
parameter THIRTYSECOND_NOTE=QUARTER_NOTE/8;

parameter INTRO_QUARTER=6500;
parameter INTRO_EIGHTH=INTRO_QUARTER/2;
parameter INTRO_HALF=INTRO_QUARTER*2;
parameter INTRO_WHOLE=INTRO_QUARTER*4;
parameter INTRO_SIXTEENTH=INTRO_QUARTER/4;
parameter INTRO_THIRTYSECOND=INTRO_QUARTER/8;

parameter INTRO_OFFSET=INTRO_QUARTER-5000;


logic[27:0]clk_counter;
logic[19:0]ms_counter; //milisecond counter
logic[7:0]loop_counter;
logic[2:0]loop_counter2;
logic[2:0]loop_counter3;
logic loop_inc3;
logic loop_inc2;
logic loop_inc;
logic ms_inc;
logic ms_reset;
logic loop_reset;
logic loop_reset2;
logic loop_reset3;

logic finished_temp;


//light 4 overhead
//light 3 icicles
//light 2 rails
//light 1 corners

always_comb begin
    next_state=IDLE;
    light1=0;
	 light2=0;
	 light3=0;
	 light4=0;
	 ms_reset=0;
	 loop_reset=0;
	 loop_reset2=0;
	 loop_reset3=0;
	 loop_inc=0;
	 loop_inc2=0;
	 loop_inc3=0;
	 finished_temp=0;
    case(state)
        IDLE: begin
				next_state=IDLE;
				//light1=1;
					if(go==1) begin
							light1=1;
							next_state=WAIT;
							ms_reset=1;
							loop_reset=1;
							loop_reset2=1;
							loop_reset3=1;
					 end
				
	    end
		 
		 WAIT: begin
			//light2=1;
			next_state=WAIT;
			loop_reset=1;
			loop_reset2=1;
			loop_reset3=1;
			if(ms_counter==20000) begin
				next_state=B1;    //Barney
				ms_reset=1;
			end
		end
		 
		
		
		B1: begin//Barey start
			next_state=B1;
			light4=1;
			light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B2;
			end
		end
		 
		B2: begin//
			next_state=B2;
			//light4=1;
			//light3=1;
			light2=1;
			light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B3;
			end
		end
		
		B3: begin//
			next_state=B3;
			light4=1;
			light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B4;
			end
		end
		
		B4: begin//
			next_state=B4;
			//light4=1;
			//light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				loop_inc=1;
				next_state=B1;
				if(loop_counter==1) begin
					loop_reset=1;
					next_state=B5;
				end
			end
		end
		
		B5: begin//
			next_state=B5;
			light4=1;
			//light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B6;
			end
		end
		
		B6: begin//
			next_state=B6;
			light4=1;
			light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B7;
			end
		end

		B7: begin//
			next_state=B7;
			light4=1;
			light3=1;
			light2=1;
			//light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B8;
			end
		end
		
		B8: begin//
			next_state=B8;
			light4=1;
			light3=1;
			light2=1;
			light1=1;
			if(ms_counter==INTRO_EIGHTH-loop_counter2*INTRO_OFFSET/2) begin
				ms_reset=1;
				next_state=B9;
			end
		end
		
		B9: begin//
			next_state=B9;
			//light4=1;
			//light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_EIGHTH-loop_counter2*INTRO_OFFSET/2) begin
				ms_reset=1;
				next_state=B10;
			end
		end
		
		B10: begin//
			next_state=B10;
			//light4=1;
			//light3=1;
			light2=1;
			light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B11;
			end
		end
		
		B11: begin//
			next_state=B11;
			//light4=1;
			light3=1;
			light2=1;
			light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B12;
			end
		end
		
		B12: begin//
			next_state=B12;
			light4=1;
			light3=1;
			light2=1;
			light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B13;
			end
		end
		
		B13: begin//
			next_state=B13;
			//light4=1;
			//light3=1;
			light2=1;
			//light1=1;
			if(ms_counter==INTRO_EIGHTH-loop_counter2*INTRO_OFFSET/2) begin
				ms_reset=1;
				next_state=B14;
			end
		end
		
		B14: begin//
			next_state=B14;
			//light4=1;
			light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_EIGHTH-loop_counter2*INTRO_OFFSET/2) begin
				ms_reset=1;
				next_state=B15;
			end
		end
		
		B15: begin//
			next_state=B15;
			light4=1;
			//light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B16;
			end
		end
		
		B16: begin//
			next_state=B16;
			light4=1;
			light3=1;
			light2=1;
			light1=1;
			if(ms_counter==INTRO_EIGHTH-loop_counter2*INTRO_OFFSET/2) begin
				ms_reset=1;
				next_state=B17;
			end
		end
		
		B17: begin//
			next_state=B17;
			//light4=1;
			//light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_EIGHTH-loop_counter2*INTRO_OFFSET/2) begin
				ms_reset=1;
				next_state=B16;
				loop_inc=1;
				if(loop_counter==2) begin // 3 loops
					loop_reset=1;
					next_state=B18;
				end			
			end
		end
		
		B18: begin//
			next_state=B18;
			//light4=1;
			//light3=1;
			//light2=1;
			light1=1;
			if(ms_counter==INTRO_EIGHTH-loop_counter2*INTRO_OFFSET/2) begin
				ms_reset=1;
				next_state=B19;
			end
		end
		
		B19: begin//
			next_state=B19;
			//light4=1;
			//light3=1;
			light2=1;
			light1=1;
			if(ms_counter==INTRO_EIGHTH-loop_counter2*INTRO_OFFSET/2) begin
				ms_reset=1;
				next_state=B20;
			end
		end
		
		B20: begin//
			next_state=B20;
			//light4=1;
			light3=1;
			light2=1;
			light1=1;
			if(ms_counter==INTRO_EIGHTH-loop_counter2*INTRO_OFFSET/2) begin
				ms_reset=1;
				next_state=B21;
			end
		end
		
		B21: begin//
			next_state=B21;
			light4=1;
			light3=1;
			light2=1;
			light1=1;
			if(ms_counter==INTRO_SIXTEENTH-loop_counter2*INTRO_OFFSET/4) begin
				ms_reset=1;
				next_state=B22;
			end
		end
		
		B22: begin//
			next_state=B22;
			//light4=1;
			//light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_SIXTEENTH-loop_counter2*INTRO_OFFSET/4) begin
				ms_reset=1;
				next_state=B23;
			end
		end
		
		B23: begin//
			next_state=B23;
			light4=1;
			light3=1;
			light2=1;
			light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B24;
			end
		end
		
		B24: begin//
			next_state=B24;
			//light4=1;
			//light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B25;
			end
		end
		
		B25: begin// won't you say...
			next_state=B25;
			light4=1;
			//light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B26;
			end
		end
		
		B26: begin// you
			next_state=B26;
			//light4=1;
			//light3=1;
			light2=1;
			light1=1;
			if(ms_counter==INTRO_EIGHTH-loop_counter2*INTRO_OFFSET/2) begin
				ms_reset=1;
				next_state=B27;
			end
		end
		
		B27: begin//
			next_state=B27;
			//light4=1;
			//light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_EIGHTH-loop_counter2*INTRO_OFFSET/2) begin
				ms_reset=1;
				next_state=B28;
			end
		end
		
		B28: begin// say
			next_state=B28;
			//light4=1;
			//light3=1;
			light2=1;
			light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B29;
			end
		end
		
		B29: begin// you --- split off to end
			next_state=B29;
			light4=1;
			//light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B30;
				if(loop_counter2==1)
					next_state=B34;
			end
		end
		
		B30: begin//
			next_state=B30;
			light4=1;
			light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B31;
			end
		end
		
		B31: begin//
			next_state=B31;
			light4=1;
			light3=1;
			light2=1;
			//light1=1;
			if(ms_counter==INTRO_QUARTER-loop_counter2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B32;
			end
		end
		
		B32: begin// transition
			next_state=B32;
			//light4=1;
			//light3=1;
			light2=1;
			light1=1;
			if(ms_counter==INTRO_HALF-(loop_counter*INTRO_OFFSET/2)-200) begin
				ms_reset=1;
				next_state=B33;
			end
		end
		
		B33: begin//
			next_state=B33;
			light4=1;
			light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_HALF-(loop_counter*INTRO_OFFSET/2)-200) begin
				ms_reset=1;
				next_state=B32;
				loop_inc=1;
				if(loop_counter==3) begin// 4 loops
					loop_reset=1;
					next_state=B1;
					loop_inc2=1;
				end				
			end
		end
			
		
		B34: begin// love
			next_state=B34;
			light4=1;
			light3=1;
			//light2=1;
			//light1=1;
			if(ms_counter==INTRO_HALF-loop_counter2*2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B35;
			end
		end
		
		B35: begin// me
			next_state=B35;
			light4=1;
			light3=1;
			light2=1;
			//light1=1;
			if(ms_counter==INTRO_HALF-loop_counter2*2*INTRO_OFFSET) begin
				ms_reset=1;
				next_state=B36;
			end
		end
		
		B36: begin// too
			next_state=B36;
			light4=1;
			light3=1;
			light2=1;
			light1=1;
			if(ms_counter==INTRO_HALF*2) begin
				ms_reset=1;
				finished_temp=1;
				next_state=IDLE;
			end
		end
		
		
				
			
			
			default: begin
            next_state=IDLE;
				ms_reset=1;
           end
   endcase

	end
            


always_ff @(posedge clk, negedge rst_n) begin
    if(!rst_n)
		clk_counter=28'h0000000;
	 else if(ms_inc)
		clk_counter=28'h0000000;
    else
		clk_counter=clk_counter+1;
       
end

always_ff @(posedge clk, negedge rst_n) begin
	if(!rst_n)
		finished<=1'b0;
	
	else
		finished<=finished_temp;
end

always_ff @(posedge clk, negedge rst_n) begin
	if(!rst_n)
		ms_counter=20'h0;
	else if(ms_reset)
		ms_counter=20'h0;
	else if(ms_inc)
		ms_counter=ms_counter+1;
end
  
always_ff @(posedge clk, negedge rst_n) begin
	if(!rst_n)
		loop_counter<=0;
	else if (loop_reset)
		loop_counter<=8'h00;
	else if (loop_inc)
		loop_counter<=loop_counter+1;
end
always_ff @(posedge clk, negedge rst_n) begin
	if(!rst_n)
		loop_counter2<=0;
	else if (loop_reset2)
		loop_counter2<=8'h00;
	else if (loop_inc2)
		loop_counter2<=loop_counter2+1;
end
always_ff @(posedge clk, negedge rst_n) begin
	if(!rst_n)
		loop_counter3<=0;
	else if (loop_reset3)
		loop_counter3<=8'h00;
	else if (loop_inc3)
		loop_counter3<=loop_counter3+1;
end

always_ff @(posedge clk, negedge rst_n) begin
    if(!rst_n)
       state<=IDLE;
    else
       state<=next_state;
end



always_comb begin

  light5=light1;
  light6=light2;
  light7=light3;
  light8=light4;

  ms_inc=(clk_counter==DELAY);
end



endmodule
