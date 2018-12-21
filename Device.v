module Device (DeviceAddress[1:0],force_Request,address_To_Contact[1:0],WriteData,RW,GNT,REQ,AD[31:0],IRDY,TRDY,FRAME,CBE[3:0],DEVSEL,CLK,RST);

output reg REQ;

input  RW,CLK,GNT,RST,force_Request;
input  [1:0] address_To_Contact;
input  [1:0] DeviceAddress;
input  [31:0] WriteData;

inout IRDY,TRDY,DEVSEL,FRAME;
inout [31:0] AD;
inout [3:0] CBE;

reg REG_IRDY;
reg REG_TRDY;
reg REG_DEVSEL;
reg REG_FRAME;
reg [31:0] REG_D;
reg [1:0]  REG_A;
reg [3:0]  REG_CBE;
reg [31:0] Memory [0:9];
reg [31:0] Data2write;
reg MasterNotSlave;
integer    counter;
reg SelectedAddress; 
reg par;
reg [2:0] countREQ;



assign DEVSEL = SelectedAddress? 1'b0 : 1'bz ;

always @ (posedge force_Request)
begin
REQ<=0;
end

always @ (negedge GNT)
begin
MasterNotSlave<=1'b1;
end


always @(posedge CLK,RST)
begin
if(RST)
begin 
par=0;
counter =0;
countREQ =0;
MasterNotSlave=0;
end 

else 
begin
    if(~force_Request) begin counter = counter + 1; end
	
	if(MasterNotSlave) /* Master Scope */
	begin
		if(RW) /* Write from master side */
		begin
			case (par)
			0: @(negedge CLK)
				   begin
				   REG_FRAME <= 1'b0;
				   REG_A <= address_To_Contact;
				   REG_CBE <= RW;//command el write
				   par = 1;
				   end
			   
			1: begin
				   @(negedge CLK)
				   begin
				   if(counter > 1)
				   begin
				   REG_IRDY <= 1'b0;
				   REG_CBE <= 4'b1111;
				   REG_D <= WriteData;
				   counter = counter - 1;
				   end
				   else if (counter == 1)
				   begin 
				   par = 2; 
				   REG_FRAME <= 1'b1; 
				   REG_D <= WriteData;
				   end
				   end 
			   end
            2: begin
				   @(negedge CLK)
				   begin
				   REG_IRDY <= 1'b1;
				   REG_D <= 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
				   par=0;
				   MasterNotSlave<=1'b0;
				   end
               end			   
	endcase
		end	
		
		else /* Read from master side */
		begin
			case (par)

				3'b000: begin 
							@(negedge CLK)
							begin
							REG_FRAME<=1'b0;
							REG_A<=address_To_Contact;
							REG_CBE <= WR; //command el write
							par=1;
							end
					    end		
				
				3'b001: begin 
							@(negedge CLK)
							begin
							REG_A<=2'bzz;
							REG_IRDY<=1'b0;
							par=2;
							end
						end	

				3'b010: begin 
							par=3;
						end	

				3'b011:  @(negedge CLK)
					 begin
						if(~DEVSEL&&~TRDY&&~IRDY&&(countREQ>0))
							begin
							counter=counter-1;
							Memory[counterM]=AD;
							if(counterM ==9)begin counterM =0; end
							else begin counterM ++; end

							if (counterREQ ==1 )
							begin
							@(negedge CLK)
							begin FRAME<=1; end
							end

							else if (counterREQ==0)
							begin
							@(negedge CLK)
							begin
								REG_IRDY<=1;
								par=0;
								MasterNotSlave<=1'b0;
							end
							end
						    end
					  end
			endcase
		end
	end
	
	else	/* Slave scope */
	begin
		case (par)
			0: if (adress == adres 3al bus )
				begin
					//increment par by 2 in each state
					//odd numbers for write
					//even numbers for read
					if(CBE == ) /* Write from slave side */
					begin	
<<<<<<< HEAD
						@(negedge CLK)
=======
						@(negedge clk)
>>>>>>> e2b73d53e8247447da8eb92e7fc320fad3c87ce3
						begin
						REG_DEVSEL<=1'b0;
						REG_TRDY<=1'b0;
						par=1;
						end //end of negative edge	
					end
					else if (CBE == ) /* read from slave side*/
					begin
<<<<<<< HEAD
						@(negedge CLK)
=======
						@(negedge clk)
>>>>>>> e2b73d53e8247447da8eb92e7fc320fad3c87ce3
						begin
						REG_DEVSEL<=1'b0;
						par=2;
						end //end of negative edge	

					end
				end	
			1: for(integer i=0;i<4;i=i+1) //for loop that checks BE and assigns the corresponding bits into the memory
				begin                      
				  if(CBE[i]==1'b1)
					 begin 
					 memory[adrress eli geh][8*i:(8*(i+1))-1]<=AD[8*i:(8*(i+1))-1]; //memory[row][byte]
					 end
				end //end for loop
				if (FRAME=1'b1) 
				begin
<<<<<<< HEAD
					@(negedge CLK)
=======
					@(negedge clk)
>>>>>>> e2b73d53e8247447da8eb92e7fc320fad3c87ce3
					begin
					REG_DEVSEL<=1'b1;
					REG_TRDY<=1'b1;
					par=0;
					end
				end	
<<<<<<< HEAD
			2: @(negedge CLK)
=======
			2: @(negedge clk)
>>>>>>> e2b73d53e8247447da8eb92e7fc320fad3c87ce3
				begin
				REG_TRDY<=1'b0;
				REG_D<=(IRDY)?Data2write;
				par=3;
				end
<<<<<<< HEAD
			3: @(negedge CLK)
=======
			3: @(negedge clk)
>>>>>>> e2b73d53e8247447da8eb92e7fc320fad3c87ce3
				begin
				    if(~FRAME)
					begin
					REG_D<=(IRDY)?Data2write;
					end
					else
					begin
					REG_D<=(IRDY)?Data2write;
					REG_DEVSEL<=1'b1;
					REG_TRDY<=1'b1;
					par=0;
					end
				end
			endcase
	end


end

endmodule 
