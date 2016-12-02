
module Bieber_alaylm(go,finished,clk,rst_n,light1,light2,light3,light4,light5,light6,light7,light8);
    input logic go,clk,rst_n;
    output logic finished,light1,light2,light3,light4,light5,light6,light7,light8;
    
typedef enum logic[8:0]{DONE,IDLE,WAIT,T1_1,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13,T14,T15,T16,T17,T18,T19,T20,T21,T22,T23,T24,T25,T26,T27,T28,T29,T30,T31,T32,T33,T34,T35,T36,T37,T38,T39,T40,T41,T42,T43,T44,T45,T46,T47,T48,T49,T50,T51,T52,T53,T54,T55,T56,T57,T58,T59,T60,T61,T62,T63,T64,T65,T66,T67,T68,T69,T70,T71,T72,T73,T74,T75,T76,T77,T78,T79,T80,T81,T82,T83,T84,T85,T86,T87,T88,T88_1,T89,T90,T91,T92,T93,T94,T95,T96,T97,T98,T99,T100,T101,T102,T103,T104,T105,T106,T107,T108,T109,T110,T111,T112,T113,T114,T115,T116,T117,T118,T119,T120} state_t;
parameter MILLISECONDS = 1;
parameter DELAY = 5000*MILLISECONDS;
state_t state,next_state;
parameter QUARTER_NOTE=4290; //140 bpm
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
				//next_state=T92;
				ms_reset=1;
				end
		end
		 
		

		 T1: begin 
				next_state=T1;
				light2=1;
				if(ms_counter==WHOLE_NOTE) begin
					ms_reset=1;
					next_state=T2;
				end
			end 
			T2: begin 
			next_state=T2;
				light5=1;
				if(ms_counter==WHOLE_NOTE) begin
					ms_reset=1;
					next_state=T3;
				end
			end 
			T3: begin 
			next_state=T3;
				light3=1;
				if(ms_counter==WHOLE_NOTE) begin
					ms_reset=1;
					next_state=T4;
				end
			end	

		 
		 
		 T4: begin 
		 next_state=T4;
				light4=1;
				if(ms_counter==WHOLE_NOTE) begin
					ms_reset=1;
					next_state=T5;
            end
			end
			
		T5: begin //intro pickup 
		next_state=T5;
			light2=1;
			if(ms_counter==HALF_NOTE) begin
				ms_reset=1;
				next_state=T6;
			end
		end
		
		T6: begin // intro pickup off
		next_state=T6;
			light3=1;
			if(ms_counter==HALF_NOTE) begin
				ms_reset=1;
				next_state=T7;
			end
		end
		
		T7: begin // 
		next_state=T7;
			light4=1;
			if(ms_counter==HALF_NOTE) begin
				ms_reset=1;
				next_state=T8;
				
			end
		end
		
		T8: begin //
		next_state=T8;	
			light5=1;
			if(ms_counter==HALF_NOTE) begin
				ms_reset=1;
				next_state=T9;				
			end
		end
		
		T9: begin
		next_state=T9;
			light2=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T10;
			end
		end
		
		T10: begin //
		next_state=T10;	
			light2=1;
			light3=1;
			//light4=1;
			//light5=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T11;
			end
		end
		
		T11: begin //
		next_state=T11;
			light2=1;
			light3=1;
			light4=1;
			//light5=1;
			if(ms_counter==QUARTER_NOTE)begin
				ms_reset=1;
				next_state=T12;
			end
		end
		
		T12: begin //
		next_state=T12;
			light2=1;
			light3=1;
			light4=1;
			light5=1;
			if(ms_counter==QUARTER_NOTE)begin
				ms_reset=1;
				next_state=T13;
			end
		end
		
		T13: begin  // bass drop
		next_state=T13;
			light7=1;
			if(ms_counter==SIXTEENTH_NOTE)begin
				ms_reset=1;
				next_state=T14;
			end
		end
		
		T14: begin
		next_state=T14;
			if(ms_counter==SIXTEENTH_NOTE) begin
				ms_reset=1;
				next_state = T13;
				loop_inc=1;
				if(loop_counter==1)begin
					loop_reset=1;
					next_state=T15;
				end
			end
		
		end
		
		T15: begin 
		next_state=T15;
			light7=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=T16;
			end
		end
		
		T16: begin 
		next_state=T16;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=T15;
				loop_inc=1;
				if(loop_counter==3)begin
					loop_reset=1;
					next_state=T17;
				end
			end
		end
		
		T17: begin // dramatic pause
		next_state=T17;
			if(ms_counter==HALF_NOTE-SIXTEENTH_NOTE) begin
				ms_reset=1;
				next_state=T18;
				
			end
		end
		
		T18: begin // fast runs -- explode out -- start of verse
		next_state=T18;
			light3=1;
			light4=1;
			if(ms_counter==SIXTYFOURTH_NOTE)begin
					ms_reset=1;
					next_state=T19;
			end	
		end
		
		T19: begin
		next_state=T19;
			light2=1;
			light5=1;
			if(ms_counter==SIXTYFOURTH_NOTE) begin
				ms_reset=1;
				next_state=T20;
			end
		end
		
		T20: begin //
		next_state=T20;	
			light1=1;
			light6=1;
			light7=1;
			if(ms_counter==EIGHTH_NOTE-THIRTYSECOND_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T18;
				if(loop_counter==2)begin
					loop_reset=1;
					next_state=T21;
				end
			end
		end
		
		T21: begin 
		next_state=T21;
		if(ms_counter<SIXTEENTH_NOTE) begin
			light1=1;
			light6=1;
		end
		if(ms_counter==EIGHTH_NOTE+THIRTYSECOND_NOTE)begin
			ms_reset=1;
			next_state=T22;
		end
		end
		
		T22: begin //triplet start
		next_state=T22;
			light8=1;
			light6=1;
			
			if(ms_counter==TRIPLET_EIGHTH)begin
				ms_reset=1;
				next_state=T23;
				
			end
		end
		
		T23: begin //
		next_state=T23;
			light8=1;
			light5=1;
			if(ms_counter==TRIPLET_EIGHTH)begin
				ms_reset=1;
				next_state=T24;
			end
		end
		
		T24: begin //
		next_state=T24;
			light8=1;
			light4=1;
			if(ms_counter==TRIPLET_EIGHTH)begin
				ms_reset=1;
				next_state=T25;
			end
		end
		
		T25: begin //
		next_state=T25;
			light8=1;
			light3=1;
			if(ms_counter==TRIPLET_EIGHTH)begin
				ms_reset=1;
				next_state=T26;
			end
		end
		
		T26: begin //
		next_state=T26;
			light8=1;
			light2=1;
			if(ms_counter==TRIPLET_EIGHTH)begin
				ms_reset=1;
				next_state=T27;
			end
		end
		
		T27: begin //
		next_state=T27;
			light1=1;
			if(ms_counter==TRIPLET_EIGHTH)begin
				ms_reset=1;
				next_state=T28;
			end
		end
		
		
		
		
		
		T28: begin // 
		next_state=T28;
			light7=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T29;
			end
		end
		
		T29: begin 
		next_state=T29;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T30;
			end
		end
		
		
		T30: begin //
		next_state=T30;
			light7=1;
			if(ms_counter==EIGHTH_NOTE)begin
				ms_reset=1;
				next_state=T31;
			end
		end
		
		T31: begin // run up
		next_state=T31;
		light8=1;
		light1=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T32;
		end
		end
		
		T32: begin //
		next_state=T32;
		light8=1;
		light2=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T33;
		end
		end
		
		T33: begin //
		next_state=T33;
		light8=1;
		light3=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T34;
		end
		end
		
		T34: begin //
		next_state=T34;
		light8=1;
		light4=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T35;
		end
		end
		
		T35: begin //
		next_state=T35;
		light8=1;
		light5=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T36;
		end
		end
		
		T36: begin //
		next_state=T36;
		light6=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T38;
			
			end
		
		end
		
		
		T38: begin //3
		next_state=T38;
			light7=1;
			if(loop_counter==0) begin
				light1=1;
				light6=1;
			end
			if(loop_counter==1) begin
				light2=1;
				light5=1;
			end
			if(loop_counter==2) begin
				light3=1;
				light4=1;
			end
			if(ms_counter==SIXTEENTH_NOTE) begin
				ms_reset=1;
				next_state=T39;
			end
		end
		
		T39: begin //4
		next_state=T39;
			if(loop_counter==0) begin
				light1=1;
				light6=1;
			end
			if(loop_counter==1) begin
				light2=1;
				light5=1;
			end
			if(loop_counter==2) begin
				light3=1;
				light4=1;
			end
			if(ms_counter==SIXTEENTH_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T38;
				if(loop_counter==2) begin
					loop_reset=1;
					next_state=T40;
				end
			end
		end
		
		T40: begin //e
		next_state=T40;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T41;
			end
		end
		
		T41: begin
		next_state=T41;
			light8=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T42;
			end
		end
		
		T42: begin
		next_state=T42;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T43;
				if(loop_counter3==1 && loop_counter2==3) begin
					loop_reset2=1;
					loop_reset=1;
					next_state=T90;
				end
			end
		end
		
		T43: begin
		next_state =T43;
			light5=1;
			light4=1;
			if(ms_counter<SIXTEENTH_NOTE)
				light7=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T44;
			end
		end
		
		T44: begin
		next_state=T44;
			light2=1;
			light3=1;
			if(ms_counter>3*SIXTEENTH_NOTE)
				light7=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T45;
				
			end
		end
		
		T45: begin
		next_state=T45;
			light8=1;
			if(loop_counter2>=2 && ms_counter>EIGHTH_NOTE) begin
				light8=0;
			end
			
			light4=1;
			light5=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T46;
			end
		end
		
		T46: begin
		next_state=T46;
			if(loop_counter2>=2 && ms_counter<EIGHTH_NOTE) begin
				light8=1;
			end
			light2=1;
			light3=1;
			if(ms_counter==QUARTER_NOTE-THIRTYSECOND_NOTE) begin
				next_state=T18;
				loop_inc2=1;
				ms_reset=1;
				if(loop_counter2==3) begin
					next_state=T47;
					loop_reset2=1;
				end
			end
		end
		
		T47: begin //finish off the 32nd note
		next_state=T47;
			light2=1;
			light3=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				next_state=T48;
				ms_reset=1;
			end
		end
		
		T48: begin // long runs
		next_state=T48;
		if(loop_counter2<=1)
		light1=1;
		if(loop_counter2>=2)
			light6=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T49;
		end
		end
		
		T49: begin //
		next_state=T49;
		if(loop_counter2<=1)
		light2=1;
		if(loop_counter2>=2)
			light5=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T50;
		end
		end
		
		T50: begin //
		next_state=T50;
		if(loop_counter2<=1)
		light3=1;
		if(loop_counter2>=2)
			light4=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T51;
		end
		end
		
		T51: begin //
		next_state=T51;
		if(loop_counter2<=1)
		light4=1;
		if(loop_counter2>=2)
			light3=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T52;
		end
		end
		
		T52: begin //
		next_state=T52;
		if(loop_counter2<=1)
		light5=1;
		if(loop_counter2>=2)
			light2=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T53;
		end
		end
		
		T53: begin //
		next_state=T53;
		if(loop_counter2<=1) begin
			light6=1;
			if(ms_counter>TRIPLET_EIGHTH/2)
				light6=0;
		end
		if(loop_counter2>=2) begin
			light1=1;
			if(ms_counter>TRIPLET_EIGHTH/2)
				light1=0;
		end
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T54;
		end
		end
		
		T54: begin //
		next_state=T54;
		if(loop_counter2<=1)
		light6=1;
		if(loop_counter2>=2)
			light1=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T55;
		end
		end
		
		T55: begin //
		next_state=T55;
		if(loop_counter2<=1)
		light5=1;
		if(loop_counter2>=2)
			light2=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T56;
		end
		end
		
		T56: begin //
		next_state=T56;
		if(loop_counter2<=1)
		light4=1;
		if(loop_counter2>=2)
			light3=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T57;
		end
		end
		
		T57: begin //
		next_state=T57;
		if(loop_counter2<=1)
		light3=1;
		if(loop_counter2>=2)
			light4=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T58;
		end
		end
		
		T58: begin //
		next_state=T58;
		if(loop_counter2<=1)
		light2=1;
		if(loop_counter2>=2)
			light5=1;
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T59;
		end
		end
		
		T59: begin //
		next_state=T59;
		if(loop_counter2<=1) begin
			light1=1;
			if(ms_counter>TRIPLET_EIGHTH/2)
				light1=0;
		end
		if(loop_counter2>=2) begin
			light6=1;
			if(ms_counter>TRIPLET_EIGHTH/2)
				light6=0;
		end
		if(ms_counter==TRIPLET_EIGHTH)begin
			ms_reset=1;
			next_state=T60;
		end
		end
		
	
		T60: begin // long runs fast  -- CLAP!!!!!
		next_state=T60;
		if(loop_counter2<=1)
		light1=1;
		if(loop_counter2>=2)
			light6=1;
		if(ms_counter==TRIPLET_EIGHTH/2)begin
			ms_reset=1;
			next_state=T61;
		end
		end
		
		T61: begin //
		next_state=T61;
		if(loop_counter2<=1)
		light2=1;
		if(loop_counter2>=2)
			light5=1;
		if(ms_counter==TRIPLET_EIGHTH/2)begin
			ms_reset=1;
			next_state=T62;
		end
		end
		
		T62: begin //
		next_state=T62;
		if(loop_counter2<=1)
		light3=1;
		if(loop_counter2>=2)
			light4=1;
		if(ms_counter==TRIPLET_EIGHTH/2)begin
			ms_reset=1;
			next_state=T63;
		end
		end
		
		T63: begin //
		next_state=T63;
		if(loop_counter2<=1)
		light4=1;
		if(loop_counter2>=2)
			light3=1;
		if(ms_counter==TRIPLET_EIGHTH/2)begin
			ms_reset=1;
			next_state=T64;
		end
		end
		
		T64: begin //
		next_state=T64;
		if(loop_counter2<=1)
		light5=1;
		if(loop_counter2>=2)
			light2=1;
		if(ms_counter==TRIPLET_EIGHTH/2)begin
			ms_reset=1;
			next_state=T65;
		end
		end
		
		T65: begin //
		next_state=T65;
		if(loop_counter2<=1)
		light6=1;
		if(loop_counter2>=2)
			light1=1;
		if(ms_counter==TRIPLET_EIGHTH/2)begin
			ms_reset=1;
			next_state=T66;
		end
		end
		
		T66: begin //
		next_state=T66;
		if(loop_counter2<=1)
		light6=1;
		if(loop_counter2>=2)
			light1=1;
		if(ms_counter==TRIPLET_EIGHTH/2)begin
			ms_reset=1;
			next_state=T67;
		end
		end
		
		T67: begin //
		next_state=T67;
		if(loop_counter2<=1)
		light5=1;
		if(loop_counter2>=2)
			light2=1;
		if(ms_counter==TRIPLET_EIGHTH/2)begin
			ms_reset=1;
			next_state=T68;
		end
		end
		
		T68: begin //
		next_state=T68;
		if(loop_counter2<=1)
		light4=1;
		if(loop_counter2>=2)
			light3=1;
		if(ms_counter==TRIPLET_EIGHTH/2)begin
			ms_reset=1;
			next_state=T69;
		end
		end
		
		T69: begin //
		next_state=T69;
		if(loop_counter2<=1)
		light3=1;
		if(loop_counter2>=2)
			light4=1;
		if(ms_counter==TRIPLET_EIGHTH/2)begin
			ms_reset=1;
			next_state=T70;
		end
		end
		
		T70: begin //
		next_state=T70;
		if(loop_counter2<=1)
		light2=1;
		if(loop_counter2>=2)
			light5=1;
		if(ms_counter==TRIPLET_EIGHTH/2)begin
			ms_reset=1;
			next_state=T71;
		end
		end
		
		T71: begin //
		next_state=T71;
			if(loop_counter2<=1)begin
				light1=1;
				if(ms_counter>TRIPLET_EIGHTH/4)
				light1=0;
			end
			if(loop_counter2>=2)begin
				light6=1;
				if(ms_counter>TRIPLET_EIGHTH/4)
				light6=0;
			end
			if(ms_counter==TRIPLET_EIGHTH/2)begin
				ms_reset=1;
				next_state=T60;
				loop_inc=1;
				if(loop_counter==1) begin
					loop_inc2=1;
					loop_reset=1;
					next_state=T48;
					if(loop_counter2==3) begin
						loop_reset2=1;
						next_state=T72;
					end
				end
			end
		end
		
		T72: begin //End of runs -- "as long as you..."
		next_state=T72;
			light1=1;
			light6=1;
			if(ms_counter<SIXTEENTH_NOTE)
			light7=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T73;
			end
		end
		
		T73: begin
		next_state=T73;
			light1=1;
			light6=1;
			light2=1;
			light5=1;
			if(ms_counter<SIXTEENTH_NOTE)
			light7=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T74;
			end
		end
		
		T74: begin
		next_state=T74;
			light1=1;
			light6=1;
			light2=1;
			light5=1;
			light3=1;
			light4=1;
			if(ms_counter<SIXTEENTH_NOTE)
			light7=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T75;
			end
		end
		
		T75: begin
		next_state=T75;
			light1=1;
			light6=1;
			light2=1;
			light5=1;
			light3=1;
			light4=1;
			light8=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T76;
			end
		end
		
		T76: begin
		next_state=T76;
			light1=1;
			light6=1;
			light2=1;
			light5=1;
			light3=1;
			light4=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T77;
			end
		end
		
		T77: begin
		next_state=T77;
			light1=1;
			light6=1;
			light2=1;
			light5=1;
			light3=1;
			light4=1;
			if(ms_counter<EIGHTH_NOTE)
			light7=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T78;
			end
		end
		
		T78: begin
		next_state=T78;
			light1=1;
			light6=1;
			light2=1;
			light5=1;
			light3=1;
			light4=1;
			if(ms_counter>EIGHTH_NOTE)
			light7=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T88_1;
			end
		end
		
		T88_1: begin
		next_state=T88_1;
			light1=1;
			light6=1;
			light2=1;
			light5=1;
			light3=1;
			light4=1;
			if(ms_counter<QUARTER_NOTE)
			light8=1;
			if(ms_counter==HALF_NOTE) begin
				ms_reset=1;
				next_state=T79;
			end
		end
		
		T79: begin
		next_state=T79;
			light1=1;
			light6=1;
			light2=1;
			light5=1;
			if(ms_counter<SIXTEENTH_NOTE)
			light7=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T80;
			end
		end
		
		T80: begin
		next_state=T80;
			light1=1;
			light6=1;
			if(ms_counter<SIXTEENTH_NOTE)
			light7=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T81;
			end
		end
		
		T81: begin
		next_state=T81;
			if(ms_counter<SIXTEENTH_NOTE)
			light7=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T82;
			end
		end
		
		T82: begin
		next_state=T82;
			if(ms_counter<QUARTER_NOTE)
			light8=1;
			if(ms_counter==HALF_NOTE) begin
				ms_reset=1;
				next_state=T83;
			end
		end
		
		T83: begin
		next_state=T83;
			if(ms_counter<EIGHTH_NOTE)
			light7=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T84;
			end
		end
		
		T84: begin
		next_state=T84;
			if(ms_counter>EIGHTH_NOTE)
			light7=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T85;
			end
		end
			
		T85: begin
		next_state=T85;
			if(ms_counter<EIGHTH_NOTE)
			light8=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T86;
			end
		end

		T86: begin
		next_state=T86;
			if(ms_counter<EIGHTH_NOTE)
			light8=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T72;
				loop_inc=1;
				if(loop_counter==1) begin
					loop_reset=1;
					next_state=T87;
					if(loop_counter3==2) begin
						loop_reset3=1;
						next_state=T102;
					end
				end
			end
		end
		
		T87: begin
		next_state=T87;
			if(ms_counter==3*QUARTER_NOTE-SIXTEENTH_NOTE)begin
				ms_reset=1;
				next_state=T88;
			end
		end
		
		T88: begin
		next_state=T88;
			light1=1;
			if(ms_counter>1*THIRTYSECOND_NOTE)
			light2=1;
			if(ms_counter>2*THIRTYSECOND_NOTE)
			light3=1;
			if(ms_counter>3*THIRTYSECOND_NOTE)
			light4=1;
			if(ms_counter>4*THIRTYSECOND_NOTE)
			light5=1;
			if(ms_counter>5*THIRTYSECOND_NOTE)
			light6=1;
			if(ms_counter>6*THIRTYSECOND_NOTE)
			light7=1;
			if(ms_counter>7*THIRTYSECOND_NOTE)
			light8=1;
			if(ms_counter==QUARTER_NOTE)begin
				ms_reset=1;
				loop_inc3=1;
				next_state=T18;
			end
		end

		
		T90: begin
		next_state=T90;
			light1=1;
			light6=1;
			if(loop_counter>0) begin
				light2=1;
				light3=1;
				light4=1;
				light5=1;
			end
			if(loop_counter>1)
				light8=1;
				
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				if(loop_counter==2)begin
					next_state=T91;
					loop_reset=1;
				end
			end
		end
		
		T91: begin
		next_state=T91;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T92;
			end
		end
		
		T92: begin // clap section -- train of lights
		next_state=T92;
			if(loop_counter<5)
			light1=1;
			if(loop_counter>0 && loop_counter<6)
			light3=1;
			if(loop_counter>1)
			light5=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T93;
			end
		end
			
		T93: begin
		next_state=T93;
			if(loop_counter<5)
			light2=1;
			if(loop_counter>0 && loop_counter<6)
			light4=1;
			if(loop_counter >1)
			light6=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T92;
				loop_inc=1;
				if(loop_counter==6) begin
					loop_reset=1;
					next_state=T94;				
				end
			end
		end
			
		T94: begin
		next_state=T94;
			if(ms_counter==HALF_NOTE-EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T95;
			end
		end
		
		T95: begin //clap clap clap!
		next_state=T95;
			light1=1;
			light6=1;
			if(ms_counter == TRIPLET_EIGHTH/2|| (loop_counter>11 && ms_counter == TRIPLET_EIGHTH/4)) begin
				ms_reset=1;
				next_state=T96;
			end
		end
		
		T96: begin
		next_state=T96;
			light2=1;
			light5=1;
			if(ms_counter == TRIPLET_EIGHTH/2|| (loop_counter>11 && ms_counter == TRIPLET_EIGHTH/4)) begin
				ms_reset=1;
				next_state=T97;
			end
		end
		
		T97: begin
		next_state=T97;
			light3=1;
			light4=1;
			if(ms_counter == TRIPLET_EIGHTH|| (loop_counter>11 && ms_counter == TRIPLET_EIGHTH/2)) begin
				ms_reset=1;
				next_state=T98;
			end
		end
		
		T98: begin
		next_state=T98;
			light2=1;
			light5=1;
			if(ms_counter == TRIPLET_EIGHTH/2|| (loop_counter>11 && ms_counter == TRIPLET_EIGHTH/4)) begin
				ms_reset=1;
				next_state=T99;
			end
		end
		
		T99: begin
		next_state=T99;
			light1=1;
			light6=1;
			if(ms_counter == TRIPLET_EIGHTH/2 || (loop_counter>11 && ms_counter == TRIPLET_EIGHTH/4)) begin
				ms_reset=1;
				next_state=T95;
				loop_inc=1;
				if(loop_counter==15) begin
					loop_reset=1;
					next_state=T100;
				end
			end
		end
		
		T100: begin
		next_state=T100;
			if(ms_counter<THIRTYSECOND_NOTE&&loop_counter<8) begin
				light1=1;
				light2=1;
				light3=1;
				light4=1;
				light5=1;
				light6=1;
				light7=1;
				light8=1;
			end
			if(ms_counter==SIXTEENTH_NOTE) begin
				loop_inc=1;
				ms_reset=1;
				if(loop_counter==8) begin
					loop_reset=1;
					next_state=T101;
				end
			end
		end
		
		T101: begin
		next_state=T101;
			if(ms_counter==SIXTEENTH_NOTE)  begin
				ms_reset=1;
				next_state=T72;
				loop_inc3=1;
			end
		end
		
		T102: begin //done with song -- do little sparkle pattern or something
		next_state=T102;
			light1=1;
			light2=1;
			light3=1;
			light4=1;
			light5=1;
			light6=1;
			light7=1;
			light8=1;
			if(ms_counter==17274) begin
				ms_reset=1;
				next_state=T103;
			end
		end
		
		T103: begin
		next_state=T103;
			light1=1;
			light2=1;
			light3=1;
			light4=1;
			light5=1;
			//light6=1;
			light7=1;
			light8=1;
			if(ms_counter==2914) begin
				ms_reset=1;
				next_state=T104;
			end
		end
		
		T104: begin
		next_state=T104;
			light1=1;
			light2=1;
			light3=1;
			light4=1;
			light5=1;
			light6=1;
			light7=1;
			light8=1;
			if(ms_counter==8936) begin
				ms_reset=1;
				next_state=T105;
			end
		end
		
		T105: begin
		next_state=T105;
			light1=1;
			light2=1;
			light3=1;
			light4=1;
			light5=1;
			light6=1;
			light7=1;
			//light8=1;
			if(ms_counter==1746) begin
				ms_reset=1;
				next_state=T106;
			end
		end
		
		T106: begin
		next_state=T106;
			light1=1;
			light2=1;
			light3=1;
			light4=1;
			light5=1;
			light6=1;
			light7=1;
			light8=1;
			if(ms_counter==6192) begin
				ms_reset=1;
				next_state=T107;
			end
		end
		
		T107: begin
		next_state=T107;
			light1=1;
			//light2=1;
			light3=1;
			light4=1;
			light5=1;
			light6=1;
			light7=1;
			light8=1;
			if(ms_counter==2758) begin
				ms_reset=1;
				next_state=T108;
			end
		end
		
		T108: begin
		next_state=T108;
			light1=1;
			light2=1;
			light3=1;
			light4=1;
			light5=1;
			light6=1;
			light7=1;
			light8=1;
			if(ms_counter==10583) begin
				ms_reset=1;
				next_state=T109;
			end
		end
		
		T109: begin
		next_state=T109;
			//light1=1;
			light2=1;
			light3=1;
			light4=1;
			light5=1;
			light6=1;
			light7=1;
			light8=1;
			if(ms_counter==2263) begin
				ms_reset=1;
				next_state=T110;
			end
		end
		
		T110: begin
		next_state=T110;
			light1=1;
			light2=1;
			light3=1;
			light4=1;
			light5=1;
			light6=1;
			light7=1;
			light8=1;
			if(ms_counter==5263) begin
				ms_reset=1;
				next_state=T111;
			end
		end
	
		
		T111: begin
		next_state=T111;
			light1=1;
			light2=1;
			light3=1;
			light4=1;
			light5=1;
			light6=1;
			light7=1;
			light8=1;
			if(ms_counter==1263) begin
				ms_reset=1;
				next_state=T112;
			end
		end
		
		T112: begin
		next_state=T112;
			light1=1;
			light2=1;
			light3=1;
			//light4=1;
			light5=1;
			light6=1;
			light7=1;
			light8=1;
			if(ms_counter==2263) begin
				ms_reset=1;
				next_state=T113;
			end
		end
		
		T113: begin
		next_state=T113;
			light1=1;
			light2=1;
			light3=1;
			light4=1;
			light5=1;
			light6=1;
			light7=1;
			light8=1;
			if(ms_counter==7263) begin
				ms_reset=1;
				next_state=T114;
			end
		end
		
		T114: begin
		next_state=T114;
			light1=1;
			light2=1;
			light3=1;
			light4=1;
			light5=1;
			//light6=1;
			light7=1;
			light8=1;
			if(ms_counter==1263) begin
				ms_reset=1;
				next_state=T115;
			end
		end
		
		T115: begin
		next_state=T115;
			light1=1;
			light2=1;
			light3=1;
			light4=1;
			light5=1;
			light6=1;
			light7=1;
			light8=1;
			if(ms_counter==3263) begin
				ms_reset=1;
				next_state=T116;
			end
		end
		
		T116: begin
		next_state=T116;
			light1=1;
			light2=1;
			light3=1;
			light4=1;
			light5=1;
			light6=1;
			//light7=1;
			light8=1;
			if(ms_counter==963) begin
				ms_reset=1;
				next_state=T117;
			end
		end
		
		T117: begin
		next_state=T117;
			light1=1;
			light2=1;
			light3=1;
			light4=1;
			light5=1;
			light6=1;
			light7=1;
			light8=1;
			if(ms_counter==3263) begin
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
				if(ms_counter==QUARTER_NOTE) begin
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
