
module main_controller(DIP3,DIP2,DIP1,clk,rst_n,out_light1,out_light2,out_light3,out_light4,out_light5,out_light6,out_light7,out_light8,LED1,LED2,LED3,LED4,LED5,LED6,LED7,LED8);
    input logic clk,rst_n,DIP1,DIP2,DIP3;
    output logic out_light1,out_light2,out_light3,out_light4,out_light5,out_light6,out_light7,out_light8,LED1,LED2,LED3,LED4,LED5,LED6,LED7,LED8;
    
typedef enum logic[8:0]{IDLE,OFF,ALWAYS_ON,DECIDE,MODULE1,MODULE2,MODULE3,MODULE4,MODULE5,MODULE6,MODULE7,SHOW1,SHOW2,SHOW3,SHOW4,SHOW5,SHOW6,SHOW7,SHOW8} state_t;
parameter MILLISECONDS = 1;
parameter DELAY = 5000*MILLISECONDS;
state_t state,next_state;



parameter HOUR_ON=16; //4pm
parameter HOUR_OFF=24; //11pm

parameter CURRENT_HOUR=19;
parameter CURRENT_MINUTE=20;

parameter SHOW_ON=0;
parameter SHOW_OFF=3; // play once
parameter FIRST_OFF=20;
parameter PATTERN_OFF=45;

parameter FIRST_ON=SHOW_OFF;
parameter PATTERN_ON=FIRST_OFF;
parameter SECOND_ON=PATTERN_OFF;
parameter SECOND_OFF=SHOW_ON;

logic[27:0]global_clocks;
logic[7:0]global_seconds;
logic[7:0]global_minutes;
logic[7:0]global_hours;

logic[19:0]ms_counter; //milisecond counter

logic seconds_inc;
logic minutes_inc;
logic hours_inc;

logic global_clocks_reset;
logic global_seconds_reset;
logic global_minutes_reset;
logic global_hours_reset;

logic module1_go;
logic module2_go;
logic module3_go;
logic module4_go;
logic module5_go;
logic module6_go;
logic module7_go;

logic module1_finished;
logic module2_finished;
logic module3_finished;
logic module4_finished;
logic module5_finished;
logic module6_finished;
logic module7_finished;

logic module2_light1;
logic module2_light8;
logic module2_light7;
logic module2_light6;
logic module2_light5;
logic module2_light4;
logic module2_light3;
logic module2_light2;

logic module3_light1;
logic module3_light8;
logic module3_light7;
logic module3_light6;
logic module3_light5;
logic module3_light4;
logic module3_light3;
logic module3_light2;
logic module4_light1;
logic module4_light8;
logic module4_light7;
logic module4_light6;
logic module4_light5;
logic module4_light4;
logic module4_light3;
logic module4_light2;
logic module5_light1;
logic module5_light8;
logic module5_light7;
logic module5_light6;
logic module5_light5;
logic module5_light4;
logic module5_light3;
logic module5_light2;
logic module6_light1;
logic module6_light8;
logic module6_light7;
logic module6_light6;
logic module6_light5;
logic module6_light4;
logic module6_light3;
logic module6_light2;
logic module7_light1;
logic module7_light8;
logic module7_light7;
logic module7_light6;
logic module7_light5;
logic module7_light4;
logic module7_light3;
logic module7_light2;

logic module1_light1;
logic module1_light8;
logic module1_light7;
logic module1_light6;
logic module1_light5;
logic module1_light4;
logic module1_light3;
logic module1_light2;

logic[27:0]clk_counter;
logic[2:0] sel_synchronous;


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



logic light1;
logic light2;
logic light3;
logic light4;

logic[2:0] dip_sel;
logic[2:0] sel;

logic mux_light1;
logic mux_light2;
logic mux_light3;
logic mux_light4;
logic mux_light5;
logic mux_light6;
logic mux_light7;
logic mux_light8;


//light 4 overhead
//light 3 icicles
//light 2 rails
//light 1 corners

