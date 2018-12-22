module arbiter(input clk,input rst,input[2:0] req,input framein,output reg[2:0] gnt);
reg[2:0] buffer;

always @(posedge clk or rst or framein)
	begin
		
		if(rst==1'b1) begin gnt<=3'b111; end
		else begin
			//gnt<=3'b000;
			buffer <= req;
		end
        end

always @(negedge clk or rst or framein)
	begin
		if(rst==1'b1) begin gnt<=3'b111; end
		else if(framein==1'b1  &&  (gnt[0]==1'b0||gnt[1]==1'b0||gnt[2]==1'b0)) begin
		gnt<=3'b111;
		end
		else if(framein==1'b1  &&  (gnt[0]==1'b1||gnt[1]==1'b1||gnt[2]==1'b1)) begin
		gnt<=3'b111;
		if (buffer[0]==1'b0)begin
		gnt[0]<=1'b0;
		end
		else if (buffer[1]==1'b0)begin
		gnt[1]<=1'b0;
		end
		else if (buffer[2]==1'b0)begin
		gnt[2]<=1'b0;
		end
		else begin
		gnt<=3'b111;
		end
		end
		else begin end
	end
endmodule

module tb();
reg clk,rst,framein;
reg [2:0]req;
wire [2:0]gnt;
always
begin
#5 clk=~clk;
end
initial
begin
$monitor($time,,"gnt:%b   req:%b   rst:%b   framein:%d",gnt,req,rst,framein);
clk=1;
rst=1;
framein=1;
#10
rst=0;
req=3'b110;
#5
req=3'b100;
#10
framein=0;
#10
framein=1;
#20
req<=3'b101;
#5
framein=1;
#15
framein=0;
#5
framein=1;
/*
#5
framein=1;
#5
framein=1;
#10
req=3'b001;
#5
framein=1;
#5
req=3'b011;
#5
framein=1;
#5
rst=1;
#5
framein=1;
rst=0;
req=3'b010;
#5
req=3'b111;
*/
end
arbiter arb(clk,rst,req,framein,gnt);

endmodule
