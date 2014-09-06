
_interrupt:

;FirmV_0_7_0.c,210 :: 		void interrupt()
;FirmV_0_7_0.c,212 :: 		if(TMR0IF_bit)
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;FirmV_0_7_0.c,214 :: 		msCounter=msCounter+1;
	INCF        _msCounter+0, 1 
;FirmV_0_7_0.c,215 :: 		LCDBackLight=1;
	BSF         PORTB+0, 3 
;FirmV_0_7_0.c,216 :: 		Flag20ms=1;
	MOVLW       1
	MOVWF       _Flag20ms+0 
;FirmV_0_7_0.c,217 :: 		if(ms20A==255)
	MOVF        _ms20A+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;FirmV_0_7_0.c,218 :: 		{ms20A=0;RemotePulse1=0;}
	CLRF        _ms20A+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt2
L_interrupt1:
;FirmV_0_7_0.c,220 :: 		ms20A=ms20A+1;
	INCF        _ms20A+0, 1 
L_interrupt2:
;FirmV_0_7_0.c,222 :: 		if(ms20B==255)
	MOVF        _ms20B+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;FirmV_0_7_0.c,223 :: 		{ms20B=0;RemotePulse2=0;}
	CLRF        _ms20B+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt4
L_interrupt3:
;FirmV_0_7_0.c,225 :: 		ms20B=ms20B+1;
	INCF        _ms20B+0, 1 
L_interrupt4:
;FirmV_0_7_0.c,227 :: 		if(msCounter>=25)
	MOVLW       25
	SUBWF       _msCounter+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt5
;FirmV_0_7_0.c,229 :: 		msCounter=0;
	CLRF        _msCounter+0 
;FirmV_0_7_0.c,230 :: 		ms500=ms500+1;
	MOVLW       1
	ADDWF       _ms500+0, 1 
	MOVLW       0
	ADDWFC      _ms500+1, 1 
	ADDWFC      _ms500+2, 1 
	ADDWFC      _ms500+3, 1 
;FirmV_0_7_0.c,231 :: 		LCDFlashFlag=!LCDFlashFlag;
	MOVF        _LCDFlashFlag+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _LCDFlashFlag+0 
;FirmV_0_7_0.c,232 :: 		LCDBackLight=0;
	BCF         PORTB+0, 3 
;FirmV_0_7_0.c,233 :: 		Flag500ms=1;
	MOVLW       1
	MOVWF       _Flag500ms+0 
;FirmV_0_7_0.c,234 :: 		}
L_interrupt5:
;FirmV_0_7_0.c,235 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,236 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,237 :: 		TMR0IF_bit=0;
	BCF         TMR0IF_bit+0, 2 
;FirmV_0_7_0.c,238 :: 		}
L_interrupt0:
;FirmV_0_7_0.c,241 :: 		if(INT1F_bit)
	BTFSS       INT1F_bit+0, 0 
	GOTO        L_interrupt6
;FirmV_0_7_0.c,243 :: 		if(RemotePulse1==0)
	MOVF        _RemotePulse1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;FirmV_0_7_0.c,244 :: 		{ RemotePulse1=RemotePulse1+1;ms20A=0;}
	INCF        _RemotePulse1+0, 1 
	CLRF        _ms20A+0 
	GOTO        L_interrupt8
L_interrupt7:
;FirmV_0_7_0.c,246 :: 		{ RemotePulse1=RemotePulse1+1;}
	INCF        _RemotePulse1+0, 1 
L_interrupt8:
;FirmV_0_7_0.c,247 :: 		if(RemotePulse1>=5)
	MOVLW       5
	SUBWF       _RemotePulse1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt9
;FirmV_0_7_0.c,248 :: 		if((ms20A>=19)&&(ms20A<=21))
	MOVLW       19
	SUBWF       _ms20A+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
	MOVF        _ms20A+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
L__interrupt570:
;FirmV_0_7_0.c,249 :: 		{RemoteAFlag=1;RemotePulse1=0;}
	MOVLW       1
	MOVWF       _RemoteAFlag+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt13
L_interrupt12:
;FirmV_0_7_0.c,251 :: 		RemotePulse1=0;
	CLRF        _RemotePulse1+0 
L_interrupt13:
L_interrupt9:
;FirmV_0_7_0.c,252 :: 		INT1IF_bit=0;
	BCF         INT1IF_bit+0, 0 
;FirmV_0_7_0.c,253 :: 		}
L_interrupt6:
;FirmV_0_7_0.c,257 :: 		if(INT2IF_bit)
	BTFSS       INT2IF_bit+0, 1 
	GOTO        L_interrupt14
;FirmV_0_7_0.c,259 :: 		if(RemotePulse2==0)
	MOVF        _RemotePulse2+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt15
;FirmV_0_7_0.c,260 :: 		{ RemotePulse2=RemotePulse2+1;ms20B=0;}
	INCF        _RemotePulse2+0, 1 
	CLRF        _ms20B+0 
	GOTO        L_interrupt16
L_interrupt15:
;FirmV_0_7_0.c,262 :: 		{ RemotePulse2=RemotePulse2+1;}
	INCF        _RemotePulse2+0, 1 
L_interrupt16:
;FirmV_0_7_0.c,263 :: 		if(RemotePulse2>=5)
	MOVLW       5
	SUBWF       _RemotePulse2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt17
;FirmV_0_7_0.c,264 :: 		if((ms20B>=19)&&(ms20B<=21))
	MOVLW       19
	SUBWF       _ms20B+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
	MOVF        _ms20B+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
L__interrupt569:
;FirmV_0_7_0.c,265 :: 		{RemoteBFlag=1;RemotePulse2=0;}
	MOVLW       1
	MOVWF       _RemoteBFlag+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt21
L_interrupt20:
;FirmV_0_7_0.c,267 :: 		RemotePulse2=0;
	CLRF        _RemotePulse2+0 
L_interrupt21:
L_interrupt17:
;FirmV_0_7_0.c,268 :: 		INT2IF_bit=0;
	BCF         INT2IF_bit+0, 1 
;FirmV_0_7_0.c,269 :: 		}
L_interrupt14:
;FirmV_0_7_0.c,274 :: 		if(INT0F_bit==1)
	BTFSS       INT0F_bit+0, 1 
	GOTO        L_interrupt22
;FirmV_0_7_0.c,276 :: 		ZCCounter=ZCCounter+1;
	INCF        _ZCCounter+0, 1 
;FirmV_0_7_0.c,277 :: 		if(ZCCounter==255)
	MOVF        _ZCCounter+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt23
;FirmV_0_7_0.c,278 :: 		ZCCounter=0;
	CLRF        _ZCCounter+0 
L_interrupt23:
;FirmV_0_7_0.c,279 :: 		if(ZCCounter%3==1)
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
;FirmV_0_7_0.c,281 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt25
;FirmV_0_7_0.c,282 :: 		if(Motor1FullSpeed)
	MOVF        _Motor1FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt26
;FirmV_0_7_0.c,283 :: 		Motor1=1;
	BSF         PORTC+0, 1 
	GOTO        L_interrupt27
L_interrupt26:
;FirmV_0_7_0.c,285 :: 		Motor1=0;
	BCF         PORTC+0, 1 
L_interrupt27:
L_interrupt25:
;FirmV_0_7_0.c,287 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt28
;FirmV_0_7_0.c,288 :: 		if(Motor2FullSpeed)
	MOVF        _Motor2FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt29
;FirmV_0_7_0.c,289 :: 		Motor2=1;
	BSF         PORTC+0, 0 
	GOTO        L_interrupt30
L_interrupt29:
;FirmV_0_7_0.c,291 :: 		Motor2=0;
	BCF         PORTC+0, 0 
L_interrupt30:
L_interrupt28:
;FirmV_0_7_0.c,292 :: 		}
L_interrupt24:
;FirmV_0_7_0.c,293 :: 		if(ZCCounter%3==0)
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
;FirmV_0_7_0.c,295 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt32
;FirmV_0_7_0.c,296 :: 		Motor1=1;
	BSF         PORTC+0, 1 
L_interrupt32:
;FirmV_0_7_0.c,298 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt33
;FirmV_0_7_0.c,299 :: 		Motor2=1;
	BSF         PORTC+0, 0 
L_interrupt33:
;FirmV_0_7_0.c,300 :: 		}
L_interrupt31:
;FirmV_0_7_0.c,301 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, 1 
;FirmV_0_7_0.c,302 :: 		}
L_interrupt22:
;FirmV_0_7_0.c,303 :: 		}
L__interrupt662:
	RETFIE      1
; end of _interrupt

_ResetTaskEvents:

;FirmV_0_7_0.c,316 :: 		void ResetTaskEvents()
;FirmV_0_7_0.c,318 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,319 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,320 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,321 :: 		}
	RETURN      0
; end of _ResetTaskEvents

_Logger:

;FirmV_0_7_0.c,333 :: 		void Logger(char* text)
;FirmV_0_7_0.c,336 :: 		longwordtostrwithzeros(ms500,time);
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
;FirmV_0_7_0.c,337 :: 		uart_write_text(time);
	MOVLW       Logger_time_L0+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(Logger_time_L0+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;FirmV_0_7_0.c,338 :: 		uart1_write_text(": ");
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
;FirmV_0_7_0.c,339 :: 		uart1_write_text(text);
	MOVF        FARG_Logger_text+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_Logger_text+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;FirmV_0_7_0.c,340 :: 		uart1_write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,341 :: 		uart1_write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,342 :: 		}
	RETURN      0
; end of _Logger

_main:

;FirmV_0_7_0.c,359 :: 		void main() {
;FirmV_0_7_0.c,361 :: 		PhotocellRel=1;
	BSF         PORTC+0, 5 
;FirmV_0_7_0.c,363 :: 		Init();
	CALL        _Init+0, 0
;FirmV_0_7_0.c,365 :: 		Logger("Start ...");
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
;FirmV_0_7_0.c,369 :: 		while(1)
L_main34:
;FirmV_0_7_0.c,371 :: 		if(Flag20ms==1)
	MOVF        _Flag20ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main36
;FirmV_0_7_0.c,373 :: 		if(DebouncingDelay<DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelay+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main37
;FirmV_0_7_0.c,374 :: 		DebouncingDelay=DebouncingDelay+1;
	INCF        _DebouncingDelay+0, 1 
L_main37:
;FirmV_0_7_0.c,375 :: 		LCDUpdater();
	CALL        _LCDUpdater+0, 0
;FirmV_0_7_0.c,376 :: 		Flag20ms=0;
	CLRF        _Flag20ms+0 
;FirmV_0_7_0.c,377 :: 		}
L_main36:
;FirmV_0_7_0.c,379 :: 		if(Flag500ms==1)
	MOVF        _Flag500ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main38
;FirmV_0_7_0.c,381 :: 		ResetTaskEvents();
	CALL        _ResetTaskEvents+0, 0
;FirmV_0_7_0.c,382 :: 		TaskManager();
	CALL        _TaskManager+0, 0
;FirmV_0_7_0.c,383 :: 		Flag500ms=0;
	CLRF        _Flag500ms+0 
;FirmV_0_7_0.c,384 :: 		}
L_main38:
;FirmV_0_7_0.c,385 :: 		EventHandler();
	CALL        _EventHandler+0, 0
;FirmV_0_7_0.c,386 :: 		StateManager();
	CALL        _StateManager+0, 0
;FirmV_0_7_0.c,387 :: 		}
	GOTO        L_main34
;FirmV_0_7_0.c,389 :: 		}
	GOTO        $+0
; end of _main

_StateManager:

;FirmV_0_7_0.c,414 :: 		void StateManager()
;FirmV_0_7_0.c,420 :: 		switch(State)
	GOTO        L_StateManager39
;FirmV_0_7_0.c,423 :: 		case 0: State1(); break;
L_StateManager41:
	CALL        _State1+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,425 :: 		case 1: State1(); break;
L_StateManager42:
	CALL        _State1+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,427 :: 		case 2: State2(); break;
L_StateManager43:
	CALL        _State2+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,429 :: 		case 3: State3(); break;
L_StateManager44:
	CALL        _State3+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,431 :: 		case 4: State4(); break;
L_StateManager45:
	CALL        _State4+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,433 :: 		case 5: State5(); break;
L_StateManager46:
	CALL        _State5+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,435 :: 		case 6: State6(); break;
L_StateManager47:
	CALL        _State6+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,437 :: 		case 7: State7(); break;
L_StateManager48:
	CALL        _State7+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,439 :: 		case 8: State8(); break;
L_StateManager49:
	CALL        _State8+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,441 :: 		case 10:State00(); break;
L_StateManager50:
	CALL        _State00+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,443 :: 		case 100:Menu0(); break;
L_StateManager51:
	CALL        _Menu0+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,445 :: 		case 101:Menu1(); break;
L_StateManager52:
	CALL        _Menu1+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,447 :: 		case 102:Menu2(); break;
L_StateManager53:
	CALL        _Menu2+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,449 :: 		case 103:Menu3(); break;
L_StateManager54:
	CALL        _Menu3+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,451 :: 		case 200:LearnAuto(); break;
L_StateManager55:
	CALL        _LearnAuto+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,453 :: 		case 201:LearnManual(); break;
L_StateManager56:
	CALL        _LearnManual+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,455 :: 		}
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
;FirmV_0_7_0.c,456 :: 		}
	RETURN      0
; end of _StateManager

_StateTest:

;FirmV_0_7_0.c,460 :: 		void StateTest()
;FirmV_0_7_0.c,462 :: 		if (Events.Photocell==1)
	MOVF        _Events+6, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StateTest57
;FirmV_0_7_0.c,463 :: 		LCDLine1[0]='1';
	MOVLW       49
	MOVWF       _LCDLine1+0 
	GOTO        L_StateTest58
L_StateTest57:
;FirmV_0_7_0.c,465 :: 		LCDLine1[0]='0';
	MOVLW       48
	MOVWF       _LCDLine1+0 
L_StateTest58:
;FirmV_0_7_0.c,467 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,469 :: 		}
	RETURN      0
; end of _StateTest

_State00:

;FirmV_0_7_0.c,473 :: 		void State00()
;FirmV_0_7_0.c,478 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,479 :: 		StartMotor(1,_Close);
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,480 :: 		StartMotor(2,_Close);
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,484 :: 		if(Events.Remote.b0==1)
	BTFSS       _Events+4, 0 
	GOTO        L_State0059
;FirmV_0_7_0.c,485 :: 		{Flasher=0;StopMotor(1);StopMotor(2);
	BCF         PORTC+0, 2 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,486 :: 		State=1;                }
	MOVLW       1
	MOVWF       _State+0 
L_State0059:
;FirmV_0_7_0.c,487 :: 		}
	RETURN      0
; end of _State00

_State1:

;FirmV_0_7_0.c,496 :: 		void State1()
;FirmV_0_7_0.c,498 :: 		char delay=3;
	MOVLW       3
	MOVWF       State1_delay_L0+0 
;FirmV_0_7_0.c,501 :: 		Flasher=0;
	BCF         PORTC+0, 2 
;FirmV_0_7_0.c,503 :: 		if(Events.Keys==2)
	MOVF        _Events+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State160
