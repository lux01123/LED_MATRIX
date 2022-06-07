D_S    BIT P3.0 
SHCP   BIT P3.1 	
STCP   BIT P3.2 
CON_TRO EQU R0
ORG 00H           
MAIN :                       
	 	  MOV DPTR,#MALED
		  MOV R1,#0 
	      MOV R3,#5
CHAY:        
          LCALL DULIEU
          LCALL QUET
          DJNZ R3,CHAY
          MOV R3,#5
          INC R1
          CJNE R1,#64,CHAY							
          LJMP MAIN
DULIEU:
          PUSH 01H
          MOV R0,#70H    
          MOV R2,#32                
LAPL_01:  
          MOV A,R1                                                  
          MOVC A, @A+DPTR                                      
          MOV @R0,A      
          INC R0         
          INC R1        
          DJNZ R2,LAPL_01
          POP 01H
          RET
;***********************************************
QUET:
          MOV R7,#11111110B  
LAPHANG: 
          MOV CON_TRO,#70H
          CLR STCP                 
LAPCOT: 
          CLR SHCP           
          MOV A,@R0				
          CLR C
          RLC A								 
          MOV @R0,A				
          SETB SHCP							
          MOV D_S,C                   		
          INC R0           
          CJNE R0,#91H,LAPCOT			
          SETB STCP       					
          MOV P2,R7                                
          LCALL DELAY
          MOV P2,#0FFH					 
		  SETB C
          MOV A,R7
		  RLC A
		  MOV R7,A
          CJNE R7,#0FFH,LAPHANG
RET
;******************************************* 
DELAY: 
          MOV 09H,#10
M: 
          MOV 10H,# 200            
          DJNZ 10H,$  // 2T  
          DJNZ 09H,M  // 2T
               
RET
MALED:
DB    000h,000h,000h,000h,000h,000h,000h,000h
DB    000h,000h,000h,000h,000h,000h,000h,000h
DB    000h,000h,000h,000h,000h,000h,000h,000h
DB    000h,000h,000h,000h,000h,000h,000h,000h		
DB	  000h,000h,066h,089h,091h,062h,000h,000h	    ;S
DB    000h,03Dh,042h,085h,081h,042h,03Ch,000h		;Q
DB    000h,080h,080h,0FFh,080h,080h,000h,000h		;T
DB	  000h,083h,044h,028h,010h,0FFh,000h,000h		;K
END