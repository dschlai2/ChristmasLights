
module always_on(go,finished,clk,rst_n,light1,light2,light3,light4,light5,light6,light7,light8);


    input logic go,clk,rst_n;
    output logic finished,light1,light2,light3,light4,light5,light6,light7,light8;
    
  parameter MILLISECONDS = 1;
parameter DELAY = 5000*MILLISECONDS; 

logic currently_going;

logic[27:0]clk_counter;
logic[19:0]ms_counter; //milisecond counter


logic ms_inc;
logic ms_reset;

logic finished_temp;
logic done;



always_comb begin
	//initialize -- just for debug
	light1 = 1'b1;
	light2 = 1'b1;
	light3 = 1'b1;
	light4 = 1'b1;
	light5 = 1'b1;
	light6 = 1'b1;
	light7 = 1'b1;
	light8 = 1'b1;
	ms_reset=0;
	finished_temp=1'b0;
	done=0;
	
	if(ms_counter >= 20000) begin
		finished_temp=1'b1;
		ms_reset=1;
		done=1;
	end

	if(currently_going==1) begin
		light1 = 1'b1;
		light2 = 1'b1;
		light3 = 1'b1;
		light4 = 1'b1;
		light5 = 1'b1;
		light6 = 1'b1;
		light7 = 1'b1;
		light8 = 1'b1;
	end
	light4 = 1'b1; // if just this light on, something wrong where it doesn't think it's going, but still going here

end

always_ff @(posedge go, negedge rst_n) begin
	if(!rst_n) begin
		currently_going <= 1'b0;
		
	end
	else if (done==1) begin
		currently_going <= 1'b0;
	end
	
	else begin
		currently_going <= 1'b1;
		
	end
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
	 else if(ms_inc)
		clk_counter=28'h0000000;
    else
		clk_counter=clk_counter+1;
       
end

always_ff @(posedge clk, negedge rst_n) begin
    if(!rst_n)
		finished <= 1'b0;

    else
		finished <= finished_temp;
       
end

assign ms_inc=(clk_counter==DELAY);

endmodule