;FirmV_0_7_0.c,504 :: 		{State=100;MenuPointer=0;}
	MOVLW       100
	MOVWF       _State+0 
	CLRF        _MenuPointer+0 
L_State160:
;FirmV_0_7_0.c,506 :: 		ActiveDoors=3-Events.Remote;
	MOVF        _Events+4, 0 
	SUBLW       3
	MOVWF       _ActiveDoors+0 
;FirmV_0_7_0.c,510 :: 		if(Events.Remote!=0)
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State161
;FirmV_0_7_0.c,513 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,514 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,515 :: 		AddTask(ms500+1,12);
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
;FirmV_0_7_0.c,516 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,517 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,518 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State162
;FirmV_0_7_0.c,519 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
;FirmV_0_7_0.c,521 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
;FirmV_0_7_0.c,522 :: 		temp=ms500+OpenSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,523 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,524 :: 		temp=ms500+OpenSoftStartTime+delay;
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
;FirmV_0_7_0.c,525 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,526 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State164
;FirmV_0_7_0.c,527 :: 		{temp=ms500+Door1OpenTime-OpenSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
;FirmV_0_7_0.c,528 :: 		temp=ms500+Door1OpenTime+delay;
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
;FirmV_0_7_0.c,529 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,531 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State167
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State167
L__State1571:
;FirmV_0_7_0.c,533 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,534 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,535 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State168
;FirmV_0_7_0.c,536 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,8); M2isSlow=1;}//speed down
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
;FirmV_0_7_0.c,538 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,6); M2isSlow=0;}//speed up
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
;FirmV_0_7_0.c,539 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,540 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,541 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+delay;
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
;FirmV_0_7_0.c,542 :: 		AddTask(temp,6);//Speed up after soft start
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
;FirmV_0_7_0.c,543 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State170
;FirmV_0_7_0.c,544 :: 		{temp=ms500+ActionTimeDiff+Door2OpenTime-OpenSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
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
;FirmV_0_7_0.c,545 :: 		temp=ms500+Door2OpenTime+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,546 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,547 :: 		}
L_State167:
;FirmV_0_7_0.c,549 :: 		if(AutoCloseTime!=0)
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State1663
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State1663:
	BTFSC       STATUS+0, 2 
	GOTO        L_State171
;FirmV_0_7_0.c,550 :: 		{temp=ms500+AutoCloseTime+delay;AddTask(ms500+AutoCloseTime+delay,9);}
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
;FirmV_0_7_0.c,552 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,553 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,554 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,555 :: 		State=3;
	MOVLW       3
	MOVWF       _State+0 
;FirmV_0_7_0.c,556 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,557 :: 		}
L_State161:
;FirmV_0_7_0.c,558 :: 		}
	RETURN      0
; end of _State1

_State2:

;FirmV_0_7_0.c,572 :: 		void State2()
;FirmV_0_7_0.c,574 :: 		char delay=2;
	MOVLW       2
	MOVWF       State2_delay_L0+0 
;FirmV_0_7_0.c,576 :: 		Flasher=0;
	BCF         PORTC+0, 2 
;FirmV_0_7_0.c,578 :: 		if((Events.Remote!=0)||(CheckTask(9)==1))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State2576
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State2576
	GOTO        L_State274
L__State2576:
;FirmV_0_7_0.c,581 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,582 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State2575
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State2575
	GOTO        L_State277
L__State2575:
;FirmV_0_7_0.c,584 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,585 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,586 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State278
;FirmV_0_7_0.c,587 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
;FirmV_0_7_0.c,589 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
;FirmV_0_7_0.c,590 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,591 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,592 :: 		temp=ms500+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,593 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,594 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State280
;FirmV_0_7_0.c,595 :: 		{temp=ms500+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
;FirmV_0_7_0.c,596 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State281
;FirmV_0_7_0.c,597 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
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
;FirmV_0_7_0.c,599 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,3);}
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
;FirmV_0_7_0.c,601 :: 		}
L_State277:
;FirmV_0_7_0.c,603 :: 		if((Door2CloseTime!=0)&&(ActiveDoors=2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State285
	MOVLW       2
	MOVWF       _ActiveDoors+0 
L__State2574:
;FirmV_0_7_0.c,605 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,606 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,607 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State286
;FirmV_0_7_0.c,608 :: 		{AddTask(temp,8); M2isSlow=1;}//speed down
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
;FirmV_0_7_0.c,610 :: 		{AddTask(temp,6); M2isSlow=0;}//speed up
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
;FirmV_0_7_0.c,611 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,612 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,613 :: 		temp=ms500+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,614 :: 		AddTask(temp,6);//Speed up after soft start
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
;FirmV_0_7_0.c,615 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State288
;FirmV_0_7_0.c,616 :: 		{temp=ms500+Door2CloseTime-CloseSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
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
;FirmV_0_7_0.c,618 :: 		temp=ms500+Door2CloseTime+delay;
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
;FirmV_0_7_0.c,619 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,623 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,624 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,625 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State289
;FirmV_0_7_0.c,626 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
;FirmV_0_7_0.c,628 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
;FirmV_0_7_0.c,629 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,630 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,631 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,632 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,633 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State291
;FirmV_0_7_0.c,634 :: 		{temp=ms500+ActionTimeDiff+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
;FirmV_0_7_0.c,635 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State292
;FirmV_0_7_0.c,636 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
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
;FirmV_0_7_0.c,638 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,3);}
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
;FirmV_0_7_0.c,640 :: 		}
L_State285:
;FirmV_0_7_0.c,643 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,644 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,645 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,646 :: 		State=4;
	MOVLW       4
	MOVWF       _State+0 
;FirmV_0_7_0.c,647 :: 		}
L_State274:
;FirmV_0_7_0.c,649 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State296
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2664
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State2664:
	BTFSC       STATUS+0, 2 
	GOTO        L_State296
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State296
L__State2573:
;FirmV_0_7_0.c,650 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S2 Auto Close Deleted");}
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
;FirmV_0_7_0.c,652 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State299
	BTFSC       _Events+6, 0 
	GOTO        L_State299
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2665
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State2665:
	BTFSC       STATUS+0, 2 
	GOTO        L_State299
L__State2572:
;FirmV_0_7_0.c,653 :: 		if(CloseAfterPass==0)
	MOVF        _CloseAfterPass+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State2100
;FirmV_0_7_0.c,654 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:");Logger(t);}
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
;FirmV_0_7_0.c,656 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:");Logger(t);}
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
;FirmV_0_7_0.c,658 :: 		}
	RETURN      0
; end of _State2

_State3:

;FirmV_0_7_0.c,673 :: 		void State3()
;FirmV_0_7_0.c,675 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,677 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3102
;FirmV_0_7_0.c,678 :: 		{StartMotor(1,_Open);Logger("S3 Motor1Start"); Lock=0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,680 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3103
;FirmV_0_7_0.c,681 :: 		{StartMotor(2,_Open);Logger("S3 Motor2Start"); Lock=0;}
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
;FirmV_0_7_0.c,683 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3104
;FirmV_0_7_0.c,684 :: 		{SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;Logger("S3 Motor1 Fast");}
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
;FirmV_0_7_0.c,686 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3105
;FirmV_0_7_0.c,687 :: 		{SetMotorSpeed(0,Motor2FullSpeed); M1isSlow=1;Logger("S3 Motor1 Slow");}
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
;FirmV_0_7_0.c,689 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3106
;FirmV_0_7_0.c,690 :: 		{SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;Logger("S3 Motor2 Fast");}
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
;FirmV_0_7_0.c,692 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3107
;FirmV_0_7_0.c,693 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S3 Motor2 Slow");}
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
;FirmV_0_7_0.c,695 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3108
;FirmV_0_7_0.c,696 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S3 Overflow Flag1 Set");}
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
;FirmV_0_7_0.c,698 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3109
;FirmV_0_7_0.c,699 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S3 Overflow Flag2 Set");}
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
;FirmV_0_7_0.c,701 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3110
;FirmV_0_7_0.c,702 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S3 Motor1 Stop");}
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
;FirmV_0_7_0.c,704 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3111
;FirmV_0_7_0.c,705 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S3 Motor2 Stop");}
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
;FirmV_0_7_0.c,707 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3112
;FirmV_0_7_0.c,708 :: 		{Lock=1;}
	BSF         PORTD+0, 7 
L_State3112:
;FirmV_0_7_0.c,710 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
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
L__State3582:
;FirmV_0_7_0.c,711 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor1 Collision");ClearTasks(9);
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
;FirmV_0_7_0.c,712 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,714 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
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
L__State3581:
;FirmV_0_7_0.c,715 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor2 Collision");ClearTasks(9);
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
;FirmV_0_7_0.c,716 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,718 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State3580
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State3580
	GOTO        L_State3121
L__State3580:
;FirmV_0_7_0.c,719 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State3121:
;FirmV_0_7_0.c,721 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State3124
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3124
L__State3579:
;FirmV_0_7_0.c,722 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Photocell Int");ClearTasks(9);
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
;FirmV_0_7_0.c,723 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,725 :: 		if(Events.Remote!=0)
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State3125
;FirmV_0_7_0.c,726 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Remote Stoped");ClearTasks(9);
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
;FirmV_0_7_0.c,727 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,729 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3128
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3128
L__State3578:
;FirmV_0_7_0.c,730 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Limit Switch Stoped");ClearTasks(9);
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
;FirmV_0_7_0.c,731 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,733 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3129
;FirmV_0_7_0.c,734 :: 		{State=2; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_blank,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,736 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State3577
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State3577
	GOTO        L_State3132
L__State3577:
;FirmV_0_7_0.c,737 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S3 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State3666
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State3666:
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
;FirmV_0_7_0.c,739 :: 		}
	RETURN      0
; end of _State3

_State4:

;FirmV_0_7_0.c,753 :: 		void State4()
;FirmV_0_7_0.c,755 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,757 :: 		bytetostr(Events.Task1,LCDLine1);
	MOVF        _Events+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,758 :: 		bytetostr(Events.Task2,LCDLine2);
	MOVF        _Events+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,759 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,761 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4134
;FirmV_0_7_0.c,762 :: 		{StartMotor(1,_Close);Logger("S4 Motor1Start");memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,764 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4135
;FirmV_0_7_0.c,765 :: 		{StartMotor(2,_Close);Logger("S4 Motor2Start");}
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
;FirmV_0_7_0.c,767 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4136
;FirmV_0_7_0.c,768 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S4 M1 Overload Check");}
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
;FirmV_0_7_0.c,770 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4137
;FirmV_0_7_0.c,771 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S4 M2 Overload Check");}
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
;FirmV_0_7_0.c,773 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4138
;FirmV_0_7_0.c,774 :: 		{SetMotorSpeed(1,Motor2FullSpeed); OverloadCheckFlag1=0; M1isSlow=0;Logger("S4 M1 Speed UP");}
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
;FirmV_0_7_0.c,776 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4139
;FirmV_0_7_0.c,777 :: 		{SetMotorSpeed(0,Motor2FullSpeed); OverloadCheckFlag2=0; M1isSlow=1;Logger("S4 M1 Speed Down");}
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
;FirmV_0_7_0.c,779 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4140
;FirmV_0_7_0.c,780 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S4 M2 Speed UP");}
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
;FirmV_0_7_0.c,782 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4141
;FirmV_0_7_0.c,783 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S4 M2 Speed Down");}
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
;FirmV_0_7_0.c,785 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4142
;FirmV_0_7_0.c,786 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S4 M1 Stoped");}
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
;FirmV_0_7_0.c,788 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4143
;FirmV_0_7_0.c,789 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S4 M2 Stoped");}
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
;FirmV_0_7_0.c,791 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
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
L__State4587:
;FirmV_0_7_0.c,792 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M1 Overloaded");ClearTasks(9);
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
;FirmV_0_7_0.c,793 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,795 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
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
L__State4586:
;FirmV_0_7_0.c,796 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M2 Overloaded");ClearTasks(9);
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
;FirmV_0_7_0.c,797 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,799 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State4585
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State4585
	GOTO        L_State4152
L__State4585:
;FirmV_0_7_0.c,800 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State4152:
;FirmV_0_7_0.c,802 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State4153
;FirmV_0_7_0.c,803 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S4 Photocell Int");ClearTasks(9);
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
;FirmV_0_7_0.c,804 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,806 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4156
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4156
L__State4584:
;FirmV_0_7_0.c,807 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Limit Switch Stop");ClearTasks(9);
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
;FirmV_0_7_0.c,808 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,810 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State4157
;FirmV_0_7_0.c,811 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Remote Pressed");ClearTasks(9);
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
;FirmV_0_7_0.c,812 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,814 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4158
;FirmV_0_7_0.c,815 :: 		{State=1; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,817 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State4583
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State4583
	GOTO        L_State4161
L__State4583:
;FirmV_0_7_0.c,818 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S4 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State4667
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State4667:
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
;FirmV_0_7_0.c,820 :: 		}
	RETURN      0
; end of _State4

_State5:

;FirmV_0_7_0.c,835 :: 		void State5()
;FirmV_0_7_0.c,837 :: 		char delay=2;
	MOVLW       2
	MOVWF       State5_delay_L0+0 
;FirmV_0_7_0.c,838 :: 		Flasher=0;
	BCF         PORTC+0, 2 
;FirmV_0_7_0.c,839 :: 		if((Events.Remote!=0)||(CheckTask(9)==1))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State5592
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5592
	GOTO        L_State5165
L__State5592:
;FirmV_0_7_0.c,841 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State5591
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5591
	GOTO        L_State5168
L__State5591:
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
;FirmV_0_7_0.c,845 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,846 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,849 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,851 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,852 :: 		}
L_State5168:
;FirmV_0_7_0.c,853 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State5171
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State5171
L__State5590:
;FirmV_0_7_0.c,855 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,856 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,857 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,858 :: 		AddTask(temp,6);
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
;FirmV_0_7_0.c,859 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,860 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,861 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,862 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,863 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,868 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,869 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,870 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,871 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,872 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,873 :: 		temp=ms500+ActionTimeDiff+OverloadDelay+delay;
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
;FirmV_0_7_0.c,874 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,875 :: 		temp=ms500+Door2CloseTime+delay;
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
;FirmV_0_7_0.c,876 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,877 :: 		}
L_State5171:
;FirmV_0_7_0.c,878 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,879 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,880 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,881 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,882 :: 		}
L_State5165:
;FirmV_0_7_0.c,884 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State5174
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State5668
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State5668:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5174
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State5174
L__State5589:
;FirmV_0_7_0.c,885 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S5 Auto Close Deleted");}
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
;FirmV_0_7_0.c,887 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State5177
	BTFSC       _Events+6, 0 
	GOTO        L_State5177
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State5669
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State5669:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5177
L__State5588:
;FirmV_0_7_0.c,890 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:");Logger(t);}
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
;FirmV_0_7_0.c,892 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:");Logger(t);}
L_State5179:
;FirmV_0_7_0.c,893 :: 		}
L_State5177:
;FirmV_0_7_0.c,895 :: 		}
	RETURN      0
; end of _State5

_State6:

;FirmV_0_7_0.c,915 :: 		void State6()
;FirmV_0_7_0.c,919 :: 		char delay=3;
	MOVLW       3
	MOVWF       State6_delay_L0+0 
