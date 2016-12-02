
module Trans_Syberian(go,finished,clk,rst_n,light1,light2,light3,light4,light5,light6,light7,light8);
    input logic go,clk,rst_n;
    output logic finished,light1,light2,light3,light4,light5,light6,light7,light8;
	 
	 
logic pre_light1,pre_light2,pre_light3,pre_light4;
logic finished_pre;
    
typedef enum logic[8:0]{IDLE,WAIT,T1_1,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13,T14,T15,T16,T17,T18,T19,T20,T21,T22,T23,T24,T25,T26,T27,T28,T29,T30,T31,T32,T33,T34,T35,T36,T37,T38,T39,T40,T41,T42,T43,T44,T45,T46,T47,T48,T49,T50,T51,T52,T53,A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,A21,A22,A23,A24,A25,A26,A27,A28,A29,A30,A31,A32,A33,A34,A35,A36,A37,A38,A39,A40,A41,A42,A43,A44,A45,A46,A47,A48,A49,A50,A51,A52,A53,A54,A55,A56,A57,A58,A59,A60,A61,A62,A63,A64,A65,A66,A67,A68,A69,A70,A71,A72,A73,A74,A75,A76,A77,A78,A79,A80,A81,A82,A83,A84,A85,A86,A87,A88,A89,A90,A91,A92,A93,A94,A95,A96,A97,A98,A99} state_t;
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

parameter INTRO_QUARTER=7330;
parameter INTRO_EIGHTH=INTRO_QUARTER/2;
parameter INTRO_HALF=INTRO_QUARTER*2;
parameter INTRO_WHOLE=INTRO_QUARTER*4;
parameter INTRO_SIXTEENTH=INTRO_QUARTER/4;
parameter INTRO_THIRTYSECOND=INTRO_QUARTER/8;


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

logic clk_rst;


//light 4 overhead
//light 3 icicles
//light 2 rails
//light 1 corners

