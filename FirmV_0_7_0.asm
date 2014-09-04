
_interrupt:

;FirmV_0_7_0.c,180 :: 		void interrupt()
;FirmV_0_7_0.c,182 :: 		if(TMR0IF_bit)
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;FirmV_0_7_0.c,184 :: 		msCounter=msCounter+1;
	INCF        _msCounter+0, 1 
;FirmV_0_7_0.c,185 :: 		LCDBackLight=1;
	BSF         PORTB+0, 3 
;FirmV_0_7_0.c,186 :: 		Flag20ms=1;
	MOVLW       1
	MOVWF       _Flag20ms+0 
;FirmV_0_7_0.c,187 :: 		if(ms20A==255)
	MOVF        _ms20A+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;FirmV_0_7_0.c,188 :: 		{ms20A=0;RemotePulse1=0;}
	CLRF        _ms20A+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt2
L_interrupt1:
;FirmV_0_7_0.c,190 :: 		ms20A=ms20A+1;
	INCF        _ms20A+0, 1 
L_interrupt2:
;FirmV_0_7_0.c,192 :: 		if(ms20B==255)
	MOVF        _ms20B+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;FirmV_0_7_0.c,193 :: 		{ms20B=0;RemotePulse2=0;}
	CLRF        _ms20B+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt4
L_interrupt3:
;FirmV_0_7_0.c,195 :: 		ms20B=ms20B+1;
	INCF        _ms20B+0, 1 
L_interrupt4:
;FirmV_0_7_0.c,197 :: 		if(msCounter>=25)
	MOVLW       25
	SUBWF       _msCounter+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt5
;FirmV_0_7_0.c,199 :: 		msCounter=0;
	CLRF        _msCounter+0 
;FirmV_0_7_0.c,200 :: 		ms500=ms500+1;
	MOVLW       1
	ADDWF       _ms500+0, 1 
	MOVLW       0
	ADDWFC      _ms500+1, 1 
	ADDWFC      _ms500+2, 1 
	ADDWFC      _ms500+3, 1 
;FirmV_0_7_0.c,201 :: 		LCDFlashFlag=!LCDFlashFlag;
	MOVF        _LCDFlashFlag+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _LCDFlashFlag+0 
;FirmV_0_7_0.c,202 :: 		LCDBackLight=0;
	BCF         PORTB+0, 3 
;FirmV_0_7_0.c,203 :: 		Flag500ms=1;
	MOVLW       1
	MOVWF       _Flag500ms+0 
;FirmV_0_7_0.c,204 :: 		}
L_interrupt5:
;FirmV_0_7_0.c,205 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,206 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,207 :: 		TMR0IF_bit=0;
	BCF         TMR0IF_bit+0, 2 
;FirmV_0_7_0.c,208 :: 		}
L_interrupt0:
;FirmV_0_7_0.c,211 :: 		if(INT1F_bit)
	BTFSS       INT1F_bit+0, 0 
	GOTO        L_interrupt6
;FirmV_0_7_0.c,213 :: 		if(RemotePulse1==0)
	MOVF        _RemotePulse1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;FirmV_0_7_0.c,214 :: 		{ RemotePulse1=RemotePulse1+1;ms20A=0;}
	INCF        _RemotePulse1+0, 1 
	CLRF        _ms20A+0 
	GOTO        L_interrupt8
L_interrupt7:
;FirmV_0_7_0.c,216 :: 		{ RemotePulse1=RemotePulse1+1;}
	INCF        _RemotePulse1+0, 1 
L_interrupt8:
;FirmV_0_7_0.c,217 :: 		if(RemotePulse1>=5)
	MOVLW       5
	SUBWF       _RemotePulse1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt9
;FirmV_0_7_0.c,218 :: 		if((ms20A>=19)&&(ms20A<=21))
	MOVLW       19
	SUBWF       _ms20A+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
	MOVF        _ms20A+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
L__interrupt544:
;FirmV_0_7_0.c,219 :: 		{RemoteAFlag=1;RemotePulse1=0;}
	MOVLW       1
	MOVWF       _RemoteAFlag+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt13
L_interrupt12:
;FirmV_0_7_0.c,221 :: 		RemotePulse1=0;
	CLRF        _RemotePulse1+0 
L_interrupt13:
L_interrupt9:
;FirmV_0_7_0.c,222 :: 		INT1IF_bit=0;
	BCF         INT1IF_bit+0, 0 
;FirmV_0_7_0.c,223 :: 		}
L_interrupt6:
;FirmV_0_7_0.c,227 :: 		if(INT2IF_bit)
	BTFSS       INT2IF_bit+0, 1 
	GOTO        L_interrupt14
;FirmV_0_7_0.c,229 :: 		if(RemotePulse2==0)
	MOVF        _RemotePulse2+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt15
;FirmV_0_7_0.c,230 :: 		{ RemotePulse2=RemotePulse2+1;ms20B=0;}
	INCF        _RemotePulse2+0, 1 
	CLRF        _ms20B+0 
	GOTO        L_interrupt16
L_interrupt15:
;FirmV_0_7_0.c,232 :: 		{ RemotePulse2=RemotePulse2+1;}
	INCF        _RemotePulse2+0, 1 
L_interrupt16:
;FirmV_0_7_0.c,233 :: 		if(RemotePulse2>=5)
	MOVLW       5
	SUBWF       _RemotePulse2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt17
;FirmV_0_7_0.c,234 :: 		if((ms20B>=19)&&(ms20B<=21))
	MOVLW       19
	SUBWF       _ms20B+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
	MOVF        _ms20B+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
L__interrupt543:
;FirmV_0_7_0.c,235 :: 		{RemoteBFlag=1;RemotePulse2=0;}
	MOVLW       1
	MOVWF       _RemoteBFlag+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt21
L_interrupt20:
;FirmV_0_7_0.c,237 :: 		RemotePulse2=0;
	CLRF        _RemotePulse2+0 
L_interrupt21:
L_interrupt17:
;FirmV_0_7_0.c,238 :: 		INT2IF_bit=0;
	BCF         INT2IF_bit+0, 1 
;FirmV_0_7_0.c,239 :: 		}
L_interrupt14:
;FirmV_0_7_0.c,244 :: 		if(INT0F_bit==1)
	BTFSS       INT0F_bit+0, 1 
	GOTO        L_interrupt22
;FirmV_0_7_0.c,246 :: 		ZCCounter=ZCCounter+1;
	INCF        _ZCCounter+0, 1 
;FirmV_0_7_0.c,247 :: 		if(ZCCounter==255)
	MOVF        _ZCCounter+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt23
;FirmV_0_7_0.c,248 :: 		ZCCounter=0;
	CLRF        _ZCCounter+0 
L_interrupt23:
;FirmV_0_7_0.c,249 :: 		if(ZCCounter%3==1)
	MOVLW       3
	MOVWF       R4 
	MOVF        _ZCCounter+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt24
;FirmV_0_7_0.c,251 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt25
;FirmV_0_7_0.c,252 :: 		if(Motor1FullSpeed)
	MOVF        _Motor1FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt26
;FirmV_0_7_0.c,253 :: 		Motor1=1;
	BSF         PORTC+0, 1 
	GOTO        L_interrupt27
L_interrupt26:
;FirmV_0_7_0.c,255 :: 		Motor1=0;
	BCF         PORTC+0, 1 
L_interrupt27:
L_interrupt25:
;FirmV_0_7_0.c,257 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt28
;FirmV_0_7_0.c,258 :: 		if(Motor2FullSpeed)
	MOVF        _Motor2FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt29
;FirmV_0_7_0.c,259 :: 		Motor2=1;
	BSF         PORTC+0, 0 
	GOTO        L_interrupt30
L_interrupt29:
;FirmV_0_7_0.c,261 :: 		Motor2=0;
	BCF         PORTC+0, 0 
L_interrupt30:
L_interrupt28:
;FirmV_0_7_0.c,262 :: 		}
L_interrupt24:
;FirmV_0_7_0.c,263 :: 		if(ZCCounter%3==0)
	MOVLW       3
	MOVWF       R4 
	MOVF        _ZCCounter+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt31
;FirmV_0_7_0.c,265 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt32
;FirmV_0_7_0.c,266 :: 		Motor1=1;
	BSF         PORTC+0, 1 
L_interrupt32:
;FirmV_0_7_0.c,268 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt33
;FirmV_0_7_0.c,269 :: 		Motor2=1;
	BSF         PORTC+0, 0 
L_interrupt33:
;FirmV_0_7_0.c,270 :: 		}
L_interrupt31:
;FirmV_0_7_0.c,271 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, 1 
;FirmV_0_7_0.c,272 :: 		}
L_interrupt22:
;FirmV_0_7_0.c,273 :: 		}
L__interrupt636:
	RETFIE      1
; end of _interrupt

_ResetTaskEvents:

;FirmV_0_7_0.c,286 :: 		void ResetTaskEvents()
;FirmV_0_7_0.c,288 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,289 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,290 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,291 :: 		}
	RETURN      0
; end of _ResetTaskEvents

_Logger:

;FirmV_0_7_0.c,303 :: 		void Logger(char* text)
;FirmV_0_7_0.c,306 :: 		longwordtostrwithzeros(ms500,time);
	MOVF        _ms500+0, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+0 
	MOVF        _ms500+1, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+1 
	MOVF        _ms500+2, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+2 
	MOVF        _ms500+3, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+3 
	MOVLW       Logger_time_L0+0
	MOVWF       FARG_LongWordToStrWithZeros_output+0 
	MOVLW       hi_addr(Logger_time_L0+0)
	MOVWF       FARG_LongWordToStrWithZeros_output+1 
	CALL        _LongWordToStrWithZeros+0, 0
;FirmV_0_7_0.c,307 :: 		uart_write_text(time);
	MOVLW       Logger_time_L0+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(Logger_time_L0+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;FirmV_0_7_0.c,308 :: 		uart1_write_text(": ");
	MOVLW       58
	MOVWF       ?lstr1_FirmV_0_7_0+0 
	MOVLW       32
	MOVWF       ?lstr1_FirmV_0_7_0+1 
	CLRF        ?lstr1_FirmV_0_7_0+2 
	MOVLW       ?lstr1_FirmV_0_7_0+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_FirmV_0_7_0+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;FirmV_0_7_0.c,309 :: 		uart1_write_text(text);
	MOVF        FARG_Logger_text+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_Logger_text+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;FirmV_0_7_0.c,310 :: 		uart1_write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,311 :: 		uart1_write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,312 :: 		}
	RETURN      0
; end of _Logger

_main:

;FirmV_0_7_0.c,329 :: 		void main() {
;FirmV_0_7_0.c,331 :: 		PhotocellRel=1;
	BSF         PORTC+0, 5 
;FirmV_0_7_0.c,333 :: 		Init();
	CALL        _Init+0, 0
;FirmV_0_7_0.c,335 :: 		Logger("Start ...");
	MOVLW       83
	MOVWF       ?lstr2_FirmV_0_7_0+0 
	MOVLW       116
	MOVWF       ?lstr2_FirmV_0_7_0+1 
	MOVLW       97
	MOVWF       ?lstr2_FirmV_0_7_0+2 
	MOVLW       114
	MOVWF       ?lstr2_FirmV_0_7_0+3 
	MOVLW       116
	MOVWF       ?lstr2_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr2_FirmV_0_7_0+5 
	MOVLW       46
	MOVWF       ?lstr2_FirmV_0_7_0+6 
	MOVLW       46
	MOVWF       ?lstr2_FirmV_0_7_0+7 
	MOVLW       46
	MOVWF       ?lstr2_FirmV_0_7_0+8 
	CLRF        ?lstr2_FirmV_0_7_0+9 
	MOVLW       ?lstr2_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr2_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,339 :: 		while(1)
L_main34:
;FirmV_0_7_0.c,341 :: 		if(Flag20ms==1)
	MOVF        _Flag20ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main36
;FirmV_0_7_0.c,343 :: 		if(DebouncingDelay<DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelay+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main37
;FirmV_0_7_0.c,344 :: 		DebouncingDelay=DebouncingDelay+1;
	INCF        _DebouncingDelay+0, 1 
L_main37:
;FirmV_0_7_0.c,345 :: 		LCDUpdater();
	CALL        _LCDUpdater+0, 0
;FirmV_0_7_0.c,346 :: 		Flag20ms=0;
	CLRF        _Flag20ms+0 
;FirmV_0_7_0.c,347 :: 		}
L_main36:
;FirmV_0_7_0.c,349 :: 		if(Flag500ms==1)
	MOVF        _Flag500ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main38
;FirmV_0_7_0.c,351 :: 		ResetTaskEvents();
	CALL        _ResetTaskEvents+0, 0
;FirmV_0_7_0.c,352 :: 		TaskManager();
	CALL        _TaskManager+0, 0
;FirmV_0_7_0.c,353 :: 		Flag500ms=0;
	CLRF        _Flag500ms+0 
;FirmV_0_7_0.c,354 :: 		}
L_main38:
;FirmV_0_7_0.c,355 :: 		EventHandler();
	CALL        _EventHandler+0, 0
;FirmV_0_7_0.c,356 :: 		StateManager();
	CALL        _StateManager+0, 0
;FirmV_0_7_0.c,357 :: 		}
	GOTO        L_main34
;FirmV_0_7_0.c,359 :: 		}
	GOTO        $+0
; end of _main

_StateManager:

;FirmV_0_7_0.c,384 :: 		void StateManager()
;FirmV_0_7_0.c,390 :: 		switch(State)
	GOTO        L_StateManager39
;FirmV_0_7_0.c,393 :: 		case 0: State1(); break;
L_StateManager41:
	CALL        _State1+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,395 :: 		case 1: State1(); break;
L_StateManager42:
	CALL        _State1+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,397 :: 		case 2: State2(); break;
L_StateManager43:
	CALL        _State2+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,399 :: 		case 3: State3(); break;
L_StateManager44:
	CALL        _State3+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,401 :: 		case 4: State4(); break;
L_StateManager45:
	CALL        _State4+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,403 :: 		case 5: State5(); break;
L_StateManager46:
	CALL        _State5+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,405 :: 		case 6: State6(); break;
L_StateManager47:
	CALL        _State6+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,407 :: 		case 7: State7(); break;
L_StateManager48:
	CALL        _State7+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,409 :: 		case 8: State8(); break;
L_StateManager49:
	CALL        _State8+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,411 :: 		case 10:State00(); break;
L_StateManager50:
	CALL        _State00+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,413 :: 		case 100:Menu0(); break;
L_StateManager51:
	CALL        _Menu0+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,415 :: 		case 101:Menu1(); break;
L_StateManager52:
	CALL        _Menu1+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,417 :: 		case 102:Menu2(); break;
L_StateManager53:
	CALL        _Menu2+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,419 :: 		case 103:Menu3(); break;
L_StateManager54:
	CALL        _Menu3+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,421 :: 		case 200:LearnAuto(); break;
L_StateManager55:
	CALL        _LearnAuto+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,423 :: 		case 201:LearnManual(); break;
L_StateManager56:
	CALL        _LearnManual+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,425 :: 		}
L_StateManager39:
	MOVF        _State+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager41
	MOVF        _State+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager42
	MOVF        _State+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager43
	MOVF        _State+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager44
	MOVF        _State+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager45
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager46
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager47
	MOVF        _State+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager48
	MOVF        _State+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager49
	MOVF        _State+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager50
	MOVF        _State+0, 0 
	XORLW       100
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager51
	MOVF        _State+0, 0 
	XORLW       101
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager52
	MOVF        _State+0, 0 
	XORLW       102
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager53
	MOVF        _State+0, 0 
	XORLW       103
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager54
	MOVF        _State+0, 0 
	XORLW       200
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager55
	MOVF        _State+0, 0 
	XORLW       201
	BTFSC       STATUS+0, 2 
	GOTO        L_StateManager56
L_StateManager40:
;FirmV_0_7_0.c,426 :: 		}
	RETURN      0
; end of _StateManager

_StateTest:

;FirmV_0_7_0.c,430 :: 		void StateTest()
;FirmV_0_7_0.c,432 :: 		if (Events.Photocell==1)
	MOVF        _Events+6, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StateTest57
;FirmV_0_7_0.c,433 :: 		LCDLine1[0]='1';
	MOVLW       49
	MOVWF       _LCDLine1+0 
	GOTO        L_StateTest58
L_StateTest57:
;FirmV_0_7_0.c,435 :: 		LCDLine1[0]='0';
	MOVLW       48
	MOVWF       _LCDLine1+0 
L_StateTest58:
;FirmV_0_7_0.c,437 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,439 :: 		}
	RETURN      0
; end of _StateTest

_State00:

;FirmV_0_7_0.c,443 :: 		void State00()
;FirmV_0_7_0.c,448 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,449 :: 		StartMotor(1,_Close);
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,450 :: 		StartMotor(2,_Close);
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,454 :: 		if(Events.Remote.b0==1)
	BTFSS       _Events+4, 0 
	GOTO        L_State0059
;FirmV_0_7_0.c,455 :: 		{Flasher=0;StopMotor(1);StopMotor(2);
	BCF         PORTC+0, 2 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,456 :: 		State=1;                }
	MOVLW       1
	MOVWF       _State+0 
L_State0059:
;FirmV_0_7_0.c,457 :: 		}
	RETURN      0
; end of _State00

_State1:

;FirmV_0_7_0.c,466 :: 		void State1()
;FirmV_0_7_0.c,468 :: 		char delay=3;
	MOVLW       3
	MOVWF       State1_delay_L0+0 
;FirmV_0_7_0.c,471 :: 		Flasher=0;
	BCF         PORTC+0, 2 
;FirmV_0_7_0.c,473 :: 		if(Events.Keys==2)
	MOVF        _Events+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State160
;FirmV_0_7_0.c,474 :: 		{State=100;MenuPointer=0;}
	MOVLW       100
	MOVWF       _State+0 
	CLRF        _MenuPointer+0 
L_State160:
;FirmV_0_7_0.c,476 :: 		ActiveDoors=3-Events.Remote;
	MOVF        _Events+4, 0 
	SUBLW       3
	MOVWF       _ActiveDoors+0 
;FirmV_0_7_0.c,480 :: 		if(Events.Remote!=0)
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State161
;FirmV_0_7_0.c,483 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,484 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,485 :: 		AddTask(ms500+1,12);
	MOVLW       1
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       12
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,486 :: 		temp=ms500+delay;
	MOVF        State1_delay_L0+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,487 :: 		AddTask(temp,1);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       1
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,488 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State162
;FirmV_0_7_0.c,489 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       7
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
	GOTO        L_State163