;FirmV_0_7_0.c,920 :: 		Flasher=0;
	BCF         PORTC+0, 2 
;FirmV_0_7_0.c,921 :: 		if((Events.Remote!=0)||(PhotocellOpenFlag))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State6597
	MOVF        _PhotocellOpenFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6597
	GOTO        L_State6182
L__State6597:
;FirmV_0_7_0.c,923 :: 		PhotocellOpenFlag=0;
	CLRF        _PhotocellOpenFlag+0 
;FirmV_0_7_0.c,924 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,925 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,926 :: 		AddTask(ms500+1,12);
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
;FirmV_0_7_0.c,927 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,928 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,929 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,930 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,931 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,932 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,933 :: 		temp=ms500+Door1OpenTime+delay;
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
;FirmV_0_7_0.c,934 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,935 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6185
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6185
L__State6596:
;FirmV_0_7_0.c,937 :: 		AddTask(ms500+ActionTimeDiff+delay,2);
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
;FirmV_0_7_0.c,938 :: 		AddTask(ms500+ActionTimeDiff+delay,6);
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
;FirmV_0_7_0.c,939 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,940 :: 		AddTask(ms500+ActionTimeDiff+OverloadDelay+delay,11); //overload check
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
;FirmV_0_7_0.c,941 :: 		AddTask(ms500+Door2OpenTime+delay,4);//Stop motor
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
;FirmV_0_7_0.c,942 :: 		}
L_State6185:
;FirmV_0_7_0.c,943 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,944 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,945 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,946 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,947 :: 		State=8;
	MOVLW       8
	MOVWF       _State+0 
;FirmV_0_7_0.c,948 :: 		}
L_State6182:
;FirmV_0_7_0.c,951 :: 		if(CheckTask(9)==1)
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6186
;FirmV_0_7_0.c,953 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,954 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,955 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,956 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,957 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,958 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,959 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,960 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,961 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,963 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6189
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6189
L__State6595:
;FirmV_0_7_0.c,965 :: 		AddTask(ms500+ActionTimeDiff+delay,2);
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
;FirmV_0_7_0.c,966 :: 		AddTask(ms500+ActionTimeDiff+delay,6);
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
;FirmV_0_7_0.c,967 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,968 :: 		AddTask(ms500+ActionTimeDiff+OverloadDelay+delay,11); //overload check
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
;FirmV_0_7_0.c,969 :: 		AddTask(ms500+Door1CloseTime+delay,4);//Stop motor
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
;FirmV_0_7_0.c,970 :: 		}
L_State6189:
;FirmV_0_7_0.c,971 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,972 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,973 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,974 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,975 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,976 :: 		}
L_State6186:
;FirmV_0_7_0.c,978 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State6192
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6670
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State6670:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6192
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State6192
L__State6594:
;FirmV_0_7_0.c,979 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S6 Auto Close Deleted");}
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
;FirmV_0_7_0.c,981 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6195
	BTFSC       _Events+6, 0 
	GOTO        L_State6195
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6671
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State6671:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6195
L__State6593:
;FirmV_0_7_0.c,983 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:");Logger(t);}
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
;FirmV_0_7_0.c,985 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:");Logger(t);}
L_State6197:
;FirmV_0_7_0.c,986 :: 		}
L_State6195:
;FirmV_0_7_0.c,988 :: 		}
	RETURN      0
; end of _State6

_State7:

;FirmV_0_7_0.c,1010 :: 		void State7()
;FirmV_0_7_0.c,1012 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,1014 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7198
;FirmV_0_7_0.c,1015 :: 		{StartMotor(1,_Close);Logger("S7 Motor1Start");memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1017 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7199
;FirmV_0_7_0.c,1018 :: 		{StartMotor(2,_Close);Logger("S7 Motor2Start");}
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
;FirmV_0_7_0.c,1020 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7200
;FirmV_0_7_0.c,1021 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S7 M1 Overload Check");}
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
;FirmV_0_7_0.c,1023 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7201
;FirmV_0_7_0.c,1024 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S7 M2 Overload Check");}
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
;FirmV_0_7_0.c,1026 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7202
;FirmV_0_7_0.c,1027 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S7 M1 Speed UP");}
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
;FirmV_0_7_0.c,1029 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7203
;FirmV_0_7_0.c,1030 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S7 M2 Speed UP");}
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
;FirmV_0_7_0.c,1032 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(CloseDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7605
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7606
	BTFSS       _Events+5, 0 
	GOTO        L__State7606
	GOTO        L__State7605
L__State7606:
	GOTO        L_State7210
L__State7605:
	BTFSS       _CloseDone+0, 0 
	GOTO        L_State7210
L__State7604:
;FirmV_0_7_0.c,1033 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S7 M1 Stoped");}
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
;FirmV_0_7_0.c,1035 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(CloseDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7602
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7603
	BTFSS       _Events+5, 1 
	GOTO        L__State7603
	GOTO        L__State7602
L__State7603:
	GOTO        L_State7217
L__State7602:
	BTFSS       _CloseDone+0, 1 
	GOTO        L_State7217
L__State7601:
;FirmV_0_7_0.c,1036 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S7 M2 Stoped");}
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
;FirmV_0_7_0.c,1038 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State7600
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State7600
	GOTO        L_State7220
L__State7600:
;FirmV_0_7_0.c,1039 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State7220:
;FirmV_0_7_0.c,1041 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State7221
;FirmV_0_7_0.c,1042 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S7 Photocell Int");ClearTasks(9);
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
;FirmV_0_7_0.c,1043 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1045 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State7222
;FirmV_0_7_0.c,1046 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Remote Pressed");ClearTasks(9);
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
;FirmV_0_7_0.c,1047 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1049 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State7225
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7225
L__State7599:
;FirmV_0_7_0.c,1050 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Limit Switch Stop");ClearTasks(9);
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
;FirmV_0_7_0.c,1051 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1053 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State7226
;FirmV_0_7_0.c,1054 :: 		{State=1; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1056 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State7598
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State7598
	GOTO        L_State7229
L__State7598:
;FirmV_0_7_0.c,1057 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S7 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7672
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State7672:
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
;FirmV_0_7_0.c,1060 :: 		}
	RETURN      0
; end of _State7

_State8:

;FirmV_0_7_0.c,1077 :: 		void State8()
;FirmV_0_7_0.c,1079 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,1081 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8231
;FirmV_0_7_0.c,1082 :: 		{StartMotor(1,_Open);Logger("S8 Motor1Start"); Lock=0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
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
	BCF         PORTD+0, 7 
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
;FirmV_0_7_0.c,1084 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8232
;FirmV_0_7_0.c,1085 :: 		{StartMotor(2,_Open);Logger("S8 Motor2Start"); Lock=0;}
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
	BCF         PORTD+0, 7 
L_State8232:
;FirmV_0_7_0.c,1087 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8233
;FirmV_0_7_0.c,1088 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S8 Overflow Flag1 Set");}
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
;FirmV_0_7_0.c,1090 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8234
;FirmV_0_7_0.c,1091 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S8 Overflow Flag2 Set");}
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
;FirmV_0_7_0.c,1093 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8235
;FirmV_0_7_0.c,1094 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S8 Motor1 Fast");}
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
;FirmV_0_7_0.c,1096 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8236
;FirmV_0_7_0.c,1097 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S8 Motor2 Fast");}
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
;FirmV_0_7_0.c,1099 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(OpenDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8615
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8616
	BTFSS       _Events+5, 0 
	GOTO        L__State8616
	GOTO        L__State8615
L__State8616:
	GOTO        L_State8243
L__State8615:
	BTFSS       _OpenDone+0, 0 
	GOTO        L_State8243
L__State8614:
;FirmV_0_7_0.c,1100 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S8 Motor1 Stop");}
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
;FirmV_0_7_0.c,1102 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(OpenDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8612
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8613
	BTFSS       _Events+5, 1 
	GOTO        L__State8613
	GOTO        L__State8612
L__State8613:
	GOTO        L_State8250
L__State8612:
	BTFSS       _OpenDone+0, 1 
	GOTO        L_State8250
L__State8611:
;FirmV_0_7_0.c,1103 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S8 Motor2 Stop");}
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
;FirmV_0_7_0.c,1105 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8251
;FirmV_0_7_0.c,1106 :: 		{Lock=1;}
	BSF         PORTD+0, 7 
L_State8251:
;FirmV_0_7_0.c,1108 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State8610
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State8610
	GOTO        L_State8254
L__State8610:
;FirmV_0_7_0.c,1109 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State8254:
;FirmV_0_7_0.c,1111 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State8257
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8257
L__State8609:
;FirmV_0_7_0.c,1112 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S8 Photocell Int");ClearTasks(9);
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
;FirmV_0_7_0.c,1113 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1115 :: 		if((Events.Remote!=0))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State8258
;FirmV_0_7_0.c,1116 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Motors Stoped (Remote)");ClearTasks(9);
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
;FirmV_0_7_0.c,1117 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1119 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State8261
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8261
L__State8608:
;FirmV_0_7_0.c,1120 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Limit Switch Stop");ClearTasks(9);
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
;FirmV_0_7_0.c,1121 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1123 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State8262
;FirmV_0_7_0.c,1124 :: 		{State=2; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1126 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State8607
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State8607
	GOTO        L_State8265
L__State8607:
;FirmV_0_7_0.c,1127 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S8 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8673
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State8673:
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
;FirmV_0_7_0.c,1130 :: 		}
	RETURN      0
; end of _State8

_LCDUpdater:

;FirmV_0_7_0.c,1139 :: 		void LCDUpdater()
;FirmV_0_7_0.c,1141 :: 		if(LCDUpdateFlag==1)
	MOVF        _LCDUpdateFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDUpdater267
;FirmV_0_7_0.c,1143 :: 		lcd_out(1,1,LCDLine1);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;FirmV_0_7_0.c,1144 :: 		lcd_out(2,1,LCDLine2);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;FirmV_0_7_0.c,1145 :: 		LCDUpdateFlag=0;
	CLRF        _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1146 :: 		}
L_LCDUpdater267:
;FirmV_0_7_0.c,1148 :: 		if(LCDFlash)
	MOVF        _LCDFlash+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater268
;FirmV_0_7_0.c,1150 :: 		if(LCDFlashFlag)
	MOVF        _LCDFlashFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater269
;FirmV_0_7_0.c,1151 :: 		lcd_out(2,1,"               ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
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
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr68_FirmV_0_7_0+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
	GOTO        L_LCDUpdater270
L_LCDUpdater269:
;FirmV_0_7_0.c,1153 :: 		lcd_out(2,1,LCDLine2);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_LCDUpdater270:
;FirmV_0_7_0.c,1154 :: 		}
L_LCDUpdater268:
;FirmV_0_7_0.c,1157 :: 		}
	RETURN      0
; end of _LCDUpdater

_Init:

;FirmV_0_7_0.c,1177 :: 		void Init()
;FirmV_0_7_0.c,1179 :: 		char i=0;
	CLRF        Init_i_L0+0 
;FirmV_0_7_0.c,1181 :: 		porta=0;
	CLRF        PORTA+0 
;FirmV_0_7_0.c,1182 :: 		portb=0;
	CLRF        PORTB+0 
;FirmV_0_7_0.c,1183 :: 		portc=0;
	CLRF        PORTC+0 
;FirmV_0_7_0.c,1184 :: 		portd=0;
	CLRF        PORTD+0 
;FirmV_0_7_0.c,1185 :: 		porte=0;
	CLRF        PORTE+0 
;FirmV_0_7_0.c,1186 :: 		trisa=0b111111;
	MOVLW       63
	MOVWF       TRISA+0 
;FirmV_0_7_0.c,1187 :: 		trisb=0b00000111;
	MOVLW       7
	MOVWF       TRISB+0 
;FirmV_0_7_0.c,1188 :: 		trisc=0b10000000;
	MOVLW       128
	MOVWF       TRISC+0 
;FirmV_0_7_0.c,1189 :: 		trisd=0b01111111;
	MOVLW       127
	MOVWF       TRISD+0 
;FirmV_0_7_0.c,1190 :: 		trise=0b001;
	MOVLW       1
	MOVWF       TRISE+0 
;FirmV_0_7_0.c,1191 :: 		adcon1=0b1001;  // an6 and an7 is digital
	MOVLW       9
	MOVWF       ADCON1+0 
;FirmV_0_7_0.c,1196 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;FirmV_0_7_0.c,1197 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;FirmV_0_7_0.c,1200 :: 		ms500=0;
	CLRF        _ms500+0 
	CLRF        _ms500+1 
	CLRF        _ms500+2 
	CLRF        _ms500+3 
;FirmV_0_7_0.c,1201 :: 		t0con=0b10000101; //enable tmr0 and prescalar
	MOVLW       133
	MOVWF       T0CON+0 
;FirmV_0_7_0.c,1202 :: 		intcon.b7=1;   //global int enable
	BSF         INTCON+0, 7 
;FirmV_0_7_0.c,1203 :: 		intcon.b5=1;  //tmr0 int enable
	BSF         INTCON+0, 5 
;FirmV_0_7_0.c,1204 :: 		intcon.b2=0; //tmr0 flag
	BCF         INTCON+0, 2 
;FirmV_0_7_0.c,1205 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,1206 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,1209 :: 		INT1IP_bit=1;
	BSF         INT1IP_bit+0, 6 
;FirmV_0_7_0.c,1210 :: 		INT1E_bit=1;
	BSF         INT1E_bit+0, 3 
;FirmV_0_7_0.c,1211 :: 		INT1F_bit=0;
	BCF         INT1F_bit+0, 0 
;FirmV_0_7_0.c,1212 :: 		INT2IP_bit=1;
	BSF         INT2IP_bit+0, 7 
;FirmV_0_7_0.c,1213 :: 		INT2E_bit=1;
	BSF         INT2E_bit+0, 4 
;FirmV_0_7_0.c,1214 :: 		INT2F_bit=0;
	BCF         INT2F_bit+0, 1 
;FirmV_0_7_0.c,1215 :: 		INTEDG1_bit=1;
	BSF         INTEDG1_bit+0, 5 
;FirmV_0_7_0.c,1216 :: 		INTEDG2_bit=1;
	BSF         INTEDG2_bit+0, 4 
;FirmV_0_7_0.c,1219 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, 1 
;FirmV_0_7_0.c,1220 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, 4 
;FirmV_0_7_0.c,1223 :: 		for(i=0;i<20;i++)
	CLRF        Init_i_L0+0 
L_Init271:
	MOVLW       20
	SUBWF       Init_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Init272
;FirmV_0_7_0.c,1224 :: 		Tasks[i].Expired=1;
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
;FirmV_0_7_0.c,1223 :: 		for(i=0;i<20;i++)
	INCF        Init_i_L0+0, 1 
;FirmV_0_7_0.c,1224 :: 		Tasks[i].Expired=1;
	GOTO        L_Init271
L_Init272:
;FirmV_0_7_0.c,1227 :: 		Events.Keys=0;
	CLRF        _Events+0 
;FirmV_0_7_0.c,1228 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,1229 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,1230 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,1231 :: 		Events.Remote=0;
	CLRF        _Events+4 
;FirmV_0_7_0.c,1232 :: 		Events.Overload=0;
	CLRF        _Events+5 
;FirmV_0_7_0.c,1233 :: 		Events.Photocell=0;
	CLRF        _Events+6 
;FirmV_0_7_0.c,1236 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,1239 :: 		UART1_init(115200);
	MOVLW       21
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;FirmV_0_7_0.c,1242 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,1244 :: 		}
	RETURN      0
; end of _Init

_TaskManager:

;FirmV_0_7_0.c,1258 :: 		void TaskManager()
;FirmV_0_7_0.c,1260 :: 		char i=0;
	CLRF        TaskManager_i_L0+0 
;FirmV_0_7_0.c,1261 :: 		for(i=0;i<20;i++)
	CLRF        TaskManager_i_L0+0 
L_TaskManager274:
	MOVLW       20
	SUBWF       TaskManager_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TaskManager275
;FirmV_0_7_0.c,1262 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Time==ms500)&&(Tasks[i].Fired==0))
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
	GOTO        L_TaskManager279
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
	GOTO        L__TaskManager674
	MOVF        R3, 0 
	XORWF       _ms500+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager674
	MOVF        R2, 0 
	XORWF       _ms500+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager674
	MOVF        R1, 0 
	XORWF       _ms500+0, 0 
L__TaskManager674:
	BTFSS       STATUS+0, 2 
	GOTO        L_TaskManager279
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
	GOTO        L_TaskManager279
L__TaskManager617:
;FirmV_0_7_0.c,1263 :: 		Tasks[i].Fired=1;
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
L_TaskManager279:
;FirmV_0_7_0.c,1261 :: 		for(i=0;i<20;i++)
	INCF        TaskManager_i_L0+0, 1 
;FirmV_0_7_0.c,1263 :: 		Tasks[i].Fired=1;
	GOTO        L_TaskManager274
L_TaskManager275:
;FirmV_0_7_0.c,1264 :: 		}
	RETURN      0
