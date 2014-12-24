
_interrupt:

;FirmV_0_7_0.c,198 :: 		void interrupt()
;FirmV_0_7_0.c,200 :: 		if(TMR0IF_bit)
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;FirmV_0_7_0.c,202 :: 		msCounter=msCounter+1;
	INCF        _msCounter+0, 1 
;FirmV_0_7_0.c,203 :: 		LCDBackLight=1;
	BSF         PORTA+0, 4 
;FirmV_0_7_0.c,204 :: 		Flag20ms=1;
	MOVLW       1
	MOVWF       _Flag20ms+0 
;FirmV_0_7_0.c,205 :: 		if(ms20A==255)
	MOVF        _ms20A+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;FirmV_0_7_0.c,206 :: 		{ms20A=0;RemotePulse1=0;}
	CLRF        _ms20A+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt2
L_interrupt1:
;FirmV_0_7_0.c,208 :: 		ms20A=ms20A+1;
	INCF        _ms20A+0, 1 
L_interrupt2:
;FirmV_0_7_0.c,210 :: 		if(ms20B==255)
	MOVF        _ms20B+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;FirmV_0_7_0.c,211 :: 		{ms20B=0;RemotePulse2=0;}
	CLRF        _ms20B+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt4
L_interrupt3:
;FirmV_0_7_0.c,213 :: 		ms20B=ms20B+1;
	INCF        _ms20B+0, 1 
L_interrupt4:
;FirmV_0_7_0.c,215 :: 		if(msCounter>=25)
	MOVLW       25
	SUBWF       _msCounter+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt5
;FirmV_0_7_0.c,217 :: 		msCounter=0;
	CLRF        _msCounter+0 
;FirmV_0_7_0.c,218 :: 		ms500=ms500+1;
	MOVLW       1
	ADDWF       _ms500+0, 1 
	MOVLW       0
	ADDWFC      _ms500+1, 1 
	ADDWFC      _ms500+2, 1 
	ADDWFC      _ms500+3, 1 
;FirmV_0_7_0.c,219 :: 		LCDFlashFlag=!LCDFlashFlag;
	MOVF        _LCDFlashFlag+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _LCDFlashFlag+0 
;FirmV_0_7_0.c,220 :: 		LCDBackLight=0;
	BCF         PORTA+0, 4 
;FirmV_0_7_0.c,221 :: 		Flag500ms=1;
	MOVLW       1
	MOVWF       _Flag500ms+0 
;FirmV_0_7_0.c,222 :: 		}
L_interrupt5:
;FirmV_0_7_0.c,223 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,224 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,225 :: 		TMR0IF_bit=0;
	BCF         TMR0IF_bit+0, 2 
;FirmV_0_7_0.c,226 :: 		}
L_interrupt0:
;FirmV_0_7_0.c,229 :: 		if(INT1F_bit)
	BTFSS       INT1F_bit+0, 0 
	GOTO        L_interrupt6
;FirmV_0_7_0.c,231 :: 		if(RemotePulse1==0)
	MOVF        _RemotePulse1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;FirmV_0_7_0.c,232 :: 		{ RemotePulse1=RemotePulse1+1;ms20A=0;}
	INCF        _RemotePulse1+0, 1 
	CLRF        _ms20A+0 
	GOTO        L_interrupt8
L_interrupt7:
;FirmV_0_7_0.c,234 :: 		{ RemotePulse1=RemotePulse1+1;}
	INCF        _RemotePulse1+0, 1 
L_interrupt8:
;FirmV_0_7_0.c,235 :: 		if(RemotePulse1>=5)
	MOVLW       5
	SUBWF       _RemotePulse1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt9
;FirmV_0_7_0.c,236 :: 		if((ms20A>=19)&&(ms20A<=21))
	MOVLW       19
	SUBWF       _ms20A+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
	MOVF        _ms20A+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
L__interrupt620:
;FirmV_0_7_0.c,237 :: 		{RemoteAFlag=1;RemotePulse1=0;}
	MOVLW       1
	MOVWF       _RemoteAFlag+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt13
L_interrupt12:
;FirmV_0_7_0.c,239 :: 		RemotePulse1=0;
	CLRF        _RemotePulse1+0 
L_interrupt13:
L_interrupt9:
;FirmV_0_7_0.c,240 :: 		INT1IF_bit=0;
	BCF         INT1IF_bit+0, 0 
;FirmV_0_7_0.c,241 :: 		}
L_interrupt6:
;FirmV_0_7_0.c,245 :: 		if(INT2IF_bit)
	BTFSS       INT2IF_bit+0, 1 
	GOTO        L_interrupt14
;FirmV_0_7_0.c,247 :: 		if(RemotePulse2==0)
	MOVF        _RemotePulse2+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt15
;FirmV_0_7_0.c,248 :: 		{ RemotePulse2=RemotePulse2+1;ms20B=0;}
	INCF        _RemotePulse2+0, 1 
	CLRF        _ms20B+0 
	GOTO        L_interrupt16
L_interrupt15:
;FirmV_0_7_0.c,250 :: 		{ RemotePulse2=RemotePulse2+1;}
	INCF        _RemotePulse2+0, 1 
L_interrupt16:
;FirmV_0_7_0.c,251 :: 		if(RemotePulse2>=5)
	MOVLW       5
	SUBWF       _RemotePulse2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt17
;FirmV_0_7_0.c,252 :: 		if((ms20B>=19)&&(ms20B<=21))
	MOVLW       19
	SUBWF       _ms20B+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
	MOVF        _ms20B+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
L__interrupt619:
;FirmV_0_7_0.c,253 :: 		{RemoteBFlag=1;RemotePulse2=0;}
	MOVLW       1
	MOVWF       _RemoteBFlag+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt21
L_interrupt20:
;FirmV_0_7_0.c,255 :: 		RemotePulse2=0;
	CLRF        _RemotePulse2+0 
L_interrupt21:
L_interrupt17:
;FirmV_0_7_0.c,256 :: 		INT2IF_bit=0;
	BCF         INT2IF_bit+0, 1 
;FirmV_0_7_0.c,257 :: 		}
L_interrupt14:
;FirmV_0_7_0.c,262 :: 		if(INT0F_bit==1)
	BTFSS       INT0F_bit+0, 1 
	GOTO        L_interrupt22
;FirmV_0_7_0.c,264 :: 		ZCCounter=ZCCounter+1;
	INCF        _ZCCounter+0, 1 
;FirmV_0_7_0.c,265 :: 		if(ZCCounter==255)
	MOVF        _ZCCounter+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt23
;FirmV_0_7_0.c,266 :: 		ZCCounter=0;
	CLRF        _ZCCounter+0 
L_interrupt23:
;FirmV_0_7_0.c,267 :: 		if(ZCCounter%3==1)
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
;FirmV_0_7_0.c,269 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt25
;FirmV_0_7_0.c,270 :: 		if(Motor1FullSpeed)
	MOVF        _Motor1FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt26
;FirmV_0_7_0.c,271 :: 		Motor1=1;
	BSF         PORTB+0, 4 
	GOTO        L_interrupt27
L_interrupt26:
;FirmV_0_7_0.c,273 :: 		Motor1=0;
	BCF         PORTB+0, 4 
L_interrupt27:
L_interrupt25:
;FirmV_0_7_0.c,275 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt28
;FirmV_0_7_0.c,276 :: 		if(Motor2FullSpeed)
	MOVF        _Motor2FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt29
;FirmV_0_7_0.c,277 :: 		Motor2=1;
	BSF         PORTB+0, 3 
	GOTO        L_interrupt30
L_interrupt29:
;FirmV_0_7_0.c,279 :: 		Motor2=0;
	BCF         PORTB+0, 3 
L_interrupt30:
L_interrupt28:
;FirmV_0_7_0.c,280 :: 		}
L_interrupt24:
;FirmV_0_7_0.c,281 :: 		if(ZCCounter%3==0)
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
;FirmV_0_7_0.c,283 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt32
;FirmV_0_7_0.c,284 :: 		Motor1=1;
	BSF         PORTB+0, 4 
L_interrupt32:
;FirmV_0_7_0.c,286 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt33
;FirmV_0_7_0.c,287 :: 		Motor2=1;
	BSF         PORTB+0, 3 
L_interrupt33:
;FirmV_0_7_0.c,288 :: 		}
L_interrupt31:
;FirmV_0_7_0.c,289 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, 1 
;FirmV_0_7_0.c,290 :: 		}
L_interrupt22:
;FirmV_0_7_0.c,291 :: 		}
L__interrupt710:
	RETFIE      1
; end of _interrupt

_ResetTaskEvents:

;FirmV_0_7_0.c,304 :: 		void ResetTaskEvents()
;FirmV_0_7_0.c,306 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,307 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,308 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,309 :: 		}
	RETURN      0
; end of _ResetTaskEvents

_Logger:

;FirmV_0_7_0.c,321 :: 		void Logger(char* text)
;FirmV_0_7_0.c,324 :: 		longwordtostrwithzeros(ms500,time);
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
;FirmV_0_7_0.c,325 :: 		uart_write_text(time);
	MOVLW       Logger_time_L0+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(Logger_time_L0+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;FirmV_0_7_0.c,326 :: 		uart1_write_text(": ");
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
;FirmV_0_7_0.c,327 :: 		uart1_write_text(text);
	MOVF        FARG_Logger_text+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_Logger_text+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;FirmV_0_7_0.c,328 :: 		uart1_write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,329 :: 		uart1_write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,330 :: 		}
	RETURN      0
; end of _Logger

_main:

;FirmV_0_7_0.c,347 :: 		void main() {
;FirmV_0_7_0.c,349 :: 		PhotocellRel=1;
	BSF         PORTC+0, 5 
;FirmV_0_7_0.c,351 :: 		Init();
	CALL        _Init+0, 0
;FirmV_0_7_0.c,353 :: 		Logger("Start ...");
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
;FirmV_0_7_0.c,357 :: 		while(1)
L_main34:
;FirmV_0_7_0.c,359 :: 		if(Flag20ms==1)
	MOVF        _Flag20ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main36
;FirmV_0_7_0.c,361 :: 		if(DebouncingDelay<DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelay+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main37
;FirmV_0_7_0.c,362 :: 		DebouncingDelay=DebouncingDelay+1;
	INCF        _DebouncingDelay+0, 1 
L_main37:
;FirmV_0_7_0.c,363 :: 		LCDUpdater();
	CALL        _LCDUpdater+0, 0
;FirmV_0_7_0.c,364 :: 		Flag20ms=0;
	CLRF        _Flag20ms+0 
;FirmV_0_7_0.c,365 :: 		}
L_main36:
;FirmV_0_7_0.c,367 :: 		if(Flag500ms==1)
	MOVF        _Flag500ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main38
;FirmV_0_7_0.c,369 :: 		ResetTaskEvents();
	CALL        _ResetTaskEvents+0, 0
;FirmV_0_7_0.c,370 :: 		TaskManager();
	CALL        _TaskManager+0, 0
;FirmV_0_7_0.c,371 :: 		Flag500ms=0;
	CLRF        _Flag500ms+0 
;FirmV_0_7_0.c,372 :: 		}
L_main38:
;FirmV_0_7_0.c,373 :: 		EventHandler();
	CALL        _EventHandler+0, 0
;FirmV_0_7_0.c,374 :: 		StateManager();
	CALL        _StateManager+0, 0
;FirmV_0_7_0.c,375 :: 		}
	GOTO        L_main34
;FirmV_0_7_0.c,377 :: 		}
	GOTO        $+0
; end of _main

_StateManager:

;FirmV_0_7_0.c,402 :: 		void StateManager()
;FirmV_0_7_0.c,408 :: 		switch(State)
	GOTO        L_StateManager39
;FirmV_0_7_0.c,411 :: 		case 0: State1(); break;
L_StateManager41:
	CALL        _State1+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,413 :: 		case 1: State1(); break;
L_StateManager42:
	CALL        _State1+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,415 :: 		case 2: State2(); break;
L_StateManager43:
	CALL        _State2+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,417 :: 		case 3: State3(); break;
L_StateManager44:
	CALL        _State3+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,419 :: 		case 4: State4(); break;
L_StateManager45:
	CALL        _State4+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,421 :: 		case 5: State5(); break;
L_StateManager46:
	CALL        _State5+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,423 :: 		case 6: State6(); break;
L_StateManager47:
	CALL        _State6+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,425 :: 		case 7: State7(); break;
L_StateManager48:
	CALL        _State7+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,427 :: 		case 8: State8(); break;
L_StateManager49:
	CALL        _State8+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,429 :: 		case 10:State00(); break;
L_StateManager50:
	CALL        _State00+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,431 :: 		case 100:Menu0(); break;
L_StateManager51:
	CALL        _Menu0+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,433 :: 		case 101:Menu1(); break;
L_StateManager52:
	CALL        _Menu1+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,435 :: 		case 102:Menu2(); break;
L_StateManager53:
	CALL        _Menu2+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,437 :: 		case 103:Menu3(); break;
L_StateManager54:
	CALL        _Menu3+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,439 :: 		case 200:LearnAuto(); break;
L_StateManager55:
	CALL        _LearnAuto+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,441 :: 		case 201:LearnManual(); break;
L_StateManager56:
	CALL        _LearnManual+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,443 :: 		}
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
;FirmV_0_7_0.c,444 :: 		}
	RETURN      0
; end of _StateManager

_StateTest:

;FirmV_0_7_0.c,448 :: 		void StateTest()
;FirmV_0_7_0.c,450 :: 		if (Events.Photocell==1)
	MOVF        _Events+6, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StateTest57
;FirmV_0_7_0.c,451 :: 		LCDLine1[0]='1';
	MOVLW       49
	MOVWF       _LCDLine1+0 
	GOTO        L_StateTest58
L_StateTest57:
;FirmV_0_7_0.c,453 :: 		LCDLine1[0]='0';
	MOVLW       48
	MOVWF       _LCDLine1+0 
L_StateTest58:
;FirmV_0_7_0.c,455 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,457 :: 		}
	RETURN      0
; end of _StateTest

_State00:

;FirmV_0_7_0.c,461 :: 		void State00()
;FirmV_0_7_0.c,466 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,467 :: 		StartMotor(1,_Close);
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,468 :: 		StartMotor(2,_Close);
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,472 :: 		if(Events.Remote.b0==1)
	BTFSS       _Events+4, 0 
	GOTO        L_State0059
;FirmV_0_7_0.c,473 :: 		{Flasher=0;StopMotor(1);StopMotor(2);
	BCF         PORTD+0, 7 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,474 :: 		State=1;                }
	MOVLW       1
	MOVWF       _State+0 
L_State0059:
;FirmV_0_7_0.c,475 :: 		}
	RETURN      0
; end of _State00

_State1:

;FirmV_0_7_0.c,484 :: 		void State1()
;FirmV_0_7_0.c,486 :: 		char delay=3;
	MOVLW       3
	MOVWF       State1_delay_L0+0 
;FirmV_0_7_0.c,489 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,491 :: 		if(Events.Keys==2)
	MOVF        _Events+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State160
;FirmV_0_7_0.c,492 :: 		{State=100;MenuPointer=0;}
	MOVLW       100
	MOVWF       _State+0 
	CLRF        _MenuPointer+0 
L_State160:
;FirmV_0_7_0.c,494 :: 		ActiveDoors=3-Events.Remote;
	MOVF        _Events+4, 0 
	SUBLW       3
	MOVWF       _ActiveDoors+0 
;FirmV_0_7_0.c,498 :: 		if(Events.Remote!=0)
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State161
;FirmV_0_7_0.c,501 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,502 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,503 :: 		AddTask(ms500+1,12);
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
;FirmV_0_7_0.c,504 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,505 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,506 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State162
;FirmV_0_7_0.c,507 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
;FirmV_0_7_0.c,509 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
;FirmV_0_7_0.c,510 :: 		temp=ms500+OpenSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,511 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,512 :: 		temp=ms500+OpenSoftStartTime+delay;
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
;FirmV_0_7_0.c,513 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,514 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State164
;FirmV_0_7_0.c,515 :: 		{temp=ms500+Door1OpenTime-OpenSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
;FirmV_0_7_0.c,516 :: 		temp=ms500+Door1OpenTime+delay;
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
;FirmV_0_7_0.c,517 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,519 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State167
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State167
L__State1621:
;FirmV_0_7_0.c,521 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,522 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,523 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State168
;FirmV_0_7_0.c,524 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,8); M2isSlow=1;}//speed down
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
;FirmV_0_7_0.c,526 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,6); M2isSlow=0;}//speed up
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
;FirmV_0_7_0.c,527 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,528 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,529 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+delay;
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
;FirmV_0_7_0.c,530 :: 		AddTask(temp,6);//Speed up after soft start
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
;FirmV_0_7_0.c,531 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State170
;FirmV_0_7_0.c,532 :: 		{temp=ms500+ActionTimeDiff+Door2OpenTime-OpenSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
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
;FirmV_0_7_0.c,533 :: 		temp=ms500+Door2OpenTime+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,534 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,535 :: 		}
L_State167:
;FirmV_0_7_0.c,537 :: 		if(AutoCloseTime!=0)
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State1711
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State1711:
	BTFSC       STATUS+0, 2 
	GOTO        L_State171
;FirmV_0_7_0.c,538 :: 		{temp=ms500+AutoCloseTime+delay;AddTask(ms500+AutoCloseTime+delay,9);}
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
;FirmV_0_7_0.c,540 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,541 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,542 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,543 :: 		State=3;
	MOVLW       3
	MOVWF       _State+0 
;FirmV_0_7_0.c,544 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,545 :: 		}
L_State161:
;FirmV_0_7_0.c,546 :: 		}
	RETURN      0
; end of _State1

_State2:

;FirmV_0_7_0.c,560 :: 		void State2()
;FirmV_0_7_0.c,562 :: 		char delay=2;
	MOVLW       2
	MOVWF       State2_delay_L0+0 
;FirmV_0_7_0.c,564 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,566 :: 		if((Events.Remote!=0)||(CheckTask(9)==1))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State2626
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State2626
	GOTO        L_State274
L__State2626:
;FirmV_0_7_0.c,569 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,570 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State2625
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State2625
	GOTO        L_State277
L__State2625:
;FirmV_0_7_0.c,572 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,573 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,574 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State278
;FirmV_0_7_0.c,575 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
;FirmV_0_7_0.c,577 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
;FirmV_0_7_0.c,578 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,579 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,580 :: 		temp=ms500+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,581 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,582 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State280
;FirmV_0_7_0.c,583 :: 		{temp=ms500+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
;FirmV_0_7_0.c,584 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State281
;FirmV_0_7_0.c,585 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
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
;FirmV_0_7_0.c,587 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,3);}
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
;FirmV_0_7_0.c,589 :: 		}
L_State277:
;FirmV_0_7_0.c,591 :: 		if((Door2CloseTime!=0)&&(ActiveDoors=2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State285
	MOVLW       2
	MOVWF       _ActiveDoors+0 
L__State2624:
;FirmV_0_7_0.c,593 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,594 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,595 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State286
;FirmV_0_7_0.c,596 :: 		{AddTask(temp,8); M2isSlow=1;}//speed down
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
;FirmV_0_7_0.c,598 :: 		{AddTask(temp,6); M2isSlow=0;}//speed up
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
;FirmV_0_7_0.c,599 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,600 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,601 :: 		temp=ms500+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,602 :: 		AddTask(temp,6);//Speed up after soft start
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
;FirmV_0_7_0.c,603 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State288
;FirmV_0_7_0.c,604 :: 		{temp=ms500+Door2CloseTime-CloseSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
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
;FirmV_0_7_0.c,606 :: 		temp=ms500+Door2CloseTime+delay;
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
;FirmV_0_7_0.c,607 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,611 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,612 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,613 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State289
;FirmV_0_7_0.c,614 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
;FirmV_0_7_0.c,616 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
;FirmV_0_7_0.c,617 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,618 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,619 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,620 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,621 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State291
;FirmV_0_7_0.c,622 :: 		{temp=ms500+ActionTimeDiff+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
;FirmV_0_7_0.c,623 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State292
;FirmV_0_7_0.c,624 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
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
;FirmV_0_7_0.c,626 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,3);}
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
;FirmV_0_7_0.c,628 :: 		}
L_State285:
;FirmV_0_7_0.c,631 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,632 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,633 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,634 :: 		State=4;
	MOVLW       4
	MOVWF       _State+0 
;FirmV_0_7_0.c,635 :: 		}
L_State274:
;FirmV_0_7_0.c,637 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State296
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2712
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State2712:
	BTFSC       STATUS+0, 2 
	GOTO        L_State296
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State296
L__State2623:
;FirmV_0_7_0.c,638 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S2 Auto Close Deleted");}
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
;FirmV_0_7_0.c,640 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State299
	BTFSC       _Events+6, 0 
	GOTO        L_State299
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2713
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State2713:
	BTFSC       STATUS+0, 2 
	GOTO        L_State299