L_State162:
;FirmV_0_7_0.c,491 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _M1isSlow+0 
L_State163:
;FirmV_0_7_0.c,492 :: 		temp=ms500+OpenSoftStartTime+OverloadDelay+delay;
	MOVF        _OpenSoftStartTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVLW       2
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,493 :: 		AddTask(temp,10); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       10
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,494 :: 		temp=ms500+OpenSoftStartTime+delay;
	MOVF        _OpenSoftStartTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,495 :: 		AddTask(temp,5);//Speed up after soft start
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,496 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State164
;FirmV_0_7_0.c,497 :: 		{temp=ms500+Door1OpenTime-OpenSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
	MOVF        _Door1OpenTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _OpenSoftStopTime+0, 0 
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       7
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State164:
;FirmV_0_7_0.c,498 :: 		temp=ms500+Door1OpenTime+delay;
	MOVF        _Door1OpenTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,499 :: 		AddTask(temp,3);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,501 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State167
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State167
L__State1545:
;FirmV_0_7_0.c,503 :: 		temp=ms500+ActionTimeDiff+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,504 :: 		AddTask(temp,2);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       2
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,505 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State168
;FirmV_0_7_0.c,506 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,8); M2isSlow=1;}//speed down
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       8
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	GOTO        L_State169
L_State168:
;FirmV_0_7_0.c,508 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,6); M2isSlow=0;}//speed up
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       6
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _M2isSlow+0 
L_State169:
;FirmV_0_7_0.c,509 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+OverloadDelay+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _OpenSoftStartTime+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVLW       2
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,510 :: 		AddTask(temp,11); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       11
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,511 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _OpenSoftStartTime+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,512 :: 		AddTask(temp,6);//Speed up after soft start
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       6
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,513 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State170
;FirmV_0_7_0.c,514 :: 		{temp=ms500+ActionTimeDiff+Door2OpenTime-OpenSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _Door2OpenTime+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        _OpenSoftStopTime+0, 0 
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       8
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State170:
;FirmV_0_7_0.c,515 :: 		temp=ms500+Door2OpenTime+ActionTimeDiff+delay;
	MOVF        _Door2OpenTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,516 :: 		AddTask(temp,4);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       4
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,517 :: 		}
L_State167:
;FirmV_0_7_0.c,519 :: 		if(AutoCloseTime!=0)
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State1637
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State1637:
	BTFSC       STATUS+0, 2 
	GOTO        L_State171
;FirmV_0_7_0.c,520 :: 		{temp=ms500+AutoCloseTime+delay;AddTask(ms500+AutoCloseTime+delay,9);}
	MOVF        _AutoCloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVF        _AutoCloseTime+1, 0 
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State1_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State171:
;FirmV_0_7_0.c,522 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,523 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,524 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,525 :: 		State=3;
	MOVLW       3
	MOVWF       _State+0 
;FirmV_0_7_0.c,526 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,527 :: 		}
L_State161:
;FirmV_0_7_0.c,528 :: 		}
	RETURN      0
; end of _State1

_State2:

;FirmV_0_7_0.c,542 :: 		void State2()
;FirmV_0_7_0.c,544 :: 		char delay=2;
	MOVLW       2
	MOVWF       State2_delay_L0+0 
;FirmV_0_7_0.c,546 :: 		Flasher=0;
	BCF         PORTC+0, 2 
;FirmV_0_7_0.c,548 :: 		if((Events.Remote!=0)||(CheckTask(9)==1))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State2550
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State2550
	GOTO        L_State274
L__State2550:
;FirmV_0_7_0.c,551 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,552 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State2549
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State2549
	GOTO        L_State277
L__State2549:
;FirmV_0_7_0.c,554 :: 		temp=ms500+delay;
	MOVF        State2_delay_L0+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,555 :: 		AddTask(temp,1);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       1
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,556 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State278
;FirmV_0_7_0.c,557 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       7
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
	GOTO        L_State279
L_State278:
;FirmV_0_7_0.c,559 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _M1isSlow+0 
L_State279:
;FirmV_0_7_0.c,560 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
	MOVF        _CloseSoftStartTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVLW       2
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,561 :: 		AddTask(temp,10); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       10
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,562 :: 		temp=ms500+CloseSoftStartTime+delay;
	MOVF        _CloseSoftStartTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,563 :: 		AddTask(temp,5);//Speed up after soft start
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,564 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State280
;FirmV_0_7_0.c,565 :: 		{temp=ms500+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _CloseSoftStopTime+0, 0 
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       7
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State280:
;FirmV_0_7_0.c,566 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State281
;FirmV_0_7_0.c,567 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       3
	ADDWF       _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	GOTO        L_State282
L_State281:
;FirmV_0_7_0.c,569 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,3);}
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State282:
;FirmV_0_7_0.c,571 :: 		}
L_State277:
;FirmV_0_7_0.c,573 :: 		if((Door2CloseTime!=0)&&(ActiveDoors=2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State285
	MOVLW       2
	MOVWF       _ActiveDoors+0 
L__State2548:
;FirmV_0_7_0.c,575 :: 		temp=ms500+delay;
	MOVF        State2_delay_L0+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,576 :: 		AddTask(temp,2);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       2
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,577 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State286
;FirmV_0_7_0.c,578 :: 		{AddTask(temp,8); M2isSlow=1;}//speed down
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       8
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	GOTO        L_State287
L_State286:
;FirmV_0_7_0.c,580 :: 		{AddTask(temp,6); M2isSlow=0;}//speed up
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       6
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _M2isSlow+0 
L_State287:
;FirmV_0_7_0.c,581 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
	MOVF        _CloseSoftStartTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVLW       2
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,582 :: 		AddTask(temp,11); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       11
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,583 :: 		temp=ms500+CloseSoftStartTime+delay;
	MOVF        _CloseSoftStartTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,584 :: 		AddTask(temp,6);//Speed up after soft start
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       6
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,585 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State288
;FirmV_0_7_0.c,586 :: 		{temp=ms500+Door2CloseTime-CloseSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
	MOVF        _Door2CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _CloseSoftStopTime+0, 0 
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       8
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State288:
;FirmV_0_7_0.c,588 :: 		temp=ms500+Door2CloseTime+delay;
	MOVF        _Door2CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,589 :: 		AddTask(temp,4);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       4
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,593 :: 		temp=ms500+ActionTimeDiff+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,594 :: 		AddTask(temp,1);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       1
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,595 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State289
;FirmV_0_7_0.c,596 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       7
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
	GOTO        L_State290
L_State289:
;FirmV_0_7_0.c,598 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _M1isSlow+0 
L_State290:
;FirmV_0_7_0.c,599 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+OverloadDelay+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _CloseSoftStartTime+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVLW       2
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,600 :: 		AddTask(temp,10); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       10
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,601 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _CloseSoftStartTime+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,602 :: 		AddTask(temp,5);//Speed up after soft start
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,603 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State291
;FirmV_0_7_0.c,604 :: 		{temp=ms500+ActionTimeDiff+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        _CloseSoftStopTime+0, 0 
	SUBWF       R0, 1 
	MOVLW       0
	SUBWFB      R1, 1 
	SUBWFB      R2, 1 
	SUBWFB      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       7
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State291:
;FirmV_0_7_0.c,605 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State292
;FirmV_0_7_0.c,606 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       3
	ADDWF       _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	GOTO        L_State293
L_State292:
;FirmV_0_7_0.c,608 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,3);}
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State2_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
L_State293:
;FirmV_0_7_0.c,610 :: 		}
L_State285:
;FirmV_0_7_0.c,613 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,614 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,615 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,616 :: 		State=4;
	MOVLW       4
	MOVWF       _State+0 
;FirmV_0_7_0.c,617 :: 		}
L_State274:
;FirmV_0_7_0.c,619 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State296
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2638
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State2638:
	BTFSC       STATUS+0, 2 
	GOTO        L_State296
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State296
L__State2547:
;FirmV_0_7_0.c,620 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S2 Auto Close Deleted");}
	MOVLW       1
	MOVWF       _PassFlag+0 
	CALL        _GetAutocloseTime+0, 0
	MOVF        R0, 0 
	MOVWF       __AC+0 
	MOVLW       ?ICS?lstr3_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr3_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr3_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr3_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr3_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr3_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr3_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State296:
;FirmV_0_7_0.c,622 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State299
	BTFSC       _Events+6, 0 
	GOTO        L_State299
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2639
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State2639:
	BTFSC       STATUS+0, 2 
	GOTO        L_State299
L__State2546:
;FirmV_0_7_0.c,623 :: 		if(CloseAfterPass==0)
	MOVF        _CloseAfterPass+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State2100
;FirmV_0_7_0.c,624 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:");Logger(t);}
	MOVF        __AC+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _PassFlag+0 
	MOVF        _temp+0, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+3 
	MOVLW       _t+0
	MOVWF       FARG_LongWordToStrWithZeros_output+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_LongWordToStrWithZeros_output+1 
	CALL        _LongWordToStrWithZeros+0, 0
	MOVLW       ?ICS?lstr4_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr4_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr4_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr4_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr4_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       16
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr4_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr4_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       _t+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	GOTO        L_State2101
L_State2100:
;FirmV_0_7_0.c,626 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:");Logger(t);}
	MOVF        _CloseAfterPass+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _PassFlag+0 
	MOVF        _temp+0, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+3 
	MOVLW       _t+0
	MOVWF       FARG_LongWordToStrWithZeros_output+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_LongWordToStrWithZeros_output+1 
	CALL        _LongWordToStrWithZeros+0, 0
	MOVLW       ?ICS?lstr5_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr5_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr5_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr5_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr5_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       16
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr5_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr5_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       _t+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State2101:
L_State299:
;FirmV_0_7_0.c,628 :: 		}
	RETURN      0
; end of _State2

_State3:

;FirmV_0_7_0.c,643 :: 		void State3()
;FirmV_0_7_0.c,645 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,647 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3102
;FirmV_0_7_0.c,648 :: 		{StartMotor(1,_Open);Logger("S3 Motor1Start"); Lock=0;}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr6_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr6_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr6_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr6_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr6_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr6_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr6_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr6_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr6_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr6_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr6_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr6_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr6_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr6_FirmV_0_7_0+13 
	CLRF        ?lstr6_FirmV_0_7_0+14 
	MOVLW       ?lstr6_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr6_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	BCF         PORTD+0, 7 
L_State3102:
;FirmV_0_7_0.c,650 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3103
;FirmV_0_7_0.c,651 :: 		{StartMotor(2,_Open);Logger("S3 Motor2Start"); Lock=0;}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr7_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr7_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr7_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr7_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr7_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr7_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr7_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr7_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr7_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr7_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr7_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr7_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr7_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr7_FirmV_0_7_0+13 
	CLRF        ?lstr7_FirmV_0_7_0+14 
	MOVLW       ?lstr7_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr7_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	BCF         PORTD+0, 7 
L_State3103:
;FirmV_0_7_0.c,653 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3104
;FirmV_0_7_0.c,654 :: 		{SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;Logger("S3 Motor1 Fast");}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _M1isSlow+0 
	MOVLW       83
	MOVWF       ?lstr8_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr8_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr8_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr8_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr8_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr8_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr8_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr8_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr8_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr8_FirmV_0_7_0+9 
	MOVLW       70
	MOVWF       ?lstr8_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr8_FirmV_0_7_0+11 
	MOVLW       115
	MOVWF       ?lstr8_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr8_FirmV_0_7_0+13 
	CLRF        ?lstr8_FirmV_0_7_0+14 
	MOVLW       ?lstr8_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr8_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State3104:
;FirmV_0_7_0.c,656 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3105
;FirmV_0_7_0.c,657 :: 		{SetMotorSpeed(0,Motor2FullSpeed); M1isSlow=1;Logger("S3 Motor1 Slow");}
	CLRF        FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
	MOVLW       83
	MOVWF       ?lstr9_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr9_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr9_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr9_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr9_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr9_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr9_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr9_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr9_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr9_FirmV_0_7_0+9 
	MOVLW       83
	MOVWF       ?lstr9_FirmV_0_7_0+10 
	MOVLW       108
	MOVWF       ?lstr9_FirmV_0_7_0+11 
	MOVLW       111
	MOVWF       ?lstr9_FirmV_0_7_0+12 
	MOVLW       119
	MOVWF       ?lstr9_FirmV_0_7_0+13 
	CLRF        ?lstr9_FirmV_0_7_0+14 
	MOVLW       ?lstr9_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr9_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State3105:
;FirmV_0_7_0.c,659 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3106
;FirmV_0_7_0.c,660 :: 		{SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;Logger("S3 Motor2 Fast");}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag2+0 
	CLRF        _M2isSlow+0 
	MOVLW       83
	MOVWF       ?lstr10_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr10_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr10_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr10_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr10_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr10_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr10_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr10_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr10_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr10_FirmV_0_7_0+9 
	MOVLW       70
	MOVWF       ?lstr10_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr10_FirmV_0_7_0+11 
	MOVLW       115
	MOVWF       ?lstr10_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr10_FirmV_0_7_0+13 
	CLRF        ?lstr10_FirmV_0_7_0+14 
	MOVLW       ?lstr10_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr10_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State3106:
;FirmV_0_7_0.c,662 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3107
;FirmV_0_7_0.c,663 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S3 Motor2 Slow");}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CLRF        FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	MOVLW       83
	MOVWF       ?lstr11_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr11_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr11_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr11_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr11_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr11_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr11_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr11_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr11_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr11_FirmV_0_7_0+9 
	MOVLW       83
	MOVWF       ?lstr11_FirmV_0_7_0+10 
	MOVLW       108
	MOVWF       ?lstr11_FirmV_0_7_0+11 
	MOVLW       111
	MOVWF       ?lstr11_FirmV_0_7_0+12 
	MOVLW       119
	MOVWF       ?lstr11_FirmV_0_7_0+13 
	CLRF        ?lstr11_FirmV_0_7_0+14 
	MOVLW       ?lstr11_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr11_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State3107:
;FirmV_0_7_0.c,665 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3108
;FirmV_0_7_0.c,666 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S3 Overflow Flag1 Set");}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr12_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr12_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr12_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr12_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr12_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr12_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr12_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State3108:
;FirmV_0_7_0.c,668 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3109
;FirmV_0_7_0.c,669 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S3 Overflow Flag2 Set");}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr13_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr13_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr13_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr13_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr13_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr13_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr13_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State3109:
;FirmV_0_7_0.c,671 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3110
;FirmV_0_7_0.c,672 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S3 Motor1 Stop");}
	BCF         _OpenDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr14_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr14_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr14_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr14_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr14_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr14_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr14_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr14_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr14_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr14_FirmV_0_7_0+9 
	MOVLW       83
	MOVWF       ?lstr14_FirmV_0_7_0+10 
	MOVLW       116
	MOVWF       ?lstr14_FirmV_0_7_0+11 
	MOVLW       111
	MOVWF       ?lstr14_FirmV_0_7_0+12 
	MOVLW       112
	MOVWF       ?lstr14_FirmV_0_7_0+13 
	CLRF        ?lstr14_FirmV_0_7_0+14 
	MOVLW       ?lstr14_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr14_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State3110:
;FirmV_0_7_0.c,674 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3111
;FirmV_0_7_0.c,675 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S3 Motor2 Stop");}
	BCF         _OpenDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr15_FirmV_0_7_0+0 
	MOVLW       51
	MOVWF       ?lstr15_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr15_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr15_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr15_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr15_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr15_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr15_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr15_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr15_FirmV_0_7_0+9 
	MOVLW       83
	MOVWF       ?lstr15_FirmV_0_7_0+10 
	MOVLW       116
	MOVWF       ?lstr15_FirmV_0_7_0+11 
	MOVLW       111
	MOVWF       ?lstr15_FirmV_0_7_0+12 
	MOVLW       112
	MOVWF       ?lstr15_FirmV_0_7_0+13 
	CLRF        ?lstr15_FirmV_0_7_0+14 
	MOVLW       ?lstr15_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr15_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State3111:
;FirmV_0_7_0.c,677 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3112
;FirmV_0_7_0.c,678 :: 		{Lock=1;}
	BSF         PORTD+0, 7 
L_State3112:
;FirmV_0_7_0.c,680 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3115
	BTFSS       _Events+5, 0 
	GOTO        L_State3115
	MOVF        _M1isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3115
L__State3556:
;FirmV_0_7_0.c,681 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor1 Collision");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       5
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr16_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr16_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr16_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr16_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr16_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       20
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr16_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr16_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State3115:
;FirmV_0_7_0.c,683 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3118
	BTFSS       _Events+5, 1 
	GOTO        L_State3118
	MOVF        _M2isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3118
L__State3555:
;FirmV_0_7_0.c,684 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor2 Collision");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       5
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr17_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr17_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr17_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr17_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr17_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       20
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr17_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr17_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State3118:
;FirmV_0_7_0.c,686 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State3554
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State3554
	GOTO        L_State3121
L__State3554:
;FirmV_0_7_0.c,687 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State3121:
;FirmV_0_7_0.c,689 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State3124
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3124
L__State3553:
;FirmV_0_7_0.c,690 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Photocell Int");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       5
	MOVWF       _State+0 
	MOVLW       ?ICS?lstr18_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr18_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr18_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr18_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr18_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr18_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr18_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State3124:
;FirmV_0_7_0.c,692 :: 		if(Events.Remote.b0==1)
	BTFSS       _Events+4, 0 
	GOTO        L_State3125
;FirmV_0_7_0.c,693 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Remote Stoped");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       5
	MOVWF       _State+0 
	MOVLW       ?ICS?lstr19_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr19_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr19_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr19_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr19_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr19_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr19_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State3125:
;FirmV_0_7_0.c,695 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3128
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3128
L__State3552:
;FirmV_0_7_0.c,696 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Limit Switch Stoped");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       5
	MOVWF       _State+0 
	MOVLW       ?ICS?lstr20_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr20_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr20_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr20_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr20_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       23
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr20_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr20_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State3128:
;FirmV_0_7_0.c,698 :: 		if((Events.Remote.b0==1))
	BTFSS       _Events+4, 0 
	GOTO        L_State3129
;FirmV_0_7_0.c,699 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S3 Motors Stoped (Remote)");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       5
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr21_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr21_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr21_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr21_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr21_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       26
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr21_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr21_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State3129:
;FirmV_0_7_0.c,701 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3130
;FirmV_0_7_0.c,702 :: 		{State=2; PassFlag=0;ClearTasks(9);}
	MOVLW       2
	MOVWF       _State+0 
	CLRF        _PassFlag+0 
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State3130:
;FirmV_0_7_0.c,704 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State3551
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State3551
	GOTO        L_State3133
L__State3551:
;FirmV_0_7_0.c,705 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S3 Autoclose Renewed");}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State3640
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State3640:
	BTFSC       STATUS+0, 2 
	GOTO        L_State3134
	MOVF        _AutoCloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _AutoCloseTime+1, 0 
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       ?ICS?lstr22_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr22_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr22_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr22_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr22_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr22_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr22_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State3134:
L_State3133:
;FirmV_0_7_0.c,707 :: 		}
	RETURN      0
