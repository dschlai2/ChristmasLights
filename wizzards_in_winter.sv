
module wizzards_in_winter(go,finished,clk,rst_n,light1,light2,light3,light4,light5,light6,light7,light8);
    input logic go,clk,rst_n;
    output logic finished,light1,light2,light3,light4,light5,light6,light7,light8;
    
typedef enum logic[8:0]{DONE,IDLE,WAIT,T1_1,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13,T14,T15,T16,T17,T18,T19,T20,T21,T22,T23,T24,T25,T26,T27,T28,T29,T30,T31,T32,T33,T34,T35,T36,T37,T38,T39,T40,T41,T42,T43,T44,T45,T46,T47,T48,T49,T50,T51,T52,T53,T54,T55,T56,T57,T58,T59,T60,T61,T62,T63,T64,T65,T66,T67,T68,T69,T70,T71,T72,T73,T74,T75,T76,T77,T78,T79,T80,T81,T82,T83,T84,T85,T86,T87,T88,T88_1,T89,T90,T91,T92,T93,T94,T95,T96,T97,T98,T99,T100,T101,T102,T103,T104,T105,T106,T107,T108,T109,T110,T111,T112,T113,T114,T115,T116,T117,T118,T119,T120} state_t;
parameter MILLISECONDS = 1;
parameter DELAY = 5000*MILLISECONDS;
state_t state,next_state;
parameter QUARTER_NOTE=4042; //150 bpm
parameter EIGHTH_NOTE=QUARTER_NOTE/2;
parameter HALF_NOTE=QUARTER_NOTE*2;
parameter WHOLE_NOTE=QUARTER_NOTE*4;
parameter SIXTEENTH_NOTE=QUARTER_NOTE/4;
parameter TRIPLET_QUARTER=QUARTER_NOTE*2/3;
parameter TRIPLET_EIGHTH=QUARTER_NOTE/3;
parameter THIRTYSECOND_NOTE=QUARTER_NOTE/8;
parameter SIXTYFOURTH_NOTE=QUARTER_NOTE/16;


/*




*/

//to be removed later
parameter INTRO_SIXTEENTH=1;
parameter INTRO_THIRTYSECOND=1;
parameter INTRO_EIGHTH=1;
parameter INTRO_HALF=1;


logic[27:0]clk_counter;
logic[19:0]ms_counter; //milisecond counter
logic[7:0]loop_counter;
logic[4:0]loop_counter2;
logic[3:0]loop_counter3;
logic[2:0]loop_counter4;
logic loop_inc3;
logic loop_inc2;
logic loop_inc;
logic ms_inc;
logic ms_reset;
logic loop_reset;
logic loop_reset2;
logic loop_reset3;
logic loop_reset4;
logic loop_inc4;