always_comb begin
    next_state=IDLE;
	 loop_inc=0;
	 loop_inc2=0;
	 loop_inc3=0;
	 loop_reset=0;
	 loop_reset2=0;
	 loop_reset3=0;
	
	 module1_go=0;
	 module2_go=0;
	 module3_go=0;
	 module4_go=0;
	 module5_go=0;
	 module6_go=0;
	 module7_go=0;
	 sel=3'b000; //default always off
	 ms_reset=0;
	 
	 
    case(state)
        IDLE: begin
				if (global_hours<HOUR_ON || global_hours>=HOUR_OFF) begin //turn off
					next_state=OFF;
				end
				else begin
				next_state=IDLE;
				ms_reset=0; // start counting
					if(ms_counter>=2000) begin
							loop_reset=1;
							ms_reset=1;
							if(dip_sel==3'b111) begin
								next_state=MODULE7;
								sel = 3'b111;
							end
							else if(dip_sel==3'b110) begin
								//next_state=MODULE6;
								next_state=SHOW1;
								sel = 3'b110;
							end
							else if(dip_sel==3'b101) begin
								next_state=MODULE5;
								sel = 3'b101;
							end
							else if(dip_sel==3'b100) begin
								next_state=MODULE4;
								sel = 3'b100;
							end
							else if(dip_sel==3'b011) begin
								next_state=MODULE3;
								sel = 3'b011;
							end
							else if(dip_sel==3'b010) begin
								next_state=MODULE2;
								sel = 3'b010;
							end
							else if(dip_sel==3'b001) begin
								next_state=MODULE1;
								sel = 3'b001;
							end	
							else // dip is at 0, we chose based on time
								next_state=DECIDE;
					 end
				 end
	    end
		 
		 DECIDE: begin
			loop_reset=1;
			loop_reset2=1;
			loop_reset3=1;
			if(global_minutes>=PATTERN_OFF)
				next_state=MODULE5;    //LIGHTS ON :45 to :00
			else if(global_minutes>=FIRST_OFF)
				next_state=MODULE4;           //patern :20 to :45
			else if(global_minutes>=SHOW_OFF)
				next_state=MODULE5;    //LIGHTS ON :05 to :20
			else
				next_state=SHOW1;           //carrol of bells :00 to :05
		end
		 
		 MODULE7: begin // always on
			next_state=MODULE7;
			module7_go=1;
			sel=3'b111; // lights should play module7
			if(module7_finished==1 && (dip_sel!=3'b111)) begin // dip switch overwrites going back to idle 
				//sel=3'b000; //reset
				module7_go=0;
				next_state=IDLE;
				ms_reset=1;
				if(dip_sel==3'b000) begin //on show mode
					next_state=DECIDE;
				end
			end
			
		end
		
		MODULE6: begin
			next_state=MODULE6;
			module6_go=1;
			sel=3'b110; // lights should play module6
			if(module6_finished==1&&(dip_sel!=3'b110)) begin //keep on module 6 if dip is there
				//sel=3'b000; //reset
				module6_go=0;
				next_state=IDLE;
				ms_reset=1;
				if(dip_sel==3'b000) begin //on show mode
					next_state=DECIDE;
				end
			end
		end
		
		MODULE5: begin
			next_state=MODULE5;
			module5_go=1;
			sel=3'b101; // lights should play module7
			if(module5_finished==1 &&(dip_sel!=3'b101)) begin //keep on module 7 if dip is there
				//sel=3'b000; //reset
				module5_go=0;
				next_state=IDLE;
				ms_reset=1;
				if(dip_sel==3'b000) begin //on show mode
					next_state=DECIDE;
				end
			end
		end
		
		MODULE4: begin
			next_state=MODULE4;
			module4_go=1;
			sel=3'b100; // lights should play module7
			if(module4_finished==1&&(dip_sel!=3'b100)) begin //keep on module 7 if dip is there
				//sel=3'b000; //reset
				module4_go=0;
				next_state=IDLE;
				ms_reset=1;
				if(dip_sel==3'b000) begin //on show mode
					next_state=DECIDE;
				end
			end
		end
		
		MODULE3: begin
			next_state=MODULE3;
			module3_go=1;
			sel=3'b011; // lights should play module7
			if(module3_finished==1&&(dip_sel!=3'b011)) begin //keep on module 7 if dip is there
				//sel=3'b000; //reset
				module3_go=0;
				next_state=IDLE;
				if(dip_sel==3'b000)
					next_state=SHOW1;
				ms_reset=1;
			end
		end
		
		MODULE2: begin
			next_state=MODULE2;
			module2_go=1;
			sel=3'b010; // lights should play module7
			if(module2_finished==1&&(dip_sel!=3'b010)) begin //keep on module 7 if dip is there
				//sel=3'b000; //reset
				module2_go=0;
				next_state=IDLE;
				if(dip_sel==3'b000)
					next_state=SHOW1;
				ms_reset=1;
			end
		end
		
		MODULE1: begin
			next_state=MODULE1;
			module1_go=1;
			sel=3'b001; // lights should play module7
			if(module1_finished==1&&(dip_sel!=3'b001)) begin //keep on module 7 if dip is there
				//sel=3'b000; //reset
				module1_go=0;
				next_state=IDLE;
				if(dip_sel==3'b000)
					next_state=SHOW1;
				ms_reset=1;
			end
		end
			

		OFF: begin
			sel=3'b000;
			next_state=OFF;
			if(global_hours==HOUR_ON) begin // time to start again, has been 24 hours
			ms_reset=1;
			
			next_state=IDLE;
			end
			else // remain off until it's been 24 hours since start
			next_state=OFF;
		end
		
		SHOW1: begin
			sel=3'b000;
			loop_inc=1;
			next_state=DECIDE;
			if(loop_counter==0)
				next_state=MODULE1;
			if(loop_counter==1)
				next_state=MODULE2;
			if(loop_counter==2)
				next_state=MODULE3;
			if(module1_finished==1 || module2_finished==1 || module3_finished==1) begin
				loop_inc=1;
			end// || module1_finished==1|| module1_finished==1|| module1_finished==1
			if(loop_counter==3) begin
				loop_reset=1;
				next_state=DECIDE;
			end
		end
		
		default: begin 
			sel=3'b000;
			next_state=IDLE;
		end
	endcase

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
		clk_counter=28'h0000000;
	 else if(clk_reset)
       clk_counter=28'h0000000;
    else
		clk_counter=clk_counter+1;
       
end


always_ff @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
       state<=IDLE;
		 sel_synchronous<=3'b000;
	end
    else begin
       state<=next_state;
		 sel_synchronous<=sel;
		end
end

always_ff @(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		global_clocks=0;
		global_seconds=0;
		global_minutes=CURRENT_MINUTE;
		global_hours=CURRENT_HOUR;
	end
	else begin
		
		if (global_clocks_reset)
			global_clocks=0;
		else if(clk)
			global_clocks=global_clocks+1;
		
		if(global_seconds_reset)
			global_seconds=0;
		else if(seconds_inc)
			global_seconds=global_seconds+1;
		
		if(global_minutes_reset)
			global_minutes=0;
		else if(minutes_inc)
			global_minutes=global_minutes+1;
			
		if(global_hours_reset)
			global_hours=0;
		else if(hours_inc)
			global_hours=global_hours+1;
		
		
	end
end

always_comb begin
  LED1=mux_light1;
  LED2=mux_light2;
  LED3=mux_light3;
  //LED1=sel[0];
  //LED2=sel[1];
  //LED3=sel[2];
  LED4=mux_light4;
  LED5=mux_light5;
  LED6=mux_light6;
  LED7=mux_light7;
  LED8=mux_light8;
  
  //not sure why, but ss relays seem to be active low, even though it says otherwise...
  out_light1=~mux_light1;
  out_light2=~mux_light2;
  out_light3=~mux_light3;
  out_light4=~mux_light4;
  out_light5=~mux_light5;
  out_light6=~mux_light6;
  out_light7=~mux_light7;
  out_light8=~mux_light8;

end

mux8 #(1) light1mux(
	.A(1'b0),
	.B(module1_light1),
	.C(module2_light1),
	.D(module3_light1),
	.E(module4_light1),
	.F(module5_light1),
	.G(module6_light1),
	.H(1'b1),
	.sel(sel_synchronous),
	.out(mux_light1)
);
mux8 #(1) light2mux(
	.A(1'b0),
	.B(module1_light2),
	.C(module2_light2),
	.D(module3_light2),
	.E(module4_light2),
	.F(module5_light2),
	.G(module6_light2),
	.H(1'b1),
	.sel(sel_synchronous),
	.out(mux_light2)
);
mux8 #(1) light3mux(
	.A(1'b0),
	.B(module1_light3),
	.C(module2_light3),
	.D(module3_light3),
	.E(module4_light3),
	.F(module5_light3),
	.G(module6_light3),
	.H(1'b1),
	.sel(sel_synchronous),
	.out(mux_light3)
);
mux8 #(1) light4mux(
	.A(1'b0),
	.B(module1_light4),
	.C(module2_light4),
	.D(module3_light4),
	.E(module4_light4),
	.F(module5_light4),
	.G(module6_light4),
	.H(1'b1),
	.sel(sel_synchronous),
	.out(mux_light4)
);
mux8 #(1) light5mux(
	.A(1'b0),
	.B(module1_light5),
	.C(module2_light5),
	.D(module3_light5),
	.E(module4_light5),
	.F(module5_light5),
	.G(module6_light5),
	.H(1'b1),
	.sel(sel_synchronous),
	.out(mux_light5)
);
mux8 #(1) light6mux(
	.A(1'b0),
	.B(module1_light6),
	.C(module2_light6),
	.D(module3_light6),
	.E(module4_light6),
	.F(module5_light6),
	.G(module6_light6),
	.H(1'b1),
	.sel(sel_synchronous),
	.out(mux_light6)
);
mux8 #(1) light7mux(
	.A(1'b0),
	.B(module1_light7),
	.C(module2_light7),
	.D(module3_light7),
	.E(module4_light7),
	.F(module5_light7),
	.G(module6_light7),
	.H(1'b1),
	.sel(sel_synchronous),
	.out(mux_light7)
);
mux8 #(1) light8mux(
	.A(1'b0),
	.B(module1_light8),
	.C(module2_light8),
	.D(module3_light8),
	.E(module4_light8),
	.F(module5_light8),
	.G(module6_light8),
	.H(1'b1),
	.sel(sel_synchronous),
	.out(mux_light8)
);


assign clk_reset=(clk_counter==DELAY) ? 1'b1 : 1'b0;
assign ms_inc=(clk_counter==DELAY) ? 1'b1 : 1'b0;



assign seconds_inc=(global_clocks==50000000);
assign global_clocks_reset=(global_clocks>=50000000);
assign minutes_inc=(global_seconds==60);
assign global_seconds_reset=(global_seconds>=60);
assign hours_inc=(global_minutes==60);
assign global_minutes_reset=(global_minutes>=60);
assign global_hours_reset=(global_hours>=24);






///////////////////////////////////////////////////
////// MODULE 1 ///////////////////////////////////
///////////////////////////////////////////////////

wizzards_in_winter my_wizzards_in_winter(
	.go(module1_go),
	.finished(module1_finished),
	.clk(clk),
	.rst_n(rst_n),
	.light1(module1_light1),
	.light2(module1_light2),
	.light3(module1_light3),
	.light4(module1_light4),
	.light5(module1_light5),
	.light6(module1_light6),
	.light7(module1_light7),
	.light8(module1_light8)
);




///////////////////////////////////////////////////
////// MODULE 2 ///////////////////////////////////
///////////////////////////////////////////////////

Bieber_alaylm my_alaylm(
	.go(module2_go),
	.finished(module2_finished),
	.clk(clk),
	.rst_n(rst_n),
	.light1(module2_light1),
	.light2(module2_light2),
	.light3(module2_light3),
	.light4(module2_light4),
	.light5(module2_light5),
	.light6(module2_light6),
	.light7(module2_light7),
	.light8(module2_light8)
);




///////////////////////////////////////////////////
////// MODULE 3 ///////////////////////////////////
///////////////////////////////////////////////////

Trans_Syberian my_trans_syberian(
	.go(module3_go),
	.finished(module3_finished),
	.clk(clk),
	.rst_n(rst_n),
	.light1(module3_light1),
	.light2(module3_light2),
	.light3(module3_light3),
	.light4(module3_light4),
	.light5(module3_light5),
	.light6(module3_light6),
	.light7(module3_light7),
	.light8(module3_light8)
);




///////////////////////////////////////////////////
////// MODULE 4 ///////////////////////////////////
///////////////////////////////////////////////////

pattern1 lights_on4(
	.go(module4_go),
	.finished(module4_finished),
	.clk(clk),
	.rst_n(rst_n),
	.light1(module4_light1),
	.light2(module4_light2),
	.light3(module4_light3),
	.light4(module4_light4),
	.light5(module4_light5),
	.light6(module4_light6),
	.light7(module4_light7),
	.light8(module4_light8)
);




///////////////////////////////////////////////////
////// MODULE 5 ///////////////////////////////////
///////////////////////////////////////////////////


sparkle_on lights_on5(
	.go(module5_go),
	.finished(module5_finished),
	.clk(clk),
	.rst_n(rst_n),
	.light1(module5_light1),
	.light2(module5_light2),
	.light3(module5_light3),
	.light4(module5_light4),
	.light5(module5_light5),
	.light6(module5_light6),
	.light7(module5_light7),
	.light8(module5_light8)
);



///////////////////////////////////////////////////
////// MODULE 6 ///////////////////////////////////
///////////////////////////////////////////////////

Barney my_barney(
	.go(module6_go),
	.finished(module6_finished),
	.clk(clk),
	.rst_n(rst_n),
	.light1(module6_light1),
	.light2(module6_light2),
	.light3(module6_light3),
	.light4(module6_light4),
	.light5(module6_light5),
	.light6(module6_light6),
	.light7(module6_light7),
	.light8(module6_light8)
);




///////////////////////////////////////////////////
////// MODULE 7 ///////////////////////////////////
///////////////////////////////////////////////////

sparkle_on lights_on7(
	.go(module7_go),
	.finished(module7_finished),
	.clk(clk),
	.rst_n(rst_n),
	.light1(module7_light1),
	.light2(module7_light2),
	.light3(module7_light3),
	.light4(module7_light4),
	.light5(module7_light5),
	.light6(module7_light6),
	.light7(module7_light7),
	.light8(module7_light8)
);



always_comb begin
	dip_sel[2] = DIP3;
	dip_sel[1] = DIP2;
	dip_sel[0] = DIP1;
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


endmodule



module mux4(A,B,C,D,sel,out);
parameter WIDTH=4;
input logic[WIDTH-1:0] A,B,C,D;
input logic [1:0] sel;
output logic[WIDTH-1:0] out;

always_comb begin
	case(sel)
	2'b00: 
		out=A;
	2'b01:
		out=B;
	2'b10:
		out=C;
	2'b11:
		out=D;
	default:
		out=A;
endcase
end

endmodule

module mux8(A,B,C,D,E,F,G,H,sel,out);
parameter WIDTH=8;
input logic[WIDTH-1:0] A,B,C,D,E,F,G,H;
input logic [2:0] sel;
output logic[WIDTH-1:0] out;

always_comb begin
	case(sel)
	3'b000: 
		out=A;
	3'b001:
		out=B;
	3'b010:
		out=C;
	3'b011:
		out=D;
	3'b100: 
		out=E;
	3'b101:
		out=F;
	3'b110:
		out=G;
	3'b111:
		out=H;
	default:
		out=A;
endcase
end

endmodule
	