L__State2622:
;FirmV_0_7_0.c,641 :: 		if(CloseAfterPass==0)
	MOVF        _CloseAfterPass+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State2100
;FirmV_0_7_0.c,642 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:");Logger(t);}
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
;FirmV_0_7_0.c,644 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:");Logger(t);}
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
;FirmV_0_7_0.c,646 :: 		}
	RETURN      0
; end of _State2

_State3:

;FirmV_0_7_0.c,661 :: 		void State3()
;FirmV_0_7_0.c,663 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,665 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3102
;FirmV_0_7_0.c,666 :: 		{StartMotor(1,_Open);Logger("S3 Motor1Start"); Lock=0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
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
	BCF         PORTD+0, 6 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __opening+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__opening+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State3102:
;FirmV_0_7_0.c,668 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3103
;FirmV_0_7_0.c,669 :: 		{StartMotor(2,_Open);Logger("S3 Motor2Start"); Lock=0;}
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
	BCF         PORTD+0, 6 
L_State3103:
;FirmV_0_7_0.c,671 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3104
;FirmV_0_7_0.c,672 :: 		{SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;Logger("S3 Motor1 Fast");}
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
;FirmV_0_7_0.c,674 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3105
;FirmV_0_7_0.c,675 :: 		{SetMotorSpeed(0,Motor2FullSpeed); M1isSlow=1;Logger("S3 Motor1 Slow");}
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
;FirmV_0_7_0.c,677 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3106
;FirmV_0_7_0.c,678 :: 		{SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;Logger("S3 Motor2 Fast");}
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
;FirmV_0_7_0.c,680 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3107
;FirmV_0_7_0.c,681 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S3 Motor2 Slow");}
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
;FirmV_0_7_0.c,683 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3108
;FirmV_0_7_0.c,684 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S3 Overflow Flag1 Set");}
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
;FirmV_0_7_0.c,686 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3109
;FirmV_0_7_0.c,687 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S3 Overflow Flag2 Set");}
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
;FirmV_0_7_0.c,689 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3110
;FirmV_0_7_0.c,690 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S3 Motor1 Stop");}
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
;FirmV_0_7_0.c,692 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3111
;FirmV_0_7_0.c,693 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S3 Motor2 Stop");}
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
;FirmV_0_7_0.c,695 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3112
;FirmV_0_7_0.c,696 :: 		{Lock=1;}
	BSF         PORTD+0, 6 
L_State3112:
;FirmV_0_7_0.c,698 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
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
L__State3632:
;FirmV_0_7_0.c,699 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor1 Collision");ClearTasks(9);
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
;FirmV_0_7_0.c,700 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errOverload+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errOverload+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State3115:
;FirmV_0_7_0.c,702 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
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
L__State3631:
;FirmV_0_7_0.c,703 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor2 Collision");ClearTasks(9);
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
;FirmV_0_7_0.c,704 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errOverload+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errOverload+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State3118:
;FirmV_0_7_0.c,706 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State3630
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State3630
	GOTO        L_State3121
L__State3630:
;FirmV_0_7_0.c,707 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State3121:
;FirmV_0_7_0.c,709 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State3124
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3124
L__State3629:
;FirmV_0_7_0.c,710 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Photocell Int");ClearTasks(9);
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
;FirmV_0_7_0.c,711 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errPhoto+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errPhoto+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State3124:
;FirmV_0_7_0.c,713 :: 		if(Events.Remote!=0)
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State3125
;FirmV_0_7_0.c,714 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Remote Stoped");ClearTasks(9);
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
;FirmV_0_7_0.c,715 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errRemote+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errRemote+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State3125:
;FirmV_0_7_0.c,717 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3128
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3128
L__State3628:
;FirmV_0_7_0.c,718 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Limit Switch Stoped");ClearTasks(9);
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
;FirmV_0_7_0.c,719 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errLimit+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errLimit+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State3128:
;FirmV_0_7_0.c,721 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3129
;FirmV_0_7_0.c,722 :: 		{State=2; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_blank,16);LCDUpdateFlag=1;}
	MOVLW       2
	MOVWF       _State+0 
	CLRF        _PassFlag+0 
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __open+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__open+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State3129:
;FirmV_0_7_0.c,724 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State3627
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State3627
	GOTO        L_State3132
L__State3627:
;FirmV_0_7_0.c,725 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S3 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State3714
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State3714:
	BTFSC       STATUS+0, 2 
	GOTO        L_State3133
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
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr21_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr21_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __autoclose+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__autoclose+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State3133:
L_State3132:
;FirmV_0_7_0.c,727 :: 		}
	RETURN      0
; end of _State3

_State4:

;FirmV_0_7_0.c,741 :: 		void State4()
;FirmV_0_7_0.c,743 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,745 :: 		bytetostr(Events.Task1,LCDLine1);
	MOVF        _Events+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,746 :: 		bytetostr(Events.Task2,LCDLine2);
	MOVF        _Events+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,747 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,749 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4134
;FirmV_0_7_0.c,750 :: 		{StartMotor(1,_Close);Logger("S4 Motor1Start");memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr22_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr22_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr22_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr22_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr22_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr22_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr22_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr22_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr22_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr22_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr22_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr22_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr22_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr22_FirmV_0_7_0+13 
	CLRF        ?lstr22_FirmV_0_7_0+14 
	MOVLW       ?lstr22_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr22_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __closing+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__closing+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State4134:
;FirmV_0_7_0.c,752 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4135
;FirmV_0_7_0.c,753 :: 		{StartMotor(2,_Close);Logger("S4 Motor2Start");}
	MOVLW       2
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
	MOVLW       50
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
;FirmV_0_7_0.c,755 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4136
;FirmV_0_7_0.c,756 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S4 M1 Overload Check");}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr24_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr24_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr24_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr24_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr24_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr24_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr24_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4136:
;FirmV_0_7_0.c,758 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4137
;FirmV_0_7_0.c,759 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S4 M2 Overload Check");}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
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
;FirmV_0_7_0.c,761 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4138
;FirmV_0_7_0.c,762 :: 		{SetMotorSpeed(1,Motor2FullSpeed); OverloadCheckFlag1=0; M1isSlow=0;Logger("S4 M1 Speed UP");}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag1+0 
	CLRF        _M1isSlow+0 
	MOVLW       83
	MOVWF       ?lstr26_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr26_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr26_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr26_FirmV_0_7_0+3 
	MOVLW       49
	MOVWF       ?lstr26_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr26_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr26_FirmV_0_7_0+6 
	MOVLW       112
	MOVWF       ?lstr26_FirmV_0_7_0+7 
	MOVLW       101
	MOVWF       ?lstr26_FirmV_0_7_0+8 
	MOVLW       101
	MOVWF       ?lstr26_FirmV_0_7_0+9 
	MOVLW       100
	MOVWF       ?lstr26_FirmV_0_7_0+10 
	MOVLW       32
	MOVWF       ?lstr26_FirmV_0_7_0+11 
	MOVLW       85
	MOVWF       ?lstr26_FirmV_0_7_0+12 
	MOVLW       80
	MOVWF       ?lstr26_FirmV_0_7_0+13 
	CLRF        ?lstr26_FirmV_0_7_0+14 
	MOVLW       ?lstr26_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr26_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4138:
;FirmV_0_7_0.c,764 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4139
;FirmV_0_7_0.c,765 :: 		{SetMotorSpeed(0,Motor2FullSpeed); OverloadCheckFlag2=0; M1isSlow=1;Logger("S4 M1 Speed Down");}
	CLRF        FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       1
	MOVWF       _M1isSlow+0 
	MOVLW       ?ICS?lstr27_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr27_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr27_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr27_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr27_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr27_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr27_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4139:
;FirmV_0_7_0.c,767 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4140
;FirmV_0_7_0.c,768 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S4 M2 Speed UP");}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       83
	MOVWF       ?lstr28_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr28_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr28_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr28_FirmV_0_7_0+3 
	MOVLW       50
	MOVWF       ?lstr28_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr28_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr28_FirmV_0_7_0+6 
	MOVLW       112
	MOVWF       ?lstr28_FirmV_0_7_0+7 
	MOVLW       101
	MOVWF       ?lstr28_FirmV_0_7_0+8 
	MOVLW       101
	MOVWF       ?lstr28_FirmV_0_7_0+9 
	MOVLW       100
	MOVWF       ?lstr28_FirmV_0_7_0+10 
	MOVLW       32
	MOVWF       ?lstr28_FirmV_0_7_0+11 
	MOVLW       85
	MOVWF       ?lstr28_FirmV_0_7_0+12 
	MOVLW       80
	MOVWF       ?lstr28_FirmV_0_7_0+13 
	CLRF        ?lstr28_FirmV_0_7_0+14 
	MOVLW       ?lstr28_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr28_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4140:
;FirmV_0_7_0.c,770 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4141
;FirmV_0_7_0.c,771 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S4 M2 Speed Down");}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CLRF        FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	MOVLW       ?ICS?lstr29_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr29_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr29_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr29_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr29_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr29_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr29_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4141:
;FirmV_0_7_0.c,773 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4142
;FirmV_0_7_0.c,774 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S4 M1 Stoped");}
	BCF         _CloseDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr30_FirmV_0_7_0+0 
	MOVLW       52
	MOVWF       ?lstr30_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr30_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr30_FirmV_0_7_0+3 
	MOVLW       49
	MOVWF       ?lstr30_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr30_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr30_FirmV_0_7_0+6 
	MOVLW       116
	MOVWF       ?lstr30_FirmV_0_7_0+7 
	MOVLW       111
	MOVWF       ?lstr30_FirmV_0_7_0+8 
	MOVLW       112
	MOVWF       ?lstr30_FirmV_0_7_0+9 
	MOVLW       101
	MOVWF       ?lstr30_FirmV_0_7_0+10 
	MOVLW       100
	MOVWF       ?lstr30_FirmV_0_7_0+11 
	CLRF        ?lstr30_FirmV_0_7_0+12 
	MOVLW       ?lstr30_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr30_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State4142:
;FirmV_0_7_0.c,776 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4143
;FirmV_0_7_0.c,777 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S4 M2 Stoped");}
	BCF         _CloseDone+0, 1 
	MOVLW       2
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
	MOVLW       50
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
;FirmV_0_7_0.c,779 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4146
	BTFSS       _Events+5, 0 
	GOTO        L_State4146
	MOVF        _M1isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4146
L__State4637:
;FirmV_0_7_0.c,780 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M1 Overloaded");ClearTasks(9);
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
	MOVLW       ?ICS?lstr32_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr32_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr32_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr32_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr32_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr32_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr32_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,781 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errOverload+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errOverload+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State4146:
;FirmV_0_7_0.c,783 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4149
	BTFSS       _Events+5, 1 
	GOTO        L_State4149
	MOVF        _M2isSlow+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4149
L__State4636:
;FirmV_0_7_0.c,784 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M2 Overloaded");ClearTasks(9);
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
;FirmV_0_7_0.c,785 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errOverload+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errOverload+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State4149:
;FirmV_0_7_0.c,787 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State4635
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State4635
	GOTO        L_State4152
L__State4635:
;FirmV_0_7_0.c,788 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State4152:
;FirmV_0_7_0.c,790 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State4153
;FirmV_0_7_0.c,791 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S4 Photocell Int");ClearTasks(9);
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
;FirmV_0_7_0.c,792 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errPhoto+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errPhoto+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State4153:
;FirmV_0_7_0.c,794 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4156
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4156
L__State4634:
;FirmV_0_7_0.c,795 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Limit Switch Stop");ClearTasks(9);
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
	MOVLW       21
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
;FirmV_0_7_0.c,796 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errLimit+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errLimit+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State4156:
;FirmV_0_7_0.c,798 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State4157
;FirmV_0_7_0.c,799 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Remote Pressed");ClearTasks(9);
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
	MOVLW       18
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
;FirmV_0_7_0.c,800 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errRemote+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errRemote+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State4157:
;FirmV_0_7_0.c,802 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4158
;FirmV_0_7_0.c,803 :: 		{State=1; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
	MOVLW       1
	MOVWF       _State+0 
	CLRF        _PassFlag+0 
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __close+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__close+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State4158:
;FirmV_0_7_0.c,805 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State4633
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State4633
	GOTO        L_State4161
L__State4633:
;FirmV_0_7_0.c,806 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S4 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State4715
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State4715:
	BTFSC       STATUS+0, 2 
	GOTO        L_State4162
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
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr37_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr37_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __autoclose+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__autoclose+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State4162:
L_State4161:
;FirmV_0_7_0.c,808 :: 		}
	RETURN      0
; end of _State4

_State5:

;FirmV_0_7_0.c,823 :: 		void State5()
;FirmV_0_7_0.c,825 :: 		char delay=2;
	MOVLW       2
	MOVWF       State5_delay_L0+0 
;FirmV_0_7_0.c,826 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,827 :: 		if((Events.Remote!=0)||(CheckTask(9)==1))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State5642
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5642
	GOTO        L_State5165
L__State5642:
;FirmV_0_7_0.c,829 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State5641
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5641
	GOTO        L_State5168
L__State5641:
;FirmV_0_7_0.c,831 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,832 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,833 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,834 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,835 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,836 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,838 :: 		temp=ms500+Door1CloseTime+delay;
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
L_State5168:
;FirmV_0_7_0.c,841 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State5171
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State5171
L__State5640:
;FirmV_0_7_0.c,843 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,844 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,845 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,846 :: 		AddTask(temp,6);
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
;FirmV_0_7_0.c,847 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,848 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,849 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,850 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,851 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,856 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,857 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,858 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,859 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,860 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,861 :: 		temp=ms500+ActionTimeDiff+OverloadDelay+delay;
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
;FirmV_0_7_0.c,862 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,863 :: 		temp=ms500+Door2CloseTime+delay;
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
;FirmV_0_7_0.c,864 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,865 :: 		}
L_State5171:
;FirmV_0_7_0.c,866 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,867 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,868 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,869 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,870 :: 		}
L_State5165:
;FirmV_0_7_0.c,872 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State5174
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State5716
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State5716:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5174
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State5174
L__State5639:
;FirmV_0_7_0.c,873 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S5 Auto Close Deleted");}
	MOVLW       1
	MOVWF       _PassFlag+0 
	CALL        _GetAutocloseTime+0, 0
	MOVF        R0, 0 
	MOVWF       __AC+0 
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
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr38_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr38_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State5174:
;FirmV_0_7_0.c,875 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State5177
	BTFSC       _Events+6, 0 
	GOTO        L_State5177
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State5717
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State5717:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5177
L__State5638:
;FirmV_0_7_0.c,878 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:");Logger(t);}
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
	MOVLW       16
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr39_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr39_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       _t+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,880 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:");Logger(t);}
L_State5179:
;FirmV_0_7_0.c,881 :: 		}
L_State5177:
;FirmV_0_7_0.c,883 :: 		}
	RETURN      0
; end of _State5

_State6:

;FirmV_0_7_0.c,903 :: 		void State6()
;FirmV_0_7_0.c,907 :: 		char delay=3;
	MOVLW       3
	MOVWF       State6_delay_L0+0 
;FirmV_0_7_0.c,908 :: 		Flasher=0;
	BCF         PORTD+0, 7 
;FirmV_0_7_0.c,909 :: 		if((Events.Remote!=0)||(PhotocellOpenFlag))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State6647
	MOVF        _PhotocellOpenFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6647
	GOTO        L_State6182
L__State6647:
;FirmV_0_7_0.c,911 :: 		PhotocellOpenFlag=0;
	CLRF        _PhotocellOpenFlag+0 
;FirmV_0_7_0.c,912 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,913 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,914 :: 		AddTask(ms500+1,12);
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
;FirmV_0_7_0.c,915 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,916 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,917 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,918 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,919 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,920 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,921 :: 		temp=ms500+Door1OpenTime+delay;
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
;FirmV_0_7_0.c,922 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,923 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6185
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6185
L__State6646:
;FirmV_0_7_0.c,925 :: 		AddTask(ms500+ActionTimeDiff+delay,2);
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
;FirmV_0_7_0.c,926 :: 		AddTask(ms500+ActionTimeDiff+delay,6);
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
;FirmV_0_7_0.c,927 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,928 :: 		AddTask(ms500+ActionTimeDiff+OverloadDelay+delay,11); //overload check
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
;FirmV_0_7_0.c,929 :: 		AddTask(ms500+Door2OpenTime+delay,4);//Stop motor
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
;FirmV_0_7_0.c,930 :: 		}
L_State6185:
;FirmV_0_7_0.c,931 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,932 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,933 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,934 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,935 :: 		State=8;
	MOVLW       8
	MOVWF       _State+0 
;FirmV_0_7_0.c,936 :: 		}
L_State6182:
;FirmV_0_7_0.c,939 :: 		if(CheckTask(9)==1)
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6186
;FirmV_0_7_0.c,941 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,942 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,943 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,944 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,945 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,946 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,947 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,948 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,949 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,951 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6189
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6189
L__State6645:
;FirmV_0_7_0.c,953 :: 		AddTask(ms500+ActionTimeDiff+delay,2);
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
;FirmV_0_7_0.c,954 :: 		AddTask(ms500+ActionTimeDiff+delay,6);
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
;FirmV_0_7_0.c,955 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,956 :: 		AddTask(ms500+ActionTimeDiff+OverloadDelay+delay,11); //overload check
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
;FirmV_0_7_0.c,957 :: 		AddTask(ms500+Door1CloseTime+delay,4);//Stop motor
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
;FirmV_0_7_0.c,958 :: 		}
L_State6189:
;FirmV_0_7_0.c,959 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,960 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,961 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,962 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,963 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,964 :: 		}
L_State6186:
;FirmV_0_7_0.c,966 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State6192
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6718
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State6718:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6192
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State6192
L__State6644:
;FirmV_0_7_0.c,967 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S6 Auto Close Deleted");}
	MOVLW       1
	MOVWF       _PassFlag+0 
	CALL        _GetAutocloseTime+0, 0
	MOVF        R0, 0 
	MOVWF       __AC+0 
	MOVLW       ?ICS?lstr41_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr41_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr41_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr41_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr41_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr41_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr41_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State6192:
;FirmV_0_7_0.c,969 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6195
	BTFSC       _Events+6, 0 
	GOTO        L_State6195
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6719
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State6719:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6195
L__State6643:
;FirmV_0_7_0.c,971 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:");Logger(t);}
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
	MOVLW       16
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr42_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr42_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       _t+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(_t+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
;FirmV_0_7_0.c,973 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:");Logger(t);}
L_State6197:
;FirmV_0_7_0.c,974 :: 		}
L_State6195:
;FirmV_0_7_0.c,976 :: 		}
	RETURN      0