logic finished_temp;

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
	 loop_reset4=0;
	 loop_inc=0;
	 loop_inc2=0;
	 loop_inc3=0;
	 loop_inc4=0;
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
							loop_reset4=1;
					 end
				
	    end
		 
		 WAIT: begin
			//light2=1;
			next_state=WAIT;
			loop_reset=1;
			loop_reset2=1;
			loop_reset3=1;
			loop_reset4=1;
			if(ms_counter>=20000) begin
				next_state=T1;  
				//next_state=T35;
				ms_reset=1;
				end
		end
		 
		

		 T1: begin 
				next_state=T1;
				if(loop_counter!=2 && ms_counter<SIXTEENTH_NOTE)
					light7=1;				
				if(loop_counter2<2) // && ms_counter<SIXTEENTH_NOTE)
					light6=1;
				if(loop_counter2>1 && loop_counter2<4) //&& ms_counter<SIXTEENTH_NOTE)
					light4=1;
				if(loop_counter2>3 && loop_counter2<6) //&& ms_counter<SIXTEENTH_NOTE)
					light2=1;					
				
				if(ms_counter==EIGHTH_NOTE) begin
					loop_inc=1;
					ms_reset=1;
					if(loop_counter==2) begin
						loop_reset=1;
						next_state=T2;
					end
				end
			end 
			
			T2: begin 
			next_state=T2;
				if(ms_counter<SIXTEENTH_NOTE)
					light7=1;
				if(loop_counter2<2)// && ms_counter<SIXTEENTH_NOTE)
					light5=1;
				if(loop_counter2>1 && loop_counter2<4) //&& ms_counter<SIXTEENTH_NOTE)
					light3=1;
				if(loop_counter2==4 )//&& ms_counter<SIXTEENTH_NOTE)
					light1=1;
				if(loop_counter2==5)// && ms_counter<SIXTEENTH_NOTE)
					light4=1;
				
				if(ms_counter==EIGHTH_NOTE) begin
					loop_inc2=1;
					ms_reset=1;
					next_state=T1;
					if(loop_counter2==5) begin
						loop_reset2=1;
						next_state=T3;
					end
				end
			end 
			
			T3: begin 
			next_state=T3;
				if(ms_counter<SIXTEENTH_NOTE) begin
					light7=1;
					light3=1;
				end
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=T5;
					if(loop_counter3==1) begin
						next_state=T6;
						loop_reset3=1;  // maybe not reset, if easier to keep track of global loop3
					end
				end
			end	

		 
		 
		 T4: begin 
		 next_state=T4;
				if(ms_counter<SIXTEENTH_NOTE)
					light2=1;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=T5;
            end
			end
			
		T5: begin //runs up
		next_state=T5;
			if(loop_counter==1) 
				light1=1;
			if(loop_counter==2)
				light2=1;
			if(loop_counter==3)
				light3=1;
			if(loop_counter==4)
				light4=1;
			if(loop_counter==5)
				light5=1;
			if(loop_counter==6)
				light6=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==6) begin
					loop_reset=1;
					loop_inc3=1;
					next_state=T1;
				end
			end
		end

		
		T6: begin // up and down
				next_state=T6;
			if(loop_counter==0) begin
				light1=1;
				light2=1;
				light3=1;
			end
			if(loop_counter==1) begin
				light2=1;
				light3=1;
				light4=1;
			end
			if(loop_counter==2) begin
				light3=1;
				light4=1;
				light5=1;
			end
			if(loop_counter==3) begin
				light4=1;
				light5=1;
				light6=1;
			end
			if(loop_counter==4) begin
				light3=1;
				light4=1;
				light5=1;
			end
			if(loop_counter==5) begin
				light2=1;
				light3=1;
				light4=1;
			end
			if(loop_counter==6) begin
				light1=1;
				light2=1;
				light3=1;
			end
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==6) begin
				loop_reset=1;
				next_state=T7;
			end
			end
			
			
		end
		
		T7: begin
		next_state=T7;
			if(loop_counter2==0) begin
				light4=1;
				light5=1;
				light6=1;
			end
			if(loop_counter2==1) begin
				light2=1;
				light3=1;
				light4=1;
				light5=1;
			end
			if(loop_counter2==2) begin
				light2=1;
				light4=1;
				light6=1;
			end
				if(ms_counter==QUARTER_NOTE) begin
					ms_reset=1;
					next_state=T8;
				end
			end
			
		T8: begin
		next_state=T8;
			if(ms_counter<EIGHTH_NOTE)
				light8=1;
			if(loop_counter2==0) begin
				light1=1;
				light2=1;
				light3=1;
			end
			if(loop_counter2==1) begin
				light1=1;
				light6=1;
			end
			if(loop_counter2==2) begin
				light1=1;
				light3=1;
				light5=1;
			end
			//if(ms_counter>EIGHTH_NOTE && ms_counter<3*SIXTEENTH_NOTE)
				//light7=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T7;
				loop_inc=1;
				if(loop_counter==1) begin //go to next pattern
					loop_inc2=1;
					loop_reset=1;
					if(loop_counter2==2) begin // done with patterns
						next_state=T9;
						loop_reset2=1;
						if(loop_counter3==1) begin //done with repeat, go to big hits
							next_state=T10;
							loop_reset3=1;
						end
					end
				end
				
			end
		end
		
		T9: begin
		next_state=T9;
			if(loop_counter==0) begin
				light2=1;
				light4=1;
				light6=1;
			end
			if(loop_counter==1)
				light1=1;
			if(loop_counter==2)
				light2=1;
			if(loop_counter==3)
				light3=1;
			if(loop_counter==4)
				light4=1;
			if(loop_counter==5)
				light5=1;
			if(loop_counter==6)
				light6=1;
			if(loop_counter==7)
				light8=1;
			
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==7) begin
					next_state=T7;
					loop_inc3=1;
					loop_reset=1;
				end
			end		
		end
		
		T10: begin // big hits
		next_state=T10;
			light2=1;
			light4=1;
			light6=1;
			light8=1;
			if(loop_counter==0 && ms_counter==WHOLE_NOTE) begin
				ms_reset=1;
				next_state=T11;
			end
			if(loop_counter==1 && ms_counter==3*EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T11;
			end
			if(loop_counter==2 && ms_counter==3*EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T11;
			end
			if(loop_counter>2 && ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T11;
			end
		end
		
		T11: begin // big hits
		next_state=T11;
			light1=1;
			light3=1;
			light5=1;
			light7=1;
			if(loop_counter==0 && ms_counter==WHOLE_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T10;
			end
			if(loop_counter==1 && ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T10;
			end
			if(loop_counter==2 && ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T10;
				if(loop_counter2==1) begin //after first main chorus
					ms_reset=1;
					loop_reset2=1;
					loop_reset=1;
					next_state=T15;			
				end
			end
			if(loop_counter>2 && ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T10;
				if(loop_counter==4) begin
					loop_reset=1;
					next_state=T12;
				end
			end
		end
		
		T12: begin //main chorus
		next_state=T12;
			light6=1;
			if(ms_counter<SIXTEENTH_NOTE)
				light5=1;
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
			if(ms_counter<EIGHTH_NOTE) begin
				light7=1;
				light8=1;
			end
			light1=1;
			if(ms_counter<SIXTEENTH_NOTE)
				light2=1;
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
					next_state=T14;
					if(loop_counter2==1) begin
						//loop_reset2=1; use loop 2 on big hits
						next_state=T10;
					end
				end
			end
		end
		
		T14: begin
		next_state=T14;
			if(loop_counter==0 && ms_counter<SIXTEENTH_NOTE) begin
				light1=1;
				light2=1;
				light3=1;
				light4=1;
				light5=1;
				light6=1;
				light7=1;
				light8=1;
			end
			if(loop_counter==1)
				light1=1;
			if(loop_counter==2)
				light4=1;
			if(loop_counter==3)
				light2=1;
			if(loop_counter==4)
				light5=1;
			if(loop_counter==5)
				light3=1;
			if(loop_counter==6)
				light6=1;
			if(loop_counter==7)
				light4=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==7) begin
					loop_reset=1;
					next_state=T12;
					loop_inc2=1;
				end
			end
		end
		
		T15: begin
		next_state=T15; // below shows when light turns OFF
			if(loop_counter<1)
				light4=1;
			if(loop_counter<2)
				light8=1;
			if(loop_counter<3)
				light2=1;
			if(loop_counter<4)begin
				light1=1;
				light7=1;
			end
			if(loop_counter<5)
				light5=1;
			if(loop_counter<6)
				light6=1;
			if(loop_counter<7)
				light3=1;
			if(ms_counter==QUARTER_NOTE) begin
				loop_inc=1;
				ms_reset=1;
				if(loop_counter==7) begin
					loop_reset=1;
					next_state=T16;
				end
			end
		end
		
		T16: begin
		next_state=T16;
			if(loop_counter==0)
				light2=1;
			if(loop_counter==1)
				light3=1;
			if(loop_counter==2)
				light4=1;
			if(loop_counter==3)
				light5=1;
			if(loop_counter==4)
				light2=1;
			if(loop_counter==5)
				light3=1;
			if(loop_counter==6)
				light4=1;
			if(loop_counter==7)
				light5=1;
				
			if(loop_counter2>3) begin
				if(ms_counter<SIXTEENTH_NOTE) begin
					if(loop_counter==0 && loop_counter2==7)
						light8=1;
					if(loop_counter==2)
						light8=1;
					if(loop_counter==3 && loop_counter2!=7)
						light8=1;
					if(loop_counter==4)
						light8=1;
					if(loop_counter==6)
						light8=1;
				end
			end
			
			if(ms_counter==EIGHTH_NOTE)  begin
				loop_inc=1;
				ms_reset=1;
				if(loop_counter==7) begin
					loop_reset=1;
					loop_inc2=1;
					if(loop_counter2==7) begin
						loop_reset2=1;
						next_state=T17;
					end
						
				end
			end
		end
		
		T17: begin
		next_state=T17;
			if(loop_counter==2 || loop_counter==4) begin
				if(loop_counter2==0) begin
					light6=1;
					light4=1;
				end
				if (loop_counter2==1) begin
					light5=1;
					light3=1;
				end
				if (loop_counter2==2) begin
					light4=1;
					light2=1;
				end
			end
			if(loop_counter==3 || loop_counter==6) begin
				if(loop_counter2==0) begin
					light5=1;
					light3=1;
				end
				if (loop_counter2==1) begin
					light4=1;
					light2=1;
				end
				if (loop_counter2==2) begin
					light3=1;
					light1=1;
				end
			end
			if(ms_counter==EIGHTH_NOTE) begin
				loop_inc=1;
				ms_reset=1;
				if(loop_counter==7) begin
					loop_reset=1;
					loop_inc2=1;
					if(loop_counter2==2) begin
						loop_reset2=1;
						next_state=T18;
					end
				end
			end
		end
					
		T18: begin
		next_state=T18;
			light5=1;
			if(loop_counter>0)
			light4=1;
			if(loop_counter>1)
			light3=1;
			if(loop_counter==3)
			light2=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==3) begin
					next_state=T19;
					loop_reset=1;
				end
			end
		end
		
		T19: begin // big hits
		next_state=T19;
			if(ms_counter<SIXTEENTH_NOTE) begin
				light1=1;
				light2=1;
				light3=1;
				light4=1;
				light5=1;
				light6=1;
				light7=1;
				light8=1;
			end
			if(loop_counter==0 && ms_counter==WHOLE_NOTE) begin
				ms_reset=1;
				next_state=T20;
			end
			if(loop_counter==1 && ms_counter==3*EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T20;
			end
			if(loop_counter==2 && ms_counter==3*EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T20;
			end
			if(loop_counter>2 && ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T20;
			end
		end
		
		T20: begin
		next_state=T20;
			if(ms_counter<SIXTEENTH_NOTE) begin
				light1=1;
				light2=1;
				light3=1;
				light4=1;
				light5=1;
				light6=1;
				light7=1;
				light8=1;
			end
			if(loop_counter==0 && ms_counter==WHOLE_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T19;
			end
			if(loop_counter==1 && ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T19;
			end
			if(loop_counter==2 && ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T19;
			end
			if(loop_counter>2 && ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T19;
				if(loop_counter==4) begin
					loop_reset=1;
					next_state=T21;
				end
			end
		end
		
		T21: begin //main chorus -- modified
		next_state=T21;
			if(ms_counter<SIXTEENTH_NOTE) begin
				light6=1;
				light5=1;
			end
			if(ms_counter>SIXTEENTH_NOTE && ms_counter < 2* SIXTEENTH_NOTE) begin
				light5=1;
				light4=1;
			end
			if(ms_counter>2* SIXTEENTH_NOTE && ms_counter < 3* SIXTEENTH_NOTE) begin
				light4=1;
				light3=1;
			end
			if(ms_counter>3* SIXTEENTH_NOTE)begin
				light3=1;
				light2=1;
			end
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T22;
			end
		end
			
		T22: begin
		next_state=T22;
			if(ms_counter<3*THIRTYSECOND_NOTE) begin
				light7=1;
				light8=1;
			end
			if(ms_counter<SIXTEENTH_NOTE) begin
			light1=1;
			light2=1;
			end
			if(ms_counter>SIXTEENTH_NOTE && ms_counter < 2* SIXTEENTH_NOTE) begin
			light2=1;
			light3=1;
			end			
			if(ms_counter>2* SIXTEENTH_NOTE && ms_counter < 3* SIXTEENTH_NOTE)begin
				light3=1;
				light4=1;
			end
			if(ms_counter>3* SIXTEENTH_NOTE)begin
				light4=1;
				light5=1;
			end
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T21;
				if(loop_counter==5 && loop_counter4!=2) begin
					loop_reset=1;
					next_state=T23;
					if(loop_counter2==1 ) begin
						loop_reset2=1; // comment out? use loop 2 on big hits?
						next_state=T24;
						if(loop_counter4==1) begin
							next_state=T33;
							loop_reset3=1;
						end
					end
				end
				if(loop_counter==11) begin
					loop_reset=1;
					next_state=T35;
				end
			end
		end
		
		T23: begin
		next_state=T23;
			if(loop_counter==0) begin
				light1=1;
				light2=1;
				light3=1;
				light4=1;
				light5=1;
				light6=1;
			end
			if(loop_counter==2)
				light1=1;
			if(loop_counter==3)
				light2=1;
			if(loop_counter==4)
				light3=1;
			if(loop_counter==5)
				light4=1;
			if(loop_counter==6)
				light5=1;
			if(loop_counter==7)
				light6=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==7) begin
					loop_reset=1;
					next_state=T21;
					loop_inc2=1;
				end
			end
		end
			
		T24: begin
		next_state=T24;
			if(ms_counter<SIXTEENTH_NOTE) begin
				light1=1;
				light2=1;
				light3=1;
				light4=1;
				light5=1;
				light6=1;
				light7=1;
				light8=1;
			end
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T25;
				if(loop_counter2==2) begin
					loop_reset2=1;
					next_state=T26;
				end
			end
		end
		
		T25: begin
		next_state=T25;
			if(loop_counter==1 && ms_counter<SIXTEENTH_NOTE) begin
				light3=1;
				light4=1;
			end
			if(loop_counter==2 && ms_counter<SIXTEENTH_NOTE) begin
				light3=1;
				light4=1;
			end
			if(loop_counter==3 && ms_counter<SIXTEENTH_NOTE) begin
				light3=1;
				light4=1;
			end
			if(loop_counter==4 && ms_counter<SIXTEENTH_NOTE) begin
				light2=1;
				light5=1;
			end
			if(loop_counter==5 && ms_counter<SIXTEENTH_NOTE) begin
				light1=1;
				light6=1;
			end
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==5) begin
					loop_inc2=1;
					loop_reset=1;
					next_state=T24;
					
				end
					
			end
		end
			
		T26: begin
		next_state=T26;
			if(loop_counter==1 && ms_counter<SIXTEENTH_NOTE) begin
				light1=1;
				light6=1;
			end
			if(loop_counter==2 && ms_counter<SIXTEENTH_NOTE) begin
				light1=1;
				light6=1;
			end
			if(loop_counter==3 && ms_counter<SIXTEENTH_NOTE) begin
				light1=1;
				light6=1;
			end
			if(loop_counter==4 && ms_counter<SIXTEENTH_NOTE) begin
				light2=1;
				light5=1;
			end
			if(loop_counter==5 && ms_counter<SIXTEENTH_NOTE) begin
				light3=1;
				light4=1;
			end
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==5) begin
					loop_reset=1;
					next_state=T27;
					
				end
					
			end
		end
		
		T27: begin
		next_state=T27;
			if(loop_counter<3)
				light8=1;
			if(loop_counter>0 && loop_counter<3)
				light7=1;
			if(loop_counter==2) begin
				light1=1;
				light2=1;
				light3=1;
				light4=1;
				light5=1;
				light6=1;
			end
			if((ms_counter==QUARTER_NOTE && loop_counter2<2) || (ms_counter==EIGHTH_NOTE && loop_counter2>1 && loop_counter2<4) || (ms_counter==SIXTEENTH_NOTE && loop_counter2>3)) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==3) begin
					loop_reset=1;
					loop_inc2=1;
					if(loop_counter2==7) begin
						loop_reset2=1;
						next_state=T28;
					end
				end
			end
		end
		
		T28: begin
		next_state=T28;
			if(loop_counter==0 || loop_counter==1 || loop_counter==3 || loop_counter==4 || loop_counter==5 || loop_counter==7) begin
				if(ms_counter<SIXTEENTH_NOTE)
					light7=1;
			end
			if(loop_counter<2) begin
				light5=1;
			//	light1=1;
			end
			if(loop_counter>1 && loop_counter<4) begin
				light4=1;
			//	light1=1;
			end
			if(loop_counter>3 && loop_counter<6) begin
				light3=1;
			//	light6=1;
			end
			if(loop_counter>5) begin
				light2=1;
			//	light6=1;
			end
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==7) begin
					loop_reset=1;
					loop_inc2=1;
					if(loop_counter2==3) begin
						loop_reset2=1;
						next_state=T29;
					end
				end
			end
		end
					
		T29: begin
		next_state=T29;
			//if(loop_counter==0 || loop_counter==1 || loop_counter==3 || loop_counter==4 || loop_counter==5 || loop_counter==7) begin
			//	if(ms_counter<SIXTEENTH_NOTE)
					//light7=1;
			//end
			if(loop_counter<2) begin
				light3=1;
				light4=1;
			end
			if(loop_counter>1 && loop_counter<4) begin
				light2=1;
				light3=1;
				light4=1;
				light5=1;
			end
			if(loop_counter>3 && loop_counter<6) begin
				light1=1;
				light2=1;
				light5=1;
				light6=1;
			end
			if(loop_counter==6) begin
				light1=1;
				light6=1;
			end
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==7) begin
					loop_reset=1;
					next_state=T30;
				end
			end
		end
		
		T30: begin
		next_state=T30;
		//	if(loop_counter==0 || loop_counter==1 || loop_counter==3 || loop_counter==4 || loop_counter==5 || loop_counter==7) begin
			//	if(ms_counter<SIXTEENTH_NOTE)
					//light7=1;
			//end
			if(loop_counter<2) begin
				light1=1;
				light6=1;
			end
			if(loop_counter>1 && loop_counter<4) begin
				light1=1;
				light2=1;
				light5=1;
				light6=1;
			end
			if(loop_counter>3 && loop_counter<6) begin
				light2=1;
				light3=1;
				light4=1;
				light5=1;
			end
			if(loop_counter==6) begin
				light3=1;
				light4=1;
			end
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==7) begin
					loop_reset=1;
					next_state=T31;
				end
			end
		end
		
		T31: begin
		next_state=T31;
			//if(loop_counter2==0 || loop_counter2==1 || loop_counter2==3 || loop_counter2==4 || loop_counter2==5 || loop_counter2==7) begin
			//	if(ms_counter<SIXTEENTH_NOTE && loop_counter==0)
				//	light7=1;
			//end
			if(loop_counter==0) begin
				light1=1;
				if(loop_counter2!=0)
					light4=1;
			end
			if(loop_counter==1) begin
				light2=1;
				if(loop_counter2!=0)
					light5=1;
			end
			if(loop_counter==2) begin
				light3=1;
				if(loop_counter2!=0)
					light6=1;
			end
			if(ms_counter==TRIPLET_EIGHTH) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==2) begin
					loop_reset=1;
					loop_inc2=1;
					if(loop_counter2==7) begin
						loop_reset2=1;
						next_state=T32;
					end
				end
			end
		end
		
		T32: begin
		next_state=T32;
			//if(loop_counter2==0 || loop_counter2==1 || loop_counter2==3 || loop_counter2==4 || loop_counter2==5 || loop_counter2==7) begin
				//if(ms_counter<SIXTEENTH_NOTE && loop_counter==0)
					//light7=1;
			//end
			if(loop_counter==0) begin
				light6=1;
				//if(loop_counter2!=0)
					light3=1;
			end
			if(loop_counter==1) begin
				light5=1;
				//if(loop_counter2!=0)
					light2=1;
			end
			if(loop_counter==2) begin
				light4=1;
				//if(loop_counter2!=0)
					light1=1;
			end
			if(ms_counter==TRIPLET_EIGHTH) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==2) begin
					loop_reset=1;
					loop_inc2=1;
					if(loop_counter2==7) begin
						loop_reset2=1;
						next_state=T29;
						loop_inc3=1;
						if(loop_counter3==1) begin
							next_state=T19;
							loop_reset3=1; //comment out? keep track of chorus?
							loop_inc4=1; //keep track of chorus with loop inc4
						end
					end
				end
			end
		end
		
		T33: begin
		next_state=T33;
			if(ms_counter<SIXTEENTH_NOTE) begin
				light7=1;
				light8=1;
			end
			if(loop_counter3!=0) begin // start with the end of T34, not start of T34
				light4=1;
				light1=1;
			end
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T34;
			end
		end
		
		T34: begin
		next_state=T34;
			if(loop_counter3==4 && ms_counter<SIXTEENTH_NOTE && loop_counter==0) begin
				light7=1;
				light8=1;
			end
			if(loop_counter==0) begin
				light6=1;
				if(loop_counter2!=0 || loop_counter3!=0)
					light3=1;
			end
			if(loop_counter==1) begin
				light5=1;
				if(loop_counter2!=0|| loop_counter3!=0)
					light2=1;
			end
			if(loop_counter==2) begin
				light4=1;
				if(loop_counter2!=0|| loop_counter3!=0)
					light1=1;
			end
			if(ms_counter==TRIPLET_EIGHTH) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==2) begin
					loop_reset=1;
					loop_inc2=1;
					if((loop_counter2==2 && loop_counter3<2) || (loop_counter2==0 && loop_counter3==2) ||  (loop_counter2==0 && loop_counter3==3) || (loop_counter2==2 && loop_counter3==4)) begin
						next_state=T33;
						loop_inc3=1;
						loop_reset2=1;
						if(loop_counter3==4) begin
							loop_reset3=1;
							loop_inc4=1;
							next_state=T21;
						end
					end
				end
			end
		end
		
		
		T35: begin
		next_state=T35;
			if(ms_counter<EIGHTH_NOTE && loop_counter%2==0) begin
				light8=1;
			end
			if(ms_counter<EIGHTH_NOTE && loop_counter%2==1) begin
				light7=1;
			end
			if(ms_counter<SIXTEENTH_NOTE) begin
				light6=1;
				light5=1;
			end
			if(ms_counter>=SIXTEENTH_NOTE && ms_counter < 2* SIXTEENTH_NOTE) begin
				light5=1;
				light4=1;
			end
			if(ms_counter>=2* SIXTEENTH_NOTE && ms_counter < 3* SIXTEENTH_NOTE) begin
				light4=1;
				light3=1;
			end
			if(ms_counter>=3* SIXTEENTH_NOTE)begin
				light3=1;
				light2=1;
			end
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T36;
			end
		end
			
		T36: begin
		next_state=T36;
			if(ms_counter<EIGHTH_NOTE&& loop_counter%2==0) begin
				light8=1;
			end
			if(ms_counter<EIGHTH_NOTE && loop_counter%2==1) begin
				light7=1;
			end

			if(ms_counter<SIXTEENTH_NOTE) begin
			light1=1;
			light2=1;
			end
			if(ms_counter>=SIXTEENTH_NOTE && ms_counter < 2* SIXTEENTH_NOTE) begin
			light2=1;
			light3=1;
			end			
			if(ms_counter>=2* SIXTEENTH_NOTE && ms_counter < 3* SIXTEENTH_NOTE)begin
				light3=1;
				light4=1;
			end
			if(ms_counter>=3* SIXTEENTH_NOTE)begin
				light4=1;
				light5=1;
			end
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T35;
				if(loop_counter==3) begin
					loop_reset=1;
					next_state=T37;
				end
			end
		end
		
		T37: begin
		next_state=T37;
			if(ms_counter<SIXTEENTH_NOTE) 
				light8=1;
			if(ms_counter>EIGHTH_NOTE && ms_counter<3*SIXTEENTH_NOTE) 
				light8=1;
				
			if(ms_counter<SIXTEENTH_NOTE) begin
				light6=1;
				light5=1;
			end
			if(ms_counter>=SIXTEENTH_NOTE && ms_counter < 2* SIXTEENTH_NOTE) begin
				light5=1;
				light4=1;
			end
			if(ms_counter>=2* SIXTEENTH_NOTE && ms_counter < 3* SIXTEENTH_NOTE) begin
				light4=1;
				light3=1;
			end
			if(ms_counter>=3* SIXTEENTH_NOTE)begin
				light3=1;
				light2=1;
			end
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T38;
			end
		end
			
		T38: begin
		next_state=T38;
			if(ms_counter<SIXTEENTH_NOTE) 
				light7=1;
			if(ms_counter>EIGHTH_NOTE && ms_counter<3*SIXTEENTH_NOTE) 
				light7=1;
				
			if(ms_counter<SIXTEENTH_NOTE) begin
			light1=1;
			light2=1;
			end
			if(ms_counter>SIXTEENTH_NOTE && ms_counter < 2* SIXTEENTH_NOTE) begin
			light2=1;
			light3=1;
			end			
			if(ms_counter>2* SIXTEENTH_NOTE && ms_counter < 3* SIXTEENTH_NOTE)begin
				light3=1;
				light4=1;
			end
			if(ms_counter>3* SIXTEENTH_NOTE)begin
				light4=1;
				light5=1;
			end
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T37;
				if(loop_counter==3) begin
					loop_reset=1;
					next_state=T39;
				end
			end
		end
		
		T39: begin
		next_state=T39;
			if(ms_counter<SIXTEENTH_NOTE) 
				light8=1;
			if(ms_counter>EIGHTH_NOTE && ms_counter<3*SIXTEENTH_NOTE && loop_counter!=3) 
				light8=1;
			if(ms_counter>EIGHTH_NOTE && ms_counter<3*SIXTEENTH_NOTE && loop_counter==3)
				light7=1;
			if(ms_counter<SIXTEENTH_NOTE) begin
				light1=1;
				light6=1;
			end
			if(ms_counter>SIXTEENTH_NOTE && ms_counter < 2* SIXTEENTH_NOTE) begin
				light2=1;
				light5=1;
			end			
			if(ms_counter>2* SIXTEENTH_NOTE && ms_counter < 3* SIXTEENTH_NOTE)begin
				light3=1;
				light4=1;
			end
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==3) begin
					loop_reset=1;
					next_state=T40;
				end
			end
		end
		
		T40: begin
		next_state=T40;
			if(ms_counter<SIXTEENTH_NOTE) 
				light8=1;
			if(ms_counter>EIGHTH_NOTE && ms_counter<3*SIXTEENTH_NOTE && loop_counter!=3) 
				light8=1;
			if(ms_counter>EIGHTH_NOTE && ms_counter<3*SIXTEENTH_NOTE && loop_counter==3)
				light7=1;
			if(ms_counter<SIXTEENTH_NOTE) begin
				light3=1;
				light4=1;
			end
			if(ms_counter>SIXTEENTH_NOTE && ms_counter < 2* SIXTEENTH_NOTE) begin
				light2=1;
				light5=1;
			end			
			if(ms_counter>2* SIXTEENTH_NOTE && ms_counter < 3* SIXTEENTH_NOTE)begin
				light1=1;
				light6=1;
			end

			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==3) begin
					loop_reset=1;
					next_state=T39;
					loop_inc2=1;
					if(loop_counter2==1) begin
						loop_reset2=1;
						next_state=T41;
					end
				end
			end
		end
		
		T41: begin
		next_state=T41;
	
			if(loop_counter==0) begin
				light6=1;
				if(loop_counter2%2==0)begin
					light8=1;
					light7=1;
					if(loop_counter2>7) begin
						light1=1;
						light2=1;
						light3=1;
						light4=1;
						light5=1;
						light6=1;
					end
				end
				if(loop_counter2!=0)
					light3=1;
			end
			if(loop_counter==1) begin
				light5=1;
				if(loop_counter2!=0)
					light2=1;
			end
			if(loop_counter==2) begin
				light4=1;
				if(loop_counter2!=0)
					light1=1;
			end
			if(ms_counter==TRIPLET_EIGHTH) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==2) begin
					loop_inc2=1;
					loop_reset=1;
					if(loop_counter2==15) begin
						next_state=T42;
						loop_reset2=1;
					end
				end
			end
		end
		
		T42: begin
		next_state=T42;
			if(loop_counter==0) begin
				light6=1;
			end
				
			if(loop_counter==1) begin
				light5=1;
				if(loop_counter2!=0)
					light2=1;
			end
			if(loop_counter==2) begin
				light4=1;
				if(loop_counter2!=0)
					light1=1;
			end
			if(ms_counter==TRIPLET_EIGHTH/2) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==2) begin
					loop_reset=1;
					loop_inc2=1;
					if(loop_counter2==3) begin
						next_state=T43;
						loop_reset2=1;
					end
				end
			end
		end
		
		T43: begin
		next_state=T43;
			if(ms_counter<SIXTEENTH_NOTE)begin
				light1=1;
				light2=1;
				light5=1;
				light6=1;
			end
			if(ms_counter>SIXTEENTH_NOTE)begin
				light3=1;
				light4=1;
			end
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==3) begin
					loop_reset=1;
					next_state=T44;
				end
			end
		end
		
		T44: begin
		next_state=T44;
			if(ms_counter<SIXTEENTH_NOTE) begin
				light1=1;
				light2=1;
			end
			if(ms_counter>=SIXTEENTH_NOTE && ms_counter < 2*SIXTEENTH_NOTE) begin
				light1=1;
				light2=1;
				light3=1;
				light4=1;
			end
			if(ms_counter>=2*SIXTEENTH_NOTE && ms_counter < 3*SIXTEENTH_NOTE) begin
				light1=1;
				light2=1;
				light3=1;
				light4=1;
				light5=1;
				light6=1;
			end
			if(ms_counter>=3*SIXTEENTH_NOTE) begin
				light1=1;
				light2=1;
				light3=1;
			end
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==1)begin
					loop_reset=1;
					next_state=T45;
				end
			end
		end
		
		T45: begin
		next_state=T45;
			if(ms_counter<THIRTYSECOND_NOTE) begin
				light1=1;
				//light2=1;
				//light3=1;
				light4=1;
				//light5=1;
				light6=1;
				//light7=1;
				light8=1;
			end
			if(ms_counter>=1*THIRTYSECOND_NOTE && ms_counter < 2*THIRTYSECOND_NOTE) begin
				light1=1;
				//light2=1;
				//light3=1;
				light4=1;
				//light5=1;
				light6=1;
				light7=1;
				//light8=1;
			end
			if(ms_counter>=2*THIRTYSECOND_NOTE && ms_counter < 3*THIRTYSECOND_NOTE) begin
				//light1=1;
				//light2=1;
				light3=1;
				light4=1;
				//light5=1;
				light6=1;
				//light7=1;
				light8=1;
			end
			if(ms_counter>=3*THIRTYSECOND_NOTE && ms_counter < 4*THIRTYSECOND_NOTE) begin
				//light1=1;
				light2=1;
				light3=1;
				//light4=1;
				//light5=1;
				light6=1;
				//light7=1;
				light8=1;
			end
			if(ms_counter>=4*THIRTYSECOND_NOTE && ms_counter < 5*THIRTYSECOND_NOTE) begin
				light1=1;
				light2=1;
				//light3=1;
				//light4=1;
				light5=1;
				light6=1;
				//light7=1;
				//light8=1;
			end
			if(ms_counter>=5*THIRTYSECOND_NOTE && ms_counter < 6*THIRTYSECOND_NOTE) begin
				//light1=1;
				light2=1;
				//light3=1;
				//light4=1;
				light5=1;
				light6=1;
				light7=1;
				//light8=1;
			end
			if(ms_counter>=6*THIRTYSECOND_NOTE && ms_counter < 7*THIRTYSECOND_NOTE) begin
				//light1=1;
				light2=1;
				light3=1;
				//light4=1;
				light5=1;
				//light6=1;
				//light7=1;
				light8=1;
			end
			if(ms_counter>=7*THIRTYSECOND_NOTE && ms_counter < 8*THIRTYSECOND_NOTE) begin
				light1=1;
				//light2=1;
				//light3=1;
				light4=1;
				//light5=1;
				light6=1;
				//light7=1;
				light8=1;
			end
			if(ms_counter<=8*THIRTYSECOND_NOTE && ms_counter < 9*THIRTYSECOND_NOTE) begin
				//light1=1;
				light2=1;
				//light3=1;
				light4=1;
				light5=1;
				light6=1;
				//light7=1;
				//light8=1;
			end
			if(ms_counter>=9*THIRTYSECOND_NOTE && ms_counter < 10*THIRTYSECOND_NOTE) begin
				//light1=1;
				//light2=1;
				light3=1;
				light4=1;
				//light5=1;
				light6=1;
				//light7=1;
				light8=1;
			end
			if(ms_counter>=10*THIRTYSECOND_NOTE && ms_counter < 11*THIRTYSECOND_NOTE) begin
				light1=1;
				//light2=1;
				//light3=1;
				light4=1;
				//light5=1;
				light6=1;
				light7=1;
				//light8=1;
			end
			if(ms_counter>=11*THIRTYSECOND_NOTE && ms_counter < 12*THIRTYSECOND_NOTE) begin
				//light1=1;
				//light2=1;
				//light3=1;
				light4=1;
				light5=1;
				light6=1;
				//light7=1;
				light8=1;
			end
			if(ms_counter>=12*THIRTYSECOND_NOTE && ms_counter < 13*THIRTYSECOND_NOTE) begin
				//light1=1;
				light2=1;
				light3=1;
				//light4=1;
				light5=1;
				//light6=1;
				//light7=1;
				light8=1;
			end
			if(ms_counter>=13*THIRTYSECOND_NOTE && ms_counter < 14*THIRTYSECOND_NOTE) begin
				light1=1;
				//light2=1;
				light3=1;
				light4=1;
				//light5=1;
				light6=1;
				//light7=1;
				//light8=1;
			end
			if(ms_counter>=14*THIRTYSECOND_NOTE && ms_counter < 15*THIRTYSECOND_NOTE) begin
				//light1=1;
				//light2=1;
				//light3=1;
				//light4=1;
				//light5=1;
				//light6=1;
				//light7=1;
				//light8=1;
			end
			if(ms_counter>=15*THIRTYSECOND_NOTE) begin
				//light1=1;
				//light2=1;
				//light3=1;
				//light4=1;
				//light5=1;
				//light6=1;
				//light7=1;
				//light8=1;
			end
			if(ms_counter==HALF_NOTE) begin
				ms_reset=1;
				next_state=DONE;
			end
		end

			
				
		
		
				
			
			DONE: begin
				light1=1;
				light2=1;
				light3=1;
				light4=1;
				light5=1;
				light6=1;
				light7=1;
				light8=1;
				next_state=DONE;
				if(ms_counter==WHOLE_NOTE) begin
					ms_reset=1;
					finished_temp=1;
					next_state=IDLE;
				end			
			
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
		loop_counter4<=0;
	else if (loop_reset4)
		loop_counter4<=8'h00;
	else if (loop_inc4)
		loop_counter4<=loop_counter4+1;
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