; end of _State3

_State4:

;FirmV_0_7_0.c,721 :: 		void State4()
;FirmV_0_7_0.c,723 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,725 :: 		bytetostr(Events.Task1,LCDLine1);
	MOVF        _Events+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,726 :: 		bytetostr(Events.Task2,LCDLine2);
	MOVF        _Events+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,727 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,729 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4135
;FirmV_0_7_0.c,730 :: 		{StartMotor(1,_Close);Logger("S4 Motor1Start");}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr23_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr23_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr23_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr23_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr23_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr23_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr23_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr23_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr23_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr23_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr23_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr23_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr23_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr23_FirmV_0_7_0+13 
	CLRF        ?lstr23_FirmV_0_7_0+14 
	MOVLW       ?lstr23_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr23_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4135:
;FirmV_0_7_0.c,732 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4136
;FirmV_0_7_0.c,733 :: 		{StartMotor(2,_Close);Logger("S4 Motor2Start");}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr24_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr24_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr24_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr24_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr24_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr24_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr24_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr24_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr24_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr24_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr24_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr24_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr24_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr24_FirmV_0_7_0+13 
	CLRF        ?lstr24_FirmV_0_7_0+14 
	MOVLW       ?lstr24_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr24_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4136:
;FirmV_0_7_0.c,735 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4137
;FirmV_0_7_0.c,736 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S4 M1 Overload Check");}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr25_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr25_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr25_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr25_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr25_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr25_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr25_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4137:
;FirmV_0_7_0.c,738 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4138
;FirmV_0_7_0.c,739 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S4 M2 Overload Check");}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr26_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr26_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr26_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr26_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr26_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr26_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr26_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4138:
;FirmV_0_7_0.c,741 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4139
;FirmV_0_7_0.c,742 :: 		{SetMotorSpeed(1,Motor2FullSpeed); OverloadCheckFlag1=0; M1isSlow=0;Logger("S4 M1 Speed UP");}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _M1isSlow+0 
	MOVLW       83
	MOVWF       ?lstr27_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr27_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr27_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr27_FirmV_0_7_0+3 
	MOVLW       49
	MOVWF       ?lstr27_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr27_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr27_FirmV_0_7_0+6 
	MOVLW       112
	MOVWF       ?lstr27_FirmV_0_7_0+7 
	MOVLW       101
	MOVWF       ?lstr27_FirmV_0_7_0+8 
	MOVLW       101
	MOVWF       ?lstr27_FirmV_0_7_0+9 
	MOVLW       100
	MOVWF       ?lstr27_FirmV_0_7_0+10 
	MOVLW       32
	MOVWF       ?lstr27_FirmV_0_7_0+11 
	MOVLW       85
	MOVWF       ?lstr27_FirmV_0_7_0+12 
	MOVLW       80
	MOVWF       ?lstr27_FirmV_0_7_0+13 
	CLRF        ?lstr27_FirmV_0_7_0+14 
	MOVLW       ?lstr27_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr27_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4139:
;FirmV_0_7_0.c,744 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4140
;FirmV_0_7_0.c,745 :: 		{SetMotorSpeed(0,Motor2FullSpeed); OverloadCheckFlag2=0; M1isSlow=1;Logger("S4 M1 Speed Down");}
	CLRF        FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       1
	MOVWF       _M1isSlow+0 
	MOVLW       ?ICS?lstr28_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr28_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr28_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr28_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr28_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr28_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr28_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4140:
;FirmV_0_7_0.c,747 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4141
;FirmV_0_7_0.c,748 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S4 M2 Speed UP");}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       83
	MOVWF       ?lstr29_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr29_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr29_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr29_FirmV_0_7_0+3 
	MOVLW       50
	MOVWF       ?lstr29_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr29_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr29_FirmV_0_7_0+6 
	MOVLW       112
	MOVWF       ?lstr29_FirmV_0_7_0+7 
	MOVLW       101
	MOVWF       ?lstr29_FirmV_0_7_0+8 
	MOVLW       101
	MOVWF       ?lstr29_FirmV_0_7_0+9 
	MOVLW       100
	MOVWF       ?lstr29_FirmV_0_7_0+10 
	MOVLW       32
	MOVWF       ?lstr29_FirmV_0_7_0+11 
	MOVLW       85
	MOVWF       ?lstr29_FirmV_0_7_0+12 
	MOVLW       80
	MOVWF       ?lstr29_FirmV_0_7_0+13 
	CLRF        ?lstr29_FirmV_0_7_0+14 
	MOVLW       ?lstr29_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr29_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4141:
;FirmV_0_7_0.c,750 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4142
;FirmV_0_7_0.c,751 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S4 M2 Speed Down");}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CLRF        FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	MOVLW       ?ICS?lstr30_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr30_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr30_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr30_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr30_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr30_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr30_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4142:
;FirmV_0_7_0.c,753 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4143
;FirmV_0_7_0.c,754 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S4 M1 Stoped");}
	BCF         _CloseDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr31_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr31_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr31_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr31_FirmV_0_7_0+3 
	MOVLW       49
	MOVWF       ?lstr31_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr31_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr31_FirmV_0_7_0+6 
	MOVLW       116
	MOVWF       ?lstr31_FirmV_0_7_0+7 
	MOVLW       111
	MOVWF       ?lstr31_FirmV_0_7_0+8 
	MOVLW       112
	MOVWF       ?lstr31_FirmV_0_7_0+9 
	MOVLW       101
	MOVWF       ?lstr31_FirmV_0_7_0+10 
	MOVLW       100
	MOVWF       ?lstr31_FirmV_0_7_0+11 
	CLRF        ?lstr31_FirmV_0_7_0+12 
	MOVLW       ?lstr31_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr31_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4143:
;FirmV_0_7_0.c,756 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4144
;FirmV_0_7_0.c,757 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S4 M2 Stoped");}
	BCF         _CloseDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr32_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr32_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr32_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr32_FirmV_0_7_0+3 
	MOVLW       50
	MOVWF       ?lstr32_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr32_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr32_FirmV_0_7_0+6 
	MOVLW       116
	MOVWF       ?lstr32_FirmV_0_7_0+7 
	MOVLW       111
	MOVWF       ?lstr32_FirmV_0_7_0+8 
	MOVLW       112
	MOVWF       ?lstr32_FirmV_0_7_0+9 
	MOVLW       101
	MOVWF       ?lstr32_FirmV_0_7_0+10 
	MOVLW       100
	MOVWF       ?lstr32_FirmV_0_7_0+11 
	CLRF        ?lstr32_FirmV_0_7_0+12 
	MOVLW       ?lstr32_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr32_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4144:
;FirmV_0_7_0.c,759 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4147
	BTFSS       _Events+5, 0 
	GOTO        L_State4147
	MOVF        _M1isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4147
L__State4561:
;FirmV_0_7_0.c,760 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M1 Overloaded");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       6
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr33_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr33_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr33_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr33_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr33_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr33_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr33_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State4147:
;FirmV_0_7_0.c,762 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4150
	BTFSS       _Events+5, 1 
	GOTO        L_State4150
	MOVF        _M2isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4150
L__State4560:
;FirmV_0_7_0.c,763 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M2 Overloaded");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       6
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr34_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr34_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr34_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr34_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr34_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr34_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr34_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State4150:
;FirmV_0_7_0.c,765 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State4559
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State4559
	GOTO        L_State4153
L__State4559:
;FirmV_0_7_0.c,766 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State4153:
;FirmV_0_7_0.c,768 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State4154
;FirmV_0_7_0.c,769 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S4 Photocell Int");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       6
	MOVWF       _State+0 
	MOVLW       1
	MOVWF       _PhotocellOpenFlag+0 
	MOVLW       ?ICS?lstr35_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr35_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr35_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr35_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr35_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr35_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr35_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State4154:
;FirmV_0_7_0.c,771 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4157
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4157
L__State4558:
;FirmV_0_7_0.c,772 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Limit Switch Stop");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       6
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr36_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr36_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr36_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr36_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr36_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr36_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr36_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State4157:
;FirmV_0_7_0.c,774 :: 		if((Events.Remote.b0==1))
	BTFSS       _Events+4, 0 
	GOTO        L_State4158
;FirmV_0_7_0.c,775 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Remote Pressed");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       6
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr37_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr37_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr37_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr37_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr37_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       18
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr37_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr37_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State4158:
;FirmV_0_7_0.c,777 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4159
;FirmV_0_7_0.c,778 :: 		{State=1; PassFlag=0;ClearTasks(9);}
	MOVLW       1
	MOVWF       _State+0 
	CLRF        _PassFlag+0 
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State4159:
;FirmV_0_7_0.c,780 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State4557
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State4557
	GOTO        L_State4162
L__State4557:
;FirmV_0_7_0.c,781 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S4 Autoclose Renewed");}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State4641
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State4641:
	BTFSC       STATUS+0, 2 
	GOTO        L_State4163
	MOVF        _AutoCloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _AutoCloseTime+1, 0 
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       ?ICS?lstr38_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr38_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr38_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr38_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr38_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr38_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr38_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4163:
L_State4162:
;FirmV_0_7_0.c,783 :: 		}
	RETURN      0
; end of _State4

_State5:

;FirmV_0_7_0.c,798 :: 		void State5()
;FirmV_0_7_0.c,800 :: 		char delay=2;
	MOVLW       2
	MOVWF       State5_delay_L0+0 
;FirmV_0_7_0.c,801 :: 		Flasher=0;
	BCF         PORTC+0, 2 
;FirmV_0_7_0.c,802 :: 		if((Events.Remote!=0)||(CheckTask(9)==1))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State5566
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5566
	GOTO        L_State5166
L__State5566:
;FirmV_0_7_0.c,804 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State5565
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5565
	GOTO        L_State5169
L__State5565:
;FirmV_0_7_0.c,806 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,807 :: 		temp=ms500+delay;
	MOVF        State5_delay_L0+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,808 :: 		AddTask(temp,1);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       1
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,809 :: 		AddTask(temp,5);
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,810 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,811 :: 		temp=ms500+OverloadDelay+delay;
	MOVLW       2
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,812 :: 		AddTask(temp,10); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       10
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,813 :: 		temp=ms500+Door1CloseTime+delay;
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,814 :: 		AddTask(temp,3);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,815 :: 		}
L_State5169:
;FirmV_0_7_0.c,816 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State5172
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State5172
L__State5564:
;FirmV_0_7_0.c,818 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,819 :: 		temp=ms500+delay;
	MOVF        State5_delay_L0+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,820 :: 		AddTask(temp,2);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       2
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,821 :: 		AddTask(temp,6);
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       6
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,822 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,823 :: 		temp=ms500+OverloadDelay+delay;
	MOVLW       2
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,824 :: 		AddTask(temp,11); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       11
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,825 :: 		temp=ms500+Door1CloseTime+delay;
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,826 :: 		AddTask(temp,4);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       4
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,831 :: 		temp=ms500+ActionTimeDiff+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,832 :: 		AddTask(temp,1);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       1
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,833 :: 		temp=ms500+ActionTimeDiff+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,834 :: 		AddTask(temp,5);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,835 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,836 :: 		temp=ms500+ActionTimeDiff+OverloadDelay+delay;
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVLW       2
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,837 :: 		AddTask(temp,10); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       10
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,838 :: 		temp=ms500+Door2CloseTime+delay;
	MOVF        _Door2CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State5_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,839 :: 		AddTask(temp,3);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,840 :: 		}
L_State5172:
;FirmV_0_7_0.c,841 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,842 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,843 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,844 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,845 :: 		}
L_State5166:
;FirmV_0_7_0.c,847 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State5175
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State5642
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State5642:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5175
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State5175
L__State5563:
;FirmV_0_7_0.c,848 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S5 Auto Close Deleted");}
	MOVLW       1
	MOVWF       _PassFlag+0 
	CALL        _GetAutocloseTime+0, 0
	MOVF        R0, 0 
	MOVWF       __AC+0 
	MOVLW       ?ICS?lstr39_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr39_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr39_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr39_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr39_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr39_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr39_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State5175:
;FirmV_0_7_0.c,850 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State5178
	BTFSC       _Events+6, 0 
	GOTO        L_State5178
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State5643
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State5643:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5178
L__State5562:
;FirmV_0_7_0.c,853 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:");Logger(t);}
	MOVF        __AC+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _PassFlag+0 
	MOVF        _temp+0, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+3 
	MOVLW       _t+0
	MOVWF       FARG_LongWordToStrWithZeros_output+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_LongWordToStrWithZeros_output+1 
	CALL        _LongWordToStrWithZeros+0, 0
	MOVLW       ?ICS?lstr40_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr40_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr40_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr40_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr40_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       16
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr40_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr40_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       _t+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,855 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:");Logger(t);}
L_State5180:
;FirmV_0_7_0.c,856 :: 		}
L_State5178:
;FirmV_0_7_0.c,858 :: 		}
	RETURN      0
; end of _State5

_State6:

;FirmV_0_7_0.c,878 :: 		void State6()
;FirmV_0_7_0.c,882 :: 		char delay=3;
	MOVLW       3
	MOVWF       State6_delay_L0+0 
;FirmV_0_7_0.c,883 :: 		Flasher=0;
	BCF         PORTC+0, 2 
;FirmV_0_7_0.c,884 :: 		if((Events.Remote!=0)||(PhotocellOpenFlag))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State6571
	MOVF        _PhotocellOpenFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6571
	GOTO        L_State6183
L__State6571:
;FirmV_0_7_0.c,886 :: 		PhotocellOpenFlag=0;
	CLRF        _PhotocellOpenFlag+0 
;FirmV_0_7_0.c,887 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,888 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,889 :: 		AddTask(ms500+1,12);
	MOVLW       1
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       12
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,890 :: 		temp=ms500+delay;
	MOVF        State6_delay_L0+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,891 :: 		AddTask(temp,1);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       1
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,892 :: 		AddTask(temp,5);
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,893 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,894 :: 		temp=ms500+OverloadDelay+delay;
	MOVLW       2
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,895 :: 		AddTask(temp,10); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       10
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,896 :: 		temp=ms500+Door1OpenTime+delay;
	MOVF        _Door1OpenTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,897 :: 		AddTask(temp,3);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,898 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6186
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6186
L__State6570:
;FirmV_0_7_0.c,900 :: 		AddTask(ms500+ActionTimeDiff+delay,2);
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       2
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,901 :: 		AddTask(ms500+ActionTimeDiff+delay,6);
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       6
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,902 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,903 :: 		AddTask(ms500+ActionTimeDiff+OverloadDelay+delay,11); //overload check
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       2
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       11
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,904 :: 		AddTask(ms500+Door2OpenTime+delay,4);//Stop motor
	MOVF        _Door2OpenTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       4
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,905 :: 		}
L_State6186:
;FirmV_0_7_0.c,906 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,907 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,908 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,909 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,910 :: 		State=8;
	MOVLW       8
	MOVWF       _State+0 
;FirmV_0_7_0.c,911 :: 		}
L_State6183:
;FirmV_0_7_0.c,914 :: 		if(CheckTask(9)==1)
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6187
;FirmV_0_7_0.c,916 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,917 :: 		temp=ms500+delay;
	MOVF        State6_delay_L0+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,918 :: 		AddTask(temp,1);
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       1
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,919 :: 		AddTask(temp,5);
	MOVF        _temp+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       5
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,920 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,921 :: 		temp=ms500+OverloadDelay+delay;
	MOVLW       2
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,922 :: 		AddTask(temp,10); //overload check
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       10
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,923 :: 		temp=ms500+Door1CloseTime+delay;
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       R0, 1 
	MOVLW       0
	ADDWFC      R1, 1 
	ADDWFC      R2, 1 
	ADDWFC      R3, 1 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
;FirmV_0_7_0.c,924 :: 		AddTask(temp,3);//Stop motor
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       3
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,926 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6190
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6190
L__State6569:
;FirmV_0_7_0.c,928 :: 		AddTask(ms500+ActionTimeDiff+delay,2);
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       2
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,929 :: 		AddTask(ms500+ActionTimeDiff+delay,6);
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       6
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,930 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,931 :: 		AddTask(ms500+ActionTimeDiff+OverloadDelay+delay,11); //overload check
	MOVF        _ActionTimeDiff+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       2
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       11
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,932 :: 		AddTask(ms500+Door1CloseTime+delay,4);//Stop motor
	MOVF        _Door1CloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVF        State6_delay_L0+0, 0 
	ADDWF       FARG_AddTask+0, 1 
	MOVLW       0
	ADDWFC      FARG_AddTask+1, 1 
	ADDWFC      FARG_AddTask+2, 1 
	ADDWFC      FARG_AddTask+3, 1 
	MOVLW       4
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
;FirmV_0_7_0.c,933 :: 		}
L_State6190:
;FirmV_0_7_0.c,934 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,935 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,936 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,937 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,938 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,939 :: 		}
L_State6187:
;FirmV_0_7_0.c,941 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State6193
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6644
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State6644:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6193
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State6193
L__State6568:
;FirmV_0_7_0.c,942 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S6 Auto Close Deleted");}
	MOVLW       1
	MOVWF       _PassFlag+0 
	CALL        _GetAutocloseTime+0, 0
	MOVF        R0, 0 
	MOVWF       __AC+0 
	MOVLW       ?ICS?lstr42_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr42_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr42_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr42_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr42_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr42_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr42_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State6193:
;FirmV_0_7_0.c,944 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6196
	BTFSC       _Events+6, 0 
	GOTO        L_State6196
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6645
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State6645:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6196
L__State6567:
;FirmV_0_7_0.c,946 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:");Logger(t);}
	MOVF        __AC+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       _temp+0 
	MOVF        R1, 0 
	MOVWF       _temp+1 
	MOVF        R2, 0 
	MOVWF       _temp+2 
	MOVF        R3, 0 
	MOVWF       _temp+3 
	MOVF        R0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        R1, 0 
	MOVWF       FARG_AddTask+1 
	MOVF        R2, 0 
	MOVWF       FARG_AddTask+2 
	MOVF        R3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	CLRF        _PassFlag+0 
	MOVF        _temp+0, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+0 
	MOVF        _temp+1, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+1 
	MOVF        _temp+2, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+2 
	MOVF        _temp+3, 0 
	MOVWF       FARG_LongWordToStrWithZeros_input+3 
	MOVLW       _t+0
	MOVWF       FARG_LongWordToStrWithZeros_output+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_LongWordToStrWithZeros_output+1 
	CALL        _LongWordToStrWithZeros+0, 0
	MOVLW       ?ICS?lstr43_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr43_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr43_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr43_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr43_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       16
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr43_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr43_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       _t+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,948 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:");Logger(t);}
L_State6198:
;FirmV_0_7_0.c,949 :: 		}
L_State6196:
;FirmV_0_7_0.c,951 :: 		}
	RETURN      0
