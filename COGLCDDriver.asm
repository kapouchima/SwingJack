
_LCD_Init:

;COGLCDDriver.c,1 :: 		void LCD_Init(unsigned char lines)
;COGLCDDriver.c,3 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;COGLCDDriver.c,4 :: 		I2C1_wr(0x7c);  //send slave address  with write
	MOVLW       124
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,6 :: 		I2C1_wr(0x80);   // control byte
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,7 :: 		if(lines==2)
	MOVF        FARG_LCD_Init_lines+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_Init0
;COGLCDDriver.c,8 :: 		I2C1_wr(0x38);   //FUNCTION SET 8 bit,N=1 2-line display mode,5*7dot
	MOVLW       56
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
L_LCD_Init0:
;COGLCDDriver.c,9 :: 		if(lines==1)
	MOVF        FARG_LCD_Init_lines+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_Init1
;COGLCDDriver.c,10 :: 		I2C1_wr(0x34);
	MOVLW       52
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
L_LCD_Init1:
;COGLCDDriver.c,12 :: 		I2C1_wr(0x80);   // control byte
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,13 :: 		if(lines==2)
	MOVF        FARG_LCD_Init_lines+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_Init2
;COGLCDDriver.c,14 :: 		I2C1_wr(0x39);  //FUNCTION SET 8 bit,N=1 2-line display mode,5*7dot IS=1
	MOVLW       57
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
L_LCD_Init2:
;COGLCDDriver.c,15 :: 		if(lines==1)
	MOVF        FARG_LCD_Init_lines+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_Init3
;COGLCDDriver.c,16 :: 		I2C1_wr(0x35);
	MOVLW       53
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
L_LCD_Init3:
;COGLCDDriver.c,18 :: 		I2C1_wr(0x80);   // control byte
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,19 :: 		I2C1_wr(0x1c);   //Internal OSC frequency adjustment 183HZ    bias will be 1/4
	MOVLW       28
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,21 :: 		I2C1_wr(0x80);   // control byte
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,22 :: 		I2C1_wr(0x72);    //Contrast control  low byte
	MOVLW       114
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,24 :: 		I2C1_wr(0x80);     // control byte
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,25 :: 		I2C1_wr(0x55);    //booster circuit is turn on.    /ICON display off. /Contrast control   high byte
	MOVLW       85
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,27 :: 		I2C1_wr(0x80);    // control byte
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,28 :: 		I2C1_wr(0x6c);  //Follower control
	MOVLW       108
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,30 :: 		I2C1_wr(0x80);   // control byte
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,31 :: 		I2C1_wr(0x0c);    //DISPLAY ON
	MOVLW       12
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,33 :: 		I2C1_wr(0x80);   // control byte
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,34 :: 		I2C1_wr(0x01);   //CLEAR DISPLAY
	MOVLW       1
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,36 :: 		I2C1_wr(0x80);   // control byte
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,37 :: 		I2C1_wr(0x06);   //ENTRY MODE SET  CURSOR MOVES TO RIGHT
	MOVLW       6
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,39 :: 		I2C1_wr(0x80);   // control byte
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,40 :: 		I2C1_wr(0x02);
	MOVLW       2
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,42 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;COGLCDDriver.c,44 :: 		}
	RETURN      0
; end of _LCD_Init

_SetContrast:

;COGLCDDriver.c,47 :: 		void SetContrast(unsigned char val)
;COGLCDDriver.c,49 :: 		unsigned char valh=0,vall=0;
	CLRF        SetContrast_valh_L0+0 
	CLRF        SetContrast_vall_L0+0 
;COGLCDDriver.c,50 :: 		val=val&0b00111111;
	MOVLW       63
	ANDWF       FARG_SetContrast_val+0, 0 
	MOVWF       R2 
	MOVF        R2, 0 
	MOVWF       FARG_SetContrast_val+0 
;COGLCDDriver.c,51 :: 		valh=0x54;
	MOVLW       84
	MOVWF       SetContrast_valh_L0+0 
;COGLCDDriver.c,52 :: 		valh|=(val>>4);
	MOVF        R2, 0 
	MOVWF       R0 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	RRCF        R0, 1 
	BCF         R0, 7 
	MOVLW       84
	IORWF       R0, 0 
	MOVWF       SetContrast_valh_L0+0 
;COGLCDDriver.c,53 :: 		vall=0x70;
	MOVLW       112
	MOVWF       SetContrast_vall_L0+0 
;COGLCDDriver.c,54 :: 		vall|=(val&0b1111);
	MOVLW       15
	ANDWF       R2, 0 
	MOVWF       R0 
	MOVLW       112
	IORWF       R0, 0 
	MOVWF       SetContrast_vall_L0+0 
;COGLCDDriver.c,55 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;COGLCDDriver.c,57 :: 		I2C1_wr(0x7c);  //send slave address  with write
	MOVLW       124
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,58 :: 		I2C1_wr(0x80);     // control byte
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,59 :: 		I2C1_wr(valh);    //booster circuit is turn on.    /ICON display off. /Contrast control   high byte
	MOVF        SetContrast_valh_L0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,61 :: 		I2C1_wr(0x80);   // control byte
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,62 :: 		I2C1_wr(vall);    //Contrast control  low byte
	MOVF        SetContrast_vall_L0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,63 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;COGLCDDriver.c,64 :: 		delay_ms(1);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_SetContrast4:
	DECFSZ      R13, 1, 0
	BRA         L_SetContrast4
	DECFSZ      R12, 1, 0
	BRA         L_SetContrast4
	NOP
	NOP
