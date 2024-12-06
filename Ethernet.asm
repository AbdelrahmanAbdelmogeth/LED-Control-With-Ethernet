
_SPI_Ethernet_UserTCP:

;Ethernet.c,55 :: 		unsigned int reqLength, TethPktFlags* flags)
;Ethernet.c,58 :: 		for(len=0; len<10; len++)getRequest[len]=SPI_Ethernet_getByte();
	CLRF        SPI_Ethernet_UserTCP_Len_L0+0 
	CLRF        SPI_Ethernet_UserTCP_Len_L0+1 
L_SPI_Ethernet_UserTCP0:
	MOVLW       0
	SUBWF       SPI_Ethernet_UserTCP_Len_L0+1, 0 
	BTFSS       N_bit, 2 
	GOTO        L__SPI_Ethernet_UserTCP11
	MOVLW       10
	SUBWF       SPI_Ethernet_UserTCP_Len_L0+0, 0 
L__SPI_Ethernet_UserTCP11:
	BTFSC       N_bit, 0 
	GOTO        L_SPI_Ethernet_UserTCP1
	MOVLW       _getRequest+0
	ADDWF       SPI_Ethernet_UserTCP_Len_L0+0, 0 
	MOVWF       FLOC__SPI_Ethernet_UserTCP+0 
	MOVLW       hi_addr(_getRequest+0)
	ADDWFC      SPI_Ethernet_UserTCP_Len_L0+1, 0 
	MOVWF       FLOC__SPI_Ethernet_UserTCP+1 
	CALL        _SPI_Ethernet_getByte+0, 0
	MOVFF       FLOC__SPI_Ethernet_UserTCP+0, FSR1
	MOVFF       FLOC__SPI_Ethernet_UserTCP+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1 
	INFSNZ      SPI_Ethernet_UserTCP_Len_L0+0, 1 
	INCF        SPI_Ethernet_UserTCP_Len_L0+1, 1 
	GOTO        L_SPI_Ethernet_UserTCP0
L_SPI_Ethernet_UserTCP1:
;Ethernet.c,59 :: 		getRequest[len]=0;
	MOVLW       _getRequest+0
	ADDWF       SPI_Ethernet_UserTCP_Len_L0+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       hi_addr(_getRequest+0)
	ADDWFC      SPI_Ethernet_UserTCP_Len_L0+1, 0 
	MOVWF       FSR1L+1 
	MOVFF       FSR1L+0, FSR1
	MOVFF       FSR1L+1, FSR1H
	CLRF        POSTINC1 
;Ethernet.c,60 :: 		if(memcmp(getRequest,"GET /",5))return(0);
	MOVLW       _getRequest+0
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_getRequest+0)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr1_Ethernet+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr1_Ethernet+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       5
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       N_bit, 2 
	GOTO        L_SPI_Ethernet_UserTCP3
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
L_SPI_Ethernet_UserTCP3:
;Ethernet.c,61 :: 		if(!memcmp(getRequest+6,"TA",2))RD0_bit = ~ RD0_bit;
	MOVLW       _getRequest+6
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_getRequest+6)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr2_Ethernet+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr2_Ethernet+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       2
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       N_bit, 2 
	GOTO        L_SPI_Ethernet_UserTCP4
	BTG         RD0_bit, 0 
	GOTO        L_SPI_Ethernet_UserTCP5
L_SPI_Ethernet_UserTCP4:
;Ethernet.c,62 :: 		else if(!memcmp(getRequest+6,"TB",2))RD1_bit = ~ RD1_bit;
	MOVLW       _getRequest+6
	MOVWF       FARG_memcmp_s1+0 
	MOVLW       hi_addr(_getRequest+6)
	MOVWF       FARG_memcmp_s1+1 
	MOVLW       ?lstr3_Ethernet+0
	MOVWF       FARG_memcmp_s2+0 
	MOVLW       hi_addr(?lstr3_Ethernet+0)
	MOVWF       FARG_memcmp_s2+1 
	MOVLW       2
	MOVWF       FARG_memcmp_n+0 
	MOVLW       0
	MOVWF       FARG_memcmp_n+1 
	CALL        _memcmp+0, 0
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSS       N_bit, 2 
	GOTO        L_SPI_Ethernet_UserTCP6
	BTG         RD0_bit, 1 
L_SPI_Ethernet_UserTCP6:
L_SPI_Ethernet_UserTCP5:
;Ethernet.c,63 :: 		if(localPort != 80)return(0);
	MOVLW       0
	XORWF       FARG_SPI_Ethernet_UserTCP_localPort+1, 0 
	BTFSS       N_bit, 2 
	GOTO        L__SPI_Ethernet_UserTCP12
	MOVLW       80
	XORWF       FARG_SPI_Ethernet_UserTCP_localPort+0, 0 