; end of _State6

_State7:

;FirmV_0_7_0.c,973 :: 		void State7()
;FirmV_0_7_0.c,975 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,977 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7199
;FirmV_0_7_0.c,978 :: 		{StartMotor(1,_Close);Logger("S7 Motor1Start");}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr45_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr45_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr45_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr45_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr45_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr45_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr45_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr45_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr45_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr45_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr45_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr45_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr45_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr45_FirmV_0_7_0+13 
	CLRF        ?lstr45_FirmV_0_7_0+14 
	MOVLW       ?lstr45_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr45_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State7199:
;FirmV_0_7_0.c,980 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7200
;FirmV_0_7_0.c,981 :: 		{StartMotor(2,_Close);Logger("S7 Motor2Start");}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr46_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr46_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr46_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr46_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr46_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr46_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr46_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr46_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr46_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr46_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr46_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr46_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr46_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr46_FirmV_0_7_0+13 
	CLRF        ?lstr46_FirmV_0_7_0+14 
	MOVLW       ?lstr46_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr46_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State7200:
;FirmV_0_7_0.c,983 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7201
;FirmV_0_7_0.c,984 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S7 M1 Overload Check");}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr47_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr47_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr47_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr47_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr47_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr47_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr47_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State7201:
;FirmV_0_7_0.c,986 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7202
;FirmV_0_7_0.c,987 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S7 M2 Overload Check");}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr48_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr48_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr48_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr48_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr48_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr48_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr48_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State7202:
;FirmV_0_7_0.c,989 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7203
;FirmV_0_7_0.c,990 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S7 M1 Speed UP");}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
	MOVLW       83
	MOVWF       ?lstr49_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr49_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr49_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr49_FirmV_0_7_0+3 
	MOVLW       49
	MOVWF       ?lstr49_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr49_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr49_FirmV_0_7_0+6 
	MOVLW       112
	MOVWF       ?lstr49_FirmV_0_7_0+7 
	MOVLW       101
	MOVWF       ?lstr49_FirmV_0_7_0+8 
	MOVLW       101
	MOVWF       ?lstr49_FirmV_0_7_0+9 
	MOVLW       100
	MOVWF       ?lstr49_FirmV_0_7_0+10 
	MOVLW       32
	MOVWF       ?lstr49_FirmV_0_7_0+11 
	MOVLW       85
	MOVWF       ?lstr49_FirmV_0_7_0+12 
	MOVLW       80
	MOVWF       ?lstr49_FirmV_0_7_0+13 
	CLRF        ?lstr49_FirmV_0_7_0+14 
	MOVLW       ?lstr49_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr49_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State7203:
;FirmV_0_7_0.c,992 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7204
;FirmV_0_7_0.c,993 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S7 M2 Speed UP");}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       83
	MOVWF       ?lstr50_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr50_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr50_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr50_FirmV_0_7_0+3 
	MOVLW       50
	MOVWF       ?lstr50_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr50_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr50_FirmV_0_7_0+6 
	MOVLW       112
	MOVWF       ?lstr50_FirmV_0_7_0+7 
	MOVLW       101
	MOVWF       ?lstr50_FirmV_0_7_0+8 
	MOVLW       101
	MOVWF       ?lstr50_FirmV_0_7_0+9 
	MOVLW       100
	MOVWF       ?lstr50_FirmV_0_7_0+10 
	MOVLW       32
	MOVWF       ?lstr50_FirmV_0_7_0+11 
	MOVLW       85
	MOVWF       ?lstr50_FirmV_0_7_0+12 
	MOVLW       80
	MOVWF       ?lstr50_FirmV_0_7_0+13 
	CLRF        ?lstr50_FirmV_0_7_0+14 
	MOVLW       ?lstr50_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr50_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State7204:
;FirmV_0_7_0.c,995 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(CloseDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7579
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7580
	BTFSS       _Events+5, 0 
	GOTO        L__State7580
	GOTO        L__State7579
L__State7580:
	GOTO        L_State7211
L__State7579:
	BTFSS       _CloseDone+0, 0 
	GOTO        L_State7211
L__State7578:
;FirmV_0_7_0.c,996 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S7 M1 Stoped");}
	BCF         _CloseDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr51_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr51_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr51_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr51_FirmV_0_7_0+3 
	MOVLW       49
	MOVWF       ?lstr51_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr51_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr51_FirmV_0_7_0+6 
	MOVLW       116
	MOVWF       ?lstr51_FirmV_0_7_0+7 
	MOVLW       111
	MOVWF       ?lstr51_FirmV_0_7_0+8 
	MOVLW       112
	MOVWF       ?lstr51_FirmV_0_7_0+9 
	MOVLW       101
	MOVWF       ?lstr51_FirmV_0_7_0+10 
	MOVLW       100
	MOVWF       ?lstr51_FirmV_0_7_0+11 
	CLRF        ?lstr51_FirmV_0_7_0+12 
	MOVLW       ?lstr51_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr51_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State7211:
;FirmV_0_7_0.c,998 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(CloseDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7576
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7577
	BTFSS       _Events+5, 1 
	GOTO        L__State7577
	GOTO        L__State7576
L__State7577:
	GOTO        L_State7218
L__State7576:
	BTFSS       _CloseDone+0, 1 
	GOTO        L_State7218
L__State7575:
;FirmV_0_7_0.c,999 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S7 M2 Stoped");}
	BCF         _CloseDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr52_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr52_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr52_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr52_FirmV_0_7_0+3 
	MOVLW       50
	MOVWF       ?lstr52_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr52_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr52_FirmV_0_7_0+6 
	MOVLW       116
	MOVWF       ?lstr52_FirmV_0_7_0+7 
	MOVLW       111
	MOVWF       ?lstr52_FirmV_0_7_0+8 
	MOVLW       112
	MOVWF       ?lstr52_FirmV_0_7_0+9 
	MOVLW       101
	MOVWF       ?lstr52_FirmV_0_7_0+10 
	MOVLW       100
	MOVWF       ?lstr52_FirmV_0_7_0+11 
	CLRF        ?lstr52_FirmV_0_7_0+12 
	MOVLW       ?lstr52_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr52_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State7218:
;FirmV_0_7_0.c,1001 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State7574
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State7574
	GOTO        L_State7221
L__State7574:
;FirmV_0_7_0.c,1002 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State7221:
;FirmV_0_7_0.c,1004 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State7222
;FirmV_0_7_0.c,1005 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S7 Photocell Int");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       6
	MOVWF       _State+0 
	MOVLW       1
	MOVWF       _PhotocellOpenFlag+0 
	MOVLW       ?ICS?lstr53_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr53_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr53_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr53_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr53_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr53_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr53_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State7222:
;FirmV_0_7_0.c,1007 :: 		if((Events.Remote.b0==1))
	BTFSS       _Events+4, 0 
	GOTO        L_State7223
;FirmV_0_7_0.c,1008 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Remote Pressed");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       6
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr54_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr54_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr54_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr54_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr54_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       18
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr54_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr54_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State7223:
;FirmV_0_7_0.c,1010 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State7226
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7226
L__State7573:
;FirmV_0_7_0.c,1011 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Limit Switch Stop");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       6
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr55_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr55_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr55_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr55_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr55_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr55_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr55_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State7226:
;FirmV_0_7_0.c,1013 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State7227
;FirmV_0_7_0.c,1014 :: 		{State=1; PassFlag=0;ClearTasks(9);}
	MOVLW       1
	MOVWF       _State+0 
	CLRF        _PassFlag+0 
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State7227:
;FirmV_0_7_0.c,1016 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State7572
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State7572
	GOTO        L_State7230
L__State7572:
;FirmV_0_7_0.c,1017 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S7 Autoclose Renewed");}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7646
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State7646:
	BTFSC       STATUS+0, 2 
	GOTO        L_State7231
	MOVF        _AutoCloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _AutoCloseTime+1, 0 
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       ?ICS?lstr56_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr56_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr56_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr56_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr56_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr56_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr56_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State7231:
L_State7230:
;FirmV_0_7_0.c,1020 :: 		}
	RETURN      0
; end of _State7

_State8:

;FirmV_0_7_0.c,1037 :: 		void State8()
;FirmV_0_7_0.c,1039 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,1041 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8232
;FirmV_0_7_0.c,1042 :: 		{StartMotor(1,_Open);Logger("S8 Motor1Start"); Lock=0;}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr57_FirmV_0_7_0+0 
	MOVLW       56
	MOVWF       ?lstr57_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr57_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr57_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr57_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr57_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr57_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr57_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr57_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr57_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr57_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr57_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr57_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr57_FirmV_0_7_0+13 
	CLRF        ?lstr57_FirmV_0_7_0+14 
	MOVLW       ?lstr57_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr57_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	BCF         PORTD+0, 7 
L_State8232:
;FirmV_0_7_0.c,1044 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8233
;FirmV_0_7_0.c,1045 :: 		{StartMotor(2,_Open);Logger("S8 Motor2Start"); Lock=0;}
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr58_FirmV_0_7_0+0 
	MOVLW       56
	MOVWF       ?lstr58_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr58_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr58_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr58_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr58_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr58_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr58_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr58_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr58_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr58_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr58_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr58_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr58_FirmV_0_7_0+13 
	CLRF        ?lstr58_FirmV_0_7_0+14 
	MOVLW       ?lstr58_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr58_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	BCF         PORTD+0, 7 
L_State8233:
;FirmV_0_7_0.c,1047 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8234
;FirmV_0_7_0.c,1048 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S8 Overflow Flag1 Set");}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr59_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr59_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr59_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr59_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr59_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr59_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr59_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State8234:
;FirmV_0_7_0.c,1050 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8235
;FirmV_0_7_0.c,1051 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S8 Overflow Flag2 Set");}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr60_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr60_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr60_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr60_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr60_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr60_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr60_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State8235:
;FirmV_0_7_0.c,1053 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8236
;FirmV_0_7_0.c,1054 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S8 Motor1 Fast");}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
	MOVLW       83
	MOVWF       ?lstr61_FirmV_0_7_0+0 
	MOVLW       56
	MOVWF       ?lstr61_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr61_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr61_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr61_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr61_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr61_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr61_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr61_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr61_FirmV_0_7_0+9 
	MOVLW       70
	MOVWF       ?lstr61_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr61_FirmV_0_7_0+11 
	MOVLW       115
	MOVWF       ?lstr61_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr61_FirmV_0_7_0+13 
	CLRF        ?lstr61_FirmV_0_7_0+14 
	MOVLW       ?lstr61_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr61_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State8236:
;FirmV_0_7_0.c,1056 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8237
;FirmV_0_7_0.c,1057 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S8 Motor2 Fast");}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       83
	MOVWF       ?lstr62_FirmV_0_7_0+0 
	MOVLW       56
	MOVWF       ?lstr62_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr62_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr62_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr62_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr62_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr62_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr62_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr62_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr62_FirmV_0_7_0+9 
	MOVLW       70
	MOVWF       ?lstr62_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr62_FirmV_0_7_0+11 
	MOVLW       115
	MOVWF       ?lstr62_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr62_FirmV_0_7_0+13 
	CLRF        ?lstr62_FirmV_0_7_0+14 
	MOVLW       ?lstr62_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr62_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State8237:
;FirmV_0_7_0.c,1059 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(OpenDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8589
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8590
	BTFSS       _Events+5, 0 
	GOTO        L__State8590
	GOTO        L__State8589
L__State8590:
	GOTO        L_State8244
L__State8589:
	BTFSS       _OpenDone+0, 0 
	GOTO        L_State8244
L__State8588:
;FirmV_0_7_0.c,1060 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S8 Motor1 Stop");}
	BCF         _OpenDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr63_FirmV_0_7_0+0 
	MOVLW       56
	MOVWF       ?lstr63_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr63_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr63_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr63_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr63_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr63_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr63_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr63_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr63_FirmV_0_7_0+9 
	MOVLW       83
	MOVWF       ?lstr63_FirmV_0_7_0+10 
	MOVLW       116
	MOVWF       ?lstr63_FirmV_0_7_0+11 
	MOVLW       111
	MOVWF       ?lstr63_FirmV_0_7_0+12 
	MOVLW       112
	MOVWF       ?lstr63_FirmV_0_7_0+13 
	CLRF        ?lstr63_FirmV_0_7_0+14 
	MOVLW       ?lstr63_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr63_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State8244:
;FirmV_0_7_0.c,1062 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(OpenDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8586
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8587
	BTFSS       _Events+5, 1 
	GOTO        L__State8587
	GOTO        L__State8586
L__State8587:
	GOTO        L_State8251
L__State8586:
	BTFSS       _OpenDone+0, 1 
	GOTO        L_State8251
L__State8585:
;FirmV_0_7_0.c,1063 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S8 Motor2 Stop");}
	BCF         _OpenDone+0, 1 
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr64_FirmV_0_7_0+0 
	MOVLW       56
	MOVWF       ?lstr64_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr64_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr64_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr64_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr64_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr64_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr64_FirmV_0_7_0+7 
	MOVLW       50
	MOVWF       ?lstr64_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr64_FirmV_0_7_0+9 
	MOVLW       83
	MOVWF       ?lstr64_FirmV_0_7_0+10 
	MOVLW       116
	MOVWF       ?lstr64_FirmV_0_7_0+11 
	MOVLW       111
	MOVWF       ?lstr64_FirmV_0_7_0+12 
	MOVLW       112
	MOVWF       ?lstr64_FirmV_0_7_0+13 
	CLRF        ?lstr64_FirmV_0_7_0+14 
	MOVLW       ?lstr64_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr64_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State8251:
;FirmV_0_7_0.c,1065 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8252
;FirmV_0_7_0.c,1066 :: 		{Lock=1;}
	BSF         PORTD+0, 7 
L_State8252:
;FirmV_0_7_0.c,1068 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State8584
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State8584
	GOTO        L_State8255
L__State8584:
;FirmV_0_7_0.c,1069 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State8255:
;FirmV_0_7_0.c,1071 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State8258
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8258
L__State8583:
;FirmV_0_7_0.c,1072 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S8 Photocell Int");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       5
	MOVWF       _State+0 
	MOVLW       ?ICS?lstr65_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr65_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr65_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr65_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr65_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr65_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr65_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State8258:
;FirmV_0_7_0.c,1074 :: 		if((Events.Remote.b0==1))
	BTFSS       _Events+4, 0 
	GOTO        L_State8259
;FirmV_0_7_0.c,1075 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Motors Stoped (Remote)");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       5
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr66_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr66_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr66_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr66_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr66_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       26
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr66_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr66_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State8259:
;FirmV_0_7_0.c,1077 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State8262
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8262
L__State8582:
;FirmV_0_7_0.c,1078 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Limit Switch Stop");ClearTasks(9);}
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       5
	MOVWF       _State+0 
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       ?ICS?lstr67_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr67_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr67_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr67_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr67_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr67_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr67_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State8262:
;FirmV_0_7_0.c,1080 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State8263
;FirmV_0_7_0.c,1081 :: 		{State=2; PassFlag=0;ClearTasks(9);}
	MOVLW       2
	MOVWF       _State+0 
	CLRF        _PassFlag+0 
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
L_State8263:
;FirmV_0_7_0.c,1083 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State8581
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State8581
	GOTO        L_State8266
L__State8581:
;FirmV_0_7_0.c,1084 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S8 Autoclose Renewed");}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8647
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State8647:
	BTFSC       STATUS+0, 2 
	GOTO        L_State8267
	MOVF        _AutoCloseTime+0, 0 
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask+0 
	MOVF        _AutoCloseTime+1, 0 
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask+3 
	MOVLW       9
	MOVWF       FARG_AddTask+0 
	CALL        _AddTask+0, 0
	MOVLW       ?ICS?lstr68_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr68_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr68_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr68_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr68_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr68_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr68_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State8267:
L_State8266:
;FirmV_0_7_0.c,1087 :: 		}
	RETURN      0
; end of _State8

_LCDUpdater:

;FirmV_0_7_0.c,1096 :: 		void LCDUpdater()
;FirmV_0_7_0.c,1098 :: 		if(LCDUpdateFlag==1)
	MOVF        _LCDUpdateFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDUpdater268
;FirmV_0_7_0.c,1100 :: 		lcd_out(1,1,LCDLine1);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;FirmV_0_7_0.c,1101 :: 		lcd_out(2,1,LCDLine2);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;FirmV_0_7_0.c,1102 :: 		LCDUpdateFlag=0;
	CLRF        _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1103 :: 		}
L_LCDUpdater268:
;FirmV_0_7_0.c,1105 :: 		if(LCDFlash)
	MOVF        _LCDFlash+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater269
;FirmV_0_7_0.c,1107 :: 		if(LCDFlashFlag)
	MOVF        _LCDFlashFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater270
;FirmV_0_7_0.c,1108 :: 		lcd_out(2,1,"               ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?ICS?lstr69_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr69_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr69_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr69_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr69_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       16
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr69_FirmV_0_7_0+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr69_FirmV_0_7_0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_LCDUpdater271
L_LCDUpdater270:
;FirmV_0_7_0.c,1110 :: 		lcd_out(2,1,LCDLine2);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_LCDUpdater271:
;FirmV_0_7_0.c,1111 :: 		}
L_LCDUpdater269:
;FirmV_0_7_0.c,1114 :: 		}
	RETURN      0
; end of _LCDUpdater

_Init:

;FirmV_0_7_0.c,1134 :: 		void Init()
;FirmV_0_7_0.c,1136 :: 		char i=0;
	CLRF        Init_i_L0+0 
;FirmV_0_7_0.c,1138 :: 		porta=0;
	CLRF        PORTA+0 
;FirmV_0_7_0.c,1139 :: 		portb=0;
	CLRF        PORTB+0 
;FirmV_0_7_0.c,1140 :: 		portc=0;
	CLRF        PORTC+0 
;FirmV_0_7_0.c,1141 :: 		portd=0;
	CLRF        PORTD+0 
;FirmV_0_7_0.c,1142 :: 		porte=0;
	CLRF        PORTE+0 
;FirmV_0_7_0.c,1143 :: 		trisa=0b111111;
	MOVLW       63
	MOVWF       TRISA+0 
;FirmV_0_7_0.c,1144 :: 		trisb=0b00000111;
	MOVLW       7
	MOVWF       TRISB+0 
;FirmV_0_7_0.c,1145 :: 		trisc=0b10000000;
	MOVLW       128
	MOVWF       TRISC+0 
;FirmV_0_7_0.c,1146 :: 		trisd=0b01111111;
	MOVLW       127
	MOVWF       TRISD+0 
;FirmV_0_7_0.c,1147 :: 		trise=0b001;
	MOVLW       1
	MOVWF       TRISE+0 
