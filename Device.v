module Device (DeviceAddress[1:0],force_Request,address_To_Contact[1:0],RW,address_Enable,GNT,REQ,AD[31:0],IRDY,TRDY,FRAME,CBE[3:0],DEVSEL,CLK);

input reg RW,DeviceAddress[1:0],force_Request,address_To_Contact[1:0],address_Enable;
input  CLK,GNT;
output REQ,FRAME;
inout  AD[31:0],IRDY,TRDY,CBE[3:0];



reg [31:0] REG_D;
reg [1:0]  REG_A;
reg [3:0] REG_CBE;
reg [31:0] Memory [9:0];
integer    counter;


assign REQ    = ~force_Request;
assign DEVSEL = ~address_Enable;


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
						
						par=1;
					end
					else if (CBE == ) /* read from slave side*/
					begin
						
						par=2;
					end
				end	
			1:
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