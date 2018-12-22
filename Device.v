
module Device (DeviceAddress[1:0],force_Request,address_To_Contact[1:0],WriteData[31:0],WR,GNT,REQ,AD[31:0],IRDY,TRDY,FRAME,CBE[3:0],DEVSEL,CLK,RST);

output REQ;

input  WR,CLK,GNT,RST,force_Request;
input  [1:0]  address_To_Contact;
input  [1:0]  DeviceAddress;
input  [31:0] WriteData;

inout IRDY,TRDY,DEVSEL,FRAME;
inout [31:0] AD;
inout [3:0] CBE;

//REGISTERS FOR INOUT PORTS
reg REG_IRDY;
reg REG_TRDY;
reg REG_DEVSEL;
reg REG_FRAME;
reg [31:0] REG_D;
reg [1:0]  REG_A;
reg [3:0]  REG_CBE;
//INTERNAL MEMORY OF DEVICE
reg [31:0] Memory [0:9];
//CONTROL REGISTETRS OF DEVICE
reg MasterNotSlave;
integer    counter; 
reg [2:0] state;
reg [2:0] countREQ;
reg OutNotIn;
reg AddNotData;


assign REQ = force_Request;
assign FRAME  = MasterNotSlave? REG_FRAME  : 1'bz ;
assign IRDY   = MasterNotSlave? REG_IRDY   : 1'bz ;
assign CBE    = MasterNotSlave? REG_CBE    : 4'bzzzz ;
assign DEVSEL = MasterNotSlave?   1'bz     : REG_DEVSEL;
assign TRDY   = MasterNotSlave?   1'bz     : REG_TRDY ;
assign AD = (OutNotIn&&AddNotData)? REG_A : (OutNotIn&&(~AddNotData))? REG_D :  32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;

//always @ (posedge force_Request)
//begin
//REQ<=0;
//end

always @ (negedge GNT)
begin
MasterNotSlave<=1'b1;
end


always @(posedge CLK,RST)
begin
if(RST)
begin 
REG_FRAME <=1;
REG_IRDY<=1;
REG_TRDY<=1;
REG_DEVSEL<=1;
state<=0;
counter <=0;
countREQ <=0;
MasterNotSlave<=0;
OutNotIn<=0;
AddNotData<=1;
end 

else 
begin
        if(~REQ) begin countREQ = countREQ + 1; end
	
	if(MasterNotSlave) //  Master Scope 
	begin
		if(WR) // Write from master side 
		begin
			case (state)
			0: @(negedge CLK)
				   begin
				   OutNotIn<=1;
				   AddNotData<=1;
				   REG_FRAME <= 1'b0;
				   REG_A <= address_To_Contact;
				   REG_CBE <= WR;//command el write
				   state <= 1;
				   end
			   
			1: begin
				   @(negedge CLK)
				   begin
				   if(countREQ > 1)
				   begin
				   OutNotIn<=1;
				   AddNotData<=0;
				   REG_IRDY <= 1'b0;
				   REG_CBE <= 4'b1111;
				   REG_D <= WriteData;
				   countREQ <= countREQ - 1;
				   end
				   else if (countREQ == 1)
				   begin 
				   OutNotIn<=1;
				   AddNotData<=0;
				   state <= 2; 
				   REG_FRAME <= 1'b1; 
				   REG_D <= WriteData;
				   countREQ <= countREQ - 1;
				   end
				   end 
			   end
            2: begin
				   @(negedge CLK)
				   begin
				   OutNotIn<=0;
				   REG_IRDY <= 1'b1;
				   state<=0;
				   MasterNotSlave<=1'b0;
				   end
               end			   
	endcase
	end	
		
		else // Read from master side 
		begin
			case (state)

				3'b000: begin 
						@(negedge CLK)
						begin
				   		OutNotIn<=1;
				  		AddNotData<=1;
						REG_FRAME<=1'b0;
						REG_A<=address_To_Contact;
						REG_CBE <= WR; //command el read
						state<=1;
						end
					    end		
				
				3'b001: begin 
							@(negedge CLK)
							begin
				  			OutNotIn<=0;
				   			AddNotData<=0;
							REG_IRDY<=1'b0;
							state<=2;
							end
						end	

				3'b010: begin 
							state<=3;
						end	

				3'b011:  begin
					  if(~DEVSEL&&~TRDY&&(countREQ>0))
					      begin
							countREQ <=countREQ - 1;
							Memory[counter]<=AD;
							if(counter ==9)begin counter =0; end
							else begin counter = counter + 1; end

							if (countREQ ==1 )
							begin
							@(negedge CLK)
							begin REG_FRAME<=1; end
							end

							else if (countREQ==0)
							begin
							@(negedge CLK)
							begin
				   				OutNotIn<=0;
								REG_IRDY<=1;
								state<=0;
								MasterNotSlave<=1'b0;
							end
							end
						 end
					  end
			endcase
		end
	end
	
	else	// Slave scope 
	begin
		case (state)
			0: begin
				if (DeviceAddress == AD [1:0] )
				begin
					//increment state by 2 in each state
					//odd numbers for write
					//even numbers for read
					if(CBE == 4'b0001) // Write from slave side 
					begin	

						@(negedge CLK)
						begin
						REG_DEVSEL<=1'b0;
						REG_TRDY<=1'b0;
						state<=1;
						end //end of negative edge	
					end
					else if (CBE ==4'b0000 ) // read from slave side
					begin

						@(negedge CLK)
						begin
						REG_DEVSEL<=1'b0;
						state<=2;
						end //end of negative edge	

					end
				end
			end
	
	      		1:  begin

			    //checking BE and assign the corresponding bits into the memory
				 Memory[counter][7:0]  <=(CBE[0])? AD[7:0]  :Memory[counter][7:0];
				 Memory[counter][15:8] <=(CBE[1])? AD[15:8] :Memory[counter][15:8];
				 Memory[counter][23:16]<=(CBE[2])? AD[23:16]:Memory[counter][23:16];
				 Memory[counter][31:24]<=(CBE[3])? AD[31:24]:Memory[counter][31:24];
				 //Memory[counter][(8*i):((8*(i+1))-1)]<=AD[(8*i):((8*(i+1))-1)]; //memory[row][byte]
                                if(counter ==9)begin counter <=0; end
				else begin counter <= counter + 1; end
				if (FRAME == 1'b1) 
				begin

					@(negedge CLK)
					begin
					REG_DEVSEL<=1'b1;
					REG_TRDY<=1'b1;
					state<=0;
					end
				end	
			    end

			2: begin
			 	@(negedge CLK)
				begin
				OutNotIn<=1;
				AddNotData<=0;
				REG_TRDY<=1'b0;
				if (IRDY) begin REG_D <= WriteData; end
				state<=3;
				end
			end

			3: begin
				 @(negedge CLK)
				begin
				    if(~FRAME)
					begin
					if (IRDY) begin REG_D<= WriteData; end
					end
					else
					begin
					OutNotIn<=0;
					REG_DEVSEL<=1'b1;
					REG_TRDY<=1'b1;
					state<=0;
					countREQ <=0;
					end
				end
			end
		endcase
	end


 end
end
endmodule 