; end of _TaskManager

_AddTask:

;FirmV_0_7_0.c,1276 :: 		void AddTask(unsigned long OccTime,char tcode)
;FirmV_0_7_0.c,1279 :: 		for(i=0;i<20;i++)
	CLRF        AddTask_i_L0+0 
L_AddTask280:
	MOVLW       20
	SUBWF       AddTask_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AddTask281
;FirmV_0_7_0.c,1280 :: 		if(Tasks[i].Expired==1)
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
	GOTO        L_AddTask283
;FirmV_0_7_0.c,1282 :: 		Tasks[i].TaskCode=tcode;
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
;FirmV_0_7_0.c,1283 :: 		Tasks[i].Time=OccTime;
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
;FirmV_0_7_0.c,1284 :: 		Tasks[i].Expired=0;
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
;FirmV_0_7_0.c,1285 :: 		Tasks[i].Fired=0;
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
;FirmV_0_7_0.c,1286 :: 		break;
	GOTO        L_AddTask281
;FirmV_0_7_0.c,1287 :: 		}
L_AddTask283:
;FirmV_0_7_0.c,1279 :: 		for(i=0;i<20;i++)
	INCF        AddTask_i_L0+0, 1 
;FirmV_0_7_0.c,1287 :: 		}
	GOTO        L_AddTask280
L_AddTask281:
;FirmV_0_7_0.c,1288 :: 		}
	RETURN      0
; end of _AddTask

_EventHandler:

;FirmV_0_7_0.c,1298 :: 		void EventHandler()
;FirmV_0_7_0.c,1301 :: 		Events.ExternalKeys=GetExternalKeysState();
	CALL        _GetExternalKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+8 
;FirmV_0_7_0.c,1302 :: 		Events.Limiter=GetLimitSwitchState();
	CALL        _GetLimitSwitchState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+7 
;FirmV_0_7_0.c,1303 :: 		Events.Keys=GetKeysState();
	CALL        _GetKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+0 
;FirmV_0_7_0.c,1304 :: 		Events.Remote=GetRemoteState();
	CALL        _GetRemoteState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+4 
;FirmV_0_7_0.c,1305 :: 		Events.Overload=GetOverloadState();
	CALL        _GetOverloadState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+5 
;FirmV_0_7_0.c,1306 :: 		Events.Photocell=GetPhotocellState();
	CALL        _GetPhotocellState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+6 
;FirmV_0_7_0.c,1308 :: 		for(i=0;i<20;i++)
	CLRF        EventHandler_i_L0+0 
L_EventHandler284:
	MOVLW       20
	SUBWF       EventHandler_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_EventHandler285
;FirmV_0_7_0.c,1309 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Fired==1))
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
	GOTO        L_EventHandler289
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
	GOTO        L_EventHandler289
L__EventHandler618:
;FirmV_0_7_0.c,1311 :: 		if(Events.Task1==0)
	MOVF        _Events+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler290
;FirmV_0_7_0.c,1312 :: 		{Events.Task1=Tasks[i].TaskCode; Tasks[i].Expired=1;Tasks[i].Fired=0;}
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
	GOTO        L_EventHandler291
L_EventHandler290:
;FirmV_0_7_0.c,1313 :: 		else if(Events.Task2==0)
	MOVF        _Events+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler292
;FirmV_0_7_0.c,1314 :: 		{Events.Task2=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
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
	GOTO        L_EventHandler293
L_EventHandler292:
;FirmV_0_7_0.c,1315 :: 		else if(Events.Task3==0)
	MOVF        _Events+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler294
;FirmV_0_7_0.c,1316 :: 		{Events.Task3=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
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
L_EventHandler294:
L_EventHandler293:
L_EventHandler291:
;FirmV_0_7_0.c,1317 :: 		}
L_EventHandler289:
;FirmV_0_7_0.c,1308 :: 		for(i=0;i<20;i++)
	INCF        EventHandler_i_L0+0, 1 
;FirmV_0_7_0.c,1317 :: 		}
	GOTO        L_EventHandler284
L_EventHandler285:
;FirmV_0_7_0.c,1318 :: 		}
	RETURN      0
; end of _EventHandler

_GetKeysState:

;FirmV_0_7_0.c,1328 :: 		char GetKeysState()
;FirmV_0_7_0.c,1330 :: 		unsigned res=0;
	CLRF        GetKeysState_res_L0+0 
	CLRF        GetKeysState_res_L0+1 
;FirmV_0_7_0.c,1334 :: 		char resch=0,fin;
	CLRF        GetKeysState_resch_L0+0 
;FirmV_0_7_0.c,1335 :: 		res=ADC_Read(5);
	MOVLW       5
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       GetKeysState_res_L0+0 
	MOVF        R1, 0 
	MOVWF       GetKeysState_res_L0+1 
;FirmV_0_7_0.c,1336 :: 		if(((res>>2)>160)&&((res>>2)<185))
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
	GOTO        L__GetKeysState675
	MOVF        R2, 0 
	SUBLW       160
L__GetKeysState675:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState297
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
	GOTO        L__GetKeysState676
	MOVLW       185
	SUBWF       R1, 0 
L__GetKeysState676:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState297
L__GetKeysState625:
;FirmV_0_7_0.c,1337 :: 		resch.b2=1;
	BSF         GetKeysState_resch_L0+0, 2 
L_GetKeysState297:
;FirmV_0_7_0.c,1338 :: 		if(((res>>2)>100)&&((res>>2)<160))
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
	GOTO        L__GetKeysState677
	MOVF        R1, 0 
	SUBLW       100
L__GetKeysState677:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState300
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
	GOTO        L__GetKeysState678
	MOVLW       160
	SUBWF       R1, 0 
L__GetKeysState678:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState300
L__GetKeysState624:
;FirmV_0_7_0.c,1339 :: 		resch.b1=1;
	BSF         GetKeysState_resch_L0+0, 1 
L_GetKeysState300:
;FirmV_0_7_0.c,1340 :: 		if((res>>2)<50)
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
	GOTO        L__GetKeysState679
	MOVLW       50
	SUBWF       R1, 0 
L__GetKeysState679:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState301
;FirmV_0_7_0.c,1341 :: 		resch.b0=1;
	BSF         GetKeysState_resch_L0+0, 0 
L_GetKeysState301:
;FirmV_0_7_0.c,1343 :: 		if((resch==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState302
;FirmV_0_7_0.c,1345 :: 		if(Pressed==0)
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState303
;FirmV_0_7_0.c,1346 :: 		{Repeat=0;Pressed=0;fin=0;RepeatRate=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState303:
;FirmV_0_7_0.c,1347 :: 		if(Pressed==1)
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState304
;FirmV_0_7_0.c,1348 :: 		if(DebouncingDelay>=DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelay+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetKeysState305
;FirmV_0_7_0.c,1349 :: 		{Repeat=0;Pressed=0;fin=0;RepeatRate=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState305:
L_GetKeysState304:
;FirmV_0_7_0.c,1350 :: 		}
L_GetKeysState302:
;FirmV_0_7_0.c,1351 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0)&&(ms500==PressTime+KeyRepeatDelay))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState308
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState308
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState308
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
	GOTO        L__GetKeysState680
	MOVF        _ms500+2, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState680
	MOVF        _ms500+1, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState680
	MOVF        _ms500+0, 0 
	XORWF       R1, 0 
L__GetKeysState680:
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState308
L__GetKeysState623:
;FirmV_0_7_0.c,1352 :: 		Repeat=1;
	MOVLW       1
	MOVWF       GetKeysState_Repeat_L0+0 
L_GetKeysState308:
;FirmV_0_7_0.c,1354 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState311
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState311
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState311
L__GetKeysState622:
;FirmV_0_7_0.c,1355 :: 		fin=0;
	CLRF        GetKeysState_fin_L0+0 
L_GetKeysState311:
;FirmV_0_7_0.c,1357 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==1))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState314
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState314
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState314
L__GetKeysState621:
;FirmV_0_7_0.c,1358 :: 		{fin=resch*RepeatRate;RepeatRate=0;}
	MOVF        GetKeysState_resch_L0+0, 0 
	MULWF       GetKeysState_RepeatRate_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState314:
;FirmV_0_7_0.c,1361 :: 		if((resch!=0)&&(Pressed==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState317
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState317
L__GetKeysState620:
;FirmV_0_7_0.c,1362 :: 		{fin=resch; Pressed=1;PressTime=ms500;DebouncingDelay=0;}
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
L_GetKeysState317:
;FirmV_0_7_0.c,1364 :: 		if((Repeat==1)&&(msCounter%10==0))
	MOVF        GetKeysState_Repeat_L0+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState320
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
	GOTO        L_GetKeysState320
L__GetKeysState619:
;FirmV_0_7_0.c,1365 :: 		RepeatRate=1;
	MOVLW       1
	MOVWF       GetKeysState_RepeatRate_L0+0 
L_GetKeysState320:
;FirmV_0_7_0.c,1367 :: 		return fin;
	MOVF        GetKeysState_fin_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1368 :: 		}
	RETURN      0
; end of _GetKeysState

_GetExternalKeysState:

;FirmV_0_7_0.c,1378 :: 		char GetExternalKeysState()
;FirmV_0_7_0.c,1380 :: 		char out=0;
	CLRF        GetExternalKeysState_out_L0+0 
;FirmV_0_7_0.c,1381 :: 		if(D1ExKey==0)
	BTFSC       PORTD+0, 3 
	GOTO        L_GetExternalKeysState321
;FirmV_0_7_0.c,1382 :: 		out.b0=1;
	BSF         GetExternalKeysState_out_L0+0, 0 
L_GetExternalKeysState321:
;FirmV_0_7_0.c,1383 :: 		if(D2ExKey==0)
	BTFSC       PORTD+0, 4 
	GOTO        L_GetExternalKeysState322
;FirmV_0_7_0.c,1384 :: 		out.b1=1;
	BSF         GetExternalKeysState_out_L0+0, 1 
L_GetExternalKeysState322:
;FirmV_0_7_0.c,1385 :: 		return out;
	MOVF        GetExternalKeysState_out_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1386 :: 		}
	RETURN      0
; end of _GetExternalKeysState

_GetLimitSwitchState:

;FirmV_0_7_0.c,1399 :: 		char GetLimitSwitchState()
;FirmV_0_7_0.c,1401 :: 		if((Limit1==0)||(Limit2==0))
	BTFSS       PORTD+0, 1 
	GOTO        L__GetLimitSwitchState626
	BTFSS       PORTD+0, 2 
	GOTO        L__GetLimitSwitchState626
	GOTO        L_GetLimitSwitchState325
L__GetLimitSwitchState626:
;FirmV_0_7_0.c,1402 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_GetLimitSwitchState325:
;FirmV_0_7_0.c,1404 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1405 :: 		}
	RETURN      0
; end of _GetLimitSwitchState

_GetRemoteState:

;FirmV_0_7_0.c,1414 :: 		char GetRemoteState()
;FirmV_0_7_0.c,1416 :: 		char res=0;
	CLRF        GetRemoteState_res_L0+0 
;FirmV_0_7_0.c,1417 :: 		res.b0=RemoteAFlag.b0;
	BTFSC       _RemoteAFlag+0, 0 
	GOTO        L__GetRemoteState681
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState682
L__GetRemoteState681:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState682:
;FirmV_0_7_0.c,1418 :: 		res.b1=RemoteBFlag.b0;
	BTFSC       _RemoteBFlag+0, 0 
	GOTO        L__GetRemoteState683
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState684
L__GetRemoteState683:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState684:
;FirmV_0_7_0.c,1419 :: 		RemoteAFlag=0;
	CLRF        _RemoteAFlag+0 
;FirmV_0_7_0.c,1420 :: 		RemoteBFlag=0;
	CLRF        _RemoteBFlag+0 
;FirmV_0_7_0.c,1421 :: 		res.b0=res.b0|(~D1ExKey);
	BTFSC       PORTD+0, 3 
	GOTO        L__GetRemoteState685
	BSF         4056, 0 
	GOTO        L__GetRemoteState686
L__GetRemoteState685:
	BCF         4056, 0 
L__GetRemoteState686:
	BTFSC       GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState687
	BTFSC       4056, 0 
	GOTO        L__GetRemoteState687
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState688
L__GetRemoteState687:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState688:
;FirmV_0_7_0.c,1422 :: 		res.b1=res.b1|(~D2ExKey);
	BTFSC       PORTD+0, 4 
	GOTO        L__GetRemoteState689
	BSF         4056, 0 
	GOTO        L__GetRemoteState690
L__GetRemoteState689:
	BCF         4056, 0 
L__GetRemoteState690:
	BTFSC       GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState691
	BTFSC       4056, 0 
	GOTO        L__GetRemoteState691
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState692
L__GetRemoteState691:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState692:
;FirmV_0_7_0.c,1423 :: 		return res;
	MOVF        GetRemoteState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1424 :: 		}
	RETURN      0
; end of _GetRemoteState

_GetOverloadState:

;FirmV_0_7_0.c,1434 :: 		char GetOverloadState()
;FirmV_0_7_0.c,1436 :: 		char res=0;
	CLRF        GetOverloadState_res_L0+0 
;FirmV_0_7_0.c,1438 :: 		VCapM1=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       GetOverloadState_VCapM1_L0+0 
	MOVF        R1, 0 
	MOVWF       GetOverloadState_VCapM1_L0+1 
;FirmV_0_7_0.c,1439 :: 		VCapM2=ADC_Read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       GetOverloadState_VCapM2_L0+0 
	MOVF        R1, 0 
	MOVWF       GetOverloadState_VCapM2_L0+1 
;FirmV_0_7_0.c,1440 :: 		if(Motor1FullSpeed!=0)
	MOVF        _Motor1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState327
;FirmV_0_7_0.c,1442 :: 		if(VCapM1<OverloadTreshold)
	MOVF        _OverloadTreshold+1, 0 
	SUBWF       GetOverloadState_VCapM1_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState693
	MOVF        _OverloadTreshold+0, 0 
	SUBWF       GetOverloadState_VCapM1_L0+0, 0 
L__GetOverloadState693:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState328
;FirmV_0_7_0.c,1444 :: 		if(OverloadCounter1<255)
	MOVLW       255
	SUBWF       _OverloadCounter1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState329
;FirmV_0_7_0.c,1445 :: 		OverloadCounter1=OverloadCounter1+1;
	INCF        _OverloadCounter1+0, 1 
L_GetOverloadState329:
;FirmV_0_7_0.c,1446 :: 		}
	GOTO        L_GetOverloadState330
L_GetOverloadState328:
;FirmV_0_7_0.c,1449 :: 		if(OverloadCounter1>0)
	MOVF        _OverloadCounter1+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState331
;FirmV_0_7_0.c,1450 :: 		OverloadCounter1=OverloadCounter1-1;
	DECF        _OverloadCounter1+0, 1 
L_GetOverloadState331:
;FirmV_0_7_0.c,1451 :: 		}
L_GetOverloadState330:
;FirmV_0_7_0.c,1452 :: 		}
	GOTO        L_GetOverloadState332
L_GetOverloadState327:
;FirmV_0_7_0.c,1454 :: 		{OverloadCounter1=0;}
	CLRF        _OverloadCounter1+0 
L_GetOverloadState332:
;FirmV_0_7_0.c,1456 :: 		if (OverloadCounter1>OverloadDuration)
	MOVF        _OverloadCounter1+0, 0 
	SUBWF       _OverloadDuration+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState333
;FirmV_0_7_0.c,1457 :: 		res.b0=1;
	BSF         GetOverloadState_res_L0+0, 0 
L_GetOverloadState333:
;FirmV_0_7_0.c,1462 :: 		if(Motor2FullSpeed!=0)
	MOVF        _Motor2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState334
;FirmV_0_7_0.c,1464 :: 		if(VCapM2<OverloadTreshold)
	MOVF        _OverloadTreshold+1, 0 
	SUBWF       GetOverloadState_VCapM2_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState694
	MOVF        _OverloadTreshold+0, 0 
	SUBWF       GetOverloadState_VCapM2_L0+0, 0 
L__GetOverloadState694:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState335
;FirmV_0_7_0.c,1466 :: 		if(OverloadCounter2<255)
	MOVLW       255
	SUBWF       _OverloadCounter2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState336
;FirmV_0_7_0.c,1467 :: 		OverloadCounter2=OverloadCounter2+1;
	INCF        _OverloadCounter2+0, 1 
L_GetOverloadState336:
;FirmV_0_7_0.c,1468 :: 		}
	GOTO        L_GetOverloadState337
L_GetOverloadState335:
;FirmV_0_7_0.c,1471 :: 		if(OverloadCounter2>0)
	MOVF        _OverloadCounter2+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState338
;FirmV_0_7_0.c,1472 :: 		OverloadCounter2=OverloadCounter2-1;
	DECF        _OverloadCounter2+0, 1 
L_GetOverloadState338:
;FirmV_0_7_0.c,1473 :: 		}
L_GetOverloadState337:
;FirmV_0_7_0.c,1474 :: 		}
	GOTO        L_GetOverloadState339
L_GetOverloadState334:
;FirmV_0_7_0.c,1476 :: 		{OverloadCounter2=0;}
	CLRF        _OverloadCounter2+0 
L_GetOverloadState339:
;FirmV_0_7_0.c,1479 :: 		if (OverloadCounter2>OverloadDuration)
	MOVF        _OverloadCounter2+0, 0 
	SUBWF       _OverloadDuration+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState340
;FirmV_0_7_0.c,1480 :: 		res.b1=1;
	BSF         GetOverloadState_res_L0+0, 1 
L_GetOverloadState340:
;FirmV_0_7_0.c,1482 :: 		return res;
	MOVF        GetOverloadState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1483 :: 		}
	RETURN      0
; end of _GetOverloadState

_GetPhotocellState:

;FirmV_0_7_0.c,1496 :: 		char GetPhotocellState()
;FirmV_0_7_0.c,1498 :: 		if(Phcell==0)
	BTFSC       PORTD+0, 0 
	GOTO        L_GetPhotocellState341
;FirmV_0_7_0.c,1499 :: 		{if(PhotocellCount<=20)PhotocellCount=PhotocellCount+1;}
	MOVF        _PhotocellCount+0, 0 
	SUBLW       20
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState342
	INCF        _PhotocellCount+0, 1 
L_GetPhotocellState342:
	GOTO        L_GetPhotocellState343
L_GetPhotocellState341:
;FirmV_0_7_0.c,1501 :: 		{PhotocellCount=0;}
	CLRF        _PhotocellCount+0 
L_GetPhotocellState343:
;FirmV_0_7_0.c,1502 :: 		if(PhotocellCount>=20)
	MOVLW       20
	SUBWF       _PhotocellCount+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState344
;FirmV_0_7_0.c,1503 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_GetPhotocellState344:
;FirmV_0_7_0.c,1505 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1506 :: 		}
	RETURN      0
; end of _GetPhotocellState

_SetMotorSpeed:

;FirmV_0_7_0.c,1518 :: 		void SetMotorSpeed(char M1FullSpeed,char M2FullSpeed)
;FirmV_0_7_0.c,1520 :: 		if((M1FullSpeed==0)||(M2FullSpeed==0))
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed627
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed627
	GOTO        L_SetMotorSpeed348
L__SetMotorSpeed627:
;FirmV_0_7_0.c,1521 :: 		INT0E_bit=1;
	BSF         INT0E_bit+0, 4 
	GOTO        L_SetMotorSpeed349
L_SetMotorSpeed348:
;FirmV_0_7_0.c,1523 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, 4 
L_SetMotorSpeed349:
;FirmV_0_7_0.c,1525 :: 		Motor1FullSpeed=M1FullSpeed;
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	MOVWF       _Motor1FullSpeed+0 
;FirmV_0_7_0.c,1526 :: 		Motor2FullSpeed=M2FullSpeed;
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	MOVWF       _Motor2FullSpeed+0 
;FirmV_0_7_0.c,1527 :: 		}
	RETURN      0
; end of _SetMotorSpeed

_OverloadInit:

;FirmV_0_7_0.c,1538 :: 		void OverloadInit(char ch)
;FirmV_0_7_0.c,1540 :: 		if(ch==1)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit350
;FirmV_0_7_0.c,1542 :: 		OverloadCounter1=0;
	CLRF        _OverloadCounter1+0 
;FirmV_0_7_0.c,1543 :: 		Events.Overload.b0=0;
	BCF         _Events+5, 0 
;FirmV_0_7_0.c,1544 :: 		}
L_OverloadInit350:
;FirmV_0_7_0.c,1546 :: 		if(ch==2)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit351
;FirmV_0_7_0.c,1548 :: 		OverloadCounter2=0;
	CLRF        _OverloadCounter2+0 
;FirmV_0_7_0.c,1549 :: 		Events.Overload.b1=0;
	BCF         _Events+5, 1 
;FirmV_0_7_0.c,1550 :: 		}
L_OverloadInit351:
;FirmV_0_7_0.c,1551 :: 		}
	RETURN      0
; end of _OverloadInit

_SaveConfigs:

;FirmV_0_7_0.c,1562 :: 		void SaveConfigs()
;FirmV_0_7_0.c,1565 :: 		EEPROM_Write(1,Door1OpenTime);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1566 :: 		EEPROM_Write(2,Door2OpenTime);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1567 :: 		EEPROM_Write(3,Door1CloseTime);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1568 :: 		EEPROM_Write(4,Door2CloseTime);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1569 :: 		EEPROM_Write(5,ActionTimeDiff);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1570 :: 		EEPROM_Write(6,OpenSoftStartTime);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1571 :: 		EEPROM_Write(7,OpenSoftStopTime);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1572 :: 		EEPROM_Write(8,CloseSoftStartTime);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1573 :: 		EEPROM_Write(9,CloseSoftStopTime);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1574 :: 		EEPROM_Write(10,Hi(AutoCloseTime));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _AutoCloseTime+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1575 :: 		EEPROM_Write(11,Lo(AutoCloseTime));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1576 :: 		EEPROM_Write(12,OverloadSens);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OverloadSens+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1577 :: 		SetOverloadParams(9-OverloadSens);
	MOVF        _OverloadSens+0, 0 
	SUBLW       9
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1578 :: 		EEPROM_Write(13,CloseAfterPass);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1579 :: 		EEPROM_Write(14,LockForce);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _LockForce+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1580 :: 		EEPROM_Write(15,OpenPhEnable);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OpenPhEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1581 :: 		EEPROM_Write(16,LimiterEnable);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _LimiterEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1583 :: 		}
	RETURN      0
; end of _SaveConfigs

_LoadConfigs:

;FirmV_0_7_0.c,1596 :: 		void LoadConfigs()
;FirmV_0_7_0.c,1598 :: 		Door1OpenTime=EEPROM_Read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1599 :: 		Door2OpenTime=EEPROM_Read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1600 :: 		Door1CloseTime=EEPROM_Read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1601 :: 		Door2CloseTime=EEPROM_Read(4);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1602 :: 		ActionTimeDiff=EEPROM_Read(5);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1603 :: 		OpenSoftStartTime=EEPROM_Read(6);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1604 :: 		OpenSoftStopTime=EEPROM_Read(7);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1605 :: 		CloseSoftStartTime=EEPROM_Read(8);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1606 :: 		CloseSoftStopTime=EEPROM_Read(9);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1607 :: 		AutoCloseTime=EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _AutoCloseTime+0 
	MOVLW       0
	MOVWF       _AutoCloseTime+1 
;FirmV_0_7_0.c,1608 :: 		AutoCloseTime=AutoCloseTime<<8;
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       _AutoCloseTime+1 
	CLRF        _AutoCloseTime+0 
;FirmV_0_7_0.c,1609 :: 		AutoCloseTime=AutocloseTime|EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	IORWF       _AutoCloseTime+0, 1 
	MOVLW       0
	IORWF       _AutoCloseTime+1, 1 
;FirmV_0_7_0.c,1610 :: 		OverloadSens=EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadSens+0 
;FirmV_0_7_0.c,1611 :: 		SetOverloadParams(9-OverloadSens);
	MOVF        R0, 0 
	SUBLW       9
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1612 :: 		CloseAfterPass=EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseAfterPass+0 
;FirmV_0_7_0.c,1613 :: 		LockForce=EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LockForce+0 
;FirmV_0_7_0.c,1614 :: 		OpenPhEnable=EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenPhEnable+0 
;FirmV_0_7_0.c,1615 :: 		LimiterEnable=EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LimiterEnable+0 
;FirmV_0_7_0.c,1617 :: 		}
	RETURN      0
; end of _LoadConfigs

_FactorySettings:

;FirmV_0_7_0.c,1630 :: 		void FactorySettings()
;FirmV_0_7_0.c,1632 :: 		Door1OpenTime=20;
	MOVLW       20
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1633 :: 		Door1CloseTime=20;
	MOVLW       20
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1634 :: 		Door2OpenTime=20;
	MOVLW       20
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1635 :: 		Door2CloseTime=20;
	MOVLW       20
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1636 :: 		OverloadSens=5;
	MOVLW       5
	MOVWF       _OverloadSens+0 
;FirmV_0_7_0.c,1637 :: 		SetOverloadParams(4);  //9-5
	MOVLW       4
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1638 :: 		OpenSoftStopTime=10;
	MOVLW       10
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1639 :: 		OpenSoftStartTime=4;
	MOVLW       4
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1640 :: 		CloseSoftStopTime=10;
	MOVLW       10
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1641 :: 		CloseSoftStartTime=4;
	MOVLW       4
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1642 :: 		ActionTimeDiff=12;
	MOVLW       12
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1643 :: 		AutoCloseTime=0;
	CLRF        _AutoCloseTime+0 
	CLRF        _AutoCloseTime+1 
;FirmV_0_7_0.c,1644 :: 		LockForce=0;
	CLRF        _LockForce+0 
;FirmV_0_7_0.c,1645 :: 		OpenPhEnable=0;
	CLRF        _OpenPhEnable+0 
;FirmV_0_7_0.c,1646 :: 		LimiterEnable=0;
	CLRF        _LimiterEnable+0 
;FirmV_0_7_0.c,1647 :: 		CloseAfterPass=0;
	CLRF        _CloseAfterPass+0 
;FirmV_0_7_0.c,1649 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,1650 :: 		}
	RETURN      0
; end of _FactorySettings

_StartMotor:

;FirmV_0_7_0.c,1656 :: 		void StartMotor(char Mx,char Dir)
;FirmV_0_7_0.c,1658 :: 		if(Mx==1)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor352
;FirmV_0_7_0.c,1660 :: 		Motor1Start=1;
	MOVLW       1
	MOVWF       _Motor1Start+0 
;FirmV_0_7_0.c,1661 :: 		Motor1Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor695
	BCF         PORTC+0, 4 
	GOTO        L__StartMotor696
L__StartMotor695:
	BSF         PORTC+0, 4 
L__StartMotor696:
;FirmV_0_7_0.c,1662 :: 		Motor1=1;
	BSF         PORTC+0, 1 
;FirmV_0_7_0.c,1663 :: 		}
L_StartMotor352:
;FirmV_0_7_0.c,1665 :: 		if(Mx==2)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor353
;FirmV_0_7_0.c,1667 :: 		Motor2Start=1;
	MOVLW       1
	MOVWF       _Motor2Start+0 
;FirmV_0_7_0.c,1668 :: 		Motor2Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor697
	BCF         PORTC+0, 3 
	GOTO        L__StartMotor698
L__StartMotor697:
	BSF         PORTC+0, 3 
L__StartMotor698:
;FirmV_0_7_0.c,1669 :: 		Motor2=1;
	BSF         PORTC+0, 0 
;FirmV_0_7_0.c,1670 :: 		}
L_StartMotor353:
;FirmV_0_7_0.c,1671 :: 		}
	RETURN      0
; end of _StartMotor

_StopMotor:

;FirmV_0_7_0.c,1674 :: 		void StopMotor(char Mx)
;FirmV_0_7_0.c,1676 :: 		if(Mx==1)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor354
;FirmV_0_7_0.c,1678 :: 		Motor1Start=0;
	CLRF        _Motor1Start+0 
;FirmV_0_7_0.c,1679 :: 		Motor1=0;
	BCF         PORTC+0, 1 
;FirmV_0_7_0.c,1680 :: 		}
L_StopMotor354:
;FirmV_0_7_0.c,1682 :: 		if(Mx==2)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor355
;FirmV_0_7_0.c,1684 :: 		Motor2Start=0;
	CLRF        _Motor2Start+0 