always_comb begin
    next_state=IDLE;
    pre_light1=0;
	 pre_light2=0;
	 pre_light3=0;
	 pre_light4=0;
	 ms_reset=0;
	 loop_reset=0;
	 loop_reset2=0;
	 loop_reset3=0;
	 loop_inc=0;
	 loop_inc2=0;
	 loop_inc3=0;
	 finished_pre=0;
	 clk_rst=0;
    case(state)
        IDLE: begin
				//pre_light1=1;
					if(go==1) begin
							next_state=WAIT;
							ms_reset=1;
							loop_reset=1;
							loop_reset2=1;
							loop_reset3=1;
							clk_rst=1;
					 end
				
	    end
		 
		 WAIT: begin
			//pre_light2=1;
			loop_reset=1;
			loop_reset2=1;
			loop_reset3=1;
			next_state=WAIT;
			if(ms_counter>=20000) begin
				next_state=T1_1;    //Carrol of the bells
				ms_reset=1;
			end
		end
		 
		
		
		T1_1: begin//TRANS-SYBERIAN CHAROL OF THE BELLS INTRO pickup note
			next_state=T1_1;
			pre_light1=1;
			if(ms_counter==INTRO_EIGHTH) begin
				ms_reset=1;
				next_state=T1;
			end
		end
		 
		 T1: begin 
				next_state=T1;
				pre_light2=1;
				if(ms_counter==INTRO_EIGHTH) begin
					ms_reset=1;
					next_state=T2;
				end
			end 
			T2: begin 
			next_state=T2;
				pre_light4=1;
				if(ms_counter==INTRO_EIGHTH) begin
					ms_reset=1;
					next_state=T3;
				end
			end 
			T3: begin 
			next_state=T3;
				pre_light3=1;
				if(ms_counter==INTRO_EIGHTH) begin
					ms_reset=1;
					next_state=T4;
					if(loop_counter==3) begin
					loop_reset=1;
					next_state=T5;
				end	
			end
		end	

		 
		 
		 T4: begin 
		 next_state=T4;
				pre_light1=1;
				if(ms_counter==INTRO_EIGHTH) begin
					ms_reset=1;
					loop_inc=1;
					next_state=T1;
            end
			end
			
		T5: begin //intro pickup 
		next_state=T5;
			pre_light4=1;
			pre_light1=1;
			if(ms_counter==INTRO_SIXTEENTH+INTRO_THIRTYSECOND) begin
				ms_reset=1;
				next_state=T6;
			end
		end
		
		T6: begin // intro pickup off
		next_state=T6;
			pre_light1=1;
			if(ms_counter==INTRO_SIXTEENTH-INTRO_THIRTYSECOND) begin
				ms_reset=1;
				next_state=T7;
			end
		end
		
		T7: begin // 
		next_state=T7;
			pre_light2=1;
			pre_light4=1;
			if(ms_counter==INTRO_SIXTEENTH+INTRO_THIRTYSECOND) begin
				ms_reset=1;
				next_state=T8;
				
			end
		end
		
		T8: begin //
	next_state=T8;	
			pre_light2=1;
			if(ms_counter==INTRO_SIXTEENTH-INTRO_THIRTYSECOND) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T7;
				if(loop_counter==1)begin
					loop_reset=1;
					next_state=T9;
				end
				
			end
		end
		
		T9: begin
		next_state=T9;
			pre_light4=1;
			pre_light1=1;
			if(ms_counter==INTRO_SIXTEENTH+INTRO_THIRTYSECOND) begin
				ms_reset=1;
				next_state=T10;
			end
		end
		
		T10: begin //
	next_state=T10;	
			pre_light1=1;
			if(ms_counter==INTRO_SIXTEENTH-INTRO_THIRTYSECOND) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T9;
				if(loop_counter==1)begin
					loop_reset=1;
					next_state=T7;
					loop_inc2=1;
					if(loop_counter2==2)begin
						loop_reset2=1;
						next_state=T11;
					end
				end
			end
		end
		
		T11: begin //
		next_state=T11;
		pre_light2=1;
		pre_light4=1;
		if(ms_counter==INTRO_QUARTER)begin
			ms_reset=1;
			next_state=T12;
		end
		end
		
		T12: begin //
		next_state=T12;
		pre_light1=1;
		pre_light4=1;
		if(ms_counter==INTRO_QUARTER)begin
			ms_reset=1;
			next_state=T13;
		end
		end
		
		T13: begin
		next_state=T13;
		pre_light2=1;
		if(loop_counter==0)
		pre_light4=1;
		if(ms_counter==INTRO_QUARTER)begin
			ms_reset=1;
			next_state=T14;
		end
		end
		
		T14: begin
		next_state=T14;
		pre_light1=1;
		if(loop_counter==0)
			pre_light4=1;
		if(ms_counter==INTRO_EIGHTH&& loop_counter==2) begin
			ms_reset=1;
			next_state = T15;
			loop_reset=1;
		end
		if(ms_counter==INTRO_QUARTER)begin
			ms_reset=1;
			next_state=T13;
			loop_inc=1;
			if(loop_counter==2) begin
				loop_reset=1;
				next_state=T15;
			end
		end
		end
		
		T15: begin //intro pickup 
		next_state=T15;
			pre_light4=1;
			pre_light1=1;
			if(ms_counter==INTRO_SIXTEENTH+INTRO_THIRTYSECOND) begin
				ms_reset=1;
				next_state=T16;
			end
		end
		
		T16: begin // intro pickup off
		next_state=T16;
			pre_light1=1;
			if(ms_counter==INTRO_SIXTEENTH-INTRO_THIRTYSECOND) begin
				ms_reset=1;
				next_state=T17;
			end
		end
		
		T17: begin // 
		next_state=T17;
			pre_light2=1;
			pre_light4=1;
			if(ms_counter==INTRO_SIXTEENTH+INTRO_THIRTYSECOND) begin
				ms_reset=1;
				next_state=T18;
				
			end
		end
		
		T18: begin // 
		next_state=T18;
			pre_light2=1;
			if(ms_counter==INTRO_SIXTEENTH-INTRO_THIRTYSECOND) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T17;
				if(loop_counter==1)begin
					loop_reset=1;
					next_state=T19;
				end
				
			end
		end
		
		T19: begin
		next_state=T19;
			pre_light4=1;
			pre_light1=1;
			if(loop_counter2==1 && loop_counter==1)
			pre_light3=1;
			if(ms_counter==INTRO_SIXTEENTH+INTRO_THIRTYSECOND) begin
				ms_reset=1;
				next_state=T20;
			end
		end
		
		T20: begin //
	next_state=T20;	
			pre_light1=1;
			if(ms_counter==INTRO_SIXTEENTH-INTRO_THIRTYSECOND) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T19;
				if(loop_counter==1)begin
					loop_reset=1;
					next_state=T17;
					loop_inc2=1;
					if(loop_counter2==1)begin
						loop_reset2=1;
						next_state=T21;
					end
				end
			end
		end
		
		T21: begin //flute start
		next_state=T21;	
		pre_light2=1;
		pre_light3=1;
		if(loop_counter2==0)
		pre_light4=1;
		if(ms_counter==INTRO_SIXTEENTH+INTRO_THIRTYSECOND)begin
			ms_reset=1;
			next_state=T22;
		end
		end
		
		T22: begin //
		next_state=T22;
		pre_light2=1;
		if(loop_counter2==0)
		pre_light4=1;
		if(ms_counter==INTRO_SIXTEENTH-INTRO_THIRTYSECOND)begin
			ms_reset=1;
			next_state=T21;
			loop_inc=1;
			if(loop_counter==1) begin
				loop_reset=1;
				next_state=T23;
			end
		end
		end
		
		T23: begin //
		next_state=T23;
		pre_light1=1;
		pre_light3=1;
		if(loop_counter2==0)
		pre_light4=1;
		if(loop_counter2==1 && loop_counter==1)
		pre_light4=1;
		if(ms_counter==INTRO_SIXTEENTH+INTRO_THIRTYSECOND)begin
			ms_reset=1;
			next_state=T24;
		end
		end
		
		T24: begin //
		next_state=T24;
		pre_light1=1;
		if(loop_counter2==0)
		pre_light4=1;
		if(ms_counter==INTRO_SIXTEENTH-INTRO_THIRTYSECOND)begin
			ms_reset=1;
			loop_inc=1;
			next_state=T23;
			if(loop_counter==1) begin
				loop_reset=1;
				next_state=T21;
				loop_inc2=1;
				if(loop_counter2==1) begin
					loop_reset2=1;
					next_state=T25;
				end
			end
		end
		end
		
		
		
		T25: begin //cello start again
		next_state=T25;
		pre_light2=1;
		pre_light4=1;
		if(loop_counter2==0)
		pre_light3=1;
		if(ms_counter==INTRO_SIXTEENTH+INTRO_THIRTYSECOND) begin
			ms_reset=1;
			next_state=T26;
		end
		end
		
		T26: begin
		next_state=T26;
		pre_light2=1;
		if(loop_counter2==0)
		pre_light3=1;
		if(ms_counter==INTRO_SIXTEENTH-INTRO_THIRTYSECOND) begin
			ms_reset=1;
			loop_inc=1;
			next_state=T25;
			if(loop_counter==1)begin
				loop_reset=1;
				next_state=T27;
			end
		end
		end
		
		
		T27: begin // 
		next_state=T27;
			pre_light1=1;
			pre_light4=1;
			if(loop_counter2==0)
		pre_light3=1;
			if(loop_counter2==1 && loop_counter==1)
			pre_light3=1;
			if(ms_counter==INTRO_SIXTEENTH+INTRO_THIRTYSECOND) begin
				ms_reset=1;
				next_state=T28;
			end
		end
		
		
		
		T28: begin // 
		next_state=T28;
			pre_light1=1;
			if(loop_counter2==0)
		pre_light3=1;
			if(ms_counter==INTRO_SIXTEENTH-INTRO_THIRTYSECOND) begin
				ms_reset=1;
				loop_inc=1;
				next_state=T27;
				if(loop_counter==1)begin
					loop_reset=1;
					next_state=T25;
					loop_inc2=1;
					if(loop_counter2==1)begin
						loop_reset2=1;
						next_state=T29;
					end
				end
				
			end
		end
		
		T29: begin // flute begin 2nd time
		next_state=T29;
			pre_light3=1;
			pre_light2=1;
			if(loop_counter2==0)
			pre_light4=1;
			if((loop_counter2==0 && ms_counter==INTRO_SIXTEENTH+INTRO_THIRTYSECOND) || (loop_counter==0 && ms_counter==INTRO_EIGHTH) || ms_counter==INTRO_EIGHTH+INTRO_SIXTEENTH) begin
				ms_reset=1;
				next_state=T30;
			end
		end
		
		
		T30: begin //
		next_state=T30;
		pre_light2=1;
		if(loop_counter2==0)
		pre_light4=1;
		if(ms_counter==INTRO_SIXTEENTH-INTRO_THIRTYSECOND)begin
			ms_reset=1;
			next_state=T29;
			loop_inc=1;
			if(loop_counter==1) begin
				loop_reset=1;
				next_state=T31;
			end
		end
		end
		
		T31: begin //
		next_state=T31;
		pre_light1=1;
		pre_light3=1;
		if(loop_counter2==0)
		pre_light4=1;
		if((loop_counter2==0 && ms_counter==INTRO_SIXTEENTH+INTRO_THIRTYSECOND) ||(loop_counter==0 && ms_counter==INTRO_EIGHTH) || ms_counter==INTRO_HALF+INTRO_EIGHTH)begin
			ms_reset=1;
			next_state=T32;
		end
		end
		
		T32: begin //
		next_state=T32;
		pre_light1=1;
		if(loop_counter2==0)
			pre_light4=1;
		if((loop_counter2==0 && ms_counter==INTRO_SIXTEENTH-INTRO_THIRTYSECOND) || (loop_counter==0 && ms_counter==INTRO_EIGHTH) || ms_counter==INTRO_HALF+INTRO_EIGHTH)begin
			ms_reset=1;
			loop_inc=1;
			next_state=T31;
			if(loop_counter==1) begin
				loop_reset=1;
				next_state=T29;
				loop_inc2=1;
				if(loop_counter2==1) begin
					loop_reset2=1;
					next_state=T33;
				end
			end
		end
		end
		
		T33: begin // begin the drum base 1, (start loop)
		next_state=T33;
			pre_light2=1;
			if(loop_counter==2 || loop_counter==4) //chimes
			pre_light4=1;
			if(loop_counter==2 || loop_counter==4) //strings
			pre_light3=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T34;
			end
		end
		
		T34: begin //2
		next_state=T34;
			pre_light1=1;
			if(loop_counter==2 || loop_counter==4) //chimes
			pre_light4=1;
			if(loop_counter==2 || loop_counter==4) //strings
			pre_light3=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T35;
			end
		end
		
		T35: begin //e
		next_state=T35;
			pre_light2=1;
			if(loop_counter==2 || loop_counter==4) //strings
			pre_light3=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T36;
			end
		end
		
		T36: begin //and
		next_state=T36;
			pre_light1=1;
			if(loop_counter==2 || loop_counter==4) //chimes
			pre_light4=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T37;
			end
		end
		
		T37: begin //a
		next_state=T37;
			pre_light2=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T38;
			end
		end
		
		T38: begin //3
		next_state=T38;
			pre_light1=1;
			if(loop_counter==2 || loop_counter==4) //chimes
			pre_light4=1;
			if(loop_counter==2 || loop_counter==4) //strings
			pre_light3=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T39;
			end
		end
		
		T39: begin //4
		next_state=T39;
			pre_light2=1;
			if(loop_counter==2 || loop_counter==4) //strings
			pre_light3=1;
			if(loop_counter==2 || loop_counter==4) //chimes
			pre_light4=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T40;
			end
		end
		
		T40: begin //e
		next_state=T40;
			pre_light1=1;
			if(loop_counter==2 || loop_counter==4) //strings
			pre_light3=1;
	
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T41;
			end
		end
		
		T41: begin //and
		next_state=T41;
			pre_light2=1;
			if(loop_counter==2 || loop_counter==4) //chimes
			pre_light4=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T42;
			end
		end
		
		T42: begin //a
		next_state=T42;
			pre_light1=1;

			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T43;
			end
		end
		
		T43: begin //5
		next_state=T43;
			pre_light2=1;
			if(loop_counter==2 || loop_counter==4) //chimes
			pre_light4=1;
			if(loop_counter==2 || loop_counter==4) //strings
			pre_light3=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=T44;
			end
		end
		
		T44: begin // 6
		next_state=T44;
			pre_light1=1;
			if(loop_counter==2 || loop_counter==4) //strings
			pre_light3=1;
			if(loop_counter==2 || loop_counter==4) //chimes
			pre_light4=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T45;
			end
		end
		
		T45: begin // e
		next_state=T45;
			pre_light2=1;
			if(loop_counter==2 || loop_counter==4) //strings
			pre_light3=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T46;
			end
		end
		
		T46: begin // and
		next_state=T46;
			pre_light1=1;
			if(loop_counter==2 || loop_counter==4) //chimes
			pre_light4=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T47;
			end
		end
		
		T47: begin // a
		next_state=T47;
			pre_light2=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T48;
			end
		end
		
		T48: begin // 7 flash
		next_state=T48;
			pre_light2=1;
			pre_light1=1;
			if(loop_counter==2 || loop_counter==4) //strings
			pre_light3=1;
			if(loop_counter==2 || loop_counter==4) //chimes
			pre_light4=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T49;
			end
		end
		
		T49: begin // and
		next_state=T49;
		if(loop_counter==2 || loop_counter==4) //chimes
			pre_light4=1;
			if(loop_counter==2 || loop_counter==4) //strings
			pre_light3=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T50;
			end
		end
		
		T50: begin // 8 flash
		next_state=T50;
		if(loop_counter==2 || loop_counter==4) //chimes
			pre_light4=1;
			pre_light2=1;
			pre_light1=1;
			if(loop_counter==2 || loop_counter==4) //strings
			pre_light3=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T51;
			end
		end
		
		T51: begin // and
		next_state=T51;
		if(loop_counter==2 || loop_counter==4) //strings
			pre_light3=1;
		if(loop_counter==2 || loop_counter==4) //chimes
			pre_light4=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T52;
			end
		end
		
		T52: begin // 9 flash
		next_state=T52;
		if(loop_counter==2 || loop_counter==4) //strings
			pre_light3=1;
			pre_light2=1;
			pre_light1=1;
			if((loop_counter==1 || loop_counter==3) && loop_counter3==0) //chimes
			pre_light4=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T53;
			end
		end
		
		T53: begin // and (end loop)
		next_state=T53;
		if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=T33;
				loop_inc=1;
				if(loop_counter==1 && loop_counter3==1) begin //next part of song -- after 2:05
					loop_reset=1;
					next_state=A47;
				end
				if(loop_counter==5) begin
					loop_reset=1;
					next_state=A1;
				end
				
			end
		end
					
					
		
		
			
			A1: begin
			next_state=A1;
				pre_light3=1;
				if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=A2;
				end
			end
			
			A2: begin
			next_state=A2;
				pre_light2=1;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A3;
				end
			end
			
			A3: begin
			next_state=A3;
				pre_light3=1;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A4;
				end
			end
			
			A4: begin
			next_state=A4;
				pre_light1=1;
				if(ms_counter==QUARTER_NOTE) begin
					ms_reset=1;
					loop_inc=1;
					if(loop_counter==3) begin
                  next_state=A5;
						loop_reset=1;
					end
					else
						next_state=A1;
            end
			end
			
					
			A5: begin 
			next_state=A5;
				pre_light4=1;
				if(ms_counter==QUARTER_NOTE) begin
					ms_reset=1;
					next_state=A6;
				end
			end
			
			A6: begin
			next_state=A6;
				pre_light3=1;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A7;
				end
			end
			
			A7: begin
			next_state=A7;
				pre_light4=1;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A8;
				end
			end
			
			A8: begin
			next_state=A8;
				pre_light2=1;
				if(ms_counter==QUARTER_NOTE) begin
					ms_reset=1;
					loop_inc=1;
					if(loop_counter==3) begin
                  next_state=A9;
						loop_reset=1;
					end
					else
						next_state=A5;
            end
			end
			
			A9: begin 
			next_state=A9;
				pre_light1=1;
				pre_light2=1;
				pre_light3=1;
				pre_light4=1;
				if(ms_counter==QUARTER_NOTE) begin
					ms_reset=1;
					next_state=A10;
				end
			end
			
			A10: begin
			next_state=A10;
				pre_light3=1;
				pre_light2=1;
				pre_light1=1;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A11;
				end
			end
			
			A11: begin
			next_state=A11;
				pre_light2=1;
				pre_light1=1;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A12;
				end
			end
			
			A12: begin
			next_state=A12;
				pre_light1=1;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A13;
				end
			end
			
			A13: begin
			next_state=A13;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					loop_inc=1;
					if(loop_counter==2) begin
                  next_state=A14;
						loop_reset=1;
					end
					else
						next_state=A9;
            end
			end
			
			A14: begin
			next_state=A14;
				pre_light4=1;
				pre_light3=1;
				pre_light2=1;
				pre_light1=1;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A15;
				end
			end
			
			A15: begin
			next_state=A15;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					loop_inc=1;
					if(loop_counter==2) begin
                  next_state=A16;
						loop_reset=1;
					end
					else
						next_state=A14;
            end
			end
			
			A16: begin
		next_state=A16;	
				pre_light1=1;
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					next_state=A17;
				end
			end
			
			A17: begin
			next_state=A17;
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					loop_inc=1;
					if(loop_counter==1) begin
						next_state=A18;
						loop_reset=1;
					end
					else
						next_state=A16;
				end
			end
			
			A18: begin 
			next_state=A18;
				pre_light2=1;
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					next_state=A19;
				end
			end
			
			A19: begin
			next_state=A19;
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					loop_inc=1;
					next_state=A18;
					if(loop_counter==1) begin
						next_state=A20;
						loop_reset=1;
					end

				end
			end
			
			A20: begin 
			next_state=A20;
				pre_light3=1;
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					next_state=A21;
				end
			end
			
			A21: begin
			next_state=A21;
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					loop_inc=1;
					next_state=A20;
					if(loop_counter==1) begin
						next_state=A22;
						loop_reset=1;
					end
				end
			end
			
			A22: begin 
			next_state=A22;
				pre_light4=1;
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					next_state=A23;
				end
			end
			
			A23: begin
			next_state=A23;
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					loop_inc=1;
					if(loop_counter==1) begin
						next_state=A24;
						loop_reset=1;
					end
					else
						next_state=A22;
				end
			end
			
			A24: begin
			next_state=A24;
				pre_light1=1;
				pre_light2=1;
				pre_light3=1;
				pre_light4=1;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A25;
				end
			end
			
			A25: begin
			next_state=A25;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					loop_inc=1;
					if(loop_counter==1) begin
                  next_state=A16;
						loop_reset=1;
						loop_inc2=1;
						if(loop_counter2==1) begin //done with 2nd time guitar run
							next_state=A26;
							loop_reset2=1;
						end
					end
					else
						next_state=A24;
            end
			end
			
			 A26: begin //fast runs
			next_state=A26;
			pre_light1=1;
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					next_state=A27;
				end
			end
			
			A27: begin
				next_state=A27;
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					next_state=A26;
					loop_inc=1;
					if(loop_counter==1) begin //2 flashes first note
						loop_reset=1;
						next_state=A28;
					end
				end
			end
			
			A28: begin
				next_state=A28;
				pre_light2=1;
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					next_state=A29;
				end
			end
			
			A29: begin
				next_state=A29;
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					next_state=A28;
					loop_inc=1;
					if(loop_counter==1) begin //2 flashes 2nd note
						loop_reset=1;
						next_state=A30;
					end
				end
			end
			
			A30: begin
				next_state=A30;
				pre_light3=1;
				if(loop_counter==0 && loop_counter2==3) //piano goes in
				pre_light4=1;
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					next_state=A31;
				end
			end
			
			A31: begin
				next_state=A31;
				if(loop_counter==0 && loop_counter2==3) //piano goes in
				pre_light4=1;
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					next_state=A30;
					loop_inc=1;
					if(loop_counter==1) begin //2 flashes 3rd note
						loop_reset=1;
						next_state=A26; // back to run
						loop_inc2=1;
						if(loop_counter2==3) begin //4 fast runs done
							loop_reset2=1;
							next_state=A32;
						end
					end
				end
			end
			
			A32: begin //piano/ guitar trade-off
				next_state=A32;
				pre_light4=1;
				if(loop_counter2!=0) begin //guitar
					pre_light1=1;
					pre_light2=1;
				end
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A33;
				end
			end
			
			A33: begin
				next_state=A33;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A34;
				end
			end
			
			A34: begin
				next_state=A34;
				if(loop_counter2==0 || loop_counter2==2) begin
					pre_light4=1;
				end
				if(loop_counter2==1 || loop_counter2==3) begin
					pre_light2=1;
					pre_light1=1;
				end
				if(ms_counter==EIGHTH_NOTE-5) begin //offset ... it rushese for some reason? TODO
					ms_reset=1;
					next_state=A35;
				end
			end
			
			A35: begin
				next_state=A35;
				if(ms_counter==EIGHTH_NOTE-5) begin//offset ... it rushese for some reason? TODO
					ms_reset=1;
					loop_inc=1;
					next_state=A34;
					if(loop_counter==9)begin // 2nd to last
						loop_reset=1;
						next_state=A36;
					end
				end
			end
			
			A36: begin
				next_state=A36;
				pre_light1=1;
				pre_light2=1;
				if(loop_counter2!=3) // light flashes all but last
				pre_light4=1;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A37;
				end
			end
			
			A37: begin
				next_state=A37;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A32; //back to beginning
					loop_inc2=1;
					if(loop_counter2==3) begin
						loop_reset2=1;
						next_state=A38;
					end
				end
			end
			
			A38: begin // melody loop with piano hits
				if(loop_counter<12)
					pre_light3=1;
				next_state=A38;
				if(loop_counter>3 && loop_counter<12)
				pre_light4=1;
				if(loop_counter>11 &&  loop_counter%2==0) begin
					pre_light4=1;
				end
				if(loop_counter>11 &&  loop_counter%2==1) begin
					pre_light2=1;
					pre_light1=1;
				end
				if(loop_counter>11 && loop_counter%2==2) begin
					pre_light3=1;
				end
				if(loop_counter>11 &&loop_counter%2==3) begin
					pre_light1=1;
					pre_light2=1;
				end
				if(ms_counter==QUARTER_NOTE) begin
					ms_reset=1;
					next_state=A39;
				end
			end
			
			A39: begin
				next_state=A39;
				if(loop_counter<12)
					pre_light2=1;
				if(loop_counter>3 && loop_counter<12)
				pre_light4=1;
				if(loop_counter>11 &&loop_counter%2==0) begin
					pre_light4=1;
				end
				if(loop_counter>11 && loop_counter%2==1) begin
					pre_light2=1;
					pre_light1=1;
				end
				if(loop_counter>11 && loop_counter%2==2) begin
					pre_light3=1;
				end
				if(loop_counter>11 &&loop_counter%2==3) begin
					pre_light1=1;
					pre_light2=1;
				end
				if(ms_counter==EIGHTH_NOTE-6) begin //TODO: adjust offset
					ms_reset=1;
					next_state=A40;
				end
			end
			
			A40: begin
				next_state=A40;
				if(loop_counter<12)
					pre_light3=1;
				if(loop_counter>11 &&  loop_counter%2==0) begin
					pre_light4=1;
				end
				if(loop_counter>11 &&  loop_counter%2==1) begin
					pre_light2=1;
					pre_light1=1;
				end
				if(loop_counter>11 && loop_counter%2==2) begin
					pre_light3=1;
				end
				if(loop_counter>11 && loop_counter%2==3) begin
					pre_light1=1;
					pre_light2=1;
				end
				if(ms_counter==EIGHTH_NOTE-6) begin
					ms_reset=1;
					next_state=A41;
				end
			end
			
			A41: begin
				if(loop_counter<12)
					pre_light1=1;
				if(loop_counter>11 &&  loop_counter%2==0) begin
					pre_light4=1;
				end
				if(loop_counter>11 &&  loop_counter%2==1) begin
					pre_light2=1;
					pre_light1=1;
				end
				if(loop_counter>11 && loop_counter%2==2) begin
					pre_light3=1;
				end
				if(loop_counter>11 &&  loop_counter%2==3) begin
					pre_light1=1;
					pre_light2=1;
				end
				if(loop_counter>2 && loop_counter<12) // 1 less than the rest for the pickup note
				pre_light4=1;
				next_state=A41;
				if(ms_counter==EIGHTH_NOTE-6) begin
					ms_reset=1;
					next_state=A42;
				end
			end
			
			A42: begin
				if(loop_counter<12)
					pre_light1=1;
				if(loop_counter>11 && loop_counter%2==0) begin
					pre_light4=1;
				end
				if(loop_counter>11 &&  loop_counter%2==1) begin
					pre_light2=1;
					pre_light1=1;
				end
				if(loop_counter>11 && loop_counter%2==2) begin
					pre_light3=1;
				end
				if(loop_counter>11 && loop_counter%2==3) begin
					pre_light1=1;
					pre_light2=1;
				end
				next_state=A42;
				if(ms_counter==EIGHTH_NOTE-6) begin
					ms_reset=1;
					loop_inc=1;
					next_state=A38;
					if(loop_counter==19) begin
						loop_reset=1;
						next_state=A43;
					end
				end
			end
			
			A43: begin // after chimes
				next_state=A43;
				pre_light4=1;
				pre_light2=1;
				pre_light3=1;
				//pre_light1=1;
				if(ms_counter==EIGHTH_NOTE-5) begin //TODO offset adjust
					ms_reset=1;
					next_state=A44;
				end
			end
			
			A44: begin
				next_state=A44;
				pre_light4=1;
				pre_light2=1;
				//pre_light3=1;
				pre_light1=1;
				if(ms_counter==EIGHTH_NOTE-5) begin
					ms_reset=1;
					next_state=A45;
				end
			end
			
			A45: begin 
				next_state=A45;
				pre_light4=1;
				//pre_light2=1;
				pre_light3=1;
				pre_light1=1;
				if(ms_counter==EIGHTH_NOTE-5) begin
					ms_reset=1;
					next_state=A46;
				end
			end
			
			A46: begin 
				next_state=A46;
				//pre_light4=1;
				pre_light2=1;
				pre_light3=1;
				pre_light1=1;
				if(ms_counter==EIGHTH_NOTE-5) begin
					ms_reset=1;
					loop_inc=1;
					next_state=A43;
					if(loop_counter==11) begin
						loop_reset=1;
						next_state=T33; //bass drum line
						loop_inc3=1; //set flag for begin in next part of song
					end
				end
			end
			
			A47: begin //begin guitar hits
				next_state=A47;
					pre_light1=1;
				if(loop_counter>3)
					pre_light2=1;
				if(loop_counter>7)
					pre_light3=1;
				if(loop_counter>11)
					pre_light4=1;
				if(ms_counter==HALF_NOTE) begin
					ms_reset=1;
					next_state=A48;
				end
			end
			
			A48: begin
				next_state=A48;
				if(ms_counter==QUARTER_NOTE) begin
					loop_inc=1;
					ms_reset=1;
					next_state=A47;
					if(loop_counter==15) begin
						loop_reset=1;
						next_state=A49;
					end
				end
			end
			
			A49: begin // melody: I want a double cheeseburger...
				next_state=A49;
				if(loop_counter==0)
					pre_light4=1;
				if(loop_counter==1)
					pre_light3=1;
				if(loop_counter==2)
					pre_light2=1;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A50;
				end
			end
			
			A50: begin
				next_state=A50;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A51;
				end
			end
			
			A51: begin //4th note 2x
				next_state=A51;
				if(loop_counter==0)
					pre_light4=1;
				if(loop_counter==1)
					pre_light3=1;
				if(loop_counter==2)
					pre_light2=1;
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					next_state=A52;
				end
			end
			
			A52: begin
				next_state=A52;
				if(ms_counter==SIXTEENTH_NOTE) begin
					next_state=A53;
					ms_reset=1;
				end
			end
			
			A53: begin
				next_state=A53;
				if(loop_counter==0)
					pre_light4=1;
				if(loop_counter==1)
					pre_light3=1;
				if(loop_counter==2)
					pre_light2=1;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A54;
				end
			end
			
			A54: begin
				next_state=A54;
				if(loop_counter==0)
					pre_light3=1;
				if(loop_counter==1)
					pre_light2=1;
				if(loop_counter==2)
					pre_light3=1;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A55;
				end
			end
			
			A55: begin
				next_state=A55;
				if(loop_counter==0)
					pre_light2=1;
				if(loop_counter==1)
					pre_light1=1;
				if(loop_counter==2)
					pre_light2=1;
				if(ms_counter==EIGHTH_NOTE) begin
					ms_reset=1;
					next_state=A49;
					loop_inc=1;
					if(loop_counter==2) begin
						loop_reset=1;
						next_state=A56;
					end
				end
			end
			
			
		A56: begin
			pre_light1=1;
			next_state=A56;
			if(loop_counter==0 || loop_counter==3) begin
				if(ms_counter==EIGHTH_NOTE-5) begin //TODO: change offset
					ms_reset=1;
					next_state=A57;
				end
			end
			else begin // loop is 1 or 2
				if(ms_counter==SIXTEENTH_NOTE) begin
					ms_reset=1;
					next_state=A57;
				end
			end
		end
		
		A57: begin
			next_state=A57;
			if(loop_counter==0 || loop_counter==3) begin
				if(ms_counter==EIGHTH_NOTE-5) begin
					loop_inc=1;
					ms_reset=1;
					next_state=A56;
					if(loop_counter==3) begin
						loop_reset=1;
						next_state=A58;
					end
				end
			end
			else begin // loop is 1 or 2
				if(ms_counter==SIXTEENTH_NOTE) begin
					loop_inc=1;
					ms_reset=1;
					next_state=A56;
				end
			end
		end
		
		A58: begin //runs
			next_state=A58;
			pre_light1=1;
			if(loop_counter>1)
				pre_light2=1;
			if(loop_counter>3)
				pre_light3=1;
			if(loop_counter>5)
				pre_light4=1;
			if(ms_counter==SIXTEENTH_NOTE) begin
				ms_reset=1;
				next_state=A59;
			end
		end
		
		A59: begin
			next_state=A59;
			if(loop_counter>1 && loop_counter<7)
				pre_light1=1;
			if(loop_counter>3&& loop_counter<7)
				pre_light2=1;
			if(loop_counter>5&& loop_counter<7)
				pre_light3=1;
			if(ms_counter==SIXTEENTH_NOTE) begin
				ms_reset=1;
				next_state=A58;
				loop_inc=1;
				if(loop_counter==7) begin
					next_state=A60;
					loop_reset=1;
				end
			end
		end
		
		A60: begin //flash
			next_state=A60;
			pre_light1=1;
			pre_light2=1;
			pre_light3=1;
			pre_light4=1;
			if(ms_counter==EIGHTH_NOTE-10) begin
				next_state=A61;
				ms_reset=1;
			end
		end
		
		A61: begin
			next_state=A61;
			if(ms_counter==EIGHTH_NOTE-10) begin
				ms_reset=1;
				next_state=A60;
				loop_inc=1;
				if(loop_counter==1) begin //2nd flash
					loop_reset=1;
					next_state=A58;
					loop_inc2=1;
					if(loop_counter2==1) begin //2nd run
						loop_reset2=1;
						next_state=A62;
						if(loop_counter3==2) begin //jump to end of song
							next_state=A68;
							loop_reset3=1;
						end
					end
				end
			end
		end
		
		A62: begin  //pause then hits
			next_state=A62;
			if(ms_counter==HALF_NOTE+QUARTER_NOTE) begin
				next_state=A63;
				ms_reset=1;
			end
		end
		
		A63: begin
			next_state=A63;
			pre_light3=1;
			if(loop_counter>1)
			pre_light1=1;
			if(loop_counter>2)
			pre_light2=1;
			if(loop_counter>3)
			pre_light4=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=A64;
			end
		end
		
		A64: begin
			next_state=A64;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=A65;
			end
		end
		
		A65: begin
			next_state=A65;
			pre_light2=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=A66;
			end
		end
		
		A66: begin
			next_state=A66;
			pre_light3=1;
			if(ms_counter==EIGHTH_NOTE) begin
				ms_reset=1;
				next_state=A67;
			end
		end
		
		A67: begin
			next_state=A67;
			pre_light1=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				loop_inc=1;
				next_state=A62;
				if(loop_counter>0)
					next_state=A63;
				if(loop_counter==5) begin
					loop_reset=1;
					next_state=A49;
					loop_inc3=1;
				end
			end
		end
			
		A68: begin // runs
			next_state=A68;
			pre_light1=1;
			if(loop_counter>1)
				pre_light2=1;
			if(loop_counter>3)
				pre_light3=1;
			if(ms_counter==SIXTEENTH_NOTE) begin
				ms_reset=1;
				next_state=A69;
			end
		end
		
		A69: begin
			next_state=A69;
			if(loop_counter>1)
				pre_light1=1;
			if(loop_counter>3)
				pre_light2=1;
			if(ms_counter==SIXTEENTH_NOTE) begin
				ms_reset=1;
				next_state=A68;
				loop_inc=1;
				if(loop_counter==5) begin
					next_state=A68;
					loop_reset=1;
					loop_inc2=1;
					if(loop_counter2==3) begin
						loop_reset2=1;
						next_state=A70;
					end
				end
			end
		end
		
		A70: begin //flash
			next_state=A70;
			if(loop_counter>2 || loop_counter==1)
			pre_light1=1;
			if(loop_counter>2 || loop_counter==1)
			pre_light2=1;
			if(loop_counter>3 || loop_counter==0 || loop_counter==2)
			pre_light3=1;
			if(loop_counter>3 || loop_counter==0 || loop_counter==2)
			pre_light4=1;
			if(ms_counter==HALF_NOTE) begin
				next_state=A71;
				ms_reset=1;
			end
		end
		
		A71: begin
			next_state=A71;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=A70;
				loop_inc=1;
				if(loop_counter==7) begin //2nd flash
					loop_reset=1;
					next_state=A72;
				end
			end
		end	
	
		A72: begin //zig zag (4x slow, 8x fast)
			next_state=A72;
			if(ms_counter==EIGHTH_NOTE || (loop_counter>3 && ms_counter==SIXTEENTH_NOTE)) begin
				ms_reset=1;
				next_state=A73;
			end
		end
		
		A73: begin
			next_state=A73;
			pre_light4=1;
			if(ms_counter==EIGHTH_NOTE || (loop_counter>3 && ms_counter==SIXTEENTH_NOTE)) begin
				ms_reset=1;
				next_state=A74;
			end
		end
		
		A74: begin
			next_state=A74;
			pre_light4=1;
			pre_light3=1;
			if(ms_counter==EIGHTH_NOTE || (loop_counter>3 && ms_counter==SIXTEENTH_NOTE)) begin
				ms_reset=1;
				next_state=A75;
			end
		end
		
		A75: begin
			next_state=A75;
			pre_light4=1;
			pre_light3=1;
			pre_light2=1;
			pre_light1=1;
			if(ms_counter==EIGHTH_NOTE || (loop_counter>3 && ms_counter==SIXTEENTH_NOTE)) begin
				ms_reset=1;
				next_state=A76;
			end
		end
		
		A76: begin
			next_state=A76;
			pre_light4=1;
			pre_light3=1;
			if(ms_counter==EIGHTH_NOTE || (loop_counter>3 && ms_counter==SIXTEENTH_NOTE)) begin
				ms_reset=1;
				next_state=A77;
			end
		end
		
		A77: begin
			next_state=A77;
			pre_light4=1;
			if(ms_counter==EIGHTH_NOTE || (loop_counter>3 && ms_counter==SIXTEENTH_NOTE)) begin
				ms_reset=1;
				next_state=A72;
				loop_inc=1;
				if(loop_counter==11) begin
					next_state=A78;
					loop_reset=1;
				end
			end
		end
		
		A78: begin
			next_state=A78;
			pre_light4=1;
			pre_light3=1;
			pre_light2=1;
			pre_light1=1;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=A79;
			end
		end
		
		A79: begin
			next_state=A79;
			if(ms_counter==HALF_NOTE) begin
				ms_reset=1;
				next_state=A78;
				loop_inc=1;
				if(loop_counter==3) begin
					loop_reset=1;
					next_state=A80;
				end
			end
		end
		
		A80: begin
			pre_light4=1;
			pre_light3=1;
			pre_light2=1;
			pre_light1=1;
			next_state=A80;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=A81;
			end
		end
		
		A81: begin
			next_state=A81;
			//pre_light4=1;
			pre_light3=1;
			pre_light2=1;
			//pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A82;
			end
		end
		
		A82: begin
			next_state=A82;
			pre_light4=1;
			//pre_light3=1;
			pre_light2=1;
			//pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A83;
			end
		end
		
		A83: begin
			next_state=A83;
			pre_light4=1;
			//pre_light3=1;
			//pre_light2=1;
			pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A84;
			end
		end
		
		A84: begin
			next_state=A84;
			//pre_light4=1;
			pre_light3=1;
			//pre_light2=1;
			pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A85;
			end
		end
		
		A85: begin
			next_state=A85;
			//pre_light4=1;
			//pre_light3=1;
			pre_light2=1;
			pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A86;
			end
		end
		
		A86: begin
			next_state=A86;
			pre_light4=1;
			//pre_light3=1;
			pre_light2=1;
			//pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A87;
			end
		end
		
		A87: begin
			next_state=A87;
			pre_light4=1;
			pre_light3=1;
			//pre_light2=1;
			//pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A88;
			end
		end
		
		A88: begin
			next_state=A88;
			//pre_light4=1;
			pre_light3=1;
			//pre_light2=1;
			pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A89;
			end
		end
		
		A89: begin
			next_state=A89;
			//pre_light4=1;
			pre_light3=1;
			//pre_light2=1;
			pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A90;
			end
		end
		
		A90: begin
			next_state=A90;
			pre_light4=1;
			//pre_light3=1;
			//pre_light2=1;
			pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A91;
			end
		end
		
		A91: begin
			next_state=A91;
			//pre_light4=1;
			//pre_light3=1;
			pre_light2=1;
			pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A92;
			end
		end
		
		A92: begin
			next_state=A92;
			//pre_light4=1;
			pre_light3=1;
			pre_light2=1;
			//pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A93;
			end
		end
		
		A93: begin
			next_state=A93;
			pre_light4=1;
			//pre_light3=1;
			pre_light2=1;
			//pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A94;
			end
		end
		
		A94: begin
			next_state=A94;
			//pre_light4=1;
			//pre_light3=1;
			pre_light2=1;
			pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A95;
			end
		end
		
		A95: begin
			next_state=A95;
			//pre_light4=1;
			pre_light3=1;
			//pre_light2=1;
			pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A96;
			end
		end
		
		A96: begin
			next_state=A96;
			pre_light4=1;
			pre_light3=1;
			//pre_light2=1;
			//pre_light1=1;
			if(ms_counter==THIRTYSECOND_NOTE) begin
				ms_reset=1;
				next_state=A81;
				loop_inc=1;
				if(loop_counter==4)begin
					loop_reset=1;
					next_state=A97;
				end
			end
		end
		
		A97: begin
			next_state=A97;
			if(ms_counter==QUARTER_NOTE) begin
				ms_reset=1;
				next_state=A98;
			end
		end
		
		A98: begin
			pre_light4=1;
			pre_light3=1;
			pre_light2=1;
			pre_light1=1;
			next_state=A98;
			if(ms_counter==4*WHOLE_NOTE) begin
				ms_reset=1;
				finished_pre=1; //mark to controller that song is done.
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
		clk_counter<=28'h0000000;
	 else if (clk_rst)
		clk_counter <=28'h0000000;
	 else if (ms_inc)
		clk_counter <=28'h0000000;
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
		finished <=0;
	else
		finished <=finished_pre;

end



always_comb begin

  //light1=~pre_light1;
  //light2=~pre_light2;
 // light3=~pre_light3;
 // light4=~pre_light4;
  
  light1=pre_light1;
  light2=pre_light2;
  light3=pre_light2;
  light4=pre_light2;
  light5=pre_light2;
  light6=pre_light1;
  light7=pre_light3;
  light8=pre_light4;
  
  ms_inc=(clk_counter==DELAY);
   
end



endmodule