;FirmV_0_7_0.c,1148 :: 		adcon1=0b1001;  // an6 and an7 is digital
	MOVLW       9
	MOVWF       ADCON1+0 
;FirmV_0_7_0.c,1153 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;FirmV_0_7_0.c,1154 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;FirmV_0_7_0.c,1157 :: 		ms500=0;
	CLRF        _ms500+0 
	CLRF        _ms500+1 
	CLRF        _ms500+2 
	CLRF        _ms500+3 
;FirmV_0_7_0.c,1158 :: 		t0con=0b10000101; //enable tmr0 and prescalar
	MOVLW       133
	MOVWF       T0CON+0 
;FirmV_0_7_0.c,1159 :: 		intcon.b7=1;   //global int enable
	BSF         INTCON+0, 7 
;FirmV_0_7_0.c,1160 :: 		intcon.b5=1;  //tmr0 int enable
	BSF         INTCON+0, 5 
;FirmV_0_7_0.c,1161 :: 		intcon.b2=0; //tmr0 flag
	BCF         INTCON+0, 2 
;FirmV_0_7_0.c,1162 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,1163 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,1166 :: 		INT1IP_bit=1;
	BSF         INT1IP_bit+0, 6 
;FirmV_0_7_0.c,1167 :: 		INT1E_bit=1;
	BSF         INT1E_bit+0, 3 
;FirmV_0_7_0.c,1168 :: 		INT1F_bit=0;
	BCF         INT1F_bit+0, 0 
;FirmV_0_7_0.c,1169 :: 		INT2IP_bit=1;
	BSF         INT2IP_bit+0, 7 
;FirmV_0_7_0.c,1170 :: 		INT2E_bit=1;
	BSF         INT2E_bit+0, 4 
;FirmV_0_7_0.c,1171 :: 		INT2F_bit=0;
	BCF         INT2F_bit+0, 1 
;FirmV_0_7_0.c,1172 :: 		INTEDG1_bit=1;
	BSF         INTEDG1_bit+0, 5 
;FirmV_0_7_0.c,1173 :: 		INTEDG2_bit=1;
	BSF         INTEDG2_bit+0, 4 
;FirmV_0_7_0.c,1176 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, 1 
;FirmV_0_7_0.c,1177 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, 4 
;FirmV_0_7_0.c,1180 :: 		for(i=0;i<20;i++)
	CLRF        Init_i_L0+0 
L_Init272:
	MOVLW       20
	SUBWF       Init_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Init273
;FirmV_0_7_0.c,1181 :: 		Tasks[i].Expired=1;
	MOVF        Init_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,1180 :: 		for(i=0;i<20;i++)
	INCF        Init_i_L0+0, 1 
;FirmV_0_7_0.c,1181 :: 		Tasks[i].Expired=1;
	GOTO        L_Init272
L_Init273:
;FirmV_0_7_0.c,1184 :: 		Events.Keys=0;
	CLRF        _Events+0 
;FirmV_0_7_0.c,1185 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,1186 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,1187 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,1188 :: 		Events.Remote=0;
	CLRF        _Events+4 
;FirmV_0_7_0.c,1189 :: 		Events.Overload=0;
	CLRF        _Events+5 
;FirmV_0_7_0.c,1190 :: 		Events.Photocell=0;
	CLRF        _Events+6 
;FirmV_0_7_0.c,1193 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,1196 :: 		UART1_init(115200);
	MOVLW       21
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;FirmV_0_7_0.c,1199 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,1201 :: 		}
	RETURN      0
; end of _Init

_TaskManager:

;FirmV_0_7_0.c,1215 :: 		void TaskManager()
;FirmV_0_7_0.c,1217 :: 		char i=0;
	CLRF        TaskManager_i_L0+0 
;FirmV_0_7_0.c,1218 :: 		for(i=0;i<20;i++)
	CLRF        TaskManager_i_L0+0 
L_TaskManager275:
	MOVLW       20
	SUBWF       TaskManager_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TaskManager276
;FirmV_0_7_0.c,1219 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Time==ms500)&&(Tasks[i].Fired==0))
	MOVF        TaskManager_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_TaskManager280
	MOVF        TaskManager_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVF        R4, 0 
	XORWF       _ms500+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager648
	MOVF        R3, 0 
	XORWF       _ms500+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager648
	MOVF        R2, 0 
	XORWF       _ms500+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager648
	MOVF        R1, 0 
	XORWF       _ms500+0, 0 
L__TaskManager648:
	BTFSS       STATUS+0, 2 
	GOTO        L_TaskManager280
	MOVF        TaskManager_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_TaskManager280
L__TaskManager591:
;FirmV_0_7_0.c,1220 :: 		Tasks[i].Fired=1;
	MOVF        TaskManager_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_TaskManager280:
;FirmV_0_7_0.c,1218 :: 		for(i=0;i<20;i++)
	INCF        TaskManager_i_L0+0, 1 
;FirmV_0_7_0.c,1220 :: 		Tasks[i].Fired=1;
	GOTO        L_TaskManager275
L_TaskManager276:
;FirmV_0_7_0.c,1221 :: 		}
	RETURN      0
; end of _TaskManager

_AddTask:

;FirmV_0_7_0.c,1233 :: 		void AddTask(unsigned long OccTime,char tcode)
;FirmV_0_7_0.c,1236 :: 		for(i=0;i<20;i++)
	CLRF        AddTask_i_L0+0 
L_AddTask281:
	MOVLW       20
	SUBWF       AddTask_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AddTask282
;FirmV_0_7_0.c,1237 :: 		if(Tasks[i].Expired==1)
	MOVF        AddTask_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_AddTask284
;FirmV_0_7_0.c,1239 :: 		Tasks[i].TaskCode=tcode;
	MOVF        AddTask_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        FARG_AddTask_tcode+0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,1240 :: 		Tasks[i].Time=OccTime;
	MOVF        AddTask_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        FARG_AddTask_OccTime+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_AddTask_OccTime+1, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_AddTask_OccTime+2, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_AddTask_OccTime+3, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,1241 :: 		Tasks[i].Expired=0;
	MOVF        AddTask_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;FirmV_0_7_0.c,1242 :: 		Tasks[i].Fired=0;
	MOVF        AddTask_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;FirmV_0_7_0.c,1243 :: 		break;
	GOTO        L_AddTask282
;FirmV_0_7_0.c,1244 :: 		}
L_AddTask284:
;FirmV_0_7_0.c,1236 :: 		for(i=0;i<20;i++)
	INCF        AddTask_i_L0+0, 1 
;FirmV_0_7_0.c,1244 :: 		}
	GOTO        L_AddTask281
L_AddTask282:
;FirmV_0_7_0.c,1245 :: 		}
	RETURN      0
; end of _AddTask

_EventHandler:

;FirmV_0_7_0.c,1255 :: 		void EventHandler()
;FirmV_0_7_0.c,1258 :: 		Events.ExternalKeys=GetExternalKeysState();
	CALL        _GetExternalKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+8 
;FirmV_0_7_0.c,1259 :: 		Events.Limiter=GetLimitSwitchState();
	CALL        _GetLimitSwitchState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+7 
;FirmV_0_7_0.c,1260 :: 		Events.Keys=GetKeysState();
	CALL        _GetKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+0 
;FirmV_0_7_0.c,1261 :: 		Events.Remote=GetRemoteState();
	CALL        _GetRemoteState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+4 
;FirmV_0_7_0.c,1262 :: 		Events.Overload=GetOverloadState();
	CALL        _GetOverloadState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+5 
;FirmV_0_7_0.c,1263 :: 		Events.Photocell=GetPhotocellState();
	CALL        _GetPhotocellState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+6 
;FirmV_0_7_0.c,1265 :: 		for(i=0;i<20;i++)
	CLRF        EventHandler_i_L0+0 
L_EventHandler285:
	MOVLW       20
	SUBWF       EventHandler_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_EventHandler286
;FirmV_0_7_0.c,1266 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Fired==1))
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler290
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler290
L__EventHandler592:
;FirmV_0_7_0.c,1268 :: 		if(Events.Task1==0)
	MOVF        _Events+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler291
;FirmV_0_7_0.c,1269 :: 		{Events.Task1=Tasks[i].TaskCode; Tasks[i].Expired=1;Tasks[i].Fired=0;}
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0L
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _Events+1 
	MOVLW       5
	ADDWF       R2, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	GOTO        L_EventHandler292
L_EventHandler291:
;FirmV_0_7_0.c,1270 :: 		else if(Events.Task2==0)
	MOVF        _Events+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler293
;FirmV_0_7_0.c,1271 :: 		{Events.Task2=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0L
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _Events+2 
	MOVLW       5
	ADDWF       R2, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	GOTO        L_EventHandler294
L_EventHandler293:
;FirmV_0_7_0.c,1272 :: 		else if(Events.Task3==0)
	MOVF        _Events+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler295
;FirmV_0_7_0.c,1273 :: 		{Events.Task3=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       R2 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       R3 
	MOVFF       R2, FSR0L
	MOVFF       R3, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _Events+3 
	MOVLW       5
	ADDWF       R2, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
	MOVF        EventHandler_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
L_EventHandler295:
L_EventHandler294:
L_EventHandler292:
;FirmV_0_7_0.c,1274 :: 		}
L_EventHandler290:
;FirmV_0_7_0.c,1265 :: 		for(i=0;i<20;i++)
	INCF        EventHandler_i_L0+0, 1 
;FirmV_0_7_0.c,1274 :: 		}
	GOTO        L_EventHandler285
L_EventHandler286:
;FirmV_0_7_0.c,1275 :: 		}
	RETURN      0
; end of _EventHandler

_GetKeysState:

;FirmV_0_7_0.c,1285 :: 		char GetKeysState()
;FirmV_0_7_0.c,1287 :: 		unsigned res=0;
	CLRF        GetKeysState_res_L0+0 
	CLRF        GetKeysState_res_L0+1 
;FirmV_0_7_0.c,1291 :: 		char resch=0,fin;
	CLRF        GetKeysState_resch_L0+0 
;FirmV_0_7_0.c,1292 :: 		res=ADC_Read(5);
	MOVLW       5
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       GetKeysState_res_L0+0 
	MOVF        R1, 0 
	MOVWF       GetKeysState_res_L0+1 
;FirmV_0_7_0.c,1293 :: 		if(((res>>2)>160)&&((res>>2)<185))
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	MOVLW       0
	MOVWF       R0 
	MOVF        R3, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState649
	MOVF        R2, 0 
	SUBLW       160
L__GetKeysState649:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState298
	MOVF        GetKeysState_res_L0+0, 0 
	MOVWF       R1 
	MOVF        GetKeysState_res_L0+1, 0 
	MOVWF       R2 
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R2, 7 
	MOVLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState650
	MOVLW       185
	SUBWF       R1, 0 
L__GetKeysState650:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState298
L__GetKeysState599:
;FirmV_0_7_0.c,1294 :: 		resch.b2=1;
	BSF         GetKeysState_resch_L0+0, 2 
L_GetKeysState298:
;FirmV_0_7_0.c,1295 :: 		if(((res>>2)>100)&&((res>>2)<160))
	MOVF        GetKeysState_res_L0+0, 0 
	MOVWF       R1 
	MOVF        GetKeysState_res_L0+1, 0 
	MOVWF       R2 
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R2, 7 
	MOVLW       0
	MOVWF       R0 
	MOVF        R2, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState651
	MOVF        R1, 0 
	SUBLW       100
L__GetKeysState651:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState301
	MOVF        GetKeysState_res_L0+0, 0 
	MOVWF       R1 
	MOVF        GetKeysState_res_L0+1, 0 
	MOVWF       R2 
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R2, 7 
	MOVLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState652
	MOVLW       160
	SUBWF       R1, 0 
L__GetKeysState652:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState301
L__GetKeysState598:
;FirmV_0_7_0.c,1296 :: 		resch.b1=1;
	BSF         GetKeysState_resch_L0+0, 1 
L_GetKeysState301:
;FirmV_0_7_0.c,1297 :: 		if((res>>2)<50)
	MOVF        GetKeysState_res_L0+0, 0 
	MOVWF       R1 
	MOVF        GetKeysState_res_L0+1, 0 
	MOVWF       R2 
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R2, 7 
	RRCF        R2, 1 
	RRCF        R1, 1 
	BCF         R2, 7 
	MOVLW       0
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState653
	MOVLW       50
	SUBWF       R1, 0 
L__GetKeysState653:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState302
;FirmV_0_7_0.c,1298 :: 		resch.b0=1;
	BSF         GetKeysState_resch_L0+0, 0 
L_GetKeysState302:
;FirmV_0_7_0.c,1300 :: 		if((resch==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState303
;FirmV_0_7_0.c,1302 :: 		if(Pressed==0)
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState304
;FirmV_0_7_0.c,1303 :: 		{Repeat=0;Pressed=0;fin=0;RepeatRate=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState304:
;FirmV_0_7_0.c,1304 :: 		if(Pressed==1)
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState305
;FirmV_0_7_0.c,1305 :: 		if(DebouncingDelay>=DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelay+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetKeysState306
;FirmV_0_7_0.c,1306 :: 		{Repeat=0;Pressed=0;fin=0;RepeatRate=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState306:
L_GetKeysState305:
;FirmV_0_7_0.c,1307 :: 		}
L_GetKeysState303:
;FirmV_0_7_0.c,1308 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0)&&(ms500==PressTime+KeyRepeatDelay))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState309
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState309
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState309
	MOVLW       3
	ADDWF       GetKeysState_PressTime_L0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      GetKeysState_PressTime_L0+1, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      GetKeysState_PressTime_L0+2, 0 
	MOVWF       R3 
	MOVLW       0
	ADDWFC      GetKeysState_PressTime_L0+3, 0 
	MOVWF       R4 
	MOVF        _ms500+3, 0 
	XORWF       R4, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState654
	MOVF        _ms500+2, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState654
	MOVF        _ms500+1, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState654
	MOVF        _ms500+0, 0 
	XORWF       R1, 0 
L__GetKeysState654:
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState309
L__GetKeysState597:
;FirmV_0_7_0.c,1309 :: 		Repeat=1;
	MOVLW       1
	MOVWF       GetKeysState_Repeat_L0+0 
L_GetKeysState309:
;FirmV_0_7_0.c,1311 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState312
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState312
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState312
L__GetKeysState596:
;FirmV_0_7_0.c,1312 :: 		fin=0;
	CLRF        GetKeysState_fin_L0+0 
L_GetKeysState312:
;FirmV_0_7_0.c,1314 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==1))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState315
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState315
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState315
L__GetKeysState595:
;FirmV_0_7_0.c,1315 :: 		{fin=resch*RepeatRate;RepeatRate=0;}
	MOVF        GetKeysState_resch_L0+0, 0 
	MULWF       GetKeysState_RepeatRate_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState315:
;FirmV_0_7_0.c,1318 :: 		if((resch!=0)&&(Pressed==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState318
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState318
L__GetKeysState594:
;FirmV_0_7_0.c,1319 :: 		{fin=resch; Pressed=1;PressTime=ms500;DebouncingDelay=0;}
	MOVF        GetKeysState_resch_L0+0, 0 
	MOVWF       GetKeysState_fin_L0+0 
	MOVLW       1
	MOVWF       _Pressed+0 
	MOVF        _ms500+0, 0 
	MOVWF       GetKeysState_PressTime_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       GetKeysState_PressTime_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       GetKeysState_PressTime_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       GetKeysState_PressTime_L0+3 
	CLRF        _DebouncingDelay+0 
L_GetKeysState318:
;FirmV_0_7_0.c,1321 :: 		if((Repeat==1)&&(msCounter%10==0))
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState321
	MOVLW       10
	MOVWF       R4 
	MOVF        _msCounter+0, 0 
	MOVWF       R0 
	CALL        _Div_8x8_U+0, 0
	MOVF        R8, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState321
L__GetKeysState593:
;FirmV_0_7_0.c,1322 :: 		RepeatRate=1;
	MOVLW       1
	MOVWF       GetKeysState_RepeatRate_L0+0 
L_GetKeysState321:
;FirmV_0_7_0.c,1324 :: 		return fin;
	MOVF        GetKeysState_fin_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1325 :: 		}
	RETURN      0
; end of _GetKeysState

_GetExternalKeysState:

;FirmV_0_7_0.c,1335 :: 		char GetExternalKeysState()
;FirmV_0_7_0.c,1337 :: 		char out=0;
	CLRF        GetExternalKeysState_out_L0+0 
;FirmV_0_7_0.c,1338 :: 		if(D1ExKey==0)
	BTFSC       PORTD+0, 3 
	GOTO        L_GetExternalKeysState322
;FirmV_0_7_0.c,1339 :: 		out.b0=1;
	BSF         GetExternalKeysState_out_L0+0, 0 
L_GetExternalKeysState322:
;FirmV_0_7_0.c,1340 :: 		if(D2ExKey==0)
	BTFSC       PORTD+0, 4 
	GOTO        L_GetExternalKeysState323
;FirmV_0_7_0.c,1341 :: 		out.b1=1;
	BSF         GetExternalKeysState_out_L0+0, 1 
L_GetExternalKeysState323:
;FirmV_0_7_0.c,1342 :: 		return out;
	MOVF        GetExternalKeysState_out_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1343 :: 		}
	RETURN      0
; end of _GetExternalKeysState

_GetLimitSwitchState:

;FirmV_0_7_0.c,1356 :: 		char GetLimitSwitchState()
;FirmV_0_7_0.c,1358 :: 		if((Limit1==0)||(Limit2==0))
	BTFSS       PORTD+0, 1 
	GOTO        L__GetLimitSwitchState600
	BTFSS       PORTD+0, 2 
	GOTO        L__GetLimitSwitchState600
	GOTO        L_GetLimitSwitchState326
L__GetLimitSwitchState600:
;FirmV_0_7_0.c,1359 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_GetLimitSwitchState326:
;FirmV_0_7_0.c,1361 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1362 :: 		}
	RETURN      0
; end of _GetLimitSwitchState

_GetRemoteState:

;FirmV_0_7_0.c,1371 :: 		char GetRemoteState()
;FirmV_0_7_0.c,1373 :: 		char res=0;
	CLRF        GetRemoteState_res_L0+0 
;FirmV_0_7_0.c,1374 :: 		res.b0=RemoteAFlag.b0;
	BTFSC       _RemoteAFlag+0, 0 
	GOTO        L__GetRemoteState655
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState656
L__GetRemoteState655:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState656:
;FirmV_0_7_0.c,1375 :: 		res.b1=RemoteBFlag.b0;
	BTFSC       _RemoteBFlag+0, 0 
	GOTO        L__GetRemoteState657
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState658
L__GetRemoteState657:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState658:
;FirmV_0_7_0.c,1376 :: 		RemoteAFlag=0;
	CLRF        _RemoteAFlag+0 
