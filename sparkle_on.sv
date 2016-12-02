
module sparkle_on(go,finished,clk,rst_n,light1,light2,light3,light4,light5,light6,light7,light8);
    input logic go,clk,rst_n;
    output logic finished,light1,light2,light3,light4,light5,light6,light7,light8;
    
typedef enum logic[8:0]{DONE,IDLE,WAIT,T1_1,T1,T2,T3,T4,T5,T6,T7,T8,T9,T10,T11,T12,T13,T14,T15,T16,T17,T18,T19,T20,T21,T22,T23,T24,T25,T26,T27,T28,T29,T30,T31,T32,T33,T34,T35,T36,T37,T38,T39,T40,T41,T42,T43,T44,T45,T46,T47,T48,T49,T50,T51,T52,T53,T54,T55,T56,T57,T58,T59,T60,T61,T62,T63,T64,T65,T66,T67,T68,T69,T70,T71,T72,T73,T74,T75,T76,T77,T78,T79,T80,T81,T82,T83,T84,T85,T86,T87,T88,T88_1,T89,T90,T91,T92,T93,T94,T95,T96,T97,T98,T99,T100,T101,T102,T103,T104,T105,T106,T107,T108,T109,T110,T111,T112,T113,T114,T115,T116,T117,T118,T119,T120} state_t;
parameter MILLISECONDS = 1;
parameter DELAY = 5000*MILLISECONDS;
state_t state,next_state;



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
				next_state=T102;
				ms_reset=1;
				loop_reset=1;
				loop_reset2=1;
				loop_reset3=1;
			end
		 
		
	T102: begin // do little sparkle pattern or something
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
			//light5=1;
			light6=1;
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
				finished_temp=1;
				next_state=T102;
			end
		end	
		default: begin
			next_state=IDLE;
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