; end of _State6

_State7:

;FirmV_0_7_0.c,998 :: 		void State7()
;FirmV_0_7_0.c,1000 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,1002 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7198
;FirmV_0_7_0.c,1003 :: 		{StartMotor(1,_Close);Logger("S7 Motor1Start");memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr44_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr44_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr44_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr44_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr44_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr44_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr44_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr44_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr44_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr44_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr44_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr44_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr44_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr44_FirmV_0_7_0+13 
	CLRF        ?lstr44_FirmV_0_7_0+14 
	MOVLW       ?lstr44_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr44_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __closing+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__closing+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State7198:
;FirmV_0_7_0.c,1005 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7199
;FirmV_0_7_0.c,1006 :: 		{StartMotor(2,_Close);Logger("S7 Motor2Start");}
	MOVLW       2
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
	MOVLW       50
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
;FirmV_0_7_0.c,1008 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7200
;FirmV_0_7_0.c,1009 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S7 M1 Overload Check");}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr46_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr46_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr46_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr46_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr46_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       21
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr46_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr46_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State7200:
;FirmV_0_7_0.c,1011 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7201
;FirmV_0_7_0.c,1012 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S7 M2 Overload Check");}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
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
;FirmV_0_7_0.c,1014 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7202
;FirmV_0_7_0.c,1015 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S7 M1 Speed UP");}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
	MOVLW       83
	MOVWF       ?lstr48_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr48_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr48_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr48_FirmV_0_7_0+3 
	MOVLW       49
	MOVWF       ?lstr48_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr48_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr48_FirmV_0_7_0+6 
	MOVLW       112
	MOVWF       ?lstr48_FirmV_0_7_0+7 
	MOVLW       101
	MOVWF       ?lstr48_FirmV_0_7_0+8 
	MOVLW       101
	MOVWF       ?lstr48_FirmV_0_7_0+9 
	MOVLW       100
	MOVWF       ?lstr48_FirmV_0_7_0+10 
	MOVLW       32
	MOVWF       ?lstr48_FirmV_0_7_0+11 
	MOVLW       85
	MOVWF       ?lstr48_FirmV_0_7_0+12 
	MOVLW       80
	MOVWF       ?lstr48_FirmV_0_7_0+13 
	CLRF        ?lstr48_FirmV_0_7_0+14 
	MOVLW       ?lstr48_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr48_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State7202:
;FirmV_0_7_0.c,1017 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7203
;FirmV_0_7_0.c,1018 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S7 M2 Speed UP");}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
	MOVLW       83
	MOVWF       ?lstr49_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr49_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr49_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr49_FirmV_0_7_0+3 
	MOVLW       50
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
;FirmV_0_7_0.c,1020 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(CloseDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7655
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7656
	BTFSS       _Events+5, 0 
	GOTO        L__State7656
	GOTO        L__State7655
L__State7656:
	GOTO        L_State7210
L__State7655:
	BTFSS       _CloseDone+0, 0 
	GOTO        L_State7210
L__State7654:
;FirmV_0_7_0.c,1021 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S7 M1 Stoped");}
	BCF         _CloseDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr50_FirmV_0_7_0+0 
	MOVLW       55
	MOVWF       ?lstr50_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr50_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr50_FirmV_0_7_0+3 
	MOVLW       49
	MOVWF       ?lstr50_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr50_FirmV_0_7_0+5 
	MOVLW       83
	MOVWF       ?lstr50_FirmV_0_7_0+6 
	MOVLW       116
	MOVWF       ?lstr50_FirmV_0_7_0+7 
	MOVLW       111
	MOVWF       ?lstr50_FirmV_0_7_0+8 
	MOVLW       112
	MOVWF       ?lstr50_FirmV_0_7_0+9 
	MOVLW       101
	MOVWF       ?lstr50_FirmV_0_7_0+10 
	MOVLW       100
	MOVWF       ?lstr50_FirmV_0_7_0+11 
	CLRF        ?lstr50_FirmV_0_7_0+12 
	MOVLW       ?lstr50_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr50_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State7210:
;FirmV_0_7_0.c,1023 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(CloseDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7652
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7653
	BTFSS       _Events+5, 1 
	GOTO        L__State7653
	GOTO        L__State7652
L__State7653:
	GOTO        L_State7217
L__State7652:
	BTFSS       _CloseDone+0, 1 
	GOTO        L_State7217
L__State7651:
;FirmV_0_7_0.c,1024 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S7 M2 Stoped");}
	BCF         _CloseDone+0, 1 
	MOVLW       2
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
	MOVLW       50
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
L_State7217:
;FirmV_0_7_0.c,1026 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State7650
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State7650
	GOTO        L_State7220
L__State7650:
;FirmV_0_7_0.c,1027 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State7220:
;FirmV_0_7_0.c,1029 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State7221
;FirmV_0_7_0.c,1030 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S7 Photocell Int");ClearTasks(9);
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
	MOVLW       ?ICS?lstr52_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr52_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr52_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr52_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr52_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr52_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr52_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1031 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errPhoto+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errPhoto+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State7221:
;FirmV_0_7_0.c,1033 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State7222
;FirmV_0_7_0.c,1034 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Remote Pressed");ClearTasks(9);
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
	MOVLW       18
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
;FirmV_0_7_0.c,1035 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errRemote+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errRemote+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State7222:
;FirmV_0_7_0.c,1037 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State7225
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7225
L__State7649:
;FirmV_0_7_0.c,1038 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Limit Switch Stop");ClearTasks(9);
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
	MOVLW       21
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
;FirmV_0_7_0.c,1039 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errLimit+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errLimit+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State7225:
;FirmV_0_7_0.c,1041 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State7226
;FirmV_0_7_0.c,1042 :: 		{State=1; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
	MOVLW       1
	MOVWF       _State+0 
	CLRF        _PassFlag+0 
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __close+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__close+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State7226:
;FirmV_0_7_0.c,1044 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State7648
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State7648
	GOTO        L_State7229
L__State7648:
;FirmV_0_7_0.c,1045 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S7 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7720
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State7720:
	BTFSC       STATUS+0, 2 
	GOTO        L_State7230
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
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __autoclose+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__autoclose+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State7230:
L_State7229:
;FirmV_0_7_0.c,1048 :: 		}
	RETURN      0
; end of _State7

_State8:

;FirmV_0_7_0.c,1065 :: 		void State8()
;FirmV_0_7_0.c,1067 :: 		Flasher=1;
	BSF         PORTD+0, 7 
;FirmV_0_7_0.c,1069 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8231
;FirmV_0_7_0.c,1070 :: 		{StartMotor(1,_Open);Logger("S8 Motor1Start"); Lock=0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
	MOVLW       83
	MOVWF       ?lstr56_FirmV_0_7_0+0 
	MOVLW       56
	MOVWF       ?lstr56_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr56_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr56_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr56_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr56_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr56_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr56_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr56_FirmV_0_7_0+8 
	MOVLW       83
	MOVWF       ?lstr56_FirmV_0_7_0+9 
	MOVLW       116
	MOVWF       ?lstr56_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr56_FirmV_0_7_0+11 
	MOVLW       114
	MOVWF       ?lstr56_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr56_FirmV_0_7_0+13 
	CLRF        ?lstr56_FirmV_0_7_0+14 
	MOVLW       ?lstr56_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr56_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	BCF         PORTD+0, 6 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __opening+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__opening+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State8231:
;FirmV_0_7_0.c,1072 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8232
;FirmV_0_7_0.c,1073 :: 		{StartMotor(2,_Open);Logger("S8 Motor2Start"); Lock=0;}
	MOVLW       2
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
	MOVLW       50
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
	BCF         PORTD+0, 6 
L_State8232:
;FirmV_0_7_0.c,1075 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8233
;FirmV_0_7_0.c,1076 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S8 Overflow Flag1 Set");}
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_OverloadInit+0 
	CALL        _OverloadInit+0, 0
	MOVLW       ?ICS?lstr58_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr58_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr58_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr58_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr58_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       22
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr58_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr58_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State8233:
;FirmV_0_7_0.c,1078 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8234
;FirmV_0_7_0.c,1079 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S8 Overflow Flag2 Set");}
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
	MOVLW       2
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
;FirmV_0_7_0.c,1081 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8235
;FirmV_0_7_0.c,1082 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S8 Motor1 Fast");}
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
	MOVLW       83
	MOVWF       ?lstr60_FirmV_0_7_0+0 
	MOVLW       56
	MOVWF       ?lstr60_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr60_FirmV_0_7_0+2 
	MOVLW       77
	MOVWF       ?lstr60_FirmV_0_7_0+3 
	MOVLW       111
	MOVWF       ?lstr60_FirmV_0_7_0+4 
	MOVLW       116
	MOVWF       ?lstr60_FirmV_0_7_0+5 
	MOVLW       111
	MOVWF       ?lstr60_FirmV_0_7_0+6 
	MOVLW       114
	MOVWF       ?lstr60_FirmV_0_7_0+7 
	MOVLW       49
	MOVWF       ?lstr60_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr60_FirmV_0_7_0+9 
	MOVLW       70
	MOVWF       ?lstr60_FirmV_0_7_0+10 
	MOVLW       97
	MOVWF       ?lstr60_FirmV_0_7_0+11 
	MOVLW       115
	MOVWF       ?lstr60_FirmV_0_7_0+12 
	MOVLW       116
	MOVWF       ?lstr60_FirmV_0_7_0+13 
	CLRF        ?lstr60_FirmV_0_7_0+14 
	MOVLW       ?lstr60_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr60_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State8235:
;FirmV_0_7_0.c,1084 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8236
;FirmV_0_7_0.c,1085 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S8 Motor2 Fast");}
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
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
	MOVLW       50
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
;FirmV_0_7_0.c,1087 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(OpenDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8665
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8666
	BTFSS       _Events+5, 0 
	GOTO        L__State8666
	GOTO        L__State8665
L__State8666:
	GOTO        L_State8243
L__State8665:
	BTFSS       _OpenDone+0, 0 
	GOTO        L_State8243
L__State8664:
;FirmV_0_7_0.c,1088 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S8 Motor1 Stop");}
	BCF         _OpenDone+0, 0 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
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
	MOVLW       49
	MOVWF       ?lstr62_FirmV_0_7_0+8 
	MOVLW       32
	MOVWF       ?lstr62_FirmV_0_7_0+9 
	MOVLW       83
	MOVWF       ?lstr62_FirmV_0_7_0+10 
	MOVLW       116
	MOVWF       ?lstr62_FirmV_0_7_0+11 
	MOVLW       111
	MOVWF       ?lstr62_FirmV_0_7_0+12 
	MOVLW       112
	MOVWF       ?lstr62_FirmV_0_7_0+13 
	CLRF        ?lstr62_FirmV_0_7_0+14 
	MOVLW       ?lstr62_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr62_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
L_State8243:
;FirmV_0_7_0.c,1090 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(OpenDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8662
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8663
	BTFSS       _Events+5, 1 
	GOTO        L__State8663
	GOTO        L__State8662
L__State8663:
	GOTO        L_State8250
L__State8662:
	BTFSS       _OpenDone+0, 1 
	GOTO        L_State8250
L__State8661:
;FirmV_0_7_0.c,1091 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S8 Motor2 Stop");}
	BCF         _OpenDone+0, 1 
	MOVLW       2
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
	MOVLW       50
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
L_State8250:
;FirmV_0_7_0.c,1093 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8251
;FirmV_0_7_0.c,1094 :: 		{Lock=1;}
	BSF         PORTD+0, 6 
L_State8251:
;FirmV_0_7_0.c,1096 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State8660
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State8660
	GOTO        L_State8254
L__State8660:
;FirmV_0_7_0.c,1097 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State8254:
;FirmV_0_7_0.c,1099 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State8257
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8257
L__State8659:
;FirmV_0_7_0.c,1100 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S8 Photocell Int");ClearTasks(9);
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
	MOVLW       ?ICS?lstr64_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr64_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr64_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr64_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr64_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr64_FirmV_0_7_0+0
	MOVWF       FARG_Logger_text+0 
	MOVLW       hi_addr(?lstr64_FirmV_0_7_0+0)
	MOVWF       FARG_Logger_text+1 
	CALL        _Logger+0, 0
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,1101 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errPhoto+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errPhoto+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State8257:
;FirmV_0_7_0.c,1103 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State8258
;FirmV_0_7_0.c,1104 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Motors Stoped (Remote)");ClearTasks(9);
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
	MOVLW       26
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
;FirmV_0_7_0.c,1105 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errRemote+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errRemote+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State8258:
;FirmV_0_7_0.c,1107 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State8261
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8261
L__State8658:
;FirmV_0_7_0.c,1108 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Limit Switch Stop");ClearTasks(9);
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
	MOVLW       21
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
;FirmV_0_7_0.c,1109 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __stop+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__stop+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __errLimit+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__errLimit+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State8261:
;FirmV_0_7_0.c,1111 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State8262
;FirmV_0_7_0.c,1112 :: 		{State=2; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
	MOVLW       2
	MOVWF       _State+0 
	CLRF        _PassFlag+0 
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __open+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__open+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __Blank+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__Blank+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State8262:
;FirmV_0_7_0.c,1114 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State8657
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State8657
	GOTO        L_State8265
L__State8657:
;FirmV_0_7_0.c,1115 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S8 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8721
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State8721:
	BTFSC       STATUS+0, 2 
	GOTO        L_State8266
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
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       __autoclose+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(__autoclose+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
L_State8266:
L_State8265:
;FirmV_0_7_0.c,1118 :: 		}
	RETURN      0
; end of _State8

_LCDUpdater:

;FirmV_0_7_0.c,1127 :: 		void LCDUpdater()
;FirmV_0_7_0.c,1129 :: 		if(LCDUpdateFlag==1)
	MOVF        _LCDUpdateFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDUpdater267
;FirmV_0_7_0.c,1131 :: 		lcd_out(1,1,LCDLine1);
	MOVLW       1
	MOVWF       FARG_LCD_out+0 
	MOVLW       1
	MOVWF       FARG_LCD_out+0 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_LCD_out+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_LCD_out+1 
	CALL        _LCD_out+0, 0
;FirmV_0_7_0.c,1132 :: 		lcd_out(2,1,LCDLine2);
	MOVLW       2
	MOVWF       FARG_LCD_out+0 
	MOVLW       1
	MOVWF       FARG_LCD_out+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_LCD_out+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_LCD_out+1 
	CALL        _LCD_out+0, 0
;FirmV_0_7_0.c,1133 :: 		LCDUpdateFlag=0;
	CLRF        _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1134 :: 		}
L_LCDUpdater267:
;FirmV_0_7_0.c,1136 :: 		if(LCDFlash)
	MOVF        _LCDFlash+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater268
;FirmV_0_7_0.c,1138 :: 		if(LCDFlashFlag)
	MOVF        _LCDFlashFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater269
;FirmV_0_7_0.c,1139 :: 		lcd_out(2,1,"               ");
	MOVLW       2
	MOVWF       FARG_LCD_out+0 
	MOVLW       1
	MOVWF       FARG_LCD_out+0 
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
	MOVLW       16
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr68_FirmV_0_7_0+0
	MOVWF       FARG_LCD_out+0 
	MOVLW       hi_addr(?lstr68_FirmV_0_7_0+0)
	MOVWF       FARG_LCD_out+1 
	CALL        _LCD_out+0, 0
	GOTO        L_LCDUpdater270
L_LCDUpdater269:
;FirmV_0_7_0.c,1141 :: 		lcd_out(2,1,LCDLine2);
	MOVLW       2
	MOVWF       FARG_LCD_out+0 
	MOVLW       1
	MOVWF       FARG_LCD_out+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_LCD_out+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_LCD_out+1 
	CALL        _LCD_out+0, 0
L_LCDUpdater270:
;FirmV_0_7_0.c,1142 :: 		}
L_LCDUpdater268:
;FirmV_0_7_0.c,1145 :: 		}
	RETURN      0
; end of _LCDUpdater

_Init:

;FirmV_0_7_0.c,1165 :: 		void Init()
;FirmV_0_7_0.c,1167 :: 		char i=0;
	CLRF        Init_i_L0+0 
;FirmV_0_7_0.c,1169 :: 		porta=0;
	CLRF        PORTA+0 
;FirmV_0_7_0.c,1170 :: 		portb=0;
	CLRF        PORTB+0 
;FirmV_0_7_0.c,1171 :: 		portc=0;
	CLRF        PORTC+0 
;FirmV_0_7_0.c,1172 :: 		portd=0;
	CLRF        PORTD+0 
;FirmV_0_7_0.c,1173 :: 		porte=0;
	CLRF        PORTE+0 
;FirmV_0_7_0.c,1174 :: 		trisa=0b101111;
	MOVLW       47
	MOVWF       TRISA+0 
;FirmV_0_7_0.c,1175 :: 		trisb=0b10000111;
	MOVLW       135
	MOVWF       TRISB+0 
;FirmV_0_7_0.c,1176 :: 		trisc=0b10000100;
	MOVLW       132
	MOVWF       TRISC+0 
;FirmV_0_7_0.c,1177 :: 		trisd=0b00111111;
	MOVLW       63
	MOVWF       TRISD+0 
;FirmV_0_7_0.c,1178 :: 		trise=0b001;
	MOVLW       1
	MOVWF       TRISE+0 
;FirmV_0_7_0.c,1179 :: 		adcon1=0b0010;  // an6, an5 and an7 is digital
	MOVLW       2
	MOVWF       ADCON1+0 
;FirmV_0_7_0.c,1184 :: 		LCDxReset=1;
	BSF         PORTB+0, 6 
;FirmV_0_7_0.c,1185 :: 		LCDBackLight=1;
	BSF         PORTA+0, 4 
;FirmV_0_7_0.c,1186 :: 		I2C1_init(100000);
	MOVLW       100
	MOVWF       SSPADD+0 
	CALL        _I2C1_Init+0, 0
;FirmV_0_7_0.c,1188 :: 		delay_ms(100);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_Init271:
	DECFSZ      R13, 1, 0
	BRA         L_Init271
	DECFSZ      R12, 1, 0
	BRA         L_Init271
	DECFSZ      R11, 1, 0
	BRA         L_Init271
	NOP
	NOP
;FirmV_0_7_0.c,1190 :: 		LCD_init(2);
	MOVLW       2
	MOVWF       FARG_LCD_Init+0 
	CALL        _LCD_Init+0, 0
;FirmV_0_7_0.c,1191 :: 		delay_ms(300);
	MOVLW       16
	MOVWF       R11, 0
	MOVLW       57
	MOVWF       R12, 0
	MOVLW       13
	MOVWF       R13, 0
L_Init272:
	DECFSZ      R13, 1, 0
	BRA         L_Init272
	DECFSZ      R12, 1, 0
	BRA         L_Init272
	DECFSZ      R11, 1, 0
	BRA         L_Init272
	NOP
	NOP
;FirmV_0_7_0.c,1192 :: 		SetContrast(20);
	MOVLW       20
	MOVWF       FARG_SetContrast+0 
	CALL        _SetContrast+0, 0
;FirmV_0_7_0.c,1195 :: 		ms500=0;
	CLRF        _ms500+0 
	CLRF        _ms500+1 
	CLRF        _ms500+2 
	CLRF        _ms500+3 
;FirmV_0_7_0.c,1196 :: 		t0con=0b10000101; //enable tmr0 and prescalar
	MOVLW       133
	MOVWF       T0CON+0 
;FirmV_0_7_0.c,1197 :: 		intcon.b7=1;   //global int enable
	BSF         INTCON+0, 7 
;FirmV_0_7_0.c,1198 :: 		intcon.b5=1;  //tmr0 int enable
	BSF         INTCON+0, 5 
;FirmV_0_7_0.c,1199 :: 		intcon.b2=0; //tmr0 flag
	BCF         INTCON+0, 2 
;FirmV_0_7_0.c,1200 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,1201 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,1204 :: 		INT1IP_bit=1;
	BSF         INT1IP_bit+0, 6 
;FirmV_0_7_0.c,1205 :: 		INT1E_bit=1;
	BSF         INT1E_bit+0, 3 
;FirmV_0_7_0.c,1206 :: 		INT1F_bit=0;
	BCF         INT1F_bit+0, 0 
;FirmV_0_7_0.c,1207 :: 		INT2IP_bit=1;
	BSF         INT2IP_bit+0, 7 
;FirmV_0_7_0.c,1208 :: 		INT2E_bit=1;
	BSF         INT2E_bit+0, 4 
;FirmV_0_7_0.c,1209 :: 		INT2F_bit=0;
	BCF         INT2F_bit+0, 1 
;FirmV_0_7_0.c,1210 :: 		INTEDG1_bit=1;
	BSF         INTEDG1_bit+0, 5 
;FirmV_0_7_0.c,1211 :: 		INTEDG2_bit=1;
	BSF         INTEDG2_bit+0, 4 
;FirmV_0_7_0.c,1214 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, 1 
;FirmV_0_7_0.c,1215 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, 4 
;FirmV_0_7_0.c,1218 :: 		for(i=0;i<20;i++)
	CLRF        Init_i_L0+0 
L_Init273:
	MOVLW       20
	SUBWF       Init_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Init274
;FirmV_0_7_0.c,1219 :: 		Tasks[i].Expired=1;
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
;FirmV_0_7_0.c,1218 :: 		for(i=0;i<20;i++)
	INCF        Init_i_L0+0, 1 
;FirmV_0_7_0.c,1219 :: 		Tasks[i].Expired=1;
	GOTO        L_Init273
L_Init274:
;FirmV_0_7_0.c,1222 :: 		Events.Keys=0;
	CLRF        _Events+0 
;FirmV_0_7_0.c,1223 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,1224 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,1225 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,1226 :: 		Events.Remote=0;
	CLRF        _Events+4 
;FirmV_0_7_0.c,1227 :: 		Events.Overload=0;
	CLRF        _Events+5 
;FirmV_0_7_0.c,1228 :: 		Events.Photocell=0;
	CLRF        _Events+6 
;FirmV_0_7_0.c,1231 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,1234 :: 		UART1_init(115200);
	MOVLW       21
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;FirmV_0_7_0.c,1237 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,1241 :: 		}
	RETURN      0
; end of _Init

_TaskManager:

;FirmV_0_7_0.c,1255 :: 		void TaskManager()
;FirmV_0_7_0.c,1257 :: 		char i=0;
	CLRF        TaskManager_i_L0+0 
;FirmV_0_7_0.c,1258 :: 		for(i=0;i<20;i++)
	CLRF        TaskManager_i_L0+0 
L_TaskManager276:
	MOVLW       20
	SUBWF       TaskManager_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TaskManager277
;FirmV_0_7_0.c,1259 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Time==ms500)&&(Tasks[i].Fired==0))
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
	GOTO        L_TaskManager281
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
	GOTO        L__TaskManager722
	MOVF        R3, 0 
	XORWF       _ms500+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager722
	MOVF        R2, 0 
	XORWF       _ms500+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager722
	MOVF        R1, 0 
	XORWF       _ms500+0, 0 
L__TaskManager722:
	BTFSS       STATUS+0, 2 
	GOTO        L_TaskManager281
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
	GOTO        L_TaskManager281
L__TaskManager667:
;FirmV_0_7_0.c,1260 :: 		Tasks[i].Fired=1;
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
L_TaskManager281:
;FirmV_0_7_0.c,1258 :: 		for(i=0;i<20;i++)
	INCF        TaskManager_i_L0+0, 1 
;FirmV_0_7_0.c,1260 :: 		Tasks[i].Fired=1;
	GOTO        L_TaskManager276
L_TaskManager277:
;FirmV_0_7_0.c,1261 :: 		}
	RETURN      0
