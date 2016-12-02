
module pattern1(go,finished,clk,rst_n,light1,light2,light3,light4,light5,light6,light7,light8);
    input logic go,clk,rst_n;
    output logic finished,light1,light2,light3,light4,light5,light6,light7,light8;
    
typedef enum logic[8:0]{DONE,IDLE,WAIT,T1_1,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13,T14,T15,T16,T17,T18,T19,T20,T21,T22,T23,T24,T25,T26,T27,T28,T29,T30,T31,T32,T33,T34,T35,T36,T37,T38,T39,T40,T41,T42,T43,T44,T45,T46,T47,T48,T49,T50,T51,T52,T53,T54,T55,T56,T57,T58,T59,T60,T61,T62,T63,T64,T65,T66,T67,T68,T69,T70,T71,T72,T73,T74,T75,T76,T77,T78,T79,T80,T81,T82,T83,T84,T85,T86,T87,T88,T89,T90,T91,T92,T93,T94,T95,T96,T97,T98,T99} state_t;
parameter MILLISECONDS = 1;
parameter DELAY = 5000*MILLISECONDS;
state_t state,next_state;
parameter QUARTER_NOTE=3825;
parameter EIGHTH_NOTE=QUARTER_NOTE/2;
parameter HALF_NOTE=QUARTER_NOTE*2;
parameter WHOLE_NOTE=QUARTER_NOTE*4;
parameter SIXTEENTH_NOTE=QUARTER_NOTE/4;
parameter TRIPLET_QUARTER=QUARTER_NOTE*2/3;
parameter TRIPLET_EIGHTH=QUARTER_NOTE/3;
parameter THIRTYSECOND_NOTE=QUARTER_NOTE/8;