L__SPI_Ethernet_UserTCP12:
	BTFSC       N_bit, 2 
	GOTO        L_SPI_Ethernet_UserTCP7
	CLRF        R0 
	CLRF        R1 
	GOTO        L_end_SPI_Ethernet_UserTCP
L_SPI_Ethernet_UserTCP7:
;Ethernet.c,64 :: 		Len = SPI_Ethernet_putConstString(HTTPheader);
	MOVLW       _HTTPheader+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_HTTPheader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_HTTPheader+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_Len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_Len_L0+1 
;Ethernet.c,65 :: 		Len += SPI_Ethernet_putConstString(HTTPMimeTypeHTML);
	MOVLW       _HTTPMimeTypeHTML+0
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+0 
	MOVLW       hi_addr(_HTTPMimeTypeHTML+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+1 
	MOVLW       higher_addr(_HTTPMimeTypeHTML+0)
	MOVWF       FARG_SPI_Ethernet_putConstString_ptr+2 
	CALL        _SPI_Ethernet_putConstString+0, 0
	MOVF        R0, 0 
	ADDWF       SPI_Ethernet_UserTCP_Len_L0+0, 1 
	MOVF        R1, 0 
	ADDWFC      SPI_Ethernet_UserTCP_Len_L0+1, 1 
;Ethernet.c,66 :: 		Len += SPI_Ethernet_putString(StrtPage);
	MOVLW       _StrtPage+0
	MOVWF       FARG_SPI_Ethernet_putString_ptr+0 
	MOVLW       hi_addr(_StrtPage+0)
	MOVWF       FARG_SPI_Ethernet_putString_ptr+1 
	CALL        _SPI_Ethernet_putString+0, 0
	MOVF        SPI_Ethernet_UserTCP_Len_L0+0, 0 
	ADDWF       R0, 1 
	MOVF        SPI_Ethernet_UserTCP_Len_L0+1, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       SPI_Ethernet_UserTCP_Len_L0+0 
	MOVF        R1, 0 
	MOVWF       SPI_Ethernet_UserTCP_Len_L0+1 
;Ethernet.c,67 :: 		return Len;
;Ethernet.c,68 :: 		}
L_end_SPI_Ethernet_UserTCP:
	RETURN      0
; end of _SPI_Ethernet_UserTCP

_SPI_Ethernet_UserUDP:

;Ethernet.c,74 :: 		unsigned int reqLength, TEthPktFlags *flags)
;Ethernet.c,76 :: 		return(0);
	CLRF        R0 
	CLRF        R1 
;Ethernet.c,77 :: 		}
L_end_SPI_Ethernet_UserUDP:
	RETURN      0
; end of _SPI_Ethernet_UserUDP

_main:

;Ethernet.c,81 :: 		void main()
;Ethernet.c,83 :: 		ANSELC = 0; // Configure PORTC as digital
	CLRF        ANSC7_bit 
;Ethernet.c,84 :: 		ANSELD = 0; // Configure PORTD as digital
	CLRF        ANSD7_bit 
;Ethernet.c,85 :: 		TRISD = 0; // Configure PORTD as output
	CLRF        TRISD0_bit 
;Ethernet.c,86 :: 		PORTD = 0;
	CLRF        RD0_bit 
;Ethernet.c,87 :: 		SPI1_Init(); // Inialize SPI module
	CALL        _SPI1_Init+0, 0
;Ethernet.c,88 :: 		SPI_Ethernet_Init(MACAddr, IPAddr, 0x01); // Initialize Ethernet module
	MOVLW       _MACAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_mac+0 
	MOVLW       hi_addr(_MACAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_mac+1 
	MOVLW       _IPAddr+0
	MOVWF       FARG_SPI_Ethernet_Init_ip+0 
	MOVLW       hi_addr(_IPAddr+0)
	MOVWF       FARG_SPI_Ethernet_Init_ip+1 
	MOVLW       1
	MOVWF       FARG_SPI_Ethernet_Init_fullDuplex+0 
	CALL        _SPI_Ethernet_Init+0, 0
;Ethernet.c,89 :: 		while(1) // Do forever
L_main8:
;Ethernet.c,91 :: 		SPI_Ethernet_doPacket(); // Process next received packet
	CALL        _SPI_Ethernet_doPacket+0, 0
;Ethernet.c,92 :: 		}
	GOTO        L_main8
;Ethernet.c,93 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