;FirmV_0_7_0.c,1377 :: 		RemoteBFlag=0;
	CLRF        _RemoteBFlag+0 
;FirmV_0_7_0.c,1378 :: 		res.b0=res.b0|(~D1ExKey);
	BTFSC       PORTD+0, 3 
	GOTO        L__GetRemoteState659
	BSF         4056, 0 
	GOTO        L__GetRemoteState660
L__GetRemoteState659:
	BCF         4056, 0 
L__GetRemoteState660:
	BTFSC       GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState661
	BTFSC       4056, 0 
	GOTO        L__GetRemoteState661
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState662
L__GetRemoteState661:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState662:
;FirmV_0_7_0.c,1379 :: 		res.b1=res.b1|(~D2ExKey);
	BTFSC       PORTD+0, 4 
	GOTO        L__GetRemoteState663
	BSF         4056, 0 
	GOTO        L__GetRemoteState664
L__GetRemoteState663:
	BCF         4056, 0 
L__GetRemoteState664:
	BTFSC       GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState665
	BTFSC       4056, 0 
	GOTO        L__GetRemoteState665
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState666
L__GetRemoteState665:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState666:
;FirmV_0_7_0.c,1380 :: 		return res;
	MOVF        GetRemoteState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1381 :: 		}
	RETURN      0
; end of _GetRemoteState

_GetOverloadState:

;FirmV_0_7_0.c,1391 :: 		char GetOverloadState()
;FirmV_0_7_0.c,1393 :: 		char res=0;
	CLRF        GetOverloadState_res_L0+0 
;FirmV_0_7_0.c,1395 :: 		VCapM1=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       GetOverloadState_VCapM1_L0+0 
	MOVF        R1, 0 
	MOVWF       GetOverloadState_VCapM1_L0+1 
;FirmV_0_7_0.c,1396 :: 		VCapM2=ADC_Read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       GetOverloadState_VCapM2_L0+0 
	MOVF        R1, 0 
	MOVWF       GetOverloadState_VCapM2_L0+1 
;FirmV_0_7_0.c,1397 :: 		if(Motor1FullSpeed!=0)
	MOVF        _Motor1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState328
;FirmV_0_7_0.c,1399 :: 		if(VCapM1<OverloadTreshold)
	MOVF        _OverloadTreshold+1, 0 
	SUBWF       GetOverloadState_VCapM1_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState667
	MOVF        _OverloadTreshold+0, 0 
	SUBWF       GetOverloadState_VCapM1_L0+0, 0 
L__GetOverloadState667:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState329
;FirmV_0_7_0.c,1401 :: 		if(OverloadCounter1<255)
	MOVLW       255
	SUBWF       _OverloadCounter1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState330
;FirmV_0_7_0.c,1402 :: 		OverloadCounter1=OverloadCounter1+1;
	INCF        _OverloadCounter1+0, 1 
L_GetOverloadState330:
;FirmV_0_7_0.c,1403 :: 		}
	GOTO        L_GetOverloadState331
L_GetOverloadState329:
;FirmV_0_7_0.c,1406 :: 		if(OverloadCounter1>0)
	MOVF        _OverloadCounter1+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState332
;FirmV_0_7_0.c,1407 :: 		OverloadCounter1=OverloadCounter1-1;
	DECF        _OverloadCounter1+0, 1 
L_GetOverloadState332:
;FirmV_0_7_0.c,1408 :: 		}
L_GetOverloadState331:
;FirmV_0_7_0.c,1409 :: 		}
	GOTO        L_GetOverloadState333
L_GetOverloadState328:
;FirmV_0_7_0.c,1411 :: 		{OverloadCounter1=0;}
	CLRF        _OverloadCounter1+0 
L_GetOverloadState333:
;FirmV_0_7_0.c,1413 :: 		if (OverloadCounter1>OverloadDuration)
	MOVF        _OverloadCounter1+0, 0 
	SUBWF       _OverloadDuration+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState334
;FirmV_0_7_0.c,1414 :: 		res.b0=1;
	BSF         GetOverloadState_res_L0+0, 0 
L_GetOverloadState334:
;FirmV_0_7_0.c,1419 :: 		if(Motor2FullSpeed!=0)
	MOVF        _Motor2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState335
;FirmV_0_7_0.c,1421 :: 		if(VCapM2<OverloadTreshold)
	MOVF        _OverloadTreshold+1, 0 
	SUBWF       GetOverloadState_VCapM2_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState668
	MOVF        _OverloadTreshold+0, 0 
	SUBWF       GetOverloadState_VCapM2_L0+0, 0 
L__GetOverloadState668:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState336
;FirmV_0_7_0.c,1423 :: 		if(OverloadCounter2<255)
	MOVLW       255
	SUBWF       _OverloadCounter2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState337
;FirmV_0_7_0.c,1424 :: 		OverloadCounter2=OverloadCounter2+1;
	INCF        _OverloadCounter2+0, 1 
L_GetOverloadState337:
;FirmV_0_7_0.c,1425 :: 		}
	GOTO        L_GetOverloadState338
L_GetOverloadState336:
;FirmV_0_7_0.c,1428 :: 		if(OverloadCounter2>0)
	MOVF        _OverloadCounter2+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState339
;FirmV_0_7_0.c,1429 :: 		OverloadCounter2=OverloadCounter2-1;
	DECF        _OverloadCounter2+0, 1 
L_GetOverloadState339:
;FirmV_0_7_0.c,1430 :: 		}
L_GetOverloadState338:
;FirmV_0_7_0.c,1431 :: 		}
	GOTO        L_GetOverloadState340
L_GetOverloadState335:
;FirmV_0_7_0.c,1433 :: 		{OverloadCounter2=0;}
	CLRF        _OverloadCounter2+0 
L_GetOverloadState340:
;FirmV_0_7_0.c,1436 :: 		if (OverloadCounter2>OverloadDuration)
	MOVF        _OverloadCounter2+0, 0 
	SUBWF       _OverloadDuration+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState341
;FirmV_0_7_0.c,1437 :: 		res.b1=1;
	BSF         GetOverloadState_res_L0+0, 1 
L_GetOverloadState341:
;FirmV_0_7_0.c,1439 :: 		return res;
	MOVF        GetOverloadState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1440 :: 		}
	RETURN      0
; end of _GetOverloadState

_GetPhotocellState:

;FirmV_0_7_0.c,1453 :: 		char GetPhotocellState()
;FirmV_0_7_0.c,1455 :: 		if(Phcell==0)
	BTFSC       PORTD+0, 0 
	GOTO        L_GetPhotocellState342
;FirmV_0_7_0.c,1456 :: 		{if(PhotocellCount<=20)PhotocellCount=PhotocellCount+1;}
	MOVF        _PhotocellCount+0, 0 
	SUBLW       20
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState343
	INCF        _PhotocellCount+0, 1 
L_GetPhotocellState343:
	GOTO        L_GetPhotocellState344
L_GetPhotocellState342:
;FirmV_0_7_0.c,1458 :: 		{PhotocellCount=0;}
	CLRF        _PhotocellCount+0 
L_GetPhotocellState344:
;FirmV_0_7_0.c,1459 :: 		if(PhotocellCount>=20)
	MOVLW       20
	SUBWF       _PhotocellCount+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState345
;FirmV_0_7_0.c,1460 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_GetPhotocellState345:
;FirmV_0_7_0.c,1462 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1463 :: 		}
	RETURN      0
; end of _GetPhotocellState

_SetMotorSpeed:

;FirmV_0_7_0.c,1475 :: 		void SetMotorSpeed(char M1FullSpeed,char M2FullSpeed)
;FirmV_0_7_0.c,1477 :: 		if((M1FullSpeed==0)||(M2FullSpeed==0))
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed601
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed601
	GOTO        L_SetMotorSpeed349
L__SetMotorSpeed601:
;FirmV_0_7_0.c,1478 :: 		INT0E_bit=1;
	BSF         INT0E_bit+0, 4 
	GOTO        L_SetMotorSpeed350
L_SetMotorSpeed349:
;FirmV_0_7_0.c,1480 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, 4 
L_SetMotorSpeed350:
;FirmV_0_7_0.c,1482 :: 		Motor1FullSpeed=M1FullSpeed;
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	MOVWF       _Motor1FullSpeed+0 
;FirmV_0_7_0.c,1483 :: 		Motor2FullSpeed=M2FullSpeed;
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	MOVWF       _Motor2FullSpeed+0 
;FirmV_0_7_0.c,1484 :: 		}
	RETURN      0
; end of _SetMotorSpeed

_OverloadInit:

;FirmV_0_7_0.c,1495 :: 		void OverloadInit(char ch)
;FirmV_0_7_0.c,1497 :: 		if(ch==1)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit351
;FirmV_0_7_0.c,1499 :: 		OverloadCounter1=0;
	CLRF        _OverloadCounter1+0 
;FirmV_0_7_0.c,1500 :: 		Events.Overload.b0=0;
	BCF         _Events+5, 0 
;FirmV_0_7_0.c,1501 :: 		}
L_OverloadInit351:
;FirmV_0_7_0.c,1503 :: 		if(ch==2)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit352
;FirmV_0_7_0.c,1505 :: 		OverloadCounter2=0;
	CLRF        _OverloadCounter2+0 
;FirmV_0_7_0.c,1506 :: 		Events.Overload.b1=0;
	BCF         _Events+5, 1 
;FirmV_0_7_0.c,1507 :: 		}
L_OverloadInit352:
;FirmV_0_7_0.c,1508 :: 		}
	RETURN      0
; end of _OverloadInit

_SaveConfigs:

;FirmV_0_7_0.c,1519 :: 		void SaveConfigs()
;FirmV_0_7_0.c,1522 :: 		EEPROM_Write(1,Door1OpenTime);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1523 :: 		EEPROM_Write(2,Door2OpenTime);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1524 :: 		EEPROM_Write(3,Door1CloseTime);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1525 :: 		EEPROM_Write(4,Door2CloseTime);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1526 :: 		EEPROM_Write(5,ActionTimeDiff);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1527 :: 		EEPROM_Write(6,OpenSoftStartTime);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1528 :: 		EEPROM_Write(7,OpenSoftStopTime);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1529 :: 		EEPROM_Write(8,CloseSoftStartTime);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1530 :: 		EEPROM_Write(9,CloseSoftStopTime);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1531 :: 		EEPROM_Write(10,Hi(AutoCloseTime));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _AutoCloseTime+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1532 :: 		EEPROM_Write(11,Lo(AutoCloseTime));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1533 :: 		EEPROM_Write(12,OverloadSens);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OverloadSens+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1534 :: 		SetOverloadParams(9-OverloadSens);
	MOVF        _OverloadSens+0, 0 
	SUBLW       9
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1535 :: 		EEPROM_Write(13,CloseAfterPass);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1536 :: 		EEPROM_Write(14,LockForce);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _LockForce+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1537 :: 		EEPROM_Write(15,OpenPhEnable);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OpenPhEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1538 :: 		EEPROM_Write(16,LimiterEnable);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _LimiterEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1540 :: 		}
	RETURN      0
; end of _SaveConfigs

_LoadConfigs:

;FirmV_0_7_0.c,1553 :: 		void LoadConfigs()
;FirmV_0_7_0.c,1555 :: 		Door1OpenTime=EEPROM_Read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1556 :: 		Door2OpenTime=EEPROM_Read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1557 :: 		Door1CloseTime=EEPROM_Read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1558 :: 		Door2CloseTime=EEPROM_Read(4);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1559 :: 		ActionTimeDiff=EEPROM_Read(5);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1560 :: 		OpenSoftStartTime=EEPROM_Read(6);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1561 :: 		OpenSoftStopTime=EEPROM_Read(7);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1562 :: 		CloseSoftStartTime=EEPROM_Read(8);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1563 :: 		CloseSoftStopTime=EEPROM_Read(9);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1564 :: 		AutoCloseTime=EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _AutoCloseTime+0 
	MOVLW       0
	MOVWF       _AutoCloseTime+1 
;FirmV_0_7_0.c,1565 :: 		AutoCloseTime=AutoCloseTime<<8;
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       _AutoCloseTime+1 
	CLRF        _AutoCloseTime+0 
;FirmV_0_7_0.c,1566 :: 		AutoCloseTime=AutocloseTime|EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	IORWF       _AutoCloseTime+0, 1 
	MOVLW       0
	IORWF       _AutoCloseTime+1, 1 
;FirmV_0_7_0.c,1567 :: 		OverloadSens=EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadSens+0 
;FirmV_0_7_0.c,1568 :: 		SetOverloadParams(9-OverloadSens);
	MOVF        R0, 0 
	SUBLW       9
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1569 :: 		CloseAfterPass=EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseAfterPass+0 
;FirmV_0_7_0.c,1570 :: 		LockForce=EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LockForce+0 
;FirmV_0_7_0.c,1571 :: 		OpenPhEnable=EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenPhEnable+0 
;FirmV_0_7_0.c,1572 :: 		LimiterEnable=EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LimiterEnable+0 
;FirmV_0_7_0.c,1574 :: 		}
	RETURN      0
; end of _LoadConfigs

_FactorySettings:

;FirmV_0_7_0.c,1587 :: 		void FactorySettings()
;FirmV_0_7_0.c,1589 :: 		Door1OpenTime=20;
	MOVLW       20
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1590 :: 		Door1CloseTime=20;
	MOVLW       20
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1591 :: 		Door2OpenTime=20;
	MOVLW       20
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1592 :: 		Door2CloseTime=20;
	MOVLW       20
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1593 :: 		OverloadSens=5;
	MOVLW       5
	MOVWF       _OverloadSens+0 
;FirmV_0_7_0.c,1594 :: 		SetOverloadParams(4);  //9-5
	MOVLW       4
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1595 :: 		OpenSoftStopTime=10;
	MOVLW       10
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1596 :: 		OpenSoftStartTime=4;
	MOVLW       4
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1597 :: 		CloseSoftStopTime=10;
	MOVLW       10
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1598 :: 		CloseSoftStartTime=4;
	MOVLW       4
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1599 :: 		ActionTimeDiff=12;
	MOVLW       12
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1600 :: 		AutoCloseTime=0;
	CLRF        _AutoCloseTime+0 
	CLRF        _AutoCloseTime+1 
;FirmV_0_7_0.c,1601 :: 		LockForce=0;
	CLRF        _LockForce+0 
;FirmV_0_7_0.c,1602 :: 		OpenPhEnable=0;
	CLRF        _OpenPhEnable+0 
;FirmV_0_7_0.c,1603 :: 		LimiterEnable=0;
	CLRF        _LimiterEnable+0 
;FirmV_0_7_0.c,1604 :: 		CloseAfterPass=0;
	CLRF        _CloseAfterPass+0 
;FirmV_0_7_0.c,1606 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,1607 :: 		}
	RETURN      0
; end of _FactorySettings

_StartMotor:

;FirmV_0_7_0.c,1613 :: 		void StartMotor(char Mx,char Dir)
;FirmV_0_7_0.c,1615 :: 		if(Mx==1)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor353
;FirmV_0_7_0.c,1617 :: 		Motor1Start=1;
	MOVLW       1
	MOVWF       _Motor1Start+0 
;FirmV_0_7_0.c,1618 :: 		Motor1Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor669
	BCF         PORTC+0, 4 
	GOTO        L__StartMotor670
L__StartMotor669:
	BSF         PORTC+0, 4 
L__StartMotor670:
;FirmV_0_7_0.c,1619 :: 		Motor1=1;
	BSF         PORTC+0, 1 
;FirmV_0_7_0.c,1620 :: 		}
L_StartMotor353:
;FirmV_0_7_0.c,1622 :: 		if(Mx==2)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor354
;FirmV_0_7_0.c,1624 :: 		Motor2Start=1;
	MOVLW       1
	MOVWF       _Motor2Start+0 
;FirmV_0_7_0.c,1625 :: 		Motor2Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor671
	BCF         PORTC+0, 3 
	GOTO        L__StartMotor672
L__StartMotor671:
	BSF         PORTC+0, 3 
L__StartMotor672:
;FirmV_0_7_0.c,1626 :: 		Motor2=1;
	BSF         PORTC+0, 0 
;FirmV_0_7_0.c,1627 :: 		}
L_StartMotor354:
;FirmV_0_7_0.c,1628 :: 		}
	RETURN      0
; end of _StartMotor

_StopMotor:

;FirmV_0_7_0.c,1631 :: 		void StopMotor(char Mx)
;FirmV_0_7_0.c,1633 :: 		if(Mx==1)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor355
;FirmV_0_7_0.c,1635 :: 		Motor1Start=0;
	CLRF        _Motor1Start+0 
;FirmV_0_7_0.c,1636 :: 		Motor1=0;
	BCF         PORTC+0, 1 
;FirmV_0_7_0.c,1637 :: 		}
L_StopMotor355:
;FirmV_0_7_0.c,1639 :: 		if(Mx==2)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor356
;FirmV_0_7_0.c,1641 :: 		Motor2Start=0;
	CLRF        _Motor2Start+0 
;FirmV_0_7_0.c,1642 :: 		Motor2=0;
	BCF         PORTC+0, 0 
;FirmV_0_7_0.c,1643 :: 		}
L_StopMotor356:
;FirmV_0_7_0.c,1644 :: 		}
	RETURN      0
; end of _StopMotor

_CheckTask:

;FirmV_0_7_0.c,1656 :: 		char CheckTask(char TaskCode)
;FirmV_0_7_0.c,1658 :: 		if(Events.Task1==TaskCode)
	MOVF        _Events+1, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask357
;FirmV_0_7_0.c,1659 :: 		{Events.Task1=0; return 1;}
	CLRF        _Events+1 
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_CheckTask357:
;FirmV_0_7_0.c,1661 :: 		if(Events.Task2==TaskCode)
	MOVF        _Events+2, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask358
;FirmV_0_7_0.c,1662 :: 		{Events.Task2=0; return 1;}
	CLRF        _Events+2 
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_CheckTask358:
;FirmV_0_7_0.c,1664 :: 		if(Events.Task3==TaskCode)
	MOVF        _Events+3, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask359
;FirmV_0_7_0.c,1665 :: 		{Events.Task3=0; return 1;}
	CLRF        _Events+3 
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_CheckTask359:
;FirmV_0_7_0.c,1667 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1669 :: 		}
	RETURN      0
; end of _CheckTask

_GetAutocloseTime:

;FirmV_0_7_0.c,1677 :: 		char GetAutocloseTime()
;FirmV_0_7_0.c,1681 :: 		for(i=0;i<20;i++)
	CLRF        GetAutocloseTime_i_L0+0 
L_GetAutocloseTime360:
	MOVLW       20
	SUBWF       GetAutocloseTime_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetAutocloseTime361
;FirmV_0_7_0.c,1683 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode==9))
	MOVF        GetAutocloseTime_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetAutocloseTime365
	MOVF        GetAutocloseTime_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_GetAutocloseTime365
L__GetAutocloseTime602:
;FirmV_0_7_0.c,1684 :: 		t=Tasks[i].Time;
	MOVF        GetAutocloseTime_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       GetAutocloseTime_t_L0+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       GetAutocloseTime_t_L0+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       GetAutocloseTime_t_L0+2 
	MOVF        POSTINC0+0, 0 
	MOVWF       GetAutocloseTime_t_L0+3 
L_GetAutocloseTime365:
;FirmV_0_7_0.c,1685 :: 		Tasks[i].Expired=1;
	MOVF        GetAutocloseTime_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,1681 :: 		for(i=0;i<20;i++)
	INCF        GetAutocloseTime_i_L0+0, 1 
;FirmV_0_7_0.c,1686 :: 		}
	GOTO        L_GetAutocloseTime360
L_GetAutocloseTime361:
;FirmV_0_7_0.c,1687 :: 		i=t-ms500;
	MOVF        _ms500+0, 0 
	SUBWF       GetAutocloseTime_t_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       GetAutocloseTime_i_L0+0 
;FirmV_0_7_0.c,1688 :: 		return i;
;FirmV_0_7_0.c,1689 :: 		}
	RETURN      0
; end of _GetAutocloseTime

_ClearTasks:

;FirmV_0_7_0.c,1706 :: 		void ClearTasks(char except)
;FirmV_0_7_0.c,1709 :: 		for(i=0;i<20;i++)
	CLRF        ClearTasks_i_L0+0 
L_ClearTasks366:
	MOVLW       20
	SUBWF       ClearTasks_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ClearTasks367
;FirmV_0_7_0.c,1710 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode!=except))
	MOVF        ClearTasks_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_ClearTasks371
	MOVF        ClearTasks_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORWF       FARG_ClearTasks_except+0, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_ClearTasks371
L__ClearTasks603:
;FirmV_0_7_0.c,1711 :: 		Tasks[i].Expired=1;
	MOVF        ClearTasks_i_L0+0, 0 
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       7
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16x16_U+0, 0
	MOVLW       _Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVLW       1
	MOVWF       POSTINC1+0 
L_ClearTasks371:
;FirmV_0_7_0.c,1709 :: 		for(i=0;i<20;i++)
	INCF        ClearTasks_i_L0+0, 1 
;FirmV_0_7_0.c,1711 :: 		Tasks[i].Expired=1;
	GOTO        L_ClearTasks366
L_ClearTasks367:
;FirmV_0_7_0.c,1712 :: 		}
	RETURN      0
; end of _ClearTasks

_Menu0:

;FirmV_0_7_0.c,1727 :: 		void Menu0()
;FirmV_0_7_0.c,1729 :: 		memcpy(LCDLine2,"                ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr70_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr70_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr70_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr70_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr70_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr70_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr70_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,1731 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0372
;FirmV_0_7_0.c,1732 :: 		{memcpy(LCDLine1,"00 Learning Mode",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr71_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr71_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr71_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr71_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr71_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr71_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr71_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1733 :: 		if(LearningMode==0)memcpy(LCDLine2,"      Auto      ",16);
	MOVF        _LearningMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0373
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr72_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr72_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr72_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr72_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr72_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr72_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr72_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0373:
;FirmV_0_7_0.c,1734 :: 		if(LearningMode==1)memcpy(LCDLine2,"     Manual     ",16);}
	MOVF        _LearningMode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0374
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr73_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr73_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr73_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr73_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr73_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr73_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr73_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0374:
L_Menu0372:
;FirmV_0_7_0.c,1736 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0375
;FirmV_0_7_0.c,1737 :: 		{memcpy(LCDLine1,"01 D1 Open Time ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr74_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr74_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr74_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr74_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr74_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr74_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr74_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1738 :: 		charValueToStr(Door1OpenTime,LCDLine2+6);}
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0375:
;FirmV_0_7_0.c,1740 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0376
;FirmV_0_7_0.c,1741 :: 		{memcpy(LCDLine1,"02 D2 Open Time ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr75_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr75_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr75_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr75_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr75_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr75_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr75_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1742 :: 		charValueToStr(Door2OpenTime,LCDLine2+6);}
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0376:
;FirmV_0_7_0.c,1744 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0377
;FirmV_0_7_0.c,1745 :: 		{memcpy(LCDLine1,"03 D1 Close Time",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr76_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr76_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr76_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr76_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr76_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr76_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr76_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1746 :: 		charValueToStr(Door1CloseTime,LCDLine2+6);}
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0377:
;FirmV_0_7_0.c,1748 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0378
;FirmV_0_7_0.c,1749 :: 		{memcpy(LCDLine1,"04 D2 Close Time",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr77_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr77_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr77_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr77_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr77_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr77_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr77_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1750 :: 		charValueToStr(Door2CloseTime,LCDLine2+6);}
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0378:
;FirmV_0_7_0.c,1752 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0379
;FirmV_0_7_0.c,1753 :: 		{memcpy(LCDLine1,"05 Op Soft Start",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr78_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr78_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr78_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr78_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr78_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr78_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr78_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1754 :: 		charValueToStr(OpenSoftStartTime,LCDLine2+6);}
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0379:
;FirmV_0_7_0.c,1756 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0380
;FirmV_0_7_0.c,1757 :: 		{memcpy(LCDLine1,"06 Op Soft Stop ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr79_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr79_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr79_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr79_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr79_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr79_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr79_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1758 :: 		charValueToStr(OpenSoftStopTime,LCDLine2+6);}
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0380:
;FirmV_0_7_0.c,1760 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0381
;FirmV_0_7_0.c,1761 :: 		{memcpy(LCDLine1,"07 Cl Soft Start",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr80_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr80_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr80_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr80_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr80_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr80_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr80_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1762 :: 		charValueToStr(CloseSoftStartTime,LCDLine2+6);}
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0381:
;FirmV_0_7_0.c,1764 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0382
;FirmV_0_7_0.c,1765 :: 		{memcpy(LCDLine1,"08 Cl Soft Stop ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr81_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr81_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr81_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr81_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr81_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr81_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr81_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1766 :: 		charValueToStr(CloseSoftStopTime,LCDLine2+6);}
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0382:
;FirmV_0_7_0.c,1768 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0383
;FirmV_0_7_0.c,1769 :: 		{memcpy(LCDLine1,"09 Power        ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr82_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr82_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr82_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr82_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr82_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr82_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr82_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1770 :: 		bytetostr(OverloadSens,LCDLine2+6);LCDLine2[9]=' ';}
	MOVF        _OverloadSens+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
	MOVLW       32
	MOVWF       _LCDLine2+9 
L_Menu0383:
;FirmV_0_7_0.c,1772 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0384
;FirmV_0_7_0.c,1773 :: 		{memcpy(LCDLine1,"10 Interval Time",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr83_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr83_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr83_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr83_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr83_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr83_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr83_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1774 :: 		charValueToStr(ActionTimeDiff,LCDLine2+6);}
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0384:
;FirmV_0_7_0.c,1776 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0385
;FirmV_0_7_0.c,1777 :: 		{memcpy(LCDLine1,"11 Auto-close T ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr84_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr84_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr84_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr84_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr84_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr84_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr84_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1778 :: 		intValueToStr(AutoCloseTime,LCDLine2+4);}
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       FARG_intValueToStr+0 
	MOVF        _AutoCloseTime+1, 0 
	MOVWF       FARG_intValueToStr+1 
	MOVLW       _LCDLine2+4
	MOVWF       FARG_intValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+4)
	MOVWF       FARG_intValueToStr+1 
	CALL        _intValueToStr+0, 0
L_Menu0385:
;FirmV_0_7_0.c,1780 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0386
;FirmV_0_7_0.c,1781 :: 		{memcpy(LCDLine1,"12 Factory Reset",16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr85_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr85_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr85_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr85_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr85_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr85_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr85_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_Menu0386:
;FirmV_0_7_0.c,1783 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0387
;FirmV_0_7_0.c,1784 :: 		{memcpy(LCDLine1,"13 Open Photo En",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr86_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr86_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr86_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr86_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr86_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr86_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr86_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1785 :: 		if(OpenPhEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _OpenPhEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0388
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       78
	MOVWF       ?lstr87_FirmV_0_7_0+0 
	MOVLW       111
	MOVWF       ?lstr87_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr87_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr87_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr87_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr87_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr87_FirmV_0_7_0+6 
	CLRF        ?lstr87_FirmV_0_7_0+7 
	MOVLW       ?lstr87_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr87_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0389
L_Menu0388:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       89
	MOVWF       ?lstr88_FirmV_0_7_0+0 
	MOVLW       101
	MOVWF       ?lstr88_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr88_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr88_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr88_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr88_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr88_FirmV_0_7_0+6 
	MOVLW       32
	MOVWF       ?lstr88_FirmV_0_7_0+7 
	CLRF        ?lstr88_FirmV_0_7_0+8 
	MOVLW       ?lstr88_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr88_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0389:
L_Menu0387:
;FirmV_0_7_0.c,1787 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0390
;FirmV_0_7_0.c,1788 :: 		{memcpy(LCDLine1,"14 Limit Enable ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr89_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr89_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr89_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr89_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr89_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr89_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr89_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1789 :: 		if(LimiterEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LimiterEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0391
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       78
	MOVWF       ?lstr90_FirmV_0_7_0+0 
	MOVLW       111
	MOVWF       ?lstr90_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr90_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr90_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr90_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr90_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr90_FirmV_0_7_0+6 
	CLRF        ?lstr90_FirmV_0_7_0+7 
	MOVLW       ?lstr90_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr90_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0392
L_Menu0391:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       89
	MOVWF       ?lstr91_FirmV_0_7_0+0 
	MOVLW       101
	MOVWF       ?lstr91_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr91_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr91_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr91_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr91_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr91_FirmV_0_7_0+6 
	MOVLW       32
	MOVWF       ?lstr91_FirmV_0_7_0+7 
	CLRF        ?lstr91_FirmV_0_7_0+8 
	MOVLW       ?lstr91_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr91_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0392:
L_Menu0390:
;FirmV_0_7_0.c,1791 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0393
;FirmV_0_7_0.c,1792 :: 		{memcpy(LCDLine1,"15 Lock Force   ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr92_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr92_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr92_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr92_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr92_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr92_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr92_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1793 :: 		if(LockForce==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0394
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       78
	MOVWF       ?lstr93_FirmV_0_7_0+0 
	MOVLW       111
	MOVWF       ?lstr93_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr93_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr93_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr93_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr93_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr93_FirmV_0_7_0+6 
	CLRF        ?lstr93_FirmV_0_7_0+7 
	MOVLW       ?lstr93_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr93_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0395
L_Menu0394:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       89
	MOVWF       ?lstr94_FirmV_0_7_0+0 
	MOVLW       101
	MOVWF       ?lstr94_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr94_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr94_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr94_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr94_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr94_FirmV_0_7_0+6 
	MOVLW       32
	MOVWF       ?lstr94_FirmV_0_7_0+7 
	CLRF        ?lstr94_FirmV_0_7_0+8 
	MOVLW       ?lstr94_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr94_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0395:
L_Menu0393:
;FirmV_0_7_0.c,1795 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0396
;FirmV_0_7_0.c,1796 :: 		{memcpy(LCDLine1,"16 Au-Cl Pass   ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr95_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr95_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr95_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr95_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr95_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr95_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr95_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1797 :: 		charValueToStr(CloseAfterPass,LCDLine2+6);}
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0396:
;FirmV_0_7_0.c,1799 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0397
;FirmV_0_7_0.c,1800 :: 		{memcpy(LCDLine1,"17 Save Changes ",16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr96_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr96_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr96_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr96_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr96_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr96_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr96_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_Menu0397:
;FirmV_0_7_0.c,1802 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0398
;FirmV_0_7_0.c,1803 :: 		{memcpy(LCDLine1,"18 Discard Exit ",16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr97_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr97_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr97_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr97_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr97_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr97_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr97_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_Menu0398:
;FirmV_0_7_0.c,1806 :: 		State=101;
	MOVLW       101
	MOVWF       _State+0 
;FirmV_0_7_0.c,1807 :: 		}
	RETURN      0
; end of _Menu0

_Menu1:

;FirmV_0_7_0.c,1824 :: 		void Menu1()
;FirmV_0_7_0.c,1827 :: 		if((Events.Keys.b0==1))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu1399
;FirmV_0_7_0.c,1828 :: 		{if(MenuPointer==0){MenuPointer=18;}else{MenuPointer=MenuPointer-1;}State=100;}
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1400
	MOVLW       18
	MOVWF       _MenuPointer+0 
	GOTO        L_Menu1401
L_Menu1400:
	DECF        _MenuPointer+0, 1 
L_Menu1401:
	MOVLW       100
	MOVWF       _State+0 
L_Menu1399:
;FirmV_0_7_0.c,1830 :: 		if((Events.Keys.b2==1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu1402
;FirmV_0_7_0.c,1831 :: 		{if(MenuPointer==18){MenuPointer=0;}else{MenuPointer=MenuPointer+1;}State=100;}
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1403
	CLRF        _MenuPointer+0 
	GOTO        L_Menu1404
L_Menu1403:
	INCF        _MenuPointer+0, 1 
L_Menu1404:
	MOVLW       100
	MOVWF       _State+0 
L_Menu1402:
;FirmV_0_7_0.c,1833 :: 		if((Events.Keys.b1==1))
	BTFSS       _Events+0, 1 
	GOTO        L_Menu1405
;FirmV_0_7_0.c,1834 :: 		{State=102;}
	MOVLW       102
	MOVWF       _State+0 
L_Menu1405:
;FirmV_0_7_0.c,1837 :: 		}
	RETURN      0
; end of _Menu1

_Menu2:

;FirmV_0_7_0.c,1845 :: 		void Menu2()
;FirmV_0_7_0.c,1848 :: 		LCDFlash=1;
	MOVLW       1
	MOVWF       _LCDFlash+0 
;FirmV_0_7_0.c,1850 :: 		if(Events.Keys.b1==1)
	BTFSS       _Events+0, 1 
	GOTO        L_Menu2406
;FirmV_0_7_0.c,1852 :: 		LCDFlash=0;LCDFlashFlag=0;State=101;
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
	MOVLW       101
	MOVWF       _State+0 
;FirmV_0_7_0.c,1853 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2407
;FirmV_0_7_0.c,1855 :: 		if(LearningMode==0)
	MOVF        _LearningMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2408
;FirmV_0_7_0.c,1856 :: 		State=200;
	MOVLW       200
	MOVWF       _State+0 
L_Menu2408:
;FirmV_0_7_0.c,1857 :: 		if(LearningMode==1)
	MOVF        _LearningMode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2409
;FirmV_0_7_0.c,1858 :: 		State=201;
	MOVLW       201
	MOVWF       _State+0 
L_Menu2409:
;FirmV_0_7_0.c,1859 :: 		}
L_Menu2407:
;FirmV_0_7_0.c,1860 :: 		}
L_Menu2406:
;FirmV_0_7_0.c,1863 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2410
;FirmV_0_7_0.c,1864 :: 		{ if((Events.Keys.b0==1)&&(LearningMode>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2413
	MOVF        _LearningMode+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2413
L__Menu2635:
;FirmV_0_7_0.c,1865 :: 		{LearningMode=LearningMode-1;Menu0();State=102;}
	DECF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2413:
;FirmV_0_7_0.c,1866 :: 		if((Events.Keys.b2==1)&&(LearningMode<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2416
	MOVLW       1
	SUBWF       _LearningMode+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2416
L__Menu2634:
;FirmV_0_7_0.c,1867 :: 		{LearningMode=LearningMode+1;Menu0();State=102;}
	INCF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2416:
;FirmV_0_7_0.c,1868 :: 		}
L_Menu2410:
;FirmV_0_7_0.c,1872 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2417
;FirmV_0_7_0.c,1873 :: 		{ if((Events.Keys.b0==1)&&(Door1OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2420
	MOVF        _Door1OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2420
L__Menu2633:
;FirmV_0_7_0.c,1874 :: 		{Door1OpenTime=Door1OpenTime-1;Menu0();State=102;}
	DECF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2420:
;FirmV_0_7_0.c,1875 :: 		if((Events.Keys.b2==1)&&(Door1OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2423
	MOVLW       255
	SUBWF       _Door1OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2423
L__Menu2632:
;FirmV_0_7_0.c,1876 :: 		{Door1OpenTime=Door1OpenTime+1;Menu0();State=102;}
	INCF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2423:
;FirmV_0_7_0.c,1877 :: 		}
L_Menu2417:
;FirmV_0_7_0.c,1881 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2424
;FirmV_0_7_0.c,1882 :: 		{ if((Events.Keys.b0==1)&&(Door2OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2427
	MOVF        _Door2OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2427
L__Menu2631:
;FirmV_0_7_0.c,1883 :: 		{Door2OpenTime=Door2OpenTime-1;Menu0();State=102;}
	DECF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2427:
;FirmV_0_7_0.c,1884 :: 		if((Events.Keys.b2==1)&&(Door2OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2430
	MOVLW       255
	SUBWF       _Door2OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2430
L__Menu2630:
;FirmV_0_7_0.c,1885 :: 		{Door2OpenTime=Door2OpenTime+1;Menu0();State=102;}
	INCF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2430:
;FirmV_0_7_0.c,1886 :: 		}
L_Menu2424:
;FirmV_0_7_0.c,1889 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2431
;FirmV_0_7_0.c,1890 :: 		{ if((Events.Keys.b0==1)&&(Door1CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2434
	MOVF        _Door1CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2434
L__Menu2629:
;FirmV_0_7_0.c,1891 :: 		{Door1CloseTime=Door1CloseTime-1;Menu0();State=102;}
	DECF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2434:
;FirmV_0_7_0.c,1892 :: 		if((Events.Keys.b2==1)&&(Door1CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2437
	MOVLW       255
	SUBWF       _Door1CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2437
L__Menu2628:
;FirmV_0_7_0.c,1893 :: 		{Door1CloseTime=Door1CloseTime+1;Menu0();State=102;}
	INCF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2437:
;FirmV_0_7_0.c,1894 :: 		}
L_Menu2431:
;FirmV_0_7_0.c,1897 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2438
;FirmV_0_7_0.c,1898 :: 		{ if((Events.Keys.b0==1)&&(Door2CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2441
	MOVF        _Door2CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2441
L__Menu2627:
;FirmV_0_7_0.c,1899 :: 		{Door2CloseTime=Door2CloseTime-1;Menu0();State=102;}
	DECF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2441:
;FirmV_0_7_0.c,1900 :: 		if((Events.Keys.b2==1)&&(Door2CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2444
	MOVLW       255
	SUBWF       _Door2CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2444
L__Menu2626:
;FirmV_0_7_0.c,1901 :: 		{Door2CloseTime=Door2CloseTime+1;Menu0();State=102;}
	INCF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2444:
;FirmV_0_7_0.c,1902 :: 		}
L_Menu2438:
;FirmV_0_7_0.c,1906 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2445
;FirmV_0_7_0.c,1907 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2448
	MOVF        _OpenSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2448
L__Menu2625:
;FirmV_0_7_0.c,1908 :: 		{OpenSoftStartTime=OpenSoftStartTime-1;Menu0();State=102;}
	DECF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2448:
;FirmV_0_7_0.c,1909 :: 		if((Events.Keys.b2==1)&&(OpenSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2451
	MOVLW       255
	SUBWF       _OpenSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2451
L__Menu2624:
;FirmV_0_7_0.c,1910 :: 		{OpenSoftStartTime=OpenSoftStartTime+1;Menu0();State=102;}
	INCF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2451:
;FirmV_0_7_0.c,1911 :: 		}
L_Menu2445:
;FirmV_0_7_0.c,1914 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2452
;FirmV_0_7_0.c,1915 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2455
	MOVF        _OpenSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2455
L__Menu2623:
;FirmV_0_7_0.c,1916 :: 		{OpenSoftStopTime=OpenSoftStopTime-1;Menu0();State=102;}
	DECF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2455:
;FirmV_0_7_0.c,1917 :: 		if((Events.Keys.b2==1)&&(OpenSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2458
	MOVLW       255
	SUBWF       _OpenSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2458
L__Menu2622:
;FirmV_0_7_0.c,1918 :: 		{OpenSoftStopTime=OpenSoftStopTime+1;Menu0();State=102;}
	INCF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2458:
;FirmV_0_7_0.c,1919 :: 		}
L_Menu2452:
;FirmV_0_7_0.c,1922 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2459
;FirmV_0_7_0.c,1923 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2462
	MOVF        _CloseSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2462
L__Menu2621:
;FirmV_0_7_0.c,1924 :: 		{CloseSoftStartTime=CloseSoftStartTime-1;Menu0();State=102;}
	DECF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2462:
;FirmV_0_7_0.c,1925 :: 		if((Events.Keys.b2==1)&&(CloseSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2465
	MOVLW       255
	SUBWF       _CloseSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2465
L__Menu2620:
;FirmV_0_7_0.c,1926 :: 		{CloseSoftStartTime=CloseSoftStartTime+1;Menu0();State=102;}
	INCF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2465:
;FirmV_0_7_0.c,1927 :: 		}
L_Menu2459:
;FirmV_0_7_0.c,1930 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2466
;FirmV_0_7_0.c,1931 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2469
	MOVF        _CloseSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2469
L__Menu2619:
;FirmV_0_7_0.c,1932 :: 		{CloseSoftStopTime=CloseSoftStopTime-1;Menu0();State=102;}
	DECF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2469:
;FirmV_0_7_0.c,1933 :: 		if((Events.Keys.b2==1)&&(CloseSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2472
	MOVLW       255
	SUBWF       _CloseSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2472
L__Menu2618:
;FirmV_0_7_0.c,1934 :: 		{CloseSoftStopTime=CloseSoftStopTime+1;Menu0();State=102;}
	INCF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2472:
;FirmV_0_7_0.c,1935 :: 		}
L_Menu2466:
;FirmV_0_7_0.c,1939 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2473
;FirmV_0_7_0.c,1940 :: 		{ if((Events.Keys.b0==1)&&(OverloadSens>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2476
	MOVF        _OverloadSens+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2476
L__Menu2617:
;FirmV_0_7_0.c,1941 :: 		{OverloadSens=OverloadSens-1;Menu0();State=102;}
	DECF        _OverloadSens+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2476:
;FirmV_0_7_0.c,1942 :: 		if((Events.Keys.b2==1)&&(OverloadSens<9))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2479
	MOVLW       9
	SUBWF       _OverloadSens+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2479
L__Menu2616:
;FirmV_0_7_0.c,1943 :: 		{OverloadSens=OverloadSens+1;Menu0();State=102;}
	INCF        _OverloadSens+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2479:
;FirmV_0_7_0.c,1944 :: 		}
L_Menu2473:
;FirmV_0_7_0.c,1947 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2480
;FirmV_0_7_0.c,1948 :: 		{ if((Events.Keys.b0==1)&&(ActionTimeDiff>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2483
	MOVF        _ActionTimeDiff+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2483
L__Menu2615:
;FirmV_0_7_0.c,1949 :: 		{ActionTimeDiff=ActionTimeDiff-1;Menu0();State=102;}
	DECF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2483:
;FirmV_0_7_0.c,1950 :: 		if((Events.Keys.b2==1)&&(ActionTimeDiff<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2486
	MOVLW       255
	SUBWF       _ActionTimeDiff+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2486
L__Menu2614:
;FirmV_0_7_0.c,1951 :: 		{ActionTimeDiff=ActionTimeDiff+1;Menu0();State=102;}
	INCF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2486:
;FirmV_0_7_0.c,1952 :: 		}
L_Menu2480:
;FirmV_0_7_0.c,1955 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2487
;FirmV_0_7_0.c,1956 :: 		{ if((Events.Keys.b0==1)&&(AutoCloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2490
	MOVLW       0
	MOVWF       R0 
	MOVF        _AutoCloseTime+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu2673
	MOVF        _AutoCloseTime+0, 0 
	SUBLW       0
L__Menu2673:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2490
L__Menu2613:
;FirmV_0_7_0.c,1957 :: 		{AutoCloseTime=AutoCloseTime-1;Menu0();State=102;}
	MOVLW       1
	SUBWF       _AutoCloseTime+0, 1 
	MOVLW       0
	SUBWFB      _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2490:
;FirmV_0_7_0.c,1958 :: 		if((Events.Keys.b2==1)&&(AutoCloseTime<65000))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2493
	MOVLW       253
	SUBWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu2674
	MOVLW       232
	SUBWF       _AutoCloseTime+0, 0 
L__Menu2674:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2493
L__Menu2612:
;FirmV_0_7_0.c,1959 :: 		{AutoCloseTime=AutoCloseTime+1;Menu0();State=102;}
	INFSNZ      _AutoCloseTime+0, 1 
	INCF        _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2493:
;FirmV_0_7_0.c,1960 :: 		}
L_Menu2487:
;FirmV_0_7_0.c,1963 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2494
;FirmV_0_7_0.c,1965 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,1966 :: 		memcpy(LCDLine1,"                ",16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr98_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr98_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr98_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr98_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr98_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr98_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr98_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,1967 :: 		memcpy(LCDLine2,"                ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr99_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr99_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr99_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr99_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr99_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr99_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr99_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,1968 :: 		LCDFlash=0; LCDFlashFlag=0;
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,1969 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1970 :: 		FactorySettings();
	CALL        _FactorySettings+0, 0
;FirmV_0_7_0.c,1971 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,1972 :: 		}
L_Menu2494:
;FirmV_0_7_0.c,1975 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2495
;FirmV_0_7_0.c,1976 :: 		{ if((Events.Keys.b0==1)&&(OpenPhEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2498
	MOVF        _OpenPhEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2498
L__Menu2611:
;FirmV_0_7_0.c,1977 :: 		{OpenPhEnable=OpenPhEnable-1;Menu0();State=102;}
	DECF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2498:
;FirmV_0_7_0.c,1978 :: 		if((Events.Keys.b2==1)&&(OpenPhEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2501
	MOVLW       1
	SUBWF       _OpenPhEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2501
L__Menu2610:
;FirmV_0_7_0.c,1979 :: 		{OpenPhEnable=OpenPhEnable+1;Menu0();State=102;}
	INCF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2501:
;FirmV_0_7_0.c,1980 :: 		}
L_Menu2495:
;FirmV_0_7_0.c,1984 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2502
;FirmV_0_7_0.c,1985 :: 		{ if((Events.Keys.b0==1)&&(LimiterEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2505
	MOVF        _LimiterEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2505
L__Menu2609:
;FirmV_0_7_0.c,1986 :: 		{LimiterEnable=LimiterEnable-1;Menu0();State=102;}
	DECF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2505:
;FirmV_0_7_0.c,1987 :: 		if((Events.Keys.b2==1)&&(LimiterEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2508
	MOVLW       1
	SUBWF       _LimiterEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2508
L__Menu2608:
;FirmV_0_7_0.c,1988 :: 		{LimiterEnable=LimiterEnable+1;Menu0();State=102;}
	INCF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2508:
;FirmV_0_7_0.c,1989 :: 		}
L_Menu2502:
;FirmV_0_7_0.c,1992 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2509
;FirmV_0_7_0.c,1993 :: 		{ if((Events.Keys.b0==1)&&(LockForce>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2512
	MOVF        _LockForce+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2512
L__Menu2607:
;FirmV_0_7_0.c,1994 :: 		{LockForce=LockForce-1;Menu0();State=102;}
	DECF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2512:
;FirmV_0_7_0.c,1995 :: 		if((Events.Keys.b2==1)&&(LockForce<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2515
	MOVLW       1
	SUBWF       _LockForce+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2515
L__Menu2606:
;FirmV_0_7_0.c,1996 :: 		{LockForce=LockForce+1;Menu0();State=102;}
	INCF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2515:
;FirmV_0_7_0.c,1997 :: 		}
L_Menu2509:
;FirmV_0_7_0.c,2000 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2516
;FirmV_0_7_0.c,2001 :: 		{ if((Events.Keys.b0==1)&&(CloseAfterPass>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2519
	MOVF        _CloseAfterPass+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2519
L__Menu2605:
;FirmV_0_7_0.c,2002 :: 		{CloseAfterPass=CloseAfterPass-1;if(CloseAfterPass==9) CloseAfterPass=0;Menu0();State=102;}
	DECF        _CloseAfterPass+0, 1 
	MOVF        _CloseAfterPass+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2520
	CLRF        _CloseAfterPass+0 
L_Menu2520:
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2519:
;FirmV_0_7_0.c,2003 :: 		if((Events.Keys.b2==1)&&(CloseAfterPass<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2523
	MOVLW       255
	SUBWF       _CloseAfterPass+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2523
L__Menu2604:
;FirmV_0_7_0.c,2004 :: 		{CloseAfterPass=CloseAfterPass+1;if(CloseAfterPass==1) CloseAfterPass=10;Menu0();State=102;}
	INCF        _CloseAfterPass+0, 1 
	MOVF        _CloseAfterPass+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2524
	MOVLW       10
	MOVWF       _CloseAfterPass+0 
L_Menu2524:
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2523:
;FirmV_0_7_0.c,2005 :: 		}
L_Menu2516:
;FirmV_0_7_0.c,2008 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2525
;FirmV_0_7_0.c,2010 :: 		State=103;
	MOVLW       103
	MOVWF       _State+0 
;FirmV_0_7_0.c,2011 :: 		memcpy(LCDLine1,"                ",16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr100_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr100_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr100_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr100_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr100_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr100_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr100_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2012 :: 		memcpy(LCDLine2,"                ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr101_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr101_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr101_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr101_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr101_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr101_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr101_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2013 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2014 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2015 :: 		}
L_Menu2525:
;FirmV_0_7_0.c,2018 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2526
;FirmV_0_7_0.c,2020 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2021 :: 		memcpy(LCDLine1,"                ",16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr102_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr102_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr102_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr102_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr102_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr102_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr102_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2022 :: 		memcpy(LCDLine2,"                ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr103_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr103_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr103_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr103_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr103_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr103_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr103_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2023 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2024 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2025 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,2026 :: 		}
L_Menu2526:
;FirmV_0_7_0.c,2027 :: 		}
	RETURN      0
; end of _Menu2

_Menu3:

;FirmV_0_7_0.c,2039 :: 		void Menu3()
;FirmV_0_7_0.c,2041 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2042 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2043 :: 		}
	RETURN      0
; end of _Menu3

_LearnAuto:

;FirmV_0_7_0.c,2057 :: 		void LearnAuto()
;FirmV_0_7_0.c,2059 :: 		}
	RETURN      0
; end of _LearnAuto

_LearnManual:

;FirmV_0_7_0.c,2072 :: 		void LearnManual()
;FirmV_0_7_0.c,2074 :: 		}
	RETURN      0
; end of _LearnManual

_charValueToStr:

;FirmV_0_7_0.c,2082 :: 		void charValueToStr(char val, char * string)
;FirmV_0_7_0.c,2084 :: 		bytetostr(val>>1,string);
	MOVF        FARG_charValueToStr_val+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	RRCF        FARG_ByteToStr_input+0, 1 
	BCF         FARG_ByteToStr_input+0, 7 
	MOVF        FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_ByteToStr_output+0 
	MOVF        FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,2085 :: 		if((val%2)==1)
	MOVLW       1
	ANDWF       FARG_charValueToStr_val+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_charValueToStr527
;FirmV_0_7_0.c,2086 :: 		memcpy(string+3,".5s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       46
	MOVWF       ?lstr104_FirmV_0_7_0+0 
	MOVLW       53
	MOVWF       ?lstr104_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr104_FirmV_0_7_0+2 
	CLRF        ?lstr104_FirmV_0_7_0+3 
	MOVLW       ?lstr104_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr104_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_charValueToStr528
L_charValueToStr527:
;FirmV_0_7_0.c,2088 :: 		memcpy(string+3,"s  ",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       115
	MOVWF       ?lstr105_FirmV_0_7_0+0 
	MOVLW       32
	MOVWF       ?lstr105_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr105_FirmV_0_7_0+2 
	CLRF        ?lstr105_FirmV_0_7_0+3 
	MOVLW       ?lstr105_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr105_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_charValueToStr528:
;FirmV_0_7_0.c,2089 :: 		}
	RETURN      0
; end of _charValueToStr

_intValueToStr:

;FirmV_0_7_0.c,2102 :: 		void intValueToStr(unsigned val, char * string)
;FirmV_0_7_0.c,2104 :: 		wordtostr(val>>1,string);
	MOVF        FARG_intValueToStr_val+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        FARG_intValueToStr_val+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	RRCF        FARG_WordToStr_input+1, 1 
	RRCF        FARG_WordToStr_input+0, 1 
	BCF         FARG_WordToStr_input+1, 7 
	MOVF        FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_WordToStr_output+0 
	MOVF        FARG_intValueToStr_string+1, 0 
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;FirmV_0_7_0.c,2105 :: 		if((val%2)==1)
	MOVLW       1
	ANDWF       FARG_intValueToStr_val+0, 0 
	MOVWF       R1 
	MOVF        FARG_intValueToStr_val+1, 0 
	MOVWF       R2 
	MOVLW       0
	ANDWF       R2, 1 
	MOVLW       0
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__intValueToStr675
	MOVLW       1
	XORWF       R1, 0 
L__intValueToStr675:
	BTFSS       STATUS+0, 2 
	GOTO        L_intValueToStr529
;FirmV_0_7_0.c,2106 :: 		memcpy(string+5,".5s",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       46
	MOVWF       ?lstr106_FirmV_0_7_0+0 
	MOVLW       53
	MOVWF       ?lstr106_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr106_FirmV_0_7_0+2 
	CLRF        ?lstr106_FirmV_0_7_0+3 
	MOVLW       ?lstr106_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr106_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_intValueToStr530
L_intValueToStr529:
;FirmV_0_7_0.c,2108 :: 		memcpy(string+5,"s  ",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       115
	MOVWF       ?lstr107_FirmV_0_7_0+0 
	MOVLW       32
	MOVWF       ?lstr107_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr107_FirmV_0_7_0+2 
	CLRF        ?lstr107_FirmV_0_7_0+3 
	MOVLW       ?lstr107_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr107_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_intValueToStr530:
;FirmV_0_7_0.c,2109 :: 		}
	RETURN      0
; end of _intValueToStr

_SetOverloadParams:

;FirmV_0_7_0.c,2121 :: 		void SetOverloadParams(char p)
;FirmV_0_7_0.c,2124 :: 		switch(p)
	GOTO        L_SetOverloadParams531
;FirmV_0_7_0.c,2126 :: 		case 0: OverloadTreshold=0;OverloadDuration=255; break;
L_SetOverloadParams533:
	CLRF        _OverloadTreshold+0 
	CLRF        _OverloadTreshold+1 
	MOVLW       255
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams532
;FirmV_0_7_0.c,2128 :: 		case 1: OverloadTreshold=400;OverloadDuration=200; break;
L_SetOverloadParams534:
	MOVLW       144
	MOVWF       _OverloadTreshold+0 
	MOVLW       1
	MOVWF       _OverloadTreshold+1 
	MOVLW       200
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams532
;FirmV_0_7_0.c,2130 :: 		case 2: OverloadTreshold=450;OverloadDuration=150; break;
L_SetOverloadParams535:
	MOVLW       194
	MOVWF       _OverloadTreshold+0 
	MOVLW       1
	MOVWF       _OverloadTreshold+1 
	MOVLW       150
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams532
;FirmV_0_7_0.c,2132 :: 		case 3: OverloadTreshold=500;OverloadDuration=100; break;
L_SetOverloadParams536:
	MOVLW       244
	MOVWF       _OverloadTreshold+0 
	MOVLW       1
	MOVWF       _OverloadTreshold+1 
	MOVLW       100
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams532
;FirmV_0_7_0.c,2134 :: 		case 4: OverloadTreshold=550;OverloadDuration=80; break;
L_SetOverloadParams537:
	MOVLW       38
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       80
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams532
;FirmV_0_7_0.c,2136 :: 		case 5: OverloadTreshold=600;OverloadDuration=150; break;
L_SetOverloadParams538:
	MOVLW       88
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       150
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams532
;FirmV_0_7_0.c,2138 :: 		case 6: OverloadTreshold=600;OverloadDuration=100; break;
L_SetOverloadParams539:
	MOVLW       88
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       100
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams532
;FirmV_0_7_0.c,2140 :: 		case 7: OverloadTreshold=600;OverloadDuration=50; break;
L_SetOverloadParams540:
	MOVLW       88
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       50
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams532
;FirmV_0_7_0.c,2142 :: 		case 8: OverloadTreshold=700;OverloadDuration=100; break;
L_SetOverloadParams541:
	MOVLW       188
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       100
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams532
;FirmV_0_7_0.c,2144 :: 		case 9: OverloadTreshold=700;OverloadDuration=50; break;
L_SetOverloadParams542:
	MOVLW       188
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       50
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams532
;FirmV_0_7_0.c,2146 :: 		}
L_SetOverloadParams531:
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams533
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams534
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams535
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams536
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams537
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams538
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams539
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams540
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams541
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams542
L_SetOverloadParams532:
;FirmV_0_7_0.c,2147 :: 		}
	RETURN      0
; end of _SetOverloadParams