; end of _TaskManager

_AddTask:

;FirmV_0_7_0.c,1273 :: 		void AddTask(unsigned long OccTime,char tcode)
;FirmV_0_7_0.c,1276 :: 		for(i=0;i<20;i++)
	CLRF        AddTask_i_L0+0 
L_AddTask282:
	MOVLW       20
	SUBWF       AddTask_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AddTask283
;FirmV_0_7_0.c,1277 :: 		if(Tasks[i].Expired==1)
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
	GOTO        L_AddTask285
;FirmV_0_7_0.c,1279 :: 		Tasks[i].TaskCode=tcode;
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
;FirmV_0_7_0.c,1280 :: 		Tasks[i].Time=OccTime;
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
;FirmV_0_7_0.c,1281 :: 		Tasks[i].Expired=0;
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
;FirmV_0_7_0.c,1282 :: 		Tasks[i].Fired=0;
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
;FirmV_0_7_0.c,1283 :: 		break;
	GOTO        L_AddTask283
;FirmV_0_7_0.c,1284 :: 		}
L_AddTask285:
;FirmV_0_7_0.c,1276 :: 		for(i=0;i<20;i++)
	INCF        AddTask_i_L0+0, 1 
;FirmV_0_7_0.c,1284 :: 		}
	GOTO        L_AddTask282
L_AddTask283:
;FirmV_0_7_0.c,1285 :: 		}
	RETURN      0
; end of _AddTask

_EventHandler:

;FirmV_0_7_0.c,1295 :: 		void EventHandler()
;FirmV_0_7_0.c,1298 :: 		Events.ExternalKeys=GetExternalKeysState();
	CALL        _GetExternalKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+8 
;FirmV_0_7_0.c,1299 :: 		Events.Limiter=GetLimitSwitchState();
	CALL        _GetLimitSwitchState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+7 
;FirmV_0_7_0.c,1300 :: 		Events.Keys=GetKeysState();
	CALL        _GetKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+0 
;FirmV_0_7_0.c,1301 :: 		Events.Remote=GetRemoteState();
	CALL        _GetRemoteState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+4 
;FirmV_0_7_0.c,1302 :: 		Events.Overload=GetOverloadState();
	CALL        _GetOverloadState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+5 
;FirmV_0_7_0.c,1303 :: 		Events.Photocell=GetPhotocellState();
	CALL        _GetPhotocellState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+6 
;FirmV_0_7_0.c,1305 :: 		for(i=0;i<20;i++)
	CLRF        EventHandler_i_L0+0 
L_EventHandler286:
	MOVLW       20
	SUBWF       EventHandler_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_EventHandler287
;FirmV_0_7_0.c,1306 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Fired==1))
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
	GOTO        L_EventHandler291
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
	GOTO        L_EventHandler291
L__EventHandler668:
;FirmV_0_7_0.c,1308 :: 		if(Events.Task1==0)
	MOVF        _Events+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler292
;FirmV_0_7_0.c,1309 :: 		{Events.Task1=Tasks[i].TaskCode; Tasks[i].Expired=1;Tasks[i].Fired=0;}
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
	GOTO        L_EventHandler293
L_EventHandler292:
;FirmV_0_7_0.c,1310 :: 		else if(Events.Task2==0)
	MOVF        _Events+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler294
;FirmV_0_7_0.c,1311 :: 		{Events.Task2=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
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
	GOTO        L_EventHandler295
L_EventHandler294:
;FirmV_0_7_0.c,1312 :: 		else if(Events.Task3==0)
	MOVF        _Events+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler296
;FirmV_0_7_0.c,1313 :: 		{Events.Task3=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
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
L_EventHandler296:
L_EventHandler295:
L_EventHandler293:
;FirmV_0_7_0.c,1314 :: 		}
L_EventHandler291:
;FirmV_0_7_0.c,1305 :: 		for(i=0;i<20;i++)
	INCF        EventHandler_i_L0+0, 1 
;FirmV_0_7_0.c,1314 :: 		}
	GOTO        L_EventHandler286
L_EventHandler287:
;FirmV_0_7_0.c,1315 :: 		}
	RETURN      0
; end of _EventHandler

_GetKeysState:

;FirmV_0_7_0.c,1325 :: 		char GetKeysState()
;FirmV_0_7_0.c,1327 :: 		unsigned res=0;
	CLRF        GetKeysState_res_L0+0 
	CLRF        GetKeysState_res_L0+1 
;FirmV_0_7_0.c,1331 :: 		char resch=0,fin;
	CLRF        GetKeysState_resch_L0+0 
;FirmV_0_7_0.c,1332 :: 		resch.b2=~KeyDown;
	BTFSC       PORTD+0, 5 
	GOTO        L__GetKeysState723
	BSF         GetKeysState_resch_L0+0, 2 
	GOTO        L__GetKeysState724
L__GetKeysState723:
	BCF         GetKeysState_resch_L0+0, 2 
L__GetKeysState724:
;FirmV_0_7_0.c,1333 :: 		resch.b1=~KeyUp;
	BTFSC       PORTD+0, 4 
	GOTO        L__GetKeysState725
	BSF         GetKeysState_resch_L0+0, 1 
	GOTO        L__GetKeysState726
L__GetKeysState725:
	BCF         GetKeysState_resch_L0+0, 1 
L__GetKeysState726:
;FirmV_0_7_0.c,1334 :: 		resch.b0=~KeyMenu;
	BTFSC       PORTE+0, 0 
	GOTO        L__GetKeysState727
	BSF         GetKeysState_resch_L0+0, 0 
	GOTO        L__GetKeysState728
L__GetKeysState727:
	BCF         GetKeysState_resch_L0+0, 0 
L__GetKeysState728:
;FirmV_0_7_0.c,1336 :: 		if((resch==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState297
;FirmV_0_7_0.c,1338 :: 		if(Pressed==0)
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState298
;FirmV_0_7_0.c,1339 :: 		{Repeat=0;Pressed=0;fin=0;RepeatRate=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState298:
;FirmV_0_7_0.c,1340 :: 		if(Pressed==1)
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState299
;FirmV_0_7_0.c,1341 :: 		if(DebouncingDelay>=DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelay+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetKeysState300
;FirmV_0_7_0.c,1342 :: 		{Repeat=0;Pressed=0;fin=0;RepeatRate=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState300:
L_GetKeysState299:
;FirmV_0_7_0.c,1343 :: 		}
L_GetKeysState297:
;FirmV_0_7_0.c,1344 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0)&&(ms500==PressTime+KeyRepeatDelay))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState303
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState303
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState303
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
	GOTO        L__GetKeysState729
	MOVF        _ms500+2, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState729
	MOVF        _ms500+1, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState729
	MOVF        _ms500+0, 0 
	XORWF       R1, 0 
L__GetKeysState729:
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState303
L__GetKeysState673:
;FirmV_0_7_0.c,1345 :: 		Repeat=1;
	MOVLW       1
	MOVWF       GetKeysState_Repeat_L0+0 
L_GetKeysState303:
;FirmV_0_7_0.c,1347 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState306
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState306
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState306
L__GetKeysState672:
;FirmV_0_7_0.c,1348 :: 		fin=0;
	CLRF        GetKeysState_fin_L0+0 
L_GetKeysState306:
;FirmV_0_7_0.c,1350 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==1))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState309
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState309
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState309
L__GetKeysState671:
;FirmV_0_7_0.c,1351 :: 		{fin=resch*RepeatRate;RepeatRate=0;}
	MOVF        GetKeysState_resch_L0+0, 0 
	MULWF       GetKeysState_RepeatRate_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState309:
;FirmV_0_7_0.c,1354 :: 		if((resch!=0)&&(Pressed==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState312
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState312
L__GetKeysState670:
;FirmV_0_7_0.c,1355 :: 		{fin=resch; Pressed=1;PressTime=ms500;DebouncingDelay=0;}
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
L_GetKeysState312:
;FirmV_0_7_0.c,1357 :: 		if((Repeat==1)&&(msCounter%10==0))
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState315
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
	GOTO        L_GetKeysState315
L__GetKeysState669:
;FirmV_0_7_0.c,1358 :: 		RepeatRate=1;
	MOVLW       1
	MOVWF       GetKeysState_RepeatRate_L0+0 
L_GetKeysState315:
;FirmV_0_7_0.c,1360 :: 		return fin;
	MOVF        GetKeysState_fin_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1361 :: 		}
	RETURN      0
; end of _GetKeysState

_GetExternalKeysState:

;FirmV_0_7_0.c,1371 :: 		char GetExternalKeysState()
;FirmV_0_7_0.c,1373 :: 		char out=0;
	CLRF        GetExternalKeysState_out_L0+0 
;FirmV_0_7_0.c,1374 :: 		if(KeyUp==0)
	BTFSC       PORTD+0, 4 
	GOTO        L_GetExternalKeysState316
;FirmV_0_7_0.c,1375 :: 		out.b0=1;
	BSF         GetExternalKeysState_out_L0+0, 0 
L_GetExternalKeysState316:
;FirmV_0_7_0.c,1376 :: 		if(KeyDown==0)
	BTFSC       PORTD+0, 5 
	GOTO        L_GetExternalKeysState317
;FirmV_0_7_0.c,1377 :: 		out.b1=1;
	BSF         GetExternalKeysState_out_L0+0, 1 
L_GetExternalKeysState317:
;FirmV_0_7_0.c,1378 :: 		return out;
	MOVF        GetExternalKeysState_out_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1379 :: 		}
	RETURN      0
; end of _GetExternalKeysState

_GetLimitSwitchState:

;FirmV_0_7_0.c,1392 :: 		char GetLimitSwitchState()
;FirmV_0_7_0.c,1394 :: 		if((Limit1==0)||(Limit2==0))
	BTFSS       PORTD+0, 0 
	GOTO        L__GetLimitSwitchState674
	BTFSS       PORTD+0, 1 
	GOTO        L__GetLimitSwitchState674
	GOTO        L_GetLimitSwitchState320
L__GetLimitSwitchState674:
;FirmV_0_7_0.c,1395 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_GetLimitSwitchState320:
;FirmV_0_7_0.c,1397 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1398 :: 		}
	RETURN      0
; end of _GetLimitSwitchState

_GetRemoteState:

;FirmV_0_7_0.c,1407 :: 		char GetRemoteState()
;FirmV_0_7_0.c,1409 :: 		char res=0;
	CLRF        GetRemoteState_res_L0+0 
;FirmV_0_7_0.c,1410 :: 		res.b0=RemoteAFlag.b0;
	BTFSC       _RemoteAFlag+0, 0 
	GOTO        L__GetRemoteState730
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState731
L__GetRemoteState730:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState731:
;FirmV_0_7_0.c,1411 :: 		res.b1=RemoteBFlag.b0;
	BTFSC       _RemoteBFlag+0, 0 
	GOTO        L__GetRemoteState732
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState733
L__GetRemoteState732:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState733:
;FirmV_0_7_0.c,1412 :: 		RemoteAFlag=0;
	CLRF        _RemoteAFlag+0 
;FirmV_0_7_0.c,1413 :: 		RemoteBFlag=0;
	CLRF        _RemoteBFlag+0 
;FirmV_0_7_0.c,1414 :: 		res.b0=res.b0|(~KeyUp);
	BTFSC       PORTD+0, 4 
	GOTO        L__GetRemoteState734
	BSF         4056, 0 
	GOTO        L__GetRemoteState735
L__GetRemoteState734:
	BCF         4056, 0 
L__GetRemoteState735:
	BTFSC       GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState736
	BTFSC       4056, 0 
	GOTO        L__GetRemoteState736
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState737
L__GetRemoteState736:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState737:
;FirmV_0_7_0.c,1415 :: 		res.b1=res.b1|(~KeyDown);
	BTFSC       PORTD+0, 5 
	GOTO        L__GetRemoteState738
	BSF         4056, 0 
	GOTO        L__GetRemoteState739
L__GetRemoteState738:
	BCF         4056, 0 
L__GetRemoteState739:
	BTFSC       GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState740
	BTFSC       4056, 0 
	GOTO        L__GetRemoteState740
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState741
L__GetRemoteState740:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState741:
;FirmV_0_7_0.c,1416 :: 		return res;
	MOVF        GetRemoteState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1417 :: 		}
	RETURN      0
; end of _GetRemoteState

_GetOverloadState:

;FirmV_0_7_0.c,1427 :: 		char GetOverloadState()
;FirmV_0_7_0.c,1429 :: 		char res=0;
	CLRF        GetOverloadState_res_L0+0 
;FirmV_0_7_0.c,1431 :: 		VCapM1=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       GetOverloadState_VCapM1_L0+0 
	MOVF        R1, 0 
	MOVWF       GetOverloadState_VCapM1_L0+1 
;FirmV_0_7_0.c,1432 :: 		VCapM2=ADC_Read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       GetOverloadState_VCapM2_L0+0 
	MOVF        R1, 0 
	MOVWF       GetOverloadState_VCapM2_L0+1 
;FirmV_0_7_0.c,1433 :: 		if(Motor1FullSpeed!=0)
	MOVF        _Motor1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState322
;FirmV_0_7_0.c,1435 :: 		if(VCapM1<OverloadTreshold)
	MOVF        _OverloadTreshold+1, 0 
	SUBWF       GetOverloadState_VCapM1_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState742
	MOVF        _OverloadTreshold+0, 0 
	SUBWF       GetOverloadState_VCapM1_L0+0, 0 
L__GetOverloadState742:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState323
;FirmV_0_7_0.c,1437 :: 		if(OverloadCounter1<255)
	MOVLW       255
	SUBWF       _OverloadCounter1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState324
;FirmV_0_7_0.c,1438 :: 		OverloadCounter1=OverloadCounter1+1;
	INCF        _OverloadCounter1+0, 1 
L_GetOverloadState324:
;FirmV_0_7_0.c,1439 :: 		}
	GOTO        L_GetOverloadState325
L_GetOverloadState323:
;FirmV_0_7_0.c,1442 :: 		if(OverloadCounter1>0)
	MOVF        _OverloadCounter1+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState326
;FirmV_0_7_0.c,1443 :: 		OverloadCounter1=OverloadCounter1-1;
	DECF        _OverloadCounter1+0, 1 
L_GetOverloadState326:
;FirmV_0_7_0.c,1444 :: 		}
L_GetOverloadState325:
;FirmV_0_7_0.c,1445 :: 		}
	GOTO        L_GetOverloadState327
L_GetOverloadState322:
;FirmV_0_7_0.c,1447 :: 		{OverloadCounter1=0;}
	CLRF        _OverloadCounter1+0 
L_GetOverloadState327:
;FirmV_0_7_0.c,1449 :: 		if (OverloadCounter1>OverloadDuration)
	MOVF        _OverloadCounter1+0, 0 
	SUBWF       _OverloadDuration+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState328
;FirmV_0_7_0.c,1450 :: 		res.b0=1;
	BSF         GetOverloadState_res_L0+0, 0 
L_GetOverloadState328:
;FirmV_0_7_0.c,1455 :: 		if(Motor2FullSpeed!=0)
	MOVF        _Motor2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState329
;FirmV_0_7_0.c,1457 :: 		if(VCapM2<OverloadTreshold)
	MOVF        _OverloadTreshold+1, 0 
	SUBWF       GetOverloadState_VCapM2_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState743
	MOVF        _OverloadTreshold+0, 0 
	SUBWF       GetOverloadState_VCapM2_L0+0, 0 
L__GetOverloadState743:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState330
;FirmV_0_7_0.c,1459 :: 		if(OverloadCounter2<255)
	MOVLW       255
	SUBWF       _OverloadCounter2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState331
