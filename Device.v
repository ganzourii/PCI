module Device (DeviceAddress[1:0],force_Request,address_To_Contact[1:0],WriteData,RW,GNT,REQ,AD[31:0],IRDY,TRDY,FRAME,CBE[3:0],DEVSEL,CLK,RST);

output REQ;

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



assign REQ    = ~force_Request;
assign DEVSEL = SelectedAddress? 1'b0 :  ;


always @(posedge CLK)
begin
    if(~force_Request) begin counter = counter + 1; end
	
	if(~GNT) /* Master Scope */
	begin
		if(RW) /* Write from master side */
		begin
			case (par)
			0: begin
				   @negedge
				   begin
				   REG_FRAME <= 1'b0;
				   REG_A <= address_To_Contact;
				   REG_CBE <= command el write;
				   par = 1;
				   end
			   end
			1: begin
				   @negedge
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
				   @negedge
				   begin
				   REG_IRDY <= 1'b1;
				   REG_D <= 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
				   par=0;
				   end
               end			   
		    endcase
		end	
		
		else /* Read from master side */
		begin
			case (par)

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
						@negedge
						begin
						REG_DEVSEL<=1'b0;
						REG_TRDY<=1'b0;
						par=1;
						end //end of negative edge	
					end
					else if (CBE == ) /* read from slave side*/
					begin
						@negedge
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
					@negedge
					begin
					REG_DEVSEL<=1'b1;
					REG_TRDY<=1'b1;
					par=0;
					end
				end	
			2: @negedge
				begin
				REG_TRDY<=1'b0;
				REG_D<=(IRDY)?Data2write;
				par=3;
				end
			3: @negedge
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
