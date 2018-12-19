module Device (DeviceAddress[1:0],force_Request,address_To_Contact[1:0],RW,GNT,REQ,AD[31:0],IRDY,TRDY,FRAME,CBE[3:0],DEVSEL,CLK,RST);

output REQ,FRAME;

input  RW,CLK,GNT,RST,force_Request;
input  [1:0] address_To_Contact;
input  [1:0] DeviceAddress;

inout IRDY,TRDY,DEVSEL;
inout [31:0] AD;
inout [3:0] CBE;

reg REG_IRDY;
reg REG_TRDY;
reg [31:0] REG_D;
reg [1:0]  REG_A;
reg [3:0]  REG_CBE;
reg [31:0] Memory [0:9];
integer    counter;
reg SelectedAddress; 

assign REQ    = ~force_Request;
assign DEVSEL = SelectedAddress? 1'b0 :  ;


always @(posedge CLK)
begin
	if(~GNT) /* Master Scope */
	begin
		if(RW) /* Write from master side */
		begin
			case (par)

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
						   DEVSEL<=1'b0;
                                        	   TRDY<=1'b0;

						 end //end of negative edge
						
					 par=1;
					end
					else if (CBE == ) /* read from slave side*/
					begin
						
						par=2;
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
				  DEVSEL<=1'b1;
                                  TRDY<=1'b1;
                                 end
			end	
			2:
		endcase
	end

/*
end
else if (
if(~GNT&IRDY&TRDY&FRAME) 
begin
	FRAME <= 0;
	REG_A <= address_To_Contact;
	REG_CBE <= (RW)?  :  ; 

*/



end

endmodule