logic[27:0]clk_counter;
logic[19:0]ms_counter; //milisecond counter
logic[7:0]loop_counter;
logic[4:0]loop_counter2;
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
	 light5=0;
	 light6=0;
	 light7=0;
	 light8=0;
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
				//light1=1;
					if(go==1) begin
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
			if(ms_counter>=20000) begin
				next_state=T1;   
				ms_reset=1;
				end
		end
		 
		
		T1: begin
		next_state=T1;
			light1=1;
			if(loop_counter>4)
				light4=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T2;
			end
		end
		
		T2: begin
		next_state=T2;
			light2=1;
			if(loop_counter>4)
				light5=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T3;
			end
		end
		
		T3: begin
		next_state=T3;
			light3=1;
			if(loop_counter>4)
				light6=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T4;
			end
		end
		
		T4: begin
		next_state=T4;
			light4=1;
			if(loop_counter>3)
				light1=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T5;
			end
		end
		
		T5: begin
		next_state=T5;
			light5=1;
			if(loop_counter>3)
				light2=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T6;
			end
		end
		
		T6: begin
		next_state=T6;
			light6=1;
			if(loop_counter>3)
				light3=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T1;
				loop_inc=1;
				if(loop_counter==15) begin
					loop_reset=1;
					next_state=T95;
				end
			end
		end
		

				T95: begin //clap clap clap!
		next_state=T95;
			light1=1;
			light6=1;
			if(ms_counter == TRIPLET_EIGHTH) begin
				ms_reset=1;
				next_state=T96;
			end
		end
		
		T96: begin
		next_state=T96;
			light2=1;
			light5=1;
			if(ms_counter == TRIPLET_EIGHTH) begin
				ms_reset=1;
				next_state=T97;
			end
		end
		
		T97: begin
		next_state=T97;
			light3=1;
			light4=1;
			if(ms_counter == TRIPLET_EIGHTH*2) begin
				ms_reset=1;
				next_state=T98;
			end
		end
		
		T98: begin
		next_state=T98;
			light2=1;
			light5=1;
			if(ms_counter == TRIPLET_EIGHTH) begin
				ms_reset=1;
				next_state=T99;
			end
		end
		
		T99: begin
		next_state=T99;
			light1=1;
			light6=1;
			if(ms_counter == TRIPLET_EIGHTH) begin
				ms_reset=1;
				next_state=T95;
				loop_inc=1;
				if(loop_counter==7) begin
					loop_reset=1;
					next_state=T44;
				end
			end
		end
		
		T44: begin
		next_state=T44;
			if(ms_counter<EIGHTH_NOTE) begin
				light1=1;
				light2=1;
			end
			if(ms_counter>=EIGHTH_NOTE && ms_counter < 2*EIGHTH_NOTE) begin
				light1=1;
				light2=1;
				light3=1;
				light4=1;
			end
			if(ms_counter>=2*EIGHTH_NOTE && ms_counter < 3*EIGHTH_NOTE) begin
				light1=1;
				light2=1;
				light3=1;
				light4=1;
				light5=1;
				light6=1;
			end
			if(ms_counter>=3*EIGHTH_NOTE) begin
				light1=1;
				light2=1;
				light3=1;
			end
			if(ms_counter==HALF_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==7)begin
					loop_reset=1;
					next_state=T43;
				end
			end
		end
		
		T43: begin
		next_state=T43;
			if(ms_counter<EIGHTH_NOTE)begin
				light1=1;
				light2=1;
				light5=1;
				light6=1;
			end
			if(ms_counter>EIGHTH_NOTE)begin
				light3=1;
				light4=1;
			end
			if(ms_counter==QUARTER_NOTE) begin
					next_state=T12;
					loop_inc=1;
					
				end
			end
		end
		
		T12: begin //main chorus
		next_state=T12;
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==15) begin
					loop_reset=1;
			//light6=1;
			if(ms_counter<SIXTEENTH_NOTE) begin
				light5=1;
				light6=1;
			end
			if(ms_counter>1* SIXTEENTH_NOTE && ms_counter < 2* SIXTEENTH_NOTE)
				light4=1;
			if(ms_counter>2* SIXTEENTH_NOTE && ms_counter < 3* SIXTEENTH_NOTE)
				light3=1;
			if(ms_counter>3* SIXTEENTH_NOTE)
				light2=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T13;
			end
		end
			
		T13: begin
		next_state=T13;
			//if(ms_counter<EIGHTH_NOTE) begin
				//light7=1;
				//light8=1;
			//end
			//light1=1;
			if(ms_counter<SIXTEENTH_NOTE)begin
				light2=1;
				light1=1;
			end
			if(ms_counter>1* SIXTEENTH_NOTE && ms_counter < 2* SIXTEENTH_NOTE)
				light3=1;
			if(ms_counter>2* SIXTEENTH_NOTE && ms_counter < 3* SIXTEENTH_NOTE)
				light4=1;
			if(ms_counter>3* SIXTEENTH_NOTE)
				light5=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T12;
				if(loop_counter==5) begin
					loop_reset=1;
					next_state=T27;
				end
			end
		end
		
		T27: begin
		next_state=T27;
			//if(loop_counter<3)
			if(loop_counter==0)
				light8=1;
			//if(loop_counter>0 && loop_counter<3)
			if(loop_counter==1)
				light7=1;
			if(loop_counter==2) begin
				light1=1;
				light2=1;
				light3=1;
				light4=1;
				light5=1;
				light6=1;
			end
			if((ms_counter==QUARTER_NOTE && loop_counter2<4) || (ms_counter==EIGHTH_NOTE && loop_counter2>3 && loop_counter2<12) || (ms_counter==EIGHTH_NOTE && loop_counter2>11)) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==3) begin
					loop_reset=1;
					loop_inc2=1;
					if(loop_counter2==15) begin
						loop_reset2=1;
						next_state=T28;
					end
				end
			end
		end
		
		T28: begin
		next_state=T28;
			light3=1;
			light4=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T29;
			end
		end
		T29: begin
		next_state=T29;
			light2=1;
			light5=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T30;
			end
		end
		T30: begin
		next_state=T30;
			light1=1;
			light6=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T28;
				loop_inc=1;
				if(loop_counter==15) begin
					loop_reset=1;
					next_state=DONE;
				end
			end
		end
		 
			
			DONE: begin
				//next_state=DONE;
				//if(ms_counter==QUARTER_NOTE*4) begin
					ms_reset=1;
					finished_temp=1;
					next_state=IDLE;

				//end
					
				
			
			end
			
	
			
			default: begin
            next_state=IDLE;
				ms_reset=1;
				finished_temp=1;
           end
   endcase

	end
            


always_ff @(posedge clk, negedge rst_n) begin
    if(!rst_n)
		clk_counter<=28'h0000000;
	else if(ms_inc)
		clk_counter<=28'h0000000;
    else
		clk_counter<=clk_counter+1;
       
end

always_ff @(posedge clk, negedge rst_n) begin
	if(!rst_n)
		ms_counter<=20'h0;
	else if(ms_reset)
		ms_counter<=20'h0;
	else if(ms_inc)
		ms_counter<=ms_counter+1;
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

always_ff @(posedge clk, negedge rst_n) begin
    if(!rst_n)
		finished <= 1'b0;


    else
		finished <= finished_temp;
end


assign ms_inc=(clk_counter==DELAY);



endmodule