;FirmV_0_7_0.c,1685 :: 		Motor2=0;
	BCF         PORTC+0, 0 
;FirmV_0_7_0.c,1686 :: 		}
L_StopMotor355:
;FirmV_0_7_0.c,1687 :: 		}
	RETURN      0
; end of _StopMotor

_CheckTask:

;FirmV_0_7_0.c,1699 :: 		char CheckTask(char TaskCode)
;FirmV_0_7_0.c,1701 :: 		if(Events.Task1==TaskCode)
	MOVF        _Events+1, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask356
;FirmV_0_7_0.c,1702 :: 		{Events.Task1=0; return 1;}
	CLRF        _Events+1 
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_CheckTask356:
;FirmV_0_7_0.c,1704 :: 		if(Events.Task2==TaskCode)
	MOVF        _Events+2, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask357
;FirmV_0_7_0.c,1705 :: 		{Events.Task2=0; return 1;}
	CLRF        _Events+2 
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_CheckTask357:
;FirmV_0_7_0.c,1707 :: 		if(Events.Task3==TaskCode)
	MOVF        _Events+3, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask358
;FirmV_0_7_0.c,1708 :: 		{Events.Task3=0; return 1;}
	CLRF        _Events+3 
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_CheckTask358:
;FirmV_0_7_0.c,1710 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1712 :: 		}
	RETURN      0
; end of _CheckTask

_GetAutocloseTime:

;FirmV_0_7_0.c,1720 :: 		char GetAutocloseTime()
;FirmV_0_7_0.c,1724 :: 		for(i=0;i<20;i++)
	CLRF        GetAutocloseTime_i_L0+0 
L_GetAutocloseTime359:
	MOVLW       20
	SUBWF       GetAutocloseTime_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetAutocloseTime360
;FirmV_0_7_0.c,1726 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode==9))
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
	GOTO        L_GetAutocloseTime364
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
	GOTO        L_GetAutocloseTime364
L__GetAutocloseTime628:
;FirmV_0_7_0.c,1727 :: 		t=Tasks[i].Time;
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
L_GetAutocloseTime364:
;FirmV_0_7_0.c,1728 :: 		Tasks[i].Expired=1;
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
;FirmV_0_7_0.c,1724 :: 		for(i=0;i<20;i++)
	INCF        GetAutocloseTime_i_L0+0, 1 
;FirmV_0_7_0.c,1729 :: 		}
	GOTO        L_GetAutocloseTime359
L_GetAutocloseTime360:
;FirmV_0_7_0.c,1730 :: 		i=t-ms500;
	MOVF        _ms500+0, 0 
	SUBWF       GetAutocloseTime_t_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       GetAutocloseTime_i_L0+0 
;FirmV_0_7_0.c,1731 :: 		return i;
;FirmV_0_7_0.c,1732 :: 		}
	RETURN      0
; end of _GetAutocloseTime

_ClearTasks:

;FirmV_0_7_0.c,1749 :: 		void ClearTasks(char except)
;FirmV_0_7_0.c,1752 :: 		for(i=0;i<20;i++)
	CLRF        ClearTasks_i_L0+0 
L_ClearTasks365:
	MOVLW       20
	SUBWF       ClearTasks_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ClearTasks366
;FirmV_0_7_0.c,1753 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode!=except))
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
	GOTO        L_ClearTasks370
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
	GOTO        L_ClearTasks370
L__ClearTasks629:
;FirmV_0_7_0.c,1754 :: 		Tasks[i].Expired=1;
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
L_ClearTasks370:
;FirmV_0_7_0.c,1752 :: 		for(i=0;i<20;i++)
	INCF        ClearTasks_i_L0+0, 1 
;FirmV_0_7_0.c,1754 :: 		Tasks[i].Expired=1;
	GOTO        L_ClearTasks365
L_ClearTasks366:
;FirmV_0_7_0.c,1755 :: 		}
	RETURN      0
; end of _ClearTasks

_Menu0:

;FirmV_0_7_0.c,1770 :: 		void Menu0()
;FirmV_0_7_0.c,1772 :: 		memcpy(LCDLine2,"                ",16);
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
;FirmV_0_7_0.c,1774 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0371
;FirmV_0_7_0.c,1775 :: 		{memcpy(LCDLine1,"00 Learning Mode",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1776 :: 		if(LearningMode==0)memcpy(LCDLine2,"      Auto      ",16);
	MOVF        _LearningMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0372
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
L_Menu0372:
;FirmV_0_7_0.c,1777 :: 		if(LearningMode==1)memcpy(LCDLine2,"     Manual     ",16);}
	MOVF        _LearningMode+0, 0 
	XORLW       1
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
L_Menu0371:
;FirmV_0_7_0.c,1779 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0374
;FirmV_0_7_0.c,1780 :: 		{memcpy(LCDLine1,"01 D1 Open Time ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1781 :: 		charValueToStr(Door1OpenTime,LCDLine2+6);}
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0374:
;FirmV_0_7_0.c,1783 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0375
;FirmV_0_7_0.c,1784 :: 		{memcpy(LCDLine1,"02 D2 Open Time ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1785 :: 		charValueToStr(Door2OpenTime,LCDLine2+6);}
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0375:
;FirmV_0_7_0.c,1787 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0376
;FirmV_0_7_0.c,1788 :: 		{memcpy(LCDLine1,"03 D1 Close Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1789 :: 		charValueToStr(Door1CloseTime,LCDLine2+6);}
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0376:
;FirmV_0_7_0.c,1791 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0377
;FirmV_0_7_0.c,1792 :: 		{memcpy(LCDLine1,"04 D2 Close Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1793 :: 		charValueToStr(Door2CloseTime,LCDLine2+6);}
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0377:
;FirmV_0_7_0.c,1795 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0378
;FirmV_0_7_0.c,1796 :: 		{memcpy(LCDLine1,"05 Op Soft Start",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1797 :: 		charValueToStr(OpenSoftStartTime,LCDLine2+6);}
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0378:
;FirmV_0_7_0.c,1799 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0379
;FirmV_0_7_0.c,1800 :: 		{memcpy(LCDLine1,"06 Op Soft Stop ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1801 :: 		charValueToStr(OpenSoftStopTime,LCDLine2+6);}
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0379:
;FirmV_0_7_0.c,1803 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0380
;FirmV_0_7_0.c,1804 :: 		{memcpy(LCDLine1,"07 Cl Soft Start",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1805 :: 		charValueToStr(CloseSoftStartTime,LCDLine2+6);}
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0380:
;FirmV_0_7_0.c,1807 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0381
;FirmV_0_7_0.c,1808 :: 		{memcpy(LCDLine1,"08 Cl Soft Stop ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1809 :: 		charValueToStr(CloseSoftStopTime,LCDLine2+6);}
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0381:
;FirmV_0_7_0.c,1811 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0382
;FirmV_0_7_0.c,1812 :: 		{memcpy(LCDLine1,"09 Power        ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1813 :: 		bytetostr(OverloadSens,LCDLine2+6);LCDLine2[9]=' ';}
	MOVF        _OverloadSens+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
	MOVLW       32
	MOVWF       _LCDLine2+9 
L_Menu0382:
;FirmV_0_7_0.c,1815 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0383
;FirmV_0_7_0.c,1816 :: 		{memcpy(LCDLine1,"10 Interval Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1817 :: 		charValueToStr(ActionTimeDiff,LCDLine2+6);}
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0383:
;FirmV_0_7_0.c,1819 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0384
;FirmV_0_7_0.c,1820 :: 		{memcpy(LCDLine1,"11 Auto-close T ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1821 :: 		intValueToStr(AutoCloseTime,LCDLine2+4);}
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       FARG_intValueToStr+0 
	MOVF        _AutoCloseTime+1, 0 
	MOVWF       FARG_intValueToStr+1 
	MOVLW       _LCDLine2+4
	MOVWF       FARG_intValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+4)
	MOVWF       FARG_intValueToStr+1 
	CALL        _intValueToStr+0, 0
L_Menu0384:
;FirmV_0_7_0.c,1823 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0385
;FirmV_0_7_0.c,1824 :: 		{memcpy(LCDLine1,"12 Factory Reset",16);LCDUpdateFlag=1;}
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
L_Menu0385:
;FirmV_0_7_0.c,1826 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0386
;FirmV_0_7_0.c,1827 :: 		{memcpy(LCDLine1,"13 Open Photo En",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1828 :: 		if(OpenPhEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _OpenPhEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0387
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
	GOTO        L_Menu0388
L_Menu0387:
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
L_Menu0388:
L_Menu0386:
;FirmV_0_7_0.c,1830 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0389
;FirmV_0_7_0.c,1831 :: 		{memcpy(LCDLine1,"14 Limit Enable ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1832 :: 		if(LimiterEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LimiterEnable+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0390
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
	GOTO        L_Menu0391
L_Menu0390:
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
L_Menu0391:
L_Menu0389:
;FirmV_0_7_0.c,1834 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0392
;FirmV_0_7_0.c,1835 :: 		{memcpy(LCDLine1,"15 Lock Force   ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1836 :: 		if(LockForce==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0393
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
	GOTO        L_Menu0394
L_Menu0393:
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
L_Menu0394:
L_Menu0392:
;FirmV_0_7_0.c,1838 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0395
;FirmV_0_7_0.c,1839 :: 		{memcpy(LCDLine1,"16 Au-Cl Pass   ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1840 :: 		charValueToStr(CloseAfterPass,LCDLine2+6);}
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0395:
;FirmV_0_7_0.c,1842 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0396
;FirmV_0_7_0.c,1843 :: 		{memcpy(LCDLine1,"17 Save Changes ",16);LCDUpdateFlag=1;}
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
L_Menu0396:
;FirmV_0_7_0.c,1845 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0397
;FirmV_0_7_0.c,1846 :: 		{memcpy(LCDLine1,"18 Discard Exit ",16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1849 :: 		State=101;
	MOVLW       101
	MOVWF       _State+0 
;FirmV_0_7_0.c,1850 :: 		}
	RETURN      0
; end of _Menu0

_Menu1:

;FirmV_0_7_0.c,1867 :: 		void Menu1()
;FirmV_0_7_0.c,1870 :: 		if((Events.Keys.b0==1))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu1398
;FirmV_0_7_0.c,1871 :: 		{if(MenuPointer==0){MenuPointer=18;}else{MenuPointer=MenuPointer-1;}State=100;}
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1399
	MOVLW       18
	MOVWF       _MenuPointer+0 
	GOTO        L_Menu1400
L_Menu1399:
	DECF        _MenuPointer+0, 1 
L_Menu1400:
	MOVLW       100
	MOVWF       _State+0 
L_Menu1398:
;FirmV_0_7_0.c,1873 :: 		if((Events.Keys.b2==1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu1401
;FirmV_0_7_0.c,1874 :: 		{if(MenuPointer==18){MenuPointer=0;}else{MenuPointer=MenuPointer+1;}State=100;}
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu1402
	CLRF        _MenuPointer+0 
	GOTO        L_Menu1403
L_Menu1402:
	INCF        _MenuPointer+0, 1 
L_Menu1403:
	MOVLW       100
	MOVWF       _State+0 
L_Menu1401:
;FirmV_0_7_0.c,1876 :: 		if((Events.Keys.b1==1))
	BTFSS       _Events+0, 1 
	GOTO        L_Menu1404
;FirmV_0_7_0.c,1877 :: 		{State=102;}
	MOVLW       102
	MOVWF       _State+0 
L_Menu1404:
;FirmV_0_7_0.c,1880 :: 		}
	RETURN      0
; end of _Menu1

_Menu2:

;FirmV_0_7_0.c,1888 :: 		void Menu2()
;FirmV_0_7_0.c,1891 :: 		LCDFlash=1;
	MOVLW       1
	MOVWF       _LCDFlash+0 
;FirmV_0_7_0.c,1893 :: 		if(Events.Keys.b1==1)
	BTFSS       _Events+0, 1 
	GOTO        L_Menu2405
;FirmV_0_7_0.c,1895 :: 		LCDFlash=0;LCDFlashFlag=0;State=101;
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
	MOVLW       101
	MOVWF       _State+0 
;FirmV_0_7_0.c,1896 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2406
;FirmV_0_7_0.c,1898 :: 		LearnPhase=0;
	CLRF        _LearnPhase+0 
;FirmV_0_7_0.c,1899 :: 		if(LearningMode==0)
	MOVF        _LearningMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2407
;FirmV_0_7_0.c,1900 :: 		State=200;
	MOVLW       200
	MOVWF       _State+0 
L_Menu2407:
;FirmV_0_7_0.c,1901 :: 		if(LearningMode==1)
	MOVF        _LearningMode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2408
;FirmV_0_7_0.c,1902 :: 		State=201;
	MOVLW       201
	MOVWF       _State+0 
L_Menu2408:
;FirmV_0_7_0.c,1903 :: 		}
L_Menu2406:
;FirmV_0_7_0.c,1904 :: 		}
L_Menu2405:
;FirmV_0_7_0.c,1907 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2409
;FirmV_0_7_0.c,1908 :: 		{ if((Events.Keys.b0==1)&&(LearningMode>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2412
	MOVF        _LearningMode+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2412
L__Menu2661:
;FirmV_0_7_0.c,1909 :: 		{LearningMode=LearningMode-1;Menu0();State=102;}
	DECF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2412:
;FirmV_0_7_0.c,1910 :: 		if((Events.Keys.b2==1)&&(LearningMode<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2415
	MOVLW       1
	SUBWF       _LearningMode+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2415
L__Menu2660:
;FirmV_0_7_0.c,1911 :: 		{LearningMode=LearningMode+1;Menu0();State=102;}
	INCF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2415:
;FirmV_0_7_0.c,1912 :: 		}
L_Menu2409:
;FirmV_0_7_0.c,1916 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2416
;FirmV_0_7_0.c,1917 :: 		{ if((Events.Keys.b0==1)&&(Door1OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2419
	MOVF        _Door1OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2419
L__Menu2659:
;FirmV_0_7_0.c,1918 :: 		{Door1OpenTime=Door1OpenTime-1;Menu0();State=102;}
	DECF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2419:
;FirmV_0_7_0.c,1919 :: 		if((Events.Keys.b2==1)&&(Door1OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2422
	MOVLW       255
	SUBWF       _Door1OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2422
L__Menu2658:
;FirmV_0_7_0.c,1920 :: 		{Door1OpenTime=Door1OpenTime+1;Menu0();State=102;}
	INCF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2422:
;FirmV_0_7_0.c,1921 :: 		}
L_Menu2416:
;FirmV_0_7_0.c,1925 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2423
;FirmV_0_7_0.c,1926 :: 		{ if((Events.Keys.b0==1)&&(Door2OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2426
	MOVF        _Door2OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2426
L__Menu2657:
;FirmV_0_7_0.c,1927 :: 		{Door2OpenTime=Door2OpenTime-1;Menu0();State=102;}
	DECF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2426:
;FirmV_0_7_0.c,1928 :: 		if((Events.Keys.b2==1)&&(Door2OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2429
	MOVLW       255
	SUBWF       _Door2OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2429
L__Menu2656:
;FirmV_0_7_0.c,1929 :: 		{Door2OpenTime=Door2OpenTime+1;Menu0();State=102;}
	INCF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2429:
;FirmV_0_7_0.c,1930 :: 		}
L_Menu2423:
;FirmV_0_7_0.c,1933 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2430
;FirmV_0_7_0.c,1934 :: 		{ if((Events.Keys.b0==1)&&(Door1CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2433
	MOVF        _Door1CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2433
L__Menu2655:
;FirmV_0_7_0.c,1935 :: 		{Door1CloseTime=Door1CloseTime-1;Menu0();State=102;}
	DECF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2433:
;FirmV_0_7_0.c,1936 :: 		if((Events.Keys.b2==1)&&(Door1CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2436
	MOVLW       255
	SUBWF       _Door1CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2436
L__Menu2654:
;FirmV_0_7_0.c,1937 :: 		{Door1CloseTime=Door1CloseTime+1;Menu0();State=102;}
	INCF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2436:
;FirmV_0_7_0.c,1938 :: 		}
L_Menu2430:
;FirmV_0_7_0.c,1941 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2437
;FirmV_0_7_0.c,1942 :: 		{ if((Events.Keys.b0==1)&&(Door2CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2440
	MOVF        _Door2CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2440
L__Menu2653:
;FirmV_0_7_0.c,1943 :: 		{Door2CloseTime=Door2CloseTime-1;Menu0();State=102;}
	DECF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2440:
;FirmV_0_7_0.c,1944 :: 		if((Events.Keys.b2==1)&&(Door2CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2443
	MOVLW       255
	SUBWF       _Door2CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2443
L__Menu2652:
;FirmV_0_7_0.c,1945 :: 		{Door2CloseTime=Door2CloseTime+1;Menu0();State=102;}
	INCF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2443:
;FirmV_0_7_0.c,1946 :: 		}
L_Menu2437:
;FirmV_0_7_0.c,1950 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2444
;FirmV_0_7_0.c,1951 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2447
	MOVF        _OpenSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2447
L__Menu2651:
;FirmV_0_7_0.c,1952 :: 		{OpenSoftStartTime=OpenSoftStartTime-1;Menu0();State=102;}
	DECF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2447:
;FirmV_0_7_0.c,1953 :: 		if((Events.Keys.b2==1)&&(OpenSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2450
	MOVLW       255
	SUBWF       _OpenSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2450
L__Menu2650:
;FirmV_0_7_0.c,1954 :: 		{OpenSoftStartTime=OpenSoftStartTime+1;Menu0();State=102;}
	INCF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2450:
;FirmV_0_7_0.c,1955 :: 		}
L_Menu2444:
;FirmV_0_7_0.c,1958 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2451
;FirmV_0_7_0.c,1959 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2454
	MOVF        _OpenSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2454
L__Menu2649:
;FirmV_0_7_0.c,1960 :: 		{OpenSoftStopTime=OpenSoftStopTime-1;Menu0();State=102;}
	DECF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2454:
;FirmV_0_7_0.c,1961 :: 		if((Events.Keys.b2==1)&&(OpenSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2457
	MOVLW       255
	SUBWF       _OpenSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2457
L__Menu2648:
;FirmV_0_7_0.c,1962 :: 		{OpenSoftStopTime=OpenSoftStopTime+1;Menu0();State=102;}
	INCF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2457:
;FirmV_0_7_0.c,1963 :: 		}
L_Menu2451:
;FirmV_0_7_0.c,1966 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2458
;FirmV_0_7_0.c,1967 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2461
	MOVF        _CloseSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2461
L__Menu2647:
;FirmV_0_7_0.c,1968 :: 		{CloseSoftStartTime=CloseSoftStartTime-1;Menu0();State=102;}
	DECF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2461:
;FirmV_0_7_0.c,1969 :: 		if((Events.Keys.b2==1)&&(CloseSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2464
	MOVLW       255
	SUBWF       _CloseSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2464
L__Menu2646:
;FirmV_0_7_0.c,1970 :: 		{CloseSoftStartTime=CloseSoftStartTime+1;Menu0();State=102;}
	INCF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2464:
;FirmV_0_7_0.c,1971 :: 		}
L_Menu2458:
;FirmV_0_7_0.c,1974 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2465
;FirmV_0_7_0.c,1975 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2468
	MOVF        _CloseSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2468
L__Menu2645:
;FirmV_0_7_0.c,1976 :: 		{CloseSoftStopTime=CloseSoftStopTime-1;Menu0();State=102;}
	DECF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2468:
;FirmV_0_7_0.c,1977 :: 		if((Events.Keys.b2==1)&&(CloseSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2471
	MOVLW       255
	SUBWF       _CloseSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2471
L__Menu2644:
;FirmV_0_7_0.c,1978 :: 		{CloseSoftStopTime=CloseSoftStopTime+1;Menu0();State=102;}
	INCF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2471:
;FirmV_0_7_0.c,1979 :: 		}
L_Menu2465:
;FirmV_0_7_0.c,1983 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2472
;FirmV_0_7_0.c,1984 :: 		{ if((Events.Keys.b0==1)&&(OverloadSens>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2475
	MOVF        _OverloadSens+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2475
L__Menu2643:
;FirmV_0_7_0.c,1985 :: 		{OverloadSens=OverloadSens-1;Menu0();State=102;}
	DECF        _OverloadSens+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2475:
;FirmV_0_7_0.c,1986 :: 		if((Events.Keys.b2==1)&&(OverloadSens<9))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2478
	MOVLW       9
	SUBWF       _OverloadSens+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2478
L__Menu2642:
;FirmV_0_7_0.c,1987 :: 		{OverloadSens=OverloadSens+1;Menu0();State=102;}
	INCF        _OverloadSens+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2478:
;FirmV_0_7_0.c,1988 :: 		}
L_Menu2472:
;FirmV_0_7_0.c,1991 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2479
;FirmV_0_7_0.c,1992 :: 		{ if((Events.Keys.b0==1)&&(ActionTimeDiff>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2482
	MOVF        _ActionTimeDiff+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2482
L__Menu2641:
;FirmV_0_7_0.c,1993 :: 		{ActionTimeDiff=ActionTimeDiff-1;Menu0();State=102;}
	DECF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2482:
;FirmV_0_7_0.c,1994 :: 		if((Events.Keys.b2==1)&&(ActionTimeDiff<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2485
	MOVLW       255
	SUBWF       _ActionTimeDiff+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2485
L__Menu2640:
;FirmV_0_7_0.c,1995 :: 		{ActionTimeDiff=ActionTimeDiff+1;Menu0();State=102;}
	INCF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2485:
;FirmV_0_7_0.c,1996 :: 		}
L_Menu2479:
;FirmV_0_7_0.c,1999 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2486
;FirmV_0_7_0.c,2000 :: 		{ if((Events.Keys.b0==1)&&(AutoCloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2489
	MOVLW       0
	MOVWF       R0 
	MOVF        _AutoCloseTime+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu2699
	MOVF        _AutoCloseTime+0, 0 
	SUBLW       0
L__Menu2699:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2489
L__Menu2639:
;FirmV_0_7_0.c,2001 :: 		{AutoCloseTime=AutoCloseTime-1;Menu0();State=102;}
	MOVLW       1
	SUBWF       _AutoCloseTime+0, 1 
	MOVLW       0
	SUBWFB      _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2489:
;FirmV_0_7_0.c,2002 :: 		if((Events.Keys.b2==1)&&(AutoCloseTime<65000))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2492
	MOVLW       253
	SUBWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu2700
	MOVLW       232
	SUBWF       _AutoCloseTime+0, 0 
L__Menu2700:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2492
L__Menu2638:
;FirmV_0_7_0.c,2003 :: 		{AutoCloseTime=AutoCloseTime+1;Menu0();State=102;}
	INFSNZ      _AutoCloseTime+0, 1 
	INCF        _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2492:
;FirmV_0_7_0.c,2004 :: 		}
L_Menu2486:
;FirmV_0_7_0.c,2007 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2493
;FirmV_0_7_0.c,2009 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2010 :: 		memcpy(LCDLine1,"                ",16);
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
;FirmV_0_7_0.c,2011 :: 		memcpy(LCDLine2,"                ",16);
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
;FirmV_0_7_0.c,2012 :: 		LCDFlash=0; LCDFlashFlag=0;
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,2013 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2014 :: 		FactorySettings();
	CALL        _FactorySettings+0, 0
;FirmV_0_7_0.c,2015 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2016 :: 		}
L_Menu2493:
;FirmV_0_7_0.c,2019 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2494
;FirmV_0_7_0.c,2020 :: 		{ if((Events.Keys.b0==1)&&(OpenPhEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2497
	MOVF        _OpenPhEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2497
L__Menu2637:
;FirmV_0_7_0.c,2021 :: 		{OpenPhEnable=OpenPhEnable-1;Menu0();State=102;}
	DECF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2497:
;FirmV_0_7_0.c,2022 :: 		if((Events.Keys.b2==1)&&(OpenPhEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2500
	MOVLW       1
	SUBWF       _OpenPhEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2500
L__Menu2636:
;FirmV_0_7_0.c,2023 :: 		{OpenPhEnable=OpenPhEnable+1;Menu0();State=102;}
	INCF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2500:
;FirmV_0_7_0.c,2024 :: 		}
L_Menu2494:
;FirmV_0_7_0.c,2028 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2501
;FirmV_0_7_0.c,2029 :: 		{ if((Events.Keys.b0==1)&&(LimiterEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2504
	MOVF        _LimiterEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2504
L__Menu2635:
;FirmV_0_7_0.c,2030 :: 		{LimiterEnable=LimiterEnable-1;Menu0();State=102;}
	DECF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2504:
;FirmV_0_7_0.c,2031 :: 		if((Events.Keys.b2==1)&&(LimiterEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2507
	MOVLW       1
	SUBWF       _LimiterEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2507
L__Menu2634:
;FirmV_0_7_0.c,2032 :: 		{LimiterEnable=LimiterEnable+1;Menu0();State=102;}
	INCF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2507:
;FirmV_0_7_0.c,2033 :: 		}
L_Menu2501:
;FirmV_0_7_0.c,2036 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2508
;FirmV_0_7_0.c,2037 :: 		{ if((Events.Keys.b0==1)&&(LockForce>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2511
	MOVF        _LockForce+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2511
L__Menu2633:
;FirmV_0_7_0.c,2038 :: 		{LockForce=LockForce-1;Menu0();State=102;}
	DECF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2511:
;FirmV_0_7_0.c,2039 :: 		if((Events.Keys.b2==1)&&(LockForce<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2514
	MOVLW       1
	SUBWF       _LockForce+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2514
L__Menu2632:
;FirmV_0_7_0.c,2040 :: 		{LockForce=LockForce+1;Menu0();State=102;}
	INCF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2514:
;FirmV_0_7_0.c,2041 :: 		}
L_Menu2508:
;FirmV_0_7_0.c,2044 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2515
;FirmV_0_7_0.c,2045 :: 		{ if((Events.Keys.b0==1)&&(CloseAfterPass>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2518
	MOVF        _CloseAfterPass+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2518
L__Menu2631:
;FirmV_0_7_0.c,2046 :: 		{CloseAfterPass=CloseAfterPass-1;if(CloseAfterPass==9) CloseAfterPass=0;Menu0();State=102;}
	DECF        _CloseAfterPass+0, 1 
	MOVF        _CloseAfterPass+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2519
	CLRF        _CloseAfterPass+0 
L_Menu2519:
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2518:
;FirmV_0_7_0.c,2047 :: 		if((Events.Keys.b2==1)&&(CloseAfterPass<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2522
	MOVLW       255
	SUBWF       _CloseAfterPass+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2522
L__Menu2630:
;FirmV_0_7_0.c,2048 :: 		{CloseAfterPass=CloseAfterPass+1;if(CloseAfterPass==1) CloseAfterPass=10;Menu0();State=102;}
	INCF        _CloseAfterPass+0, 1 
	MOVF        _CloseAfterPass+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2523
	MOVLW       10
	MOVWF       _CloseAfterPass+0 
L_Menu2523:
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2522:
;FirmV_0_7_0.c,2049 :: 		}
L_Menu2515:
;FirmV_0_7_0.c,2052 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2524
;FirmV_0_7_0.c,2054 :: 		State=103;
	MOVLW       103
	MOVWF       _State+0 
;FirmV_0_7_0.c,2055 :: 		memcpy(LCDLine1,"                ",16);
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
;FirmV_0_7_0.c,2056 :: 		memcpy(LCDLine2,"                ",16);
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
;FirmV_0_7_0.c,2057 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2058 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2059 :: 		}
L_Menu2524:
;FirmV_0_7_0.c,2062 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2525
;FirmV_0_7_0.c,2064 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2065 :: 		memcpy(LCDLine1,"                ",16);
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
;FirmV_0_7_0.c,2066 :: 		memcpy(LCDLine2,"                ",16);
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
;FirmV_0_7_0.c,2067 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2068 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2069 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,2070 :: 		}
L_Menu2525:
;FirmV_0_7_0.c,2071 :: 		}
	RETURN      0
; end of _Menu2

_Menu3:

;FirmV_0_7_0.c,2083 :: 		void Menu3()
;FirmV_0_7_0.c,2085 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2086 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2087 :: 		}
	RETURN      0
; end of _Menu3

_LearnAuto:

;FirmV_0_7_0.c,2101 :: 		void LearnAuto()
;FirmV_0_7_0.c,2106 :: 		switch(LearnPhase)
	GOTO        L_LearnAuto526
;FirmV_0_7_0.c,2108 :: 		case 0: //Start D2 and enable overload sensing after 1s
L_LearnAuto528:
;FirmV_0_7_0.c,2109 :: 		StartMotor(2,_Close);AddTask(ms500+2,21);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2110 :: 		break;
	GOTO        L_LearnAuto527
;FirmV_0_7_0.c,2112 :: 		case 1: //Check if D2 reaches end of its course
L_LearnAuto529:
;FirmV_0_7_0.c,2113 :: 		if(Events.Overload.b1==1){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 1 
	GOTO        L_LearnAuto530
	CLRF        _OverloadCheckFlag2+0 
	MOVLW       2
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnAuto530:
;FirmV_0_7_0.c,2114 :: 		if(CheckTask(21))OverloadCheckFlag2=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto531
	MOVLW       1
	MOVWF       _OverloadCheckFlag2+0 
L_LearnAuto531:
;FirmV_0_7_0.c,2115 :: 		break;
	GOTO        L_LearnAuto527
;FirmV_0_7_0.c,2117 :: 		case 2: //Start D1 and enable overload sensin after 1 s
L_LearnAuto532:
;FirmV_0_7_0.c,2118 :: 		StartMotor(1,_Close);AddTask(ms500+2,20);LearnPhase=LearnPhase+1;;
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
;FirmV_0_7_0.c,2120 :: 		case 3: //Check if D1 reaches end of its course
L_LearnAuto533:
;FirmV_0_7_0.c,2121 :: 		if(Events.Overload.b0==1){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto534
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
L_LearnAuto534:
;FirmV_0_7_0.c,2122 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto535
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto535:
;FirmV_0_7_0.c,2123 :: 		break;
	GOTO        L_LearnAuto527
;FirmV_0_7_0.c,2125 :: 		case 4: //Start D1 for opening and save start time and enable overload sensing after 1s
L_LearnAuto536:
;FirmV_0_7_0.c,2126 :: 		startT=ms500;StartMotor(1,_Open);AddTask(ms500+2,20);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2127 :: 		break;
	GOTO        L_LearnAuto527
;FirmV_0_7_0.c,2129 :: 		case 5: //Check if D1 reaches end of its course and save the stop time
L_LearnAuto537:
;FirmV_0_7_0.c,2130 :: 		if(Events.Overload.b0==1){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D1OpenTime=(char)(stopT-startT);}
	BTFSS       _Events+5, 0 
	GOTO        L_LearnAuto538
	CLRF        _OverloadCheckFlag1+0 
	MOVLW       1
	MOVWF       FARG_StopMotor_Mx+0 
	CALL        _StopMotor+0, 0
	INCF        _LearnPhase+0, 1 
	MOVF        LearnAuto_startT_L0+0, 0 
	SUBWF       _ms500+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       LearnAuto_RawData_L0+1 
L_LearnAuto538:
;FirmV_0_7_0.c,2131 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto539
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto539:
;FirmV_0_7_0.c,2132 :: 		break;
	GOTO        L_LearnAuto527
;FirmV_0_7_0.c,2134 :: 		case 6: //Start D2 for opening and save start time and enable overload sensing after 1s
L_LearnAuto540:
;FirmV_0_7_0.c,2135 :: 		startT=ms500;StartMotor(2,_Open);AddTask(ms500+2,21);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2136 :: 		break;
	GOTO        L_LearnAuto527
;FirmV_0_7_0.c,2138 :: 		case 7: //Check if D2 reaches end of its course and save the stop time
L_LearnAuto541:
;FirmV_0_7_0.c,2139 :: 		if(Events.Overload.b1==1){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D2OpenTime=(char)(stopT-startT);}
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
;FirmV_0_7_0.c,2140 :: 		if(CheckTask(21))OverloadCheckFlag1=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto543
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto543:
;FirmV_0_7_0.c,2141 :: 		break;
	GOTO        L_LearnAuto527
;FirmV_0_7_0.c,2143 :: 		case 8: //Start D2 for closing and save start time and enable overload sensing after 1s
L_LearnAuto544:
;FirmV_0_7_0.c,2144 :: 		startT=ms500;StartMotor(2,_Close);AddTask(ms500+2,21);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2145 :: 		break;
	GOTO        L_LearnAuto527
;FirmV_0_7_0.c,2147 :: 		case 9: //Check if D2 reaches end of its course and save the stop time
L_LearnAuto545:
;FirmV_0_7_0.c,2148 :: 		if(Events.Overload.b1==1){OverloadCheckFlag2=0;StopMotor(2);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D2CloseTime=(char)(stopT-startT);}
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
;FirmV_0_7_0.c,2149 :: 		if(CheckTask(21))OverloadCheckFlag1=1;
	MOVLW       21
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto547
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto547:
;FirmV_0_7_0.c,2150 :: 		break;
	GOTO        L_LearnAuto527
;FirmV_0_7_0.c,2152 :: 		case 10: //Start D1 for closing and save start time and enable overload sensing after 1s
L_LearnAuto548:
;FirmV_0_7_0.c,2153 :: 		startT=ms500;StartMotor(1,_Close);AddTask(ms500+2,20);LearnPhase=LearnPhase+1;
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
;FirmV_0_7_0.c,2154 :: 		break;
	GOTO        L_LearnAuto527
;FirmV_0_7_0.c,2156 :: 		case 11: //Check if D1 reaches end of its course and save the stop time
L_LearnAuto549:
;FirmV_0_7_0.c,2157 :: 		if(Events.Overload.b0==1){OverloadCheckFlag1=0;StopMotor(1);LearnPhase=LearnPhase+1;stopT=ms500;RawData.D1CloseTime=(char)(stopT-startT);}
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
;FirmV_0_7_0.c,2158 :: 		if(CheckTask(20))OverloadCheckFlag1=1;
	MOVLW       20
	MOVWF       FARG_CheckTask_TaskCode+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto551
	MOVLW       1
	MOVWF       _OverloadCheckFlag1+0 
L_LearnAuto551:
;FirmV_0_7_0.c,2159 :: 		break;
	GOTO        L_LearnAuto527
;FirmV_0_7_0.c,2161 :: 		case 12:
L_LearnAuto552:
;FirmV_0_7_0.c,2162 :: 		AutoLearnCalculator(&RawData);
	MOVLW       LearnAuto_RawData_L0+0
	MOVWF       FARG_AutoLearnCalculator+0 
	MOVLW       hi_addr(LearnAuto_RawData_L0+0)
	MOVWF       FARG_AutoLearnCalculator+1 
	CALL        _AutoLearnCalculator+0, 0
;FirmV_0_7_0.c,2163 :: 		memcpy(LCDLine1,"Learn Complete  ",16);
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
;FirmV_0_7_0.c,2164 :: 		memcpy(LCDLine2,"     Ready      ",16);
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
;FirmV_0_7_0.c,2165 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2166 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2167 :: 		break;
	GOTO        L_LearnAuto527
;FirmV_0_7_0.c,2170 :: 		}
L_LearnAuto526:
	MOVF        _LearnPhase+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto528
	MOVF        _LearnPhase+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto529
	MOVF        _LearnPhase+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto532
	MOVF        _LearnPhase+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto533
	MOVF        _LearnPhase+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto536
	MOVF        _LearnPhase+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto537
	MOVF        _LearnPhase+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto540
	MOVF        _LearnPhase+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto541
	MOVF        _LearnPhase+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto544
	MOVF        _LearnPhase+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto545
	MOVF        _LearnPhase+0, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto548
	MOVF        _LearnPhase+0, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto549
	MOVF        _LearnPhase+0, 0 
	XORLW       12
	BTFSC       STATUS+0, 2 
	GOTO        L_LearnAuto552
L_LearnAuto527:
;FirmV_0_7_0.c,2174 :: 		}
	RETURN      0
; end of _LearnAuto

_AutoLearnCalculator:

;FirmV_0_7_0.c,2194 :: 		void AutoLearnCalculator(Learn *raw)
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
;FirmV_0_7_0.c,2198 :: 		(*raw).D1CloseTime=(*raw).D1CloseTime+16;
	MOVFF       FARG_AutoLearnCalculator_raw+0, FSR0L
	MOVFF       FARG_AutoLearnCalculator_raw+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       FARG_AutoLearnCalculator_raw+0, FSR1L
	MOVFF       FARG_AutoLearnCalculator_raw+1, FSR1H
	MOVLW       16
	ADDWF       R0, 0 
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2199 :: 		(*raw).D2CloseTime=(*raw).D2CloseTime+16;
	MOVLW       2
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
;FirmV_0_7_0.c,2201 :: 		(*raw).D1OpenSoftStart=4;
	MOVLW       4
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2202 :: 		(*raw).D1CloseSoftStart=4;
	MOVLW       6
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2203 :: 		(*raw).D2OpenSoftStart=4;
	MOVLW       8
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2204 :: 		(*raw).D2CloseSoftStart=4;
	MOVLW       10
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       4
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2206 :: 		(*raw).D1OpenSoftStop=10;
	MOVLW       5
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2207 :: 		(*raw).D2OpenSoftStop=10;
	MOVLW       9
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2208 :: 		(*raw).D1CloseSoftStop=10;
	MOVLW       7
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2209 :: 		(*raw).D2CloseSoftStop=10;
	MOVLW       11
	ADDWF       FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FSR1L 
	MOVLW       0
	ADDWFC      FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FSR1H 
	MOVLW       10
	MOVWF       POSTINC1+0 
;FirmV_0_7_0.c,2211 :: 		SaveLearnData(raw);
	MOVF        FARG_AutoLearnCalculator_raw+0, 0 
	MOVWF       FARG_SaveLearnData+0 
	MOVF        FARG_AutoLearnCalculator_raw+1, 0 
	MOVWF       FARG_SaveLearnData+1 
	CALL        _SaveLearnData+0, 0
;FirmV_0_7_0.c,2213 :: 		}
	RETURN      0
; end of _AutoLearnCalculator

_SaveLearnData:

;FirmV_0_7_0.c,2225 :: 		void SaveLearnData(Learn *d)
;FirmV_0_7_0.c,2227 :: 		Door1OpenTime=(*d).D1OpenTime;
	MOVLW       1
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,2228 :: 		Door2OpenTime=(*d).D2OpenTime;
	MOVLW       3
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,2229 :: 		Door1CloseTime=(*d).D1CloseTime;
	MOVFF       FARG_SaveLearnData_d+0, FSR0L
	MOVFF       FARG_SaveLearnData_d+1, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,2230 :: 		Door2CloseTime=(*d).D2CloseTime;
	MOVLW       2
	ADDWF       FARG_SaveLearnData_d+0, 0 
	MOVWF       FSR0L 
	MOVLW       0
	ADDWFC      FARG_SaveLearnData_d+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,2232 :: 		OpenSoftStartTime=((*d).D1OpenSoftStart+(*d).D2OpenSoftStart)/2;
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
;FirmV_0_7_0.c,2233 :: 		OpenSoftStopTime=((*d).D1OpenSoftStop+(*d).D2OpenSoftStop)/2;
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
;FirmV_0_7_0.c,2234 :: 		CloseSoftStartTime=((*d).D1CloseSoftStart+(*d).D2CloseSoftStart)/2;
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
;FirmV_0_7_0.c,2235 :: 		CloseSoftStopTime=((*d).D1CloseSoftStop+(*d).D2CloseSoftStop)/2;
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
;FirmV_0_7_0.c,2237 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2238 :: 		}
	RETURN      0
; end of _SaveLearnData

_LearnManual:

;FirmV_0_7_0.c,2253 :: 		void LearnManual()
;FirmV_0_7_0.c,2255 :: 		}
	RETURN      0
; end of _LearnManual

_charValueToStr:

;FirmV_0_7_0.c,2263 :: 		void charValueToStr(char val, char * string)
;FirmV_0_7_0.c,2265 :: 		bytetostr(val>>1,string);
	MOVF        FARG_charValueToStr_val+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	RRCF        FARG_ByteToStr_input+0, 1 
	BCF         FARG_ByteToStr_input+0, 7 
	MOVF        FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_ByteToStr_output+0 
	MOVF        FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,2266 :: 		if((val%2)==1)
	MOVLW       1
	ANDWF       FARG_charValueToStr_val+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_charValueToStr553
;FirmV_0_7_0.c,2267 :: 		memcpy(string+3,".5s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       46
	MOVWF       ?lstr105_FirmV_0_7_0+0 
	MOVLW       53
	MOVWF       ?lstr105_FirmV_0_7_0+1 
	MOVLW       115
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
	GOTO        L_charValueToStr554
L_charValueToStr553:
;FirmV_0_7_0.c,2269 :: 		memcpy(string+3,"s  ",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       115
	MOVWF       ?lstr106_FirmV_0_7_0+0 
	MOVLW       32
	MOVWF       ?lstr106_FirmV_0_7_0+1 
	MOVLW       32
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
L_charValueToStr554:
;FirmV_0_7_0.c,2270 :: 		}
	RETURN      0
; end of _charValueToStr

_intValueToStr:

;FirmV_0_7_0.c,2283 :: 		void intValueToStr(unsigned val, char * string)
;FirmV_0_7_0.c,2285 :: 		wordtostr(val>>1,string);
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
;FirmV_0_7_0.c,2286 :: 		if((val%2)==1)
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
	GOTO        L__intValueToStr701
	MOVLW       1
	XORWF       R1, 0 
L__intValueToStr701:
	BTFSS       STATUS+0, 2 
	GOTO        L_intValueToStr555
;FirmV_0_7_0.c,2287 :: 		memcpy(string+5,".5s",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
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
	GOTO        L_intValueToStr556
L_intValueToStr555:
;FirmV_0_7_0.c,2289 :: 		memcpy(string+5,"s  ",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
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
L_intValueToStr556:
;FirmV_0_7_0.c,2290 :: 		}
	RETURN      0
; end of _intValueToStr

_SetOverloadParams:

;FirmV_0_7_0.c,2302 :: 		void SetOverloadParams(char p)
;FirmV_0_7_0.c,2305 :: 		switch(p)
	GOTO        L_SetOverloadParams557
;FirmV_0_7_0.c,2307 :: 		case 0: OverloadTreshold=0;OverloadDuration=255; break;
L_SetOverloadParams559:
	CLRF        _OverloadTreshold+0 
	CLRF        _OverloadTreshold+1 
	MOVLW       255
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams558
;FirmV_0_7_0.c,2309 :: 		case 1: OverloadTreshold=400;OverloadDuration=200; break;
L_SetOverloadParams560:
	MOVLW       144
	MOVWF       _OverloadTreshold+0 
	MOVLW       1
	MOVWF       _OverloadTreshold+1 
	MOVLW       200
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams558
;FirmV_0_7_0.c,2311 :: 		case 2: OverloadTreshold=450;OverloadDuration=150; break;
L_SetOverloadParams561:
	MOVLW       194
	MOVWF       _OverloadTreshold+0 
	MOVLW       1
	MOVWF       _OverloadTreshold+1 
	MOVLW       150
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams558
;FirmV_0_7_0.c,2313 :: 		case 3: OverloadTreshold=500;OverloadDuration=100; break;
L_SetOverloadParams562:
	MOVLW       244
	MOVWF       _OverloadTreshold+0 
	MOVLW       1
	MOVWF       _OverloadTreshold+1 
	MOVLW       100
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams558
;FirmV_0_7_0.c,2315 :: 		case 4: OverloadTreshold=550;OverloadDuration=80; break;
L_SetOverloadParams563:
	MOVLW       38
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       80
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams558
;FirmV_0_7_0.c,2317 :: 		case 5: OverloadTreshold=600;OverloadDuration=150; break;
L_SetOverloadParams564:
	MOVLW       88
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       150
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams558
;FirmV_0_7_0.c,2319 :: 		case 6: OverloadTreshold=600;OverloadDuration=100; break;
L_SetOverloadParams565:
	MOVLW       88
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       100
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams558
;FirmV_0_7_0.c,2321 :: 		case 7: OverloadTreshold=600;OverloadDuration=50; break;
L_SetOverloadParams566:
	MOVLW       88
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       50
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams558
;FirmV_0_7_0.c,2323 :: 		case 8: OverloadTreshold=700;OverloadDuration=100; break;
L_SetOverloadParams567:
	MOVLW       188
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       100
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams558
;FirmV_0_7_0.c,2325 :: 		case 9: OverloadTreshold=700;OverloadDuration=50; break;
L_SetOverloadParams568:
	MOVLW       188
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       50
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams558
;FirmV_0_7_0.c,2327 :: 		}
L_SetOverloadParams557:
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams559
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams560
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams561
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams562
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams563
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams564
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams565
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams566
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams567
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams568
L_SetOverloadParams558:
;FirmV_0_7_0.c,2328 :: 		}
	RETURN      0
; end of _SetOverloadParams