;FirmV_0_7_0.c,1460 :: 		OverloadCounter2=OverloadCounter2+1;
	INCF        _OverloadCounter2+0, 1 
L_GetOverloadState331:
;FirmV_0_7_0.c,1461 :: 		}
	GOTO        L_GetOverloadState332
L_GetOverloadState330:
;FirmV_0_7_0.c,1464 :: 		if(OverloadCounter2>0)
	MOVF        _OverloadCounter2+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState333
;FirmV_0_7_0.c,1465 :: 		OverloadCounter2=OverloadCounter2-1;
	DECF        _OverloadCounter2+0, 1 
L_GetOverloadState333:
;FirmV_0_7_0.c,1466 :: 		}
L_GetOverloadState332:
;FirmV_0_7_0.c,1467 :: 		}
	GOTO        L_GetOverloadState334
L_GetOverloadState329:
;FirmV_0_7_0.c,1469 :: 		{OverloadCounter2=0;}
	CLRF        _OverloadCounter2+0 
L_GetOverloadState334:
;FirmV_0_7_0.c,1472 :: 		if (OverloadCounter2>OverloadDuration)
	MOVF        _OverloadCounter2+0, 0 
	SUBWF       _OverloadDuration+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState335
;FirmV_0_7_0.c,1473 :: 		res.b1=1;
	BSF         GetOverloadState_res_L0+0, 1 
L_GetOverloadState335:
;FirmV_0_7_0.c,1475 :: 		return res;
	MOVF        GetOverloadState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1476 :: 		}
	RETURN      0
; end of _GetOverloadState

_GetPhotocellState:

;FirmV_0_7_0.c,1489 :: 		char GetPhotocellState()
;FirmV_0_7_0.c,1491 :: 		if(Phcell1==0)
	BTFSC       PORTD+0, 3 
	GOTO        L_GetPhotocellState336
;FirmV_0_7_0.c,1492 :: 		{if(PhotocellCount<=20)PhotocellCount=PhotocellCount+1;}
	MOVF        _PhotocellCount+0, 0 
	SUBLW       20
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState337
	INCF        _PhotocellCount+0, 1 
L_GetPhotocellState337:
	GOTO        L_GetPhotocellState338
L_GetPhotocellState336:
;FirmV_0_7_0.c,1494 :: 		{PhotocellCount=0;}
	CLRF        _PhotocellCount+0 
L_GetPhotocellState338:
;FirmV_0_7_0.c,1495 :: 		if(PhotocellCount>=20)
	MOVLW       20
	SUBWF       _PhotocellCount+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState339
;FirmV_0_7_0.c,1496 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_GetPhotocellState339:
;FirmV_0_7_0.c,1498 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1499 :: 		}
	RETURN      0
; end of _GetPhotocellState

_SetMotorSpeed:

;FirmV_0_7_0.c,1511 :: 		void SetMotorSpeed(char M1FullSpeed,char M2FullSpeed)
;FirmV_0_7_0.c,1513 :: 		if((M1FullSpeed==0)||(M2FullSpeed==0))
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed675
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed675
	GOTO        L_SetMotorSpeed343
L__SetMotorSpeed675:
;FirmV_0_7_0.c,1514 :: 		INT0E_bit=1;
	BSF         INT0E_bit+0, 4 
	GOTO        L_SetMotorSpeed344
L_SetMotorSpeed343:
;FirmV_0_7_0.c,1516 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, 4 
L_SetMotorSpeed344:
;FirmV_0_7_0.c,1518 :: 		Motor1FullSpeed=M1FullSpeed;
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	MOVWF       _Motor1FullSpeed+0 
;FirmV_0_7_0.c,1519 :: 		Motor2FullSpeed=M2FullSpeed;
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	MOVWF       _Motor2FullSpeed+0 
;FirmV_0_7_0.c,1520 :: 		}
	RETURN      0
; end of _SetMotorSpeed

_OverloadInit:

;FirmV_0_7_0.c,1531 :: 		void OverloadInit(char ch)
;FirmV_0_7_0.c,1533 :: 		if(ch==1)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit345
;FirmV_0_7_0.c,1535 :: 		OverloadCounter1=0;
	CLRF        _OverloadCounter1+0 
;FirmV_0_7_0.c,1536 :: 		Events.Overload.b0=0;
	BCF         _Events+5, 0 
;FirmV_0_7_0.c,1537 :: 		}
L_OverloadInit345:
;FirmV_0_7_0.c,1539 :: 		if(ch==2)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit346
;FirmV_0_7_0.c,1541 :: 		OverloadCounter2=0;
	CLRF        _OverloadCounter2+0 
;FirmV_0_7_0.c,1542 :: 		Events.Overload.b1=0;
	BCF         _Events+5, 1 
;FirmV_0_7_0.c,1543 :: 		}
L_OverloadInit346:
;FirmV_0_7_0.c,1544 :: 		}
	RETURN      0
; end of _OverloadInit

_SaveConfigs:

;FirmV_0_7_0.c,1555 :: 		void SaveConfigs()
;FirmV_0_7_0.c,1558 :: 		EEPROM_Write(1,Door1OpenTime);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1559 :: 		EEPROM_Write(2,Door2OpenTime);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1560 :: 		EEPROM_Write(3,Door1CloseTime);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1561 :: 		EEPROM_Write(4,Door2CloseTime);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1562 :: 		EEPROM_Write(5,ActionTimeDiff);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1563 :: 		EEPROM_Write(6,OpenSoftStartTime);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1564 :: 		EEPROM_Write(7,OpenSoftStopTime);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1565 :: 		EEPROM_Write(8,CloseSoftStartTime);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1566 :: 		EEPROM_Write(9,CloseSoftStopTime);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1567 :: 		EEPROM_Write(10,Hi(AutoCloseTime));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _AutoCloseTime+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1568 :: 		EEPROM_Write(11,Lo(AutoCloseTime));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1569 :: 		EEPROM_Write(12,OverloadSens);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OverloadSens+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1570 :: 		SetOverloadParams(9-OverloadSens);
	MOVF        _OverloadSens+0, 0 
	SUBLW       9
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1571 :: 		EEPROM_Write(13,CloseAfterPass);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1572 :: 		EEPROM_Write(14,LockForce);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _LockForce+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1573 :: 		EEPROM_Write(15,OpenPhEnable);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OpenPhEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1574 :: 		EEPROM_Write(16,LimiterEnable);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _LimiterEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1576 :: 		}
	RETURN      0
; end of _SaveConfigs

_LoadConfigs:

;FirmV_0_7_0.c,1589 :: 		void LoadConfigs()
;FirmV_0_7_0.c,1591 :: 		Door1OpenTime=EEPROM_Read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1592 :: 		Door2OpenTime=EEPROM_Read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1593 :: 		Door1CloseTime=EEPROM_Read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1594 :: 		Door2CloseTime=EEPROM_Read(4);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1595 :: 		ActionTimeDiff=EEPROM_Read(5);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1596 :: 		OpenSoftStartTime=EEPROM_Read(6);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1597 :: 		OpenSoftStopTime=EEPROM_Read(7);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1598 :: 		CloseSoftStartTime=EEPROM_Read(8);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1599 :: 		CloseSoftStopTime=EEPROM_Read(9);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1600 :: 		AutoCloseTime=EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _AutoCloseTime+0 
	MOVLW       0
	MOVWF       _AutoCloseTime+1 
;FirmV_0_7_0.c,1601 :: 		AutoCloseTime=AutoCloseTime<<8;
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       _AutoCloseTime+1 
	CLRF        _AutoCloseTime+0 
;FirmV_0_7_0.c,1602 :: 		AutoCloseTime=AutocloseTime|EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	IORWF       _AutoCloseTime+0, 1 
	MOVLW       0
	IORWF       _AutoCloseTime+1, 1 
;FirmV_0_7_0.c,1603 :: 		OverloadSens=EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadSens+0 
;FirmV_0_7_0.c,1604 :: 		SetOverloadParams(9-OverloadSens);
	MOVF        R0, 0 
	SUBLW       9
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1605 :: 		CloseAfterPass=EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseAfterPass+0 
;FirmV_0_7_0.c,1606 :: 		LockForce=EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LockForce+0 
;FirmV_0_7_0.c,1607 :: 		OpenPhEnable=EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenPhEnable+0 
;FirmV_0_7_0.c,1608 :: 		LimiterEnable=EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LimiterEnable+0 
;FirmV_0_7_0.c,1610 :: 		}
	RETURN      0
; end of _LoadConfigs

_FactorySettings:

;FirmV_0_7_0.c,1623 :: 		void FactorySettings()
;FirmV_0_7_0.c,1625 :: 		Door1OpenTime=20;
	MOVLW       20
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1626 :: 		Door1CloseTime=20;
	MOVLW       20
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1627 :: 		Door2OpenTime=20;
	MOVLW       20
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1628 :: 		Door2CloseTime=20;
	MOVLW       20
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1629 :: 		OverloadSens=5;
	MOVLW       5
	MOVWF       _OverloadSens+0 
;FirmV_0_7_0.c,1630 :: 		SetOverloadParams(4);  //9-5
	MOVLW       4
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1631 :: 		OpenSoftStopTime=10;
	MOVLW       10
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1632 :: 		OpenSoftStartTime=4;
	MOVLW       4
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1633 :: 		CloseSoftStopTime=10;
	MOVLW       10
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1634 :: 		CloseSoftStartTime=4;
	MOVLW       4
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1635 :: 		ActionTimeDiff=12;
	MOVLW       12
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1636 :: 		AutoCloseTime=0;
	CLRF        _AutoCloseTime+0 
	CLRF        _AutoCloseTime+1 
;FirmV_0_7_0.c,1637 :: 		LockForce=0;
	CLRF        _LockForce+0 
;FirmV_0_7_0.c,1638 :: 		OpenPhEnable=0;
	CLRF        _OpenPhEnable+0 
;FirmV_0_7_0.c,1639 :: 		LimiterEnable=0;
	CLRF        _LimiterEnable+0 
;FirmV_0_7_0.c,1640 :: 		CloseAfterPass=0;
	CLRF        _CloseAfterPass+0 
;FirmV_0_7_0.c,1642 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,1643 :: 		}
	RETURN      0
; end of _FactorySettings

_StartMotor:

;FirmV_0_7_0.c,1649 :: 		void StartMotor(char Mx,char Dir)
;FirmV_0_7_0.c,1651 :: 		if(Mx==1)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor347
;FirmV_0_7_0.c,1653 :: 		Motor1Start=1;
	MOVLW       1
	MOVWF       _Motor1Start+0 
;FirmV_0_7_0.c,1654 :: 		Motor1Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor744
	BCF         PORTC+0, 0 
	GOTO        L__StartMotor745
L__StartMotor744:
	BSF         PORTC+0, 0 
L__StartMotor745:
;FirmV_0_7_0.c,1655 :: 		Motor1=1;
	BSF         PORTB+0, 4 
;FirmV_0_7_0.c,1656 :: 		}
L_StartMotor347:
;FirmV_0_7_0.c,1658 :: 		if(Mx==2)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor348
;FirmV_0_7_0.c,1660 :: 		Motor2Start=1;
	MOVLW       1
	MOVWF       _Motor2Start+0 
;FirmV_0_7_0.c,1661 :: 		Motor2Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor746
	BCF         PORTC+0, 1 
	GOTO        L__StartMotor747
L__StartMotor746:
	BSF         PORTC+0, 1 
L__StartMotor747:
;FirmV_0_7_0.c,1662 :: 		Motor2=1;
	BSF         PORTB+0, 3 
;FirmV_0_7_0.c,1663 :: 		}
L_StartMotor348:
;FirmV_0_7_0.c,1664 :: 		}
	RETURN      0
; end of _StartMotor

_StopMotor:

;FirmV_0_7_0.c,1667 :: 		void StopMotor(char Mx)
;FirmV_0_7_0.c,1669 :: 		if(Mx==1)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor349
;FirmV_0_7_0.c,1671 :: 		Motor1Start=0;
	CLRF        _Motor1Start+0 
;FirmV_0_7_0.c,1672 :: 		Motor1=0;
	BCF         PORTB+0, 4 
;FirmV_0_7_0.c,1673 :: 		}
L_StopMotor349:
;FirmV_0_7_0.c,1675 :: 		if(Mx==2)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor350
;FirmV_0_7_0.c,1677 :: 		Motor2Start=0;
	CLRF        _Motor2Start+0 
;FirmV_0_7_0.c,1678 :: 		Motor2=0;
	BCF         PORTB+0, 3 
;FirmV_0_7_0.c,1679 :: 		}
L_StopMotor350:
;FirmV_0_7_0.c,1680 :: 		}
	RETURN      0
; end of _StopMotor

_CheckTask:

;FirmV_0_7_0.c,1692 :: 		char CheckTask(char TaskCode)
;FirmV_0_7_0.c,1694 :: 		if(Events.Task1==TaskCode)
	MOVF        _Events+1, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask351
;FirmV_0_7_0.c,1695 :: 		{Events.Task1=0; return 1;}
	CLRF        _Events+1 
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_CheckTask351:
;FirmV_0_7_0.c,1697 :: 		if(Events.Task2==TaskCode)
	MOVF        _Events+2, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask352
;FirmV_0_7_0.c,1698 :: 		{Events.Task2=0; return 1;}
	CLRF        _Events+2 
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_CheckTask352:
;FirmV_0_7_0.c,1700 :: 		if(Events.Task3==TaskCode)
	MOVF        _Events+3, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask353
;FirmV_0_7_0.c,1701 :: 		{Events.Task3=0; return 1;}
	CLRF        _Events+3 
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_CheckTask353:
;FirmV_0_7_0.c,1703 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1705 :: 		}
	RETURN      0
; end of _CheckTask

_GetAutocloseTime:

;FirmV_0_7_0.c,1713 :: 		char GetAutocloseTime()
;FirmV_0_7_0.c,1717 :: 		for(i=0;i<20;i++)
	CLRF        GetAutocloseTime_i_L0+0 
L_GetAutocloseTime354:
	MOVLW       20
	SUBWF       GetAutocloseTime_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetAutocloseTime355
;FirmV_0_7_0.c,1719 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode==9))
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
	GOTO        L_GetAutocloseTime359
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
	GOTO        L_GetAutocloseTime359
L__GetAutocloseTime676:
;FirmV_0_7_0.c,1720 :: 		t=Tasks[i].Time;
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
L_GetAutocloseTime359:
;FirmV_0_7_0.c,1721 :: 		Tasks[i].Expired=1;
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
;FirmV_0_7_0.c,1717 :: 		for(i=0;i<20;i++)
	INCF        GetAutocloseTime_i_L0+0, 1 
;FirmV_0_7_0.c,1722 :: 		}
	GOTO        L_GetAutocloseTime354
L_GetAutocloseTime355:
;FirmV_0_7_0.c,1723 :: 		i=t-ms500;
	MOVF        _ms500+0, 0 
	SUBWF       GetAutocloseTime_t_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       GetAutocloseTime_i_L0+0 
;FirmV_0_7_0.c,1724 :: 		return i;
;FirmV_0_7_0.c,1725 :: 		}
	RETURN      0
; end of _GetAutocloseTime

_ClearTasks:

;FirmV_0_7_0.c,1742 :: 		void ClearTasks(char except)
;FirmV_0_7_0.c,1745 :: 		for(i=0;i<20;i++)
	CLRF        ClearTasks_i_L0+0 
L_ClearTasks360:
	MOVLW       20
	SUBWF       ClearTasks_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ClearTasks361
;FirmV_0_7_0.c,1746 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode!=except))
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
	GOTO        L_ClearTasks365
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
	GOTO        L_ClearTasks365
L__ClearTasks677:
;FirmV_0_7_0.c,1747 :: 		Tasks[i].Expired=1;
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
L_ClearTasks365:
;FirmV_0_7_0.c,1745 :: 		for(i=0;i<20;i++)
	INCF        ClearTasks_i_L0+0, 1 
;FirmV_0_7_0.c,1747 :: 		Tasks[i].Expired=1;
	GOTO        L_ClearTasks360
L_ClearTasks361:
;FirmV_0_7_0.c,1748 :: 		}
	RETURN      0
; end of _ClearTasks

_Menu0:

;FirmV_0_7_0.c,1763 :: 		void Menu0()
;FirmV_0_7_0.c,1765 :: 		memcpy(LCDLine2,"                ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
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
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr69_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr69_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,1767 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0366
;FirmV_0_7_0.c,1768 :: 		{memcpy(LCDLine1,"00 Learning Mode",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1769 :: 		if(LearningMode==0)memcpy(LCDLine2,"      Auto      ",16);
	MOVF        _LearningMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0367
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
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
L_Menu0367:
;FirmV_0_7_0.c,1770 :: 		if(LearningMode==1)memcpy(LCDLine2,"     Manual     ",16);}
	MOVF        _LearningMode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0368
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
L_Menu0368:
L_Menu0366:
;FirmV_0_7_0.c,1772 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0369
;FirmV_0_7_0.c,1773 :: 		{memcpy(LCDLine1,"01 D1 Open Time ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1774 :: 		charValueToStr(Door1OpenTime,LCDLine2+6);}
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0369:
;FirmV_0_7_0.c,1776 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0370
;FirmV_0_7_0.c,1777 :: 		{memcpy(LCDLine1,"02 D2 Open Time ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1778 :: 		charValueToStr(Door2OpenTime,LCDLine2+6);}
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0370:
;FirmV_0_7_0.c,1780 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0371
;FirmV_0_7_0.c,1781 :: 		{memcpy(LCDLine1,"03 D1 Close Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1782 :: 		charValueToStr(Door1CloseTime,LCDLine2+6);}
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0371:
;FirmV_0_7_0.c,1784 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0372
;FirmV_0_7_0.c,1785 :: 		{memcpy(LCDLine1,"04 D2 Close Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1786 :: 		charValueToStr(Door2CloseTime,LCDLine2+6);}
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0372:
;FirmV_0_7_0.c,1788 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0373
;FirmV_0_7_0.c,1789 :: 		{memcpy(LCDLine1,"05 Op Soft Start",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1790 :: 		charValueToStr(OpenSoftStartTime,LCDLine2+6);}
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0373:
;FirmV_0_7_0.c,1792 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0374
;FirmV_0_7_0.c,1793 :: 		{memcpy(LCDLine1,"06 Op Soft Stop ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1794 :: 		charValueToStr(OpenSoftStopTime,LCDLine2+6);}
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0374:
;FirmV_0_7_0.c,1796 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0375
;FirmV_0_7_0.c,1797 :: 		{memcpy(LCDLine1,"07 Cl Soft Start",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1798 :: 		charValueToStr(CloseSoftStartTime,LCDLine2+6);}
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0375:
;FirmV_0_7_0.c,1800 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0376
;FirmV_0_7_0.c,1801 :: 		{memcpy(LCDLine1,"08 Cl Soft Stop ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1802 :: 		charValueToStr(CloseSoftStopTime,LCDLine2+6);}
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0376:
;FirmV_0_7_0.c,1804 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0377
;FirmV_0_7_0.c,1805 :: 		{memcpy(LCDLine1,"09 Power        ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1806 :: 		bytetostr(OverloadSens,LCDLine2+6);LCDLine2[9]=' ';}
	MOVF        _OverloadSens+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
	MOVLW       32
	MOVWF       _LCDLine2+9 
L_Menu0377:
;FirmV_0_7_0.c,1808 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0378
;FirmV_0_7_0.c,1809 :: 		{memcpy(LCDLine1,"10 Interval Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1810 :: 		charValueToStr(ActionTimeDiff,LCDLine2+6);}
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0378:
;FirmV_0_7_0.c,1812 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0379
;FirmV_0_7_0.c,1813 :: 		{memcpy(LCDLine1,"11 Auto-close T ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1814 :: 		intValueToStr(AutoCloseTime,LCDLine2+4);}
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       FARG_intValueToStr+0 
	MOVF        _AutoCloseTime+1, 0 
	MOVWF       FARG_intValueToStr+1 
	MOVLW       _LCDLine2+4
	MOVWF       FARG_intValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+4)
	MOVWF       FARG_intValueToStr+1 
	CALL        _intValueToStr+0, 0
L_Menu0379:
;FirmV_0_7_0.c,1816 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0380
;FirmV_0_7_0.c,1817 :: 		{memcpy(LCDLine1,"12 Factory Reset",16);LCDUpdateFlag=1;}
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
L_Menu0380:
;FirmV_0_7_0.c,1819 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0381
;FirmV_0_7_0.c,1820 :: 		{memcpy(LCDLine1,"13 Open Photo En",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1821 :: 		if(OpenPhEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _OpenPhEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0382
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       78
	MOVWF       ?lstr86_FirmV_0_7_0+0 
	MOVLW       111
	MOVWF       ?lstr86_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr86_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr86_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr86_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr86_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr86_FirmV_0_7_0+6 
	CLRF        ?lstr86_FirmV_0_7_0+7 
	MOVLW       ?lstr86_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr86_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0383
L_Menu0382:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       89
	MOVWF       ?lstr87_FirmV_0_7_0+0 
	MOVLW       101
	MOVWF       ?lstr87_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr87_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr87_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr87_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr87_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr87_FirmV_0_7_0+6 
	MOVLW       32
	MOVWF       ?lstr87_FirmV_0_7_0+7 
	CLRF        ?lstr87_FirmV_0_7_0+8 
	MOVLW       ?lstr87_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr87_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0383:
L_Menu0381:
;FirmV_0_7_0.c,1823 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0384
;FirmV_0_7_0.c,1824 :: 		{memcpy(LCDLine1,"14 Limit Enable ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr88_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr88_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr88_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr88_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr88_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr88_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr88_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1825 :: 		if(LimiterEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LimiterEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0385
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       78
	MOVWF       ?lstr89_FirmV_0_7_0+0 
	MOVLW       111
	MOVWF       ?lstr89_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr89_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr89_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr89_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr89_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr89_FirmV_0_7_0+6 
	CLRF        ?lstr89_FirmV_0_7_0+7 
	MOVLW       ?lstr89_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr89_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       7
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_Menu0386
L_Menu0385:
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       89
	MOVWF       ?lstr90_FirmV_0_7_0+0 
	MOVLW       101
	MOVWF       ?lstr90_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr90_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr90_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr90_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr90_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr90_FirmV_0_7_0+6 
	MOVLW       32
	MOVWF       ?lstr90_FirmV_0_7_0+7 
	CLRF        ?lstr90_FirmV_0_7_0+8 
	MOVLW       ?lstr90_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr90_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0386:
L_Menu0384:
;FirmV_0_7_0.c,1827 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0387
;FirmV_0_7_0.c,1828 :: 		{memcpy(LCDLine1,"15 Lock Force   ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr91_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr91_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr91_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr91_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr91_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr91_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr91_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1829 :: 		if(LockForce==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0388
	MOVLW       _LCDLine2+6
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       78
	MOVWF       ?lstr92_FirmV_0_7_0+0 
	MOVLW       111
	MOVWF       ?lstr92_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr92_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr92_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr92_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr92_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr92_FirmV_0_7_0+6 
	CLRF        ?lstr92_FirmV_0_7_0+7 
	MOVLW       ?lstr92_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr92_FirmV_0_7_0+0)
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
	MOVWF       ?lstr93_FirmV_0_7_0+0 
	MOVLW       101
	MOVWF       ?lstr93_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr93_FirmV_0_7_0+2 
	MOVLW       32
	MOVWF       ?lstr93_FirmV_0_7_0+3 
	MOVLW       32
	MOVWF       ?lstr93_FirmV_0_7_0+4 
	MOVLW       32
	MOVWF       ?lstr93_FirmV_0_7_0+5 
	MOVLW       32
	MOVWF       ?lstr93_FirmV_0_7_0+6 
	MOVLW       32
	MOVWF       ?lstr93_FirmV_0_7_0+7 
	CLRF        ?lstr93_FirmV_0_7_0+8 
	MOVLW       ?lstr93_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr93_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       8
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_Menu0389:
L_Menu0387:
;FirmV_0_7_0.c,1831 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0390
;FirmV_0_7_0.c,1832 :: 		{memcpy(LCDLine1,"16 Au-Cl Pass   ",16);LCDUpdateFlag=1;
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr94_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr94_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr94_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr94_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr94_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr94_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr94_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1833 :: 		charValueToStr(CloseAfterPass,LCDLine2+6);}
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0390:
;FirmV_0_7_0.c,1835 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0391
;FirmV_0_7_0.c,1836 :: 		{memcpy(LCDLine1,"17 Save Changes ",16);LCDUpdateFlag=1;}
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
L_Menu0391:
;FirmV_0_7_0.c,1838 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0392
;FirmV_0_7_0.c,1839 :: 		{memcpy(LCDLine1,"18 Discard Exit ",16);LCDUpdateFlag=1;}
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
L_Menu0392:
;FirmV_0_7_0.c,1842 :: 		State=101;
	MOVLW       101
	MOVWF       _State+0 
;FirmV_0_7_0.c,1843 :: 		}
	RETURN      0
; end of _Menu0

_Menu1:

;FirmV_0_7_0.c,1860 :: 		void Menu1()
;FirmV_0_7_0.c,1863 :: 		if((Events.Keys.b0==1))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu1393
;FirmV_0_7_0.c,1864 :: 		{if(MenuPointer==0){MenuPointer=18;}else{MenuPointer=MenuPointer-1;}State=100;}
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1394
	MOVLW       18
	MOVWF       _MenuPointer+0 
	GOTO        L_Menu1395
L_Menu1394:
	DECF        _MenuPointer+0, 1 
L_Menu1395:
	MOVLW       100
	MOVWF       _State+0 
L_Menu1393:
;FirmV_0_7_0.c,1866 :: 		if((Events.Keys.b2==1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu1396
;FirmV_0_7_0.c,1867 :: 		{if(MenuPointer==18){MenuPointer=0;}else{MenuPointer=MenuPointer+1;}State=100;}
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1397
	CLRF        _MenuPointer+0 
	GOTO        L_Menu1398
L_Menu1397:
	INCF        _MenuPointer+0, 1 
L_Menu1398:
	MOVLW       100
	MOVWF       _State+0 
L_Menu1396:
;FirmV_0_7_0.c,1869 :: 		if((Events.Keys.b1==1))
	BTFSS       _Events+0, 1 
	GOTO        L_Menu1399
;FirmV_0_7_0.c,1870 :: 		{State=102;}
	MOVLW       102
	MOVWF       _State+0 
L_Menu1399:
;FirmV_0_7_0.c,1873 :: 		}
	RETURN      0
; end of _Menu1

_Menu2:

;FirmV_0_7_0.c,1881 :: 		void Menu2()
;FirmV_0_7_0.c,1884 :: 		LCDFlash=1;
	MOVLW       1
	MOVWF       _LCDFlash+0 
;FirmV_0_7_0.c,1886 :: 		if(Events.Keys.b1==1)
	BTFSS       _Events+0, 1 
	GOTO        L_Menu2400
;FirmV_0_7_0.c,1888 :: 		LCDFlash=0;LCDFlashFlag=0;State=101;
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
	MOVLW       101
	MOVWF       _State+0 
;FirmV_0_7_0.c,1889 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2401
;FirmV_0_7_0.c,1891 :: 		LearnPhase=0;
	CLRF        _LearnPhase+0 
;FirmV_0_7_0.c,1892 :: 		if(LearningMode==0)
	MOVF        _LearningMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2402
;FirmV_0_7_0.c,1893 :: 		State=200;
	MOVLW       200
	MOVWF       _State+0 
L_Menu2402:
;FirmV_0_7_0.c,1894 :: 		if(LearningMode==1)
	MOVF        _LearningMode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2403
;FirmV_0_7_0.c,1895 :: 		State=201;
	MOVLW       201
	MOVWF       _State+0 
L_Menu2403:
;FirmV_0_7_0.c,1896 :: 		}
L_Menu2401:
;FirmV_0_7_0.c,1897 :: 		}
L_Menu2400:
;FirmV_0_7_0.c,1900 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2404
;FirmV_0_7_0.c,1901 :: 		{ if((Events.Keys.b0==1)&&(LearningMode>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2407
	MOVF        _LearningMode+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2407
L__Menu2709:
;FirmV_0_7_0.c,1902 :: 		{LearningMode=LearningMode-1;Menu0();State=102;}
	DECF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2407:
;FirmV_0_7_0.c,1903 :: 		if((Events.Keys.b2==1)&&(LearningMode<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2410
	MOVLW       1
	SUBWF       _LearningMode+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2410
L__Menu2708:
;FirmV_0_7_0.c,1904 :: 		{LearningMode=LearningMode+1;Menu0();State=102;}
	INCF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2410:
;FirmV_0_7_0.c,1905 :: 		}
L_Menu2404:
;FirmV_0_7_0.c,1909 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2411
;FirmV_0_7_0.c,1910 :: 		{ if((Events.Keys.b0==1)&&(Door1OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2414
	MOVF        _Door1OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2414
L__Menu2707:
;FirmV_0_7_0.c,1911 :: 		{Door1OpenTime=Door1OpenTime-1;Menu0();State=102;}
	DECF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2414:
;FirmV_0_7_0.c,1912 :: 		if((Events.Keys.b2==1)&&(Door1OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2417
	MOVLW       255
	SUBWF       _Door1OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2417
L__Menu2706:
;FirmV_0_7_0.c,1913 :: 		{Door1OpenTime=Door1OpenTime+1;Menu0();State=102;}
	INCF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2417:
;FirmV_0_7_0.c,1914 :: 		}
L_Menu2411:
;FirmV_0_7_0.c,1918 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2418
;FirmV_0_7_0.c,1919 :: 		{ if((Events.Keys.b0==1)&&(Door2OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2421
	MOVF        _Door2OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2421
L__Menu2705:
;FirmV_0_7_0.c,1920 :: 		{Door2OpenTime=Door2OpenTime-1;Menu0();State=102;}
	DECF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2421:
;FirmV_0_7_0.c,1921 :: 		if((Events.Keys.b2==1)&&(Door2OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2424
	MOVLW       255
	SUBWF       _Door2OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2424
L__Menu2704:
;FirmV_0_7_0.c,1922 :: 		{Door2OpenTime=Door2OpenTime+1;Menu0();State=102;}
	INCF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2424:
;FirmV_0_7_0.c,1923 :: 		}
L_Menu2418:
;FirmV_0_7_0.c,1926 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2425
;FirmV_0_7_0.c,1927 :: 		{ if((Events.Keys.b0==1)&&(Door1CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2428
	MOVF        _Door1CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2428
L__Menu2703:
;FirmV_0_7_0.c,1928 :: 		{Door1CloseTime=Door1CloseTime-1;Menu0();State=102;}
	DECF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2428:
;FirmV_0_7_0.c,1929 :: 		if((Events.Keys.b2==1)&&(Door1CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2431
	MOVLW       255
	SUBWF       _Door1CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2431
L__Menu2702:
;FirmV_0_7_0.c,1930 :: 		{Door1CloseTime=Door1CloseTime+1;Menu0();State=102;}
	INCF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2431:
;FirmV_0_7_0.c,1931 :: 		}
L_Menu2425:
;FirmV_0_7_0.c,1934 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2432
;FirmV_0_7_0.c,1935 :: 		{ if((Events.Keys.b0==1)&&(Door2CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2435
	MOVF        _Door2CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2435
L__Menu2701:
;FirmV_0_7_0.c,1936 :: 		{Door2CloseTime=Door2CloseTime-1;Menu0();State=102;}
	DECF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2435:
;FirmV_0_7_0.c,1937 :: 		if((Events.Keys.b2==1)&&(Door2CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2438
	MOVLW       255
	SUBWF       _Door2CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2438
L__Menu2700:
;FirmV_0_7_0.c,1938 :: 		{Door2CloseTime=Door2CloseTime+1;Menu0();State=102;}
	INCF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2438:
;FirmV_0_7_0.c,1939 :: 		}
L_Menu2432:
;FirmV_0_7_0.c,1943 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2439
;FirmV_0_7_0.c,1944 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2442
	MOVF        _OpenSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2442
L__Menu2699:
;FirmV_0_7_0.c,1945 :: 		{OpenSoftStartTime=OpenSoftStartTime-1;Menu0();State=102;}
	DECF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2442:
;FirmV_0_7_0.c,1946 :: 		if((Events.Keys.b2==1)&&(OpenSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2445
	MOVLW       255
	SUBWF       _OpenSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2445
L__Menu2698:
;FirmV_0_7_0.c,1947 :: 		{OpenSoftStartTime=OpenSoftStartTime+1;Menu0();State=102;}
	INCF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2445:
;FirmV_0_7_0.c,1948 :: 		}
L_Menu2439:
;FirmV_0_7_0.c,1951 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2446
;FirmV_0_7_0.c,1952 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2449
	MOVF        _OpenSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2449
L__Menu2697:
;FirmV_0_7_0.c,1953 :: 		{OpenSoftStopTime=OpenSoftStopTime-1;Menu0();State=102;}
	DECF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2449:
;FirmV_0_7_0.c,1954 :: 		if((Events.Keys.b2==1)&&(OpenSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2452
	MOVLW       255
	SUBWF       _OpenSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2452
L__Menu2696:
;FirmV_0_7_0.c,1955 :: 		{OpenSoftStopTime=OpenSoftStopTime+1;Menu0();State=102;}
	INCF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2452:
;FirmV_0_7_0.c,1956 :: 		}
L_Menu2446:
;FirmV_0_7_0.c,1959 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2453
;FirmV_0_7_0.c,1960 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2456
	MOVF        _CloseSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2456
L__Menu2695:
;FirmV_0_7_0.c,1961 :: 		{CloseSoftStartTime=CloseSoftStartTime-1;Menu0();State=102;}
	DECF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2456:
;FirmV_0_7_0.c,1962 :: 		if((Events.Keys.b2==1)&&(CloseSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2459
	MOVLW       255
	SUBWF       _CloseSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2459
L__Menu2694:
;FirmV_0_7_0.c,1963 :: 		{CloseSoftStartTime=CloseSoftStartTime+1;Menu0();State=102;}
	INCF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2459:
;FirmV_0_7_0.c,1964 :: 		}
L_Menu2453:
;FirmV_0_7_0.c,1967 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2460
;FirmV_0_7_0.c,1968 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2463
	MOVF        _CloseSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2463
L__Menu2693:
;FirmV_0_7_0.c,1969 :: 		{CloseSoftStopTime=CloseSoftStopTime-1;Menu0();State=102;}
	DECF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2463:
;FirmV_0_7_0.c,1970 :: 		if((Events.Keys.b2==1)&&(CloseSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2466
	MOVLW       255
	SUBWF       _CloseSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2466
L__Menu2692:
;FirmV_0_7_0.c,1971 :: 		{CloseSoftStopTime=CloseSoftStopTime+1;Menu0();State=102;}
	INCF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2466:
;FirmV_0_7_0.c,1972 :: 		}
L_Menu2460:
;FirmV_0_7_0.c,1976 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2467
;FirmV_0_7_0.c,1977 :: 		{ if((Events.Keys.b0==1)&&(OverloadSens>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2470
	MOVF        _OverloadSens+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2470
L__Menu2691:
;FirmV_0_7_0.c,1978 :: 		{OverloadSens=OverloadSens-1;Menu0();State=102;}
	DECF        _OverloadSens+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2470:
;FirmV_0_7_0.c,1979 :: 		if((Events.Keys.b2==1)&&(OverloadSens<9))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2473
	MOVLW       9
	SUBWF       _OverloadSens+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2473
L__Menu2690:
;FirmV_0_7_0.c,1980 :: 		{OverloadSens=OverloadSens+1;Menu0();State=102;}
	INCF        _OverloadSens+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2473:
;FirmV_0_7_0.c,1981 :: 		}
L_Menu2467:
;FirmV_0_7_0.c,1984 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2474
;FirmV_0_7_0.c,1985 :: 		{ if((Events.Keys.b0==1)&&(ActionTimeDiff>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2477
	MOVF        _ActionTimeDiff+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2477
L__Menu2689:
;FirmV_0_7_0.c,1986 :: 		{ActionTimeDiff=ActionTimeDiff-1;Menu0();State=102;}
	DECF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2477:
;FirmV_0_7_0.c,1987 :: 		if((Events.Keys.b2==1)&&(ActionTimeDiff<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2480
	MOVLW       255
	SUBWF       _ActionTimeDiff+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2480
L__Menu2688:
;FirmV_0_7_0.c,1988 :: 		{ActionTimeDiff=ActionTimeDiff+1;Menu0();State=102;}
	INCF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2480:
;FirmV_0_7_0.c,1989 :: 		}
L_Menu2474:
;FirmV_0_7_0.c,1992 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2481
;FirmV_0_7_0.c,1993 :: 		{ if((Events.Keys.b0==1)&&(AutoCloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2484
	MOVLW       0
	MOVWF       R0 
	MOVF        _AutoCloseTime+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu2748
	MOVF        _AutoCloseTime+0, 0 
	SUBLW       0
L__Menu2748:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2484
L__Menu2687:
;FirmV_0_7_0.c,1994 :: 		{AutoCloseTime=AutoCloseTime-1;Menu0();State=102;}
	MOVLW       1
	SUBWF       _AutoCloseTime+0, 1 
	MOVLW       0
	SUBWFB      _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2484:
;FirmV_0_7_0.c,1995 :: 		if((Events.Keys.b2==1)&&(AutoCloseTime<65000))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2487
	MOVLW       253
	SUBWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu2749
	MOVLW       232
	SUBWF       _AutoCloseTime+0, 0 
L__Menu2749:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2487
L__Menu2686:
;FirmV_0_7_0.c,1996 :: 		{AutoCloseTime=AutoCloseTime+1;Menu0();State=102;}
	INFSNZ      _AutoCloseTime+0, 1 
	INCF        _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2487:
;FirmV_0_7_0.c,1997 :: 		}
L_Menu2481:
;FirmV_0_7_0.c,2000 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2488
;FirmV_0_7_0.c,2002 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2003 :: 		memcpy(LCDLine1,"                ",16);
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
;FirmV_0_7_0.c,2004 :: 		memcpy(LCDLine2,"                ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
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
;FirmV_0_7_0.c,2005 :: 		LCDFlash=0; LCDFlashFlag=0;
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,2006 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2007 :: 		FactorySettings();
	CALL        _FactorySettings+0, 0
;FirmV_0_7_0.c,2008 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2009 :: 		}
L_Menu2488:
;FirmV_0_7_0.c,2012 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2489
;FirmV_0_7_0.c,2013 :: 		{ if((Events.Keys.b0==1)&&(OpenPhEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2492
	MOVF        _OpenPhEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2492
L__Menu2685:
;FirmV_0_7_0.c,2014 :: 		{OpenPhEnable=OpenPhEnable-1;Menu0();State=102;}
	DECF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2492:
;FirmV_0_7_0.c,2015 :: 		if((Events.Keys.b2==1)&&(OpenPhEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2495
	MOVLW       1
	SUBWF       _OpenPhEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2495
L__Menu2684:
;FirmV_0_7_0.c,2016 :: 		{OpenPhEnable=OpenPhEnable+1;Menu0();State=102;}
	INCF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2495:
;FirmV_0_7_0.c,2017 :: 		}
L_Menu2489:
;FirmV_0_7_0.c,2021 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2496
;FirmV_0_7_0.c,2022 :: 		{ if((Events.Keys.b0==1)&&(LimiterEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2499
	MOVF        _LimiterEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2499
L__Menu2683:
;FirmV_0_7_0.c,2023 :: 		{LimiterEnable=LimiterEnable-1;Menu0();State=102;}
	DECF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2499:
;FirmV_0_7_0.c,2024 :: 		if((Events.Keys.b2==1)&&(LimiterEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2502
	MOVLW       1
	SUBWF       _LimiterEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2502
L__Menu2682:
;FirmV_0_7_0.c,2025 :: 		{LimiterEnable=LimiterEnable+1;Menu0();State=102;}
	INCF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2502:
;FirmV_0_7_0.c,2026 :: 		}
L_Menu2496:
;FirmV_0_7_0.c,2029 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2503
;FirmV_0_7_0.c,2030 :: 		{ if((Events.Keys.b0==1)&&(LockForce>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2506
	MOVF        _LockForce+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2506
L__Menu2681:
;FirmV_0_7_0.c,2031 :: 		{LockForce=LockForce-1;Menu0();State=102;}
	DECF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2506:
;FirmV_0_7_0.c,2032 :: 		if((Events.Keys.b2==1)&&(LockForce<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2509
	MOVLW       1
	SUBWF       _LockForce+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2509
L__Menu2680:
;FirmV_0_7_0.c,2033 :: 		{LockForce=LockForce+1;Menu0();State=102;}
	INCF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2509:
;FirmV_0_7_0.c,2034 :: 		}
L_Menu2503:
;FirmV_0_7_0.c,2037 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2510
;FirmV_0_7_0.c,2038 :: 		{ if((Events.Keys.b0==1)&&(CloseAfterPass>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2513
	MOVF        _CloseAfterPass+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2513
L__Menu2679:
;FirmV_0_7_0.c,2039 :: 		{CloseAfterPass=CloseAfterPass-1;if(CloseAfterPass==9) CloseAfterPass=0;Menu0();State=102;}
	DECF        _CloseAfterPass+0, 1 
	MOVF        _CloseAfterPass+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2514
	CLRF        _CloseAfterPass+0 
L_Menu2514:
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2513:
;FirmV_0_7_0.c,2040 :: 		if((Events.Keys.b2==1)&&(CloseAfterPass<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2517
	MOVLW       255
	SUBWF       _CloseAfterPass+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2517
L__Menu2678:
;FirmV_0_7_0.c,2041 :: 		{CloseAfterPass=CloseAfterPass+1;if(CloseAfterPass==1) CloseAfterPass=10;Menu0();State=102;}
	INCF        _CloseAfterPass+0, 1 
	MOVF        _CloseAfterPass+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2518
	MOVLW       10
	MOVWF       _CloseAfterPass+0 
L_Menu2518:
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2517:
;FirmV_0_7_0.c,2042 :: 		}
L_Menu2510:
;FirmV_0_7_0.c,2045 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2519
;FirmV_0_7_0.c,2047 :: 		State=103;
	MOVLW       103
	MOVWF       _State+0 
;FirmV_0_7_0.c,2048 :: 		memcpy(LCDLine1,"                ",16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
;FirmV_0_7_0.c,2049 :: 		memcpy(LCDLine2,"                ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
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
;FirmV_0_7_0.c,2050 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2051 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2052 :: 		}
L_Menu2519:
;FirmV_0_7_0.c,2055 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2520
;FirmV_0_7_0.c,2057 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2058 :: 		memcpy(LCDLine1,"                ",16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
;FirmV_0_7_0.c,2059 :: 		memcpy(LCDLine2,"                ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
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
;FirmV_0_7_0.c,2060 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2061 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2062 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,2063 :: 		}
L_Menu2520:
;FirmV_0_7_0.c,2064 :: 		}
	RETURN      0
; end of _Menu2

_Menu3:

;FirmV_0_7_0.c,2076 :: 		void Menu3()
;FirmV_0_7_0.c,2078 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2079 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2080 :: 		}
	RETURN      0
; end of _Menu3

_LearnAuto:

;FirmV_0_7_0.c,2094 :: 		void LearnAuto()
;FirmV_0_7_0.c,2100 :: 		switch(LearnPhase)
	GOTO        L_LearnAuto521
;FirmV_0_7_0.c,2102 :: 		case 0:
L_LearnAuto523:
;FirmV_0_7_0.c,2103 :: 		if(Events.Remote.b0==1) {DoorNo=2; LearnPhase=LearnPhase+1;} if(Events.Remote.b1==1) {DoorNo=1;LearnPhase=3;}
	BTFSS       _Events+4, 0 
	GOTO        L_LearnAuto524
	MOVLW       2
	MOVWF       LearnAuto_DoorNo_L0+0 
	INCF        _LearnPhase+0, 1 
L_LearnAuto524:
	BTFSS       _Events+4, 1 
	GOTO        L_LearnAuto525
	MOVLW       1
	MOVWF       LearnAuto_DoorNo_L0+0 
	MOVLW       3
	MOVWF       _LearnPhase+0 
L_LearnAuto525:
;FirmV_0_7_0.c,2104 :: 		break;
	GOTO        L_LearnAuto522
;FirmV_0_7_0.c,2106 :: 		case 1: //Start D2 and enable overload sensing after 1s
L_LearnAuto526:
;FirmV_0_7_0.c,2107 :: 		StartMotor(2,_Close);AddTask(ms500+2,21);LearnPhase=LearnPhase+1;
	MOVLW       2
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       2
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       21
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
;FirmV_0_7_0.c,2108 :: 		break;
	GOTO        L_LearnAuto522
;FirmV_0_7_0.c,2110 :: 		case 2: //Check if D2 reaches end of its course
L_LearnAuto527:
;FirmV_0_7_0.c,2111 :: 		if(Events.Overload.b1==1){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto528
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnAuto528:
;FirmV_0_7_0.c,2112 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto529
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnAuto529:
;FirmV_0_7_0.c,2113 :: 		break;
	GOTO        L_LearnAuto522
;FirmV_0_7_0.c,2115 :: 		case 3: //Start D1 and enable overload sensin after 1 s
L_LearnAuto530:
;FirmV_0_7_0.c,2116 :: 		StartMotor(1,_Close);AddTask(ms500+2,20);LearnPhase=LearnPhase+1;;
	MOVLW       1
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       2
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       20
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
;FirmV_0_7_0.c,2118 :: 		case 4: //Check if D1 reaches end of its course
L_LearnAuto531:
;FirmV_0_7_0.c,2119 :: 		if(Events.Overload.b0==1){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto532
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnAuto532:
;FirmV_0_7_0.c,2120 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto533
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto533:
;FirmV_0_7_0.c,2121 :: 		break;
	GOTO        L_LearnAuto522
;FirmV_0_7_0.c,2123 :: 		case 5: //Start D1 for opening and save start time and enable overload sensing after 1s
L_LearnAuto534:
;FirmV_0_7_0.c,2124 :: 		startT=ms500;StartMotor(1,_Open);AddTask(ms500+2,20);LearnPhase=LearnPhase+1;
	MOVF        _ms500+0, 0 
	MOVWF       LearnAuto_startT_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnAuto_startT_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnAuto_startT_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnAuto_startT_L0+3 
	MOVLW       1
	MOVWF       FARG_StartMotor_Mx+0 
	MOVLW       1
	MOVWF       FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       2
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       20
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
;FirmV_0_7_0.c,2125 :: 		break;
	GOTO        L_LearnAuto522
;FirmV_0_7_0.c,2127 :: 		case 6: //Check if D1 reaches end of its course and save the stop time
L_LearnAuto535:
;FirmV_0_7_0.c,2128 :: 		if(Events.Overload.b0==1){OverloadCheckFlag1=0;StopMotor(1);if(DoorNo==1)LearnPhase=11;else LearnPhase=LearnPhase+1;stopT=ms500;RawData.D1OpenTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto536
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	MOVF        LearnAuto_DoorNo_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnAuto537
	MOVLW       11
	MOVWF       _LearnPhase+0 
	GOTO        L_LearnAuto538
L_LearnAuto537:
	INCF        _LearnPhase+0, 1 
L_LearnAuto538:
	MOVF        LearnAuto_startT_L0+0, 0 
	SUBWF       _ms500+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnAuto_RawData_L0+1 
L_LearnAuto536:
;FirmV_0_7_0.c,2129 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto539
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto539:
;FirmV_0_7_0.c,2130 :: 		break;
	GOTO        L_LearnAuto522
;FirmV_0_7_0.c,2132 :: 		case 7: //Start D2 for opening and save start time and enable overload sensing after 1s
L_LearnAuto540:
;FirmV_0_7_0.c,2133 :: 		startT=ms500;StartMotor(2,_Open);AddTask(ms500+2,21);LearnPhase=LearnPhase+1;
	MOVF        _ms500+0, 0 
	MOVWF       LearnAuto_startT_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnAuto_startT_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnAuto_startT_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnAuto_startT_L0+3 
	MOVLW       2
	MOVWF       FARG_StartMotor_Mx+0 
	MOVLW       1
	MOVWF       FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       2
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       21
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
;FirmV_0_7_0.c,2134 :: 		break;
	GOTO        L_LearnAuto522
;FirmV_0_7_0.c,2136 :: 		case 8: //Check if D2 reaches end of its course and save the stop time
L_LearnAuto541:
;FirmV_0_7_0.c,2137 :: 		if(Events.Overload.b1==1){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D2OpenTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto542
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
	MOVF        LearnAuto_startT_L0+0, 0 
	SUBWF       _ms500+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnAuto_RawData_L0+3 
L_LearnAuto542:
;FirmV_0_7_0.c,2138 :: 		if(CheckTask(21))OverloadCheckFlag1=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto543
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto543:
;FirmV_0_7_0.c,2139 :: 		break;
	GOTO        L_LearnAuto522
;FirmV_0_7_0.c,2141 :: 		case 9: //Start D2 for closing and save start time and enable overload sensing after 1s
L_LearnAuto544:
;FirmV_0_7_0.c,2142 :: 		startT=ms500;StartMotor(2,_Close);AddTask(ms500+2,21);LearnPhase=LearnPhase+1;
	MOVF        _ms500+0, 0 
	MOVWF       LearnAuto_startT_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnAuto_startT_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnAuto_startT_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnAuto_startT_L0+3 
	MOVLW       2
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       2
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       21
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
;FirmV_0_7_0.c,2143 :: 		break;
	GOTO        L_LearnAuto522
;FirmV_0_7_0.c,2145 :: 		case 10: //Check if D2 reaches end of its course and save the stop time
L_LearnAuto545:
;FirmV_0_7_0.c,2146 :: 		if(Events.Overload.b1==1){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D2CloseTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto546
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
	MOVF        LearnAuto_startT_L0+0, 0 
	SUBWF       _ms500+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnAuto_RawData_L0+2 
L_LearnAuto546:
;FirmV_0_7_0.c,2147 :: 		if(CheckTask(21))OverloadCheckFlag1=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto547
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto547:
;FirmV_0_7_0.c,2148 :: 		break;
	GOTO        L_LearnAuto522
;FirmV_0_7_0.c,2150 :: 		case 11: //Start D1 for closing and save start time and enable overload sensing after 1s
L_LearnAuto548:
;FirmV_0_7_0.c,2151 :: 		startT=ms500;StartMotor(1,_Close);AddTask(ms500+2,20);LearnPhase=LearnPhase+1;
	MOVF        _ms500+0, 0 
	MOVWF       LearnAuto_startT_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnAuto_startT_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnAuto_startT_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnAuto_startT_L0+3 
	MOVLW       1
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       2
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       20
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
;FirmV_0_7_0.c,2152 :: 		break;
	GOTO        L_LearnAuto522
;FirmV_0_7_0.c,2154 :: 		case 12: //Check if D1 reaches end of its course and save the stop time
L_LearnAuto549:
;FirmV_0_7_0.c,2155 :: 		if(Events.Overload.b0==1){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D1CloseTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto550
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
	MOVF        LearnAuto_startT_L0+0, 0 
	SUBWF       _ms500+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnAuto_RawData_L0+0 
L_LearnAuto550:
;FirmV_0_7_0.c,2156 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto551
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto551:
;FirmV_0_7_0.c,2157 :: 		break;
	GOTO        L_LearnAuto522
;FirmV_0_7_0.c,2159 :: 		case 13:
L_LearnAuto552:
;FirmV_0_7_0.c,2160 :: 		AutoLearnCalculator(&RawData);
	MOVLW       LearnAuto_RawData_L0+0
	MOVWF       FARG_AutoLearnCalculator+0 
	MOVLW       hi_addr(LearnAuto_RawData_L0+0)
	MOVWF       FARG_AutoLearnCalculator+1 
	CALL        _AutoLearnCalculator+0, 0
;FirmV_0_7_0.c,2161 :: 		SaveLearnData(&RawData,DoorNo);
	MOVLW       LearnAuto_RawData_L0+0
	MOVWF       FARG_SaveLearnData+0 
	MOVLW       hi_addr(LearnAuto_RawData_L0+0)
	MOVWF       FARG_SaveLearnData+1 
	MOVF        LearnAuto_DoorNo_L0+0, 0 
	MOVWF       FARG_SaveLearnData+0 
	CALL        _SaveLearnData+0, 0
;FirmV_0_7_0.c,2162 :: 		memcpy(LCDLine1,"Learn Complete  ",16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
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
;FirmV_0_7_0.c,2163 :: 		memcpy(LCDLine2,"     Ready      ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr104_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr104_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr104_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr104_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr104_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr104_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr104_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2164 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2165 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2166 :: 		break;
	GOTO        L_LearnAuto522
;FirmV_0_7_0.c,2169 :: 		}
L_LearnAuto521:
	MOVF        _LearnPhase+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto523
	MOVF        _LearnPhase+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto526
	MOVF        _LearnPhase+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto527
	MOVF        _LearnPhase+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto530
	MOVF        _LearnPhase+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto531
	MOVF        _LearnPhase+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto534
	MOVF        _LearnPhase+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto535
	MOVF        _LearnPhase+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto540
	MOVF        _LearnPhase+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto541
	MOVF        _LearnPhase+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto544
	MOVF        _LearnPhase+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto545
	MOVF        _LearnPhase+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto548
	MOVF        _LearnPhase+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto549
	MOVF        _LearnPhase+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto552
L_LearnAuto522:
;FirmV_0_7_0.c,2173 :: 		}
	RETURN      0
; end of _LearnAuto

_AutoLearnCalculator:

;FirmV_0_7_0.c,2193 :: 		void AutoLearnCalculator(Learn *raw)
;FirmV_0_7_0.c,2196 :: 		(*raw).D1OpenTime=(*raw).D1OpenTime+16;
	MOVLW       1
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       R2 
	MOVFF       R1, FSR0L
	MOVFF       R2, FSR0H
	MOVLW       16
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1L
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2197 :: 		(*raw).D2OpenTime=(*raw).D2OpenTime+16;
	MOVLW       3
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       R2 
	MOVFF       R1, FSR0L
	MOVFF       R2, FSR0H
	MOVLW       16
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1L
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2199 :: 		(*raw).D1OpenSoftStart=4;
	MOVLW       4
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2200 :: 		(*raw).D1CloseSoftStart=4;
	MOVLW       6
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2201 :: 		(*raw).D2OpenSoftStart=4;
	MOVLW       8
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2202 :: 		(*raw).D2CloseSoftStart=4;
	MOVLW       10
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2204 :: 		(*raw).D1OpenSoftStop=10;
	MOVLW       5
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2205 :: 		(*raw).D2OpenSoftStop=10;
	MOVLW       9
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2206 :: 		(*raw).D1CloseSoftStop=10;
	MOVLW       7
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2207 :: 		(*raw).D2CloseSoftStop=10;
	MOVLW       11
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2209 :: 		}
	RETURN      0
; end of _AutoLearnCalculator

_SaveLearnData:

;FirmV_0_7_0.c,2221 :: 		void SaveLearnData(Learn *d,char DCount)
;FirmV_0_7_0.c,2223 :: 		Door1OpenTime=(*d).D1OpenTime;
	MOVLW       1
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,2224 :: 		Door1CloseTime=(*d).D1CloseTime;
	MOVFF       FARG_SaveLearnData_d+0, FSR0L
	MOVFF       FARG_SaveLearnData_d+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,2225 :: 		if(DCount==2)
	MOVF        FARG_SaveLearnData_DCount+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SaveLearnData553
;FirmV_0_7_0.c,2227 :: 		Door2OpenTime=(*d).D2OpenTime;
	MOVLW       3
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,2228 :: 		Door2CloseTime=(*d).D2CloseTime;
	MOVLW       2
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,2229 :: 		OpenSoftStartTime=((*d).D1OpenSoftStart+(*d).D2OpenSoftStart)/2;
	MOVLW       4
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVLW       8
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR2L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	ADDWFC      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,2230 :: 		OpenSoftStopTime=((*d).D1OpenSoftStop+(*d).D2OpenSoftStop)/2;
	MOVLW       5
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVLW       9
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR2L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	ADDWFC      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,2231 :: 		CloseSoftStartTime=((*d).D1CloseSoftStart+(*d).D2CloseSoftStart)/2;
	MOVLW       6
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVLW       10
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR2L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	ADDWFC      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,2232 :: 		CloseSoftStopTime=((*d).D1CloseSoftStop+(*d).D2CloseSoftStop)/2;
	MOVLW       7
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVLW       11
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR2L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R3 
	CLRF        R4 
	MOVLW       0
	ADDWFC      R4, 1 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	MOVF        R0, 0 
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,2233 :: 		}
	GOTO        L_SaveLearnData554
L_SaveLearnData553:
;FirmV_0_7_0.c,2236 :: 		Door2OpenTime=0;
	CLRF        _Door2OpenTime+0 
;FirmV_0_7_0.c,2237 :: 		Door2CloseTime=0;
	CLRF        _Door2CloseTime+0 
;FirmV_0_7_0.c,2238 :: 		OpenSoftStartTime=(*d).D1OpenSoftStart;
	MOVLW       4
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,2239 :: 		OpenSoftStopTime=(*d).D1OpenSoftStop;
	MOVLW       5
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,2240 :: 		CloseSoftStartTime=(*d).D1CloseSoftStart;
	MOVLW       6
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,2241 :: 		CloseSoftStopTime=(*d).D1CloseSoftStop;
	MOVLW       7
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,2242 :: 		}
L_SaveLearnData554:
;FirmV_0_7_0.c,2244 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2245 :: 		}
	RETURN      0
; end of _SaveLearnData

_LearnManual:

;FirmV_0_7_0.c,2260 :: 		void LearnManual()
;FirmV_0_7_0.c,2267 :: 		switch(LearnPhase)
	GOTO        L_LearnManual555
;FirmV_0_7_0.c,2269 :: 		case 0:
L_LearnManual557:
;FirmV_0_7_0.c,2270 :: 		if(Events.Remote.b0==1){LearnPhase=LearnPhase+1; DoorNo=2;}if(Events.Remote.b1==1){LearnPhase=3; DoorNo=1;}
	BTFSS       _Events+4, 0 
	GOTO        L_LearnManual558
	INCF        _LearnPhase+0, 1 
	MOVLW       2
	MOVWF       LearnManual_DoorNo_L0+0 
L_LearnManual558:
	BTFSS       _Events+4, 1 
	GOTO        L_LearnManual559
	MOVLW       3
	MOVWF       _LearnPhase+0 
	MOVLW       1
	MOVWF       LearnManual_DoorNo_L0+0 
L_LearnManual559:
;FirmV_0_7_0.c,2271 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2273 :: 		case 1: //Start D2 and enable overload sensing after 1s
L_LearnManual560:
;FirmV_0_7_0.c,2274 :: 		StartMotor(2,_Close);AddTask(ms500+2,21);LearnPhase=LearnPhase+1;
	MOVLW       2
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       2
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       21
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
;FirmV_0_7_0.c,2275 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2277 :: 		case 2: //Check if D2 reaches end of its course
L_LearnManual561:
;FirmV_0_7_0.c,2278 :: 		if(Events.Overload.b1==1){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnManual562
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnManual562:
;FirmV_0_7_0.c,2279 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual563
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnManual563:
;FirmV_0_7_0.c,2280 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2282 :: 		case 3: //Start D1 and enable overload sensin after 1 s
L_LearnManual564:
;FirmV_0_7_0.c,2283 :: 		StartMotor(1,_Close);AddTask(ms500+2,20);LearnPhase=LearnPhase+1;;
	MOVLW       1
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVLW       2
	ADDWF       _ms500+0, 0 
	MOVWF       FARG_AddTask_OccTime+0 
	MOVLW       0
	ADDWFC      _ms500+1, 0 
	MOVWF       FARG_AddTask_OccTime+1 
	MOVLW       0
	ADDWFC      _ms500+2, 0 
	MOVWF       FARG_AddTask_OccTime+2 
	MOVLW       0
	ADDWFC      _ms500+3, 0 
	MOVWF       FARG_AddTask_OccTime+3 
	MOVLW       20
	MOVWF       FARG_AddTask_tcode+0 
	CALL        _AddTask+0, 0
	INCF        _LearnPhase+0, 1 
;FirmV_0_7_0.c,2285 :: 		case 4: //Check if D1 reaches end of its course
L_LearnManual565:
;FirmV_0_7_0.c,2286 :: 		if(Events.Overload.b0==1){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnManual566
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnManual566:
;FirmV_0_7_0.c,2287 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual567
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnManual567:
;FirmV_0_7_0.c,2288 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2290 :: 		case 5: //Wait for remote to start D1 and slow down
L_LearnManual568:
;FirmV_0_7_0.c,2291 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(1,_Open);SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual569
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t1_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t1_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t1_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t1_L0+3 
	MOVLW       1
	MOVWF       FARG_StartMotor_Mx+0 
	MOVLW       1
	MOVWF       FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	CLRF        FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
	INCF        _LearnPhase+0, 1 
L_LearnManual569:
;FirmV_0_7_0.c,2292 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2294 :: 		case 6: //check for Remote press and fast up
L_LearnManual570:
;FirmV_0_7_0.c,2295 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(1,Motor2FullSpeed);M1isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual571
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t2_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t2_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t2_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t2_L0+3 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
L_LearnManual571:
;FirmV_0_7_0.c,2296 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2298 :: 		case 7: //check for Remote press and slow down
L_LearnManual572:
;FirmV_0_7_0.c,2299 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual573
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t3_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t3_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t3_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t3_L0+3 
	CLRF        FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
L_LearnManual573:
;FirmV_0_7_0.c,2300 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2302 :: 		case 8: //check for Remote press and stop
L_LearnManual574:
;FirmV_0_7_0.c,2303 :: 		if(Events.Remote!=0){if(DoorNo==2)LearnPhase=LearnPhase+1;else LearnPhase=17;t4=ms500;StopMotor(1);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual575
	MOVF        LearnManual_DoorNo_L0+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_LearnManual576
	INCF        _LearnPhase+0, 1 
	GOTO        L_LearnManual577
L_LearnManual576:
	MOVLW       17
	MOVWF       _LearnPhase+0 
L_LearnManual577:
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t4_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t4_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t4_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t4_L0+3 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,2304 :: 		RawData.D1OpenTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+1 
;FirmV_0_7_0.c,2305 :: 		RawData.D1OpenSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+4 
;FirmV_0_7_0.c,2306 :: 		RawData.D1OpenSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+5 
;FirmV_0_7_0.c,2307 :: 		}
L_LearnManual575:
;FirmV_0_7_0.c,2308 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2310 :: 		case 9: //Wait for remote to start D2 and slow down
L_LearnManual578:
;FirmV_0_7_0.c,2311 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(2,_Open);SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual579
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t1_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t1_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t1_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t1_L0+3 
	MOVLW       2
	MOVWF       FARG_StartMotor_Mx+0 
	MOVLW       1
	MOVWF       FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	CLRF        FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	INCF        _LearnPhase+0, 1 
L_LearnManual579:
;FirmV_0_7_0.c,2312 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2314 :: 		case 10: //check for Remote press and fast up
L_LearnManual580:
;FirmV_0_7_0.c,2315 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(Motor1FullSpeed,1);M2isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual581
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t2_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t2_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t2_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t2_L0+3 
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
L_LearnManual581:
;FirmV_0_7_0.c,2316 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2318 :: 		case 11: //check for Remote press and slow down
L_LearnManual582:
;FirmV_0_7_0.c,2319 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual583
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t3_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t3_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t3_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t3_L0+3 
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	CLRF        FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
L_LearnManual583:
;FirmV_0_7_0.c,2320 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2322 :: 		case 12: //check for Remote press and stop
L_LearnManual584:
;FirmV_0_7_0.c,2323 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t4=ms500;StopMotor(2);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual585
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t4_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t4_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t4_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t4_L0+3 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,2324 :: 		RawData.D2OpenTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+3 
;FirmV_0_7_0.c,2325 :: 		RawData.D2OpenSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+8 
;FirmV_0_7_0.c,2326 :: 		RawData.D2OpenSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+9 
;FirmV_0_7_0.c,2327 :: 		}
L_LearnManual585:
;FirmV_0_7_0.c,2328 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2330 :: 		case 13: //Wait for remote to start D2 and slow down
L_LearnManual586:
;FirmV_0_7_0.c,2331 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(2,_Close);SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual587
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t1_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t1_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t1_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t1_L0+3 
	MOVLW       2
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	CLRF        FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
	INCF        _LearnPhase+0, 1 
L_LearnManual587:
;FirmV_0_7_0.c,2332 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2334 :: 		case 14: //check for Remote press and fast up
L_LearnManual588:
;FirmV_0_7_0.c,2335 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(Motor1FullSpeed,1);M2isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual589
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t2_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t2_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t2_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t2_L0+3 
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M2isSlow+0 
L_LearnManual589:
;FirmV_0_7_0.c,2336 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2338 :: 		case 15: //check for Remote press and slow down
L_LearnManual590:
;FirmV_0_7_0.c,2339 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(Motor1FullSpeed,0);M2isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual591
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t3_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t3_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t3_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t3_L0+3 
	MOVF        _Motor1FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	CLRF        FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M2isSlow+0 
L_LearnManual591:
;FirmV_0_7_0.c,2340 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2342 :: 		case 16: //check for Remote press and stop
L_LearnManual592:
;FirmV_0_7_0.c,2343 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t4=ms500;StopMotor(2);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual593
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t4_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t4_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t4_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t4_L0+3 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,2344 :: 		RawData.D2CloseTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+2 
;FirmV_0_7_0.c,2345 :: 		RawData.D2CloseSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+10 
;FirmV_0_7_0.c,2346 :: 		RawData.D2CloseSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+11 
;FirmV_0_7_0.c,2347 :: 		}
L_LearnManual593:
;FirmV_0_7_0.c,2348 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2350 :: 		case 17: //Wait for remote to start D1 and slow down
L_LearnManual594:
;FirmV_0_7_0.c,2351 :: 		if(Events.Remote!=0){t1=ms500;StartMotor(1,_Close);SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;LearnPhase=LearnPhase+1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual595
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t1_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t1_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t1_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t1_L0+3 
	MOVLW       1
	MOVWF       FARG_StartMotor_Mx+0 
	CLRF        FARG_StartMotor_Dir+0 
	CALL        _StartMotor+0, 0
	CLRF        FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
	INCF        _LearnPhase+0, 1 
L_LearnManual595:
;FirmV_0_7_0.c,2352 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2354 :: 		case 18: //check for Remote press and fast up
L_LearnManual596:
;FirmV_0_7_0.c,2355 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t2=ms500;SetMotorSpeed(1,Motor2FullSpeed);M1isSlow=0;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual597
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t2_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t2_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t2_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t2_L0+3 
	MOVLW       1
	MOVWF       FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	CLRF        _M1isSlow+0 
L_LearnManual597:
;FirmV_0_7_0.c,2356 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2358 :: 		case 19: //check for Remote press and slow down
L_LearnManual598:
;FirmV_0_7_0.c,2359 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t3=ms500;SetMotorSpeed(0,Motor2FullSpeed);M1isSlow=1;}
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual599
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t3_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t3_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t3_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t3_L0+3 
	CLRF        FARG_SetMotorSpeed_M1FullSpeed+0 
	MOVF        _Motor2FullSpeed+0, 0 
	MOVWF       FARG_SetMotorSpeed_M2FullSpeed+0 
	CALL        _SetMotorSpeed+0, 0
	MOVLW       1
	MOVWF       _M1isSlow+0 
L_LearnManual599:
;FirmV_0_7_0.c,2360 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2362 :: 		case 20: //check for Remote press and stop
L_LearnManual600:
;FirmV_0_7_0.c,2363 :: 		if(Events.Remote!=0){LearnPhase=LearnPhase+1;t4=ms500;StopMotor(1);
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual601
	INCF        _LearnPhase+0, 1 
	MOVF        _ms500+0, 0 
	MOVWF       LearnManual_t4_L0+0 
	MOVF        _ms500+1, 0 
	MOVWF       LearnManual_t4_L0+1 
	MOVF        _ms500+2, 0 
	MOVWF       LearnManual_t4_L0+2 
	MOVF        _ms500+3, 0 
	MOVWF       LearnManual_t4_L0+3 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,2364 :: 		RawData.D1CloseTime=(char)(t4-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+0 
;FirmV_0_7_0.c,2365 :: 		RawData.D1CloseSoftStart=(char)(t2-t1);
	MOVF        LearnManual_t1_L0+0, 0 
	SUBWF       LearnManual_t2_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+6 
;FirmV_0_7_0.c,2366 :: 		RawData.D1CloseSoftStop=(char)(t4-t3);
	MOVF        LearnManual_t3_L0+0, 0 
	SUBWF       LearnManual_t4_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnManual_RawData_L0+7 
;FirmV_0_7_0.c,2367 :: 		}
L_LearnManual601:
;FirmV_0_7_0.c,2368 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2370 :: 		case 21:
L_LearnManual602:
;FirmV_0_7_0.c,2371 :: 		SaveLearnData(&RawData,DoorNo);
	MOVLW       LearnManual_RawData_L0+0
	MOVWF       FARG_SaveLearnData_d+0 
	MOVLW       hi_addr(LearnManual_RawData_L0+0)
	MOVWF       FARG_SaveLearnData_d+1 
	MOVF        LearnManual_DoorNo_L0+0, 0 
	MOVWF       FARG_SaveLearnData_DCount+0 
	CALL        _SaveLearnData+0, 0
;FirmV_0_7_0.c,2372 :: 		memcpy(LCDLine1,"Learn Complete  ",16);
	MOVLW       _LCDLine1+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr105_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr105_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr105_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr105_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr105_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr105_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr105_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2373 :: 		memcpy(LCDLine2,"     Ready      ",16);
	MOVLW       _LCDLine2+0
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       ?ICS?lstr106_FirmV_0_7_0+0
	MOVWF       TBLPTRL 
	MOVLW       hi_addr(?ICS?lstr106_FirmV_0_7_0+0)
	MOVWF       TBLPTRH 
	MOVLW       higher_addr(?ICS?lstr106_FirmV_0_7_0+0)
	MOVWF       TBLPTRU 
	MOVLW       ?lstr106_FirmV_0_7_0+0
	MOVWF       FSR1L 
	MOVLW       hi_addr(?lstr106_FirmV_0_7_0+0)
	MOVWF       FSR1H 
	MOVLW       17
	MOVWF       R0 
	MOVLW       1
	MOVWF       R1 
	CALL        ___CC2DW+0, 0
	MOVLW       ?lstr106_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr106_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       16
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
;FirmV_0_7_0.c,2374 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2375 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2376 :: 		break;
	GOTO        L_LearnManual556
;FirmV_0_7_0.c,2377 :: 		}
L_LearnManual555:
	MOVF        _LearnPhase+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual557
	MOVF        _LearnPhase+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual560
	MOVF        _LearnPhase+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual561
	MOVF        _LearnPhase+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual564
	MOVF        _LearnPhase+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual565
	MOVF        _LearnPhase+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual568
	MOVF        _LearnPhase+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual570
	MOVF        _LearnPhase+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual572
	MOVF        _LearnPhase+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual574
	MOVF        _LearnPhase+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual578
	MOVF        _LearnPhase+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual580
	MOVF        _LearnPhase+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual582
	MOVF        _LearnPhase+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual584
	MOVF        _LearnPhase+0, 0 
	XORLW       13
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual586
	MOVF        _LearnPhase+0, 0 
	XORLW       14
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual588
	MOVF        _LearnPhase+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual590
	MOVF        _LearnPhase+0, 0 
	XORLW       16
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual592
	MOVF        _LearnPhase+0, 0 
	XORLW       17
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual594
	MOVF        _LearnPhase+0, 0 
	XORLW       18
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual596
	MOVF        _LearnPhase+0, 0 
	XORLW       19
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual598
	MOVF        _LearnPhase+0, 0 
	XORLW       20
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual600
	MOVF        _LearnPhase+0, 0 
	XORLW       21
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnManual602
L_LearnManual556:
;FirmV_0_7_0.c,2378 :: 		}
	RETURN      0
; end of _LearnManual

_charValueToStr:

;FirmV_0_7_0.c,2399 :: 		void charValueToStr(char val, char * string)
;FirmV_0_7_0.c,2401 :: 		bytetostr(val>>1,string);
	MOVF        FARG_charValueToStr_val+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	RRCF        FARG_ByteToStr_input+0, 1 
	BCF         FARG_ByteToStr_input+0, 7 
	MOVF        FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_ByteToStr_output+0 
	MOVF        FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,2402 :: 		if((val%2)==1)
	MOVLW       1
	ANDWF       FARG_charValueToStr_val+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_charValueToStr603
;FirmV_0_7_0.c,2403 :: 		memcpy(string+3,".5s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       46
	MOVWF       ?lstr107_FirmV_0_7_0+0 
	MOVLW       53
	MOVWF       ?lstr107_FirmV_0_7_0+1 
	MOVLW       115
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
	GOTO        L_charValueToStr604
L_charValueToStr603:
;FirmV_0_7_0.c,2405 :: 		memcpy(string+3,"s  ",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       115
	MOVWF       ?lstr108_FirmV_0_7_0+0 
	MOVLW       32
	MOVWF       ?lstr108_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr108_FirmV_0_7_0+2 
	CLRF        ?lstr108_FirmV_0_7_0+3 
	MOVLW       ?lstr108_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr108_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_charValueToStr604:
;FirmV_0_7_0.c,2406 :: 		}
	RETURN      0
; end of _charValueToStr

_intValueToStr:

;FirmV_0_7_0.c,2419 :: 		void intValueToStr(unsigned val, char * string)
;FirmV_0_7_0.c,2421 :: 		wordtostr(val>>1,string);
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
;FirmV_0_7_0.c,2422 :: 		if((val%2)==1)
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
	GOTO        L__intValueToStr750
	MOVLW       1
	XORWF       R1, 0 
L__intValueToStr750:
	BTFSS       STATUS+0, 2 
	GOTO        L_intValueToStr605
;FirmV_0_7_0.c,2423 :: 		memcpy(string+5,".5s",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       46
	MOVWF       ?lstr109_FirmV_0_7_0+0 
	MOVLW       53
	MOVWF       ?lstr109_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr109_FirmV_0_7_0+2 
	CLRF        ?lstr109_FirmV_0_7_0+3 
	MOVLW       ?lstr109_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr109_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_intValueToStr606
L_intValueToStr605:
;FirmV_0_7_0.c,2425 :: 		memcpy(string+5,"s  ",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       115
	MOVWF       ?lstr110_FirmV_0_7_0+0 
	MOVLW       32
	MOVWF       ?lstr110_FirmV_0_7_0+1 
	MOVLW       32
	MOVWF       ?lstr110_FirmV_0_7_0+2 
	CLRF        ?lstr110_FirmV_0_7_0+3 
	MOVLW       ?lstr110_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr110_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
L_intValueToStr606:
;FirmV_0_7_0.c,2426 :: 		}
	RETURN      0
; end of _intValueToStr

_SetOverloadParams:

;FirmV_0_7_0.c,2438 :: 		void SetOverloadParams(char p)
;FirmV_0_7_0.c,2441 :: 		switch(p)
	GOTO        L_SetOverloadParams607
;FirmV_0_7_0.c,2443 :: 		case 0: OverloadTreshold=0;OverloadDuration=255; break;
L_SetOverloadParams609:
	CLRF        _OverloadTreshold+0 
	CLRF        _OverloadTreshold+1 
	MOVLW       255
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams608
;FirmV_0_7_0.c,2445 :: 		case 1: OverloadTreshold=400;OverloadDuration=200; break;
L_SetOverloadParams610:
	MOVLW       144
	MOVWF       _OverloadTreshold+0 
	MOVLW       1
	MOVWF       _OverloadTreshold+1 
	MOVLW       200
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams608
;FirmV_0_7_0.c,2447 :: 		case 2: OverloadTreshold=450;OverloadDuration=150; break;
L_SetOverloadParams611:
	MOVLW       194
	MOVWF       _OverloadTreshold+0 
	MOVLW       1
	MOVWF       _OverloadTreshold+1 
	MOVLW       150
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams608
;FirmV_0_7_0.c,2449 :: 		case 3: OverloadTreshold=500;OverloadDuration=100; break;
L_SetOverloadParams612:
	MOVLW       244
	MOVWF       _OverloadTreshold+0 
	MOVLW       1
	MOVWF       _OverloadTreshold+1 
	MOVLW       100
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams608
;FirmV_0_7_0.c,2451 :: 		case 4: OverloadTreshold=550;OverloadDuration=80; break;
L_SetOverloadParams613:
	MOVLW       38
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       80
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams608
;FirmV_0_7_0.c,2453 :: 		case 5: OverloadTreshold=600;OverloadDuration=150; break;
L_SetOverloadParams614:
	MOVLW       88
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       150
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams608
;FirmV_0_7_0.c,2455 :: 		case 6: OverloadTreshold=600;OverloadDuration=100; break;
L_SetOverloadParams615:
	MOVLW       88
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       100
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams608
;FirmV_0_7_0.c,2457 :: 		case 7: OverloadTreshold=600;OverloadDuration=50; break;
L_SetOverloadParams616:
	MOVLW       88
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       50
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams608
;FirmV_0_7_0.c,2459 :: 		case 8: OverloadTreshold=700;OverloadDuration=100; break;
L_SetOverloadParams617:
	MOVLW       188
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       100
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams608
;FirmV_0_7_0.c,2461 :: 		case 9: OverloadTreshold=700;OverloadDuration=50; break;
L_SetOverloadParams618:
	MOVLW       188
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       50
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams608
;FirmV_0_7_0.c,2463 :: 		}
L_SetOverloadParams607:
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams609
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams610
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams611
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams612
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams613
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams614
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams615
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams616
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams617
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams618
L_SetOverloadParams608:
;FirmV_0_7_0.c,2464 :: 		}
	RETURN      0
; end of _SetOverloadParams