;COGLCDDriver.c,65 :: 		}
	RETURN      0
; end of _SetContrast

_LCD_Putch:

;COGLCDDriver.c,67 :: 		void LCD_Putch(unsigned char dat,unsigned char add,unsigned char Nline)
;COGLCDDriver.c,69 :: 		if(Nline==1)
	MOVF        FARG_LCD_Putch_Nline+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_Putch5
;COGLCDDriver.c,70 :: 		add=0x80+add;
	MOVLW       128
	ADDWF       FARG_LCD_Putch_add+0, 1 
L_LCD_Putch5:
;COGLCDDriver.c,71 :: 		if(Nline==2)
	MOVF        FARG_LCD_Putch_Nline+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_Putch6
;COGLCDDriver.c,72 :: 		add=0xc0+add;
	MOVLW       192
	ADDWF       FARG_LCD_Putch_add+0, 1 
L_LCD_Putch6:
;COGLCDDriver.c,73 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;COGLCDDriver.c,74 :: 		I2C1_wr(0x7c);
	MOVLW       124
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,75 :: 		I2C1_wr(0x80);
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,76 :: 		I2C1_wr(add);
	MOVF        FARG_LCD_Putch_add+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,77 :: 		I2C1_wr(0x40);
	MOVLW       64
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,78 :: 		I2C1_wr(dat);
	MOVF        FARG_LCD_Putch_dat+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,79 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;COGLCDDriver.c,80 :: 		delay_ms(1);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_LCD_Putch7:
	DECFSZ      R13, 1, 0
	BRA         L_LCD_Putch7
	DECFSZ      R12, 1, 0
	BRA         L_LCD_Putch7
	NOP
	NOP
;COGLCDDriver.c,82 :: 		return;
;COGLCDDriver.c,83 :: 		}
	RETURN      0
; end of _LCD_Putch

_LCD_out:

;COGLCDDriver.c,86 :: 		void LCD_out(unsigned char line,unsigned char offset,unsigned char* dat)
;COGLCDDriver.c,88 :: 		unsigned char i=0,add=0;
	CLRF        LCD_out_i_L0+0 
	CLRF        LCD_out_add_L0+0 
;COGLCDDriver.c,89 :: 		if(line==1)
	MOVF        FARG_LCD_out_line+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_out8
;COGLCDDriver.c,90 :: 		add=0x80+offset;
	MOVF        FARG_LCD_out_offset+0, 0 
	ADDLW       128
	MOVWF       LCD_out_add_L0+0 
L_LCD_out8:
;COGLCDDriver.c,91 :: 		if(line==2)
	MOVF        FARG_LCD_out_line+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_LCD_out9
;COGLCDDriver.c,92 :: 		add=0xc0+offset;
	MOVF        FARG_LCD_out_offset+0, 0 
	ADDLW       192
	MOVWF       LCD_out_add_L0+0 
L_LCD_out9:
;COGLCDDriver.c,93 :: 		I2C1_Start();
	CALL        _I2C1_Start+0, 0
;COGLCDDriver.c,94 :: 		I2C1_wr(0x7c);
	MOVLW       124
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,95 :: 		I2C1_wr(0x80);
	MOVLW       128
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,96 :: 		I2C1_wr(add);
	MOVF        LCD_out_add_L0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,97 :: 		I2C1_wr(0x40);
	MOVLW       64
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
;COGLCDDriver.c,98 :: 		while((dat[i]!='\n')&&(i<=16))
L_LCD_out10:
	MOVF        LCD_out_i_L0+0, 0 
	ADDWF       FARG_LCD_out_dat+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_LCD_out_dat+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_LCD_out11
	MOVF        LCD_out_i_L0+0, 0 
	SUBLW       16
	BTFSS       STATUS+0, 0 
	GOTO        L_LCD_out11
L__LCD_out15:
;COGLCDDriver.c,99 :: 		{I2C1_wr(dat[i]);i=i+1;}
	MOVF        LCD_out_i_L0+0, 0 
	ADDWF       FARG_LCD_out_dat+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_LCD_out_dat+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_I2C1_Wr_data_+0 
	CALL        _I2C1_Wr+0, 0
	INCF        LCD_out_i_L0+0, 1 
	GOTO        L_LCD_out10
L_LCD_out11:
;COGLCDDriver.c,100 :: 		I2C1_Stop();
	CALL        _I2C1_Stop+0, 0
;COGLCDDriver.c,101 :: 		delay_ms(1);
	MOVLW       13
	MOVWF       R12, 0
	MOVLW       251
	MOVWF       R13, 0
L_LCD_out14:
	DECFSZ      R13, 1, 0
	BRA         L_LCD_out14
	DECFSZ      R12, 1, 0
	BRA         L_LCD_out14
	NOP
	NOP
;COGLCDDriver.c,103 :: 		return;
;COGLCDDriver.c,104 :: 		}
	RETURN      0
; end of _LCD_out
