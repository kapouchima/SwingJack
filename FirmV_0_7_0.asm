
_interrupt:

;FirmV_0_7_0.c,191 :: 		void interrupt()
;FirmV_0_7_0.c,193 :: 		if(TMR0IF_bit)
	BTFSS       TMR0IF_bit+0, 2 
	GOTO        L_interrupt0
;FirmV_0_7_0.c,195 :: 		msCounter=msCounter+1;
	INCF        _msCounter+0, 1 
;FirmV_0_7_0.c,196 :: 		LCDBackLight=1;
	BSF         PORTB+0, 3 
;FirmV_0_7_0.c,197 :: 		Flag20ms=1;
	MOVLW       1
	MOVWF       _Flag20ms+0 
;FirmV_0_7_0.c,198 :: 		if(ms20A==255)
	MOVF        _ms20A+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt1
;FirmV_0_7_0.c,199 :: 		{ms20A=0;RemotePulse1=0;}
	CLRF        _ms20A+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt2
L_interrupt1:
;FirmV_0_7_0.c,201 :: 		ms20A=ms20A+1;
	INCF        _ms20A+0, 1 
L_interrupt2:
;FirmV_0_7_0.c,203 :: 		if(ms20B==255)
	MOVF        _ms20B+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt3
;FirmV_0_7_0.c,204 :: 		{ms20B=0;RemotePulse2=0;}
	CLRF        _ms20B+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt4
L_interrupt3:
;FirmV_0_7_0.c,206 :: 		ms20B=ms20B+1;
	INCF        _ms20B+0, 1 
L_interrupt4:
;FirmV_0_7_0.c,208 :: 		if(msCounter>=25)
	MOVLW       25
	SUBWF       _msCounter+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt5
;FirmV_0_7_0.c,210 :: 		msCounter=0;
	CLRF        _msCounter+0 
;FirmV_0_7_0.c,211 :: 		ms500=ms500+1;
	MOVLW       1
	ADDWF       _ms500+0, 1 
	MOVLW       0
	ADDWFC      _ms500+1, 1 
	ADDWFC      _ms500+2, 1 
	ADDWFC      _ms500+3, 1 
;FirmV_0_7_0.c,212 :: 		LCDFlashFlag=!LCDFlashFlag;
	MOVF        _LCDFlashFlag+0, 1 
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       _LCDFlashFlag+0 
;FirmV_0_7_0.c,213 :: 		LCDBackLight=0;
	BCF         PORTB+0, 3 
;FirmV_0_7_0.c,214 :: 		Flag500ms=1;
	MOVLW       1
	MOVWF       _Flag500ms+0 
;FirmV_0_7_0.c,215 :: 		}
L_interrupt5:
;FirmV_0_7_0.c,216 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,217 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,218 :: 		TMR0IF_bit=0;
	BCF         TMR0IF_bit+0, 2 
;FirmV_0_7_0.c,219 :: 		}
L_interrupt0:
;FirmV_0_7_0.c,222 :: 		if(INT1F_bit)
	BTFSS       INT1F_bit+0, 0 
	GOTO        L_interrupt6
;FirmV_0_7_0.c,224 :: 		if(RemotePulse1==0)
	MOVF        _RemotePulse1+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt7
;FirmV_0_7_0.c,225 :: 		{ RemotePulse1=RemotePulse1+1;ms20A=0;}
	INCF        _RemotePulse1+0, 1 
	CLRF        _ms20A+0 
	GOTO        L_interrupt8
L_interrupt7:
;FirmV_0_7_0.c,227 :: 		{ RemotePulse1=RemotePulse1+1;}
	INCF        _RemotePulse1+0, 1 
L_interrupt8:
;FirmV_0_7_0.c,228 :: 		if(RemotePulse1>=5)
	MOVLW       5
	SUBWF       _RemotePulse1+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt9
;FirmV_0_7_0.c,229 :: 		if((ms20A>=19)&&(ms20A<=21))
	MOVLW       19
	SUBWF       _ms20A+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
	MOVF        _ms20A+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt12
L__interrupt543:
;FirmV_0_7_0.c,230 :: 		{RemoteAFlag=1;RemotePulse1=0;}
	MOVLW       1
	MOVWF       _RemoteAFlag+0 
	CLRF        _RemotePulse1+0 
	GOTO        L_interrupt13
L_interrupt12:
;FirmV_0_7_0.c,232 :: 		RemotePulse1=0;
	CLRF        _RemotePulse1+0 
L_interrupt13:
L_interrupt9:
;FirmV_0_7_0.c,233 :: 		INT1IF_bit=0;
	BCF         INT1IF_bit+0, 0 
;FirmV_0_7_0.c,234 :: 		}
L_interrupt6:
;FirmV_0_7_0.c,238 :: 		if(INT2IF_bit)
	BTFSS       INT2IF_bit+0, 1 
	GOTO        L_interrupt14
;FirmV_0_7_0.c,240 :: 		if(RemotePulse2==0)
	MOVF        _RemotePulse2+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt15
;FirmV_0_7_0.c,241 :: 		{ RemotePulse2=RemotePulse2+1;ms20B=0;}
	INCF        _RemotePulse2+0, 1 
	CLRF        _ms20B+0 
	GOTO        L_interrupt16
L_interrupt15:
;FirmV_0_7_0.c,243 :: 		{ RemotePulse2=RemotePulse2+1;}
	INCF        _RemotePulse2+0, 1 
L_interrupt16:
;FirmV_0_7_0.c,244 :: 		if(RemotePulse2>=5)
	MOVLW       5
	SUBWF       _RemotePulse2+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt17
;FirmV_0_7_0.c,245 :: 		if((ms20B>=19)&&(ms20B<=21))
	MOVLW       19
	SUBWF       _ms20B+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
	MOVF        _ms20B+0, 0 
	SUBLW       21
	BTFSS       STATUS+0, 0 
	GOTO        L_interrupt20
L__interrupt542:
;FirmV_0_7_0.c,246 :: 		{RemoteBFlag=1;RemotePulse2=0;}
	MOVLW       1
	MOVWF       _RemoteBFlag+0 
	CLRF        _RemotePulse2+0 
	GOTO        L_interrupt21
L_interrupt20:
;FirmV_0_7_0.c,248 :: 		RemotePulse2=0;
	CLRF        _RemotePulse2+0 
L_interrupt21:
L_interrupt17:
;FirmV_0_7_0.c,249 :: 		INT2IF_bit=0;
	BCF         INT2IF_bit+0, 1 
;FirmV_0_7_0.c,250 :: 		}
L_interrupt14:
;FirmV_0_7_0.c,255 :: 		if(INT0F_bit==1)
	BTFSS       INT0F_bit+0, 1 
	GOTO        L_interrupt22
;FirmV_0_7_0.c,257 :: 		ZCCounter=ZCCounter+1;
	INCF        _ZCCounter+0, 1 
;FirmV_0_7_0.c,258 :: 		if(ZCCounter==255)
	MOVF        _ZCCounter+0, 0 
	XORLW       255
	BTFSS       STATUS+0, 2 
	GOTO        L_interrupt23
;FirmV_0_7_0.c,259 :: 		ZCCounter=0;
	CLRF        _ZCCounter+0 
L_interrupt23:
;FirmV_0_7_0.c,260 :: 		if(ZCCounter%3==1)
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
;FirmV_0_7_0.c,262 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt25
;FirmV_0_7_0.c,263 :: 		if(Motor1FullSpeed)
	MOVF        _Motor1FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt26
;FirmV_0_7_0.c,264 :: 		Motor1=1;
	BSF         PORTC+0, 1 
	GOTO        L_interrupt27
L_interrupt26:
;FirmV_0_7_0.c,266 :: 		Motor1=0;
	BCF         PORTC+0, 1 
L_interrupt27:
L_interrupt25:
;FirmV_0_7_0.c,268 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt28
;FirmV_0_7_0.c,269 :: 		if(Motor2FullSpeed)
	MOVF        _Motor2FullSpeed+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt29
;FirmV_0_7_0.c,270 :: 		Motor2=1;
	BSF         PORTC+0, 0 
	GOTO        L_interrupt30
L_interrupt29:
;FirmV_0_7_0.c,272 :: 		Motor2=0;
	BCF         PORTC+0, 0 
L_interrupt30:
L_interrupt28:
;FirmV_0_7_0.c,273 :: 		}
L_interrupt24:
;FirmV_0_7_0.c,274 :: 		if(ZCCounter%3==0)
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
;FirmV_0_7_0.c,276 :: 		if(Motor1Start)
	MOVF        _Motor1Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt32
;FirmV_0_7_0.c,277 :: 		Motor1=1;
	BSF         PORTC+0, 1 
L_interrupt32:
;FirmV_0_7_0.c,279 :: 		if(Motor2Start)
	MOVF        _Motor2Start+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_interrupt33
;FirmV_0_7_0.c,280 :: 		Motor2=1;
	BSF         PORTC+0, 0 
L_interrupt33:
;FirmV_0_7_0.c,281 :: 		}
L_interrupt31:
;FirmV_0_7_0.c,282 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, 1 
;FirmV_0_7_0.c,283 :: 		}
L_interrupt22:
;FirmV_0_7_0.c,284 :: 		}
L__interrupt635:
	RETFIE      1
; end of _interrupt

_ResetTaskEvents:

;FirmV_0_7_0.c,297 :: 		void ResetTaskEvents()
;FirmV_0_7_0.c,299 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,300 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,301 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,302 :: 		}
	RETURN      0
; end of _ResetTaskEvents

_Logger:

;FirmV_0_7_0.c,314 :: 		void Logger(char* text)
;FirmV_0_7_0.c,317 :: 		longwordtostrwithzeros(ms500,time);
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
;FirmV_0_7_0.c,318 :: 		uart_write_text(time);
	MOVLW       Logger_time_L0+0
	MOVWF       FARG_UART_Write_Text_uart_text+0 
	MOVLW       hi_addr(Logger_time_L0+0)
	MOVWF       FARG_UART_Write_Text_uart_text+1 
	CALL        _UART_Write_Text+0, 0
;FirmV_0_7_0.c,319 :: 		uart1_write_text(": ");
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
;FirmV_0_7_0.c,320 :: 		uart1_write_text(text);
	MOVF        FARG_Logger_text+0, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVF        FARG_Logger_text+1, 0 
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;FirmV_0_7_0.c,321 :: 		uart1_write(10);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,322 :: 		uart1_write(13);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;FirmV_0_7_0.c,323 :: 		}
	RETURN      0
; end of _Logger

_main:

;FirmV_0_7_0.c,340 :: 		void main() {
;FirmV_0_7_0.c,342 :: 		PhotocellRel=1;
	BSF         PORTC+0, 5 
;FirmV_0_7_0.c,344 :: 		Init();
	CALL        _Init+0, 0
;FirmV_0_7_0.c,346 :: 		Logger("Start ...");
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
;FirmV_0_7_0.c,350 :: 		while(1)
L_main34:
;FirmV_0_7_0.c,352 :: 		if(Flag20ms==1)
	MOVF        _Flag20ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main36
;FirmV_0_7_0.c,354 :: 		if(DebouncingDelay<DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelay+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main37
;FirmV_0_7_0.c,355 :: 		DebouncingDelay=DebouncingDelay+1;
	INCF        _DebouncingDelay+0, 1 
L_main37:
;FirmV_0_7_0.c,356 :: 		LCDUpdater();
	CALL        _LCDUpdater+0, 0
;FirmV_0_7_0.c,357 :: 		Flag20ms=0;
	CLRF        _Flag20ms+0 
;FirmV_0_7_0.c,358 :: 		}
L_main36:
;FirmV_0_7_0.c,360 :: 		if(Flag500ms==1)
	MOVF        _Flag500ms+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main38
;FirmV_0_7_0.c,362 :: 		ResetTaskEvents();
	CALL        _ResetTaskEvents+0, 0
;FirmV_0_7_0.c,363 :: 		TaskManager();
	CALL        _TaskManager+0, 0
;FirmV_0_7_0.c,364 :: 		Flag500ms=0;
	CLRF        _Flag500ms+0 
;FirmV_0_7_0.c,365 :: 		}
L_main38:
;FirmV_0_7_0.c,366 :: 		EventHandler();
	CALL        _EventHandler+0, 0
;FirmV_0_7_0.c,367 :: 		StateManager();
	CALL        _StateManager+0, 0
;FirmV_0_7_0.c,368 :: 		}
	GOTO        L_main34
;FirmV_0_7_0.c,370 :: 		}
	GOTO        $+0
; end of _main

_StateManager:

;FirmV_0_7_0.c,395 :: 		void StateManager()
;FirmV_0_7_0.c,401 :: 		switch(State)
	GOTO        L_StateManager39
;FirmV_0_7_0.c,404 :: 		case 0: State1(); break;
L_StateManager41:
	CALL        _State1+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,406 :: 		case 1: State1(); break;
L_StateManager42:
	CALL        _State1+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,408 :: 		case 2: State2(); break;
L_StateManager43:
	CALL        _State2+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,410 :: 		case 3: State3(); break;
L_StateManager44:
	CALL        _State3+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,412 :: 		case 4: State4(); break;
L_StateManager45:
	CALL        _State4+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,414 :: 		case 5: State5(); break;
L_StateManager46:
	CALL        _State5+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,416 :: 		case 6: State6(); break;
L_StateManager47:
	CALL        _State6+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,418 :: 		case 7: State7(); break;
L_StateManager48:
	CALL        _State7+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,420 :: 		case 8: State8(); break;
L_StateManager49:
	CALL        _State8+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,422 :: 		case 10:State00(); break;
L_StateManager50:
	CALL        _State00+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,424 :: 		case 100:Menu0(); break;
L_StateManager51:
	CALL        _Menu0+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,426 :: 		case 101:Menu1(); break;
L_StateManager52:
	CALL        _Menu1+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,428 :: 		case 102:Menu2(); break;
L_StateManager53:
	CALL        _Menu2+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,430 :: 		case 103:Menu3(); break;
L_StateManager54:
	CALL        _Menu3+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,432 :: 		case 200:LearnAuto(); break;
L_StateManager55:
	CALL        _LearnAuto+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,434 :: 		case 201:LearnManual(); break;
L_StateManager56:
	CALL        _LearnManual+0, 0
	GOTO        L_StateManager40
;FirmV_0_7_0.c,436 :: 		}
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
;FirmV_0_7_0.c,437 :: 		}
	RETURN      0
; end of _StateManager

_StateTest:

;FirmV_0_7_0.c,441 :: 		void StateTest()
;FirmV_0_7_0.c,443 :: 		if (Events.Photocell==1)
	MOVF        _Events+6, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StateTest57
;FirmV_0_7_0.c,444 :: 		LCDLine1[0]='1';
	MOVLW       49
	MOVWF       _LCDLine1+0 
	GOTO        L_StateTest58
L_StateTest57:
;FirmV_0_7_0.c,446 :: 		LCDLine1[0]='0';
	MOVLW       48
	MOVWF       _LCDLine1+0 
L_StateTest58:
;FirmV_0_7_0.c,448 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,450 :: 		}
	RETURN      0
; end of _StateTest

_State00:

;FirmV_0_7_0.c,454 :: 		void State00()
;FirmV_0_7_0.c,459 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,460 :: 		StartMotor(1,_Close);
	MOVLW       1
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,461 :: 		StartMotor(2,_Close);
	MOVLW       2
	MOVWF       FARG_StartMotor+0 
	CLRF        FARG_StartMotor+0 
	CALL        _StartMotor+0, 0
;FirmV_0_7_0.c,465 :: 		if(Events.Remote.b0==1)
	BTFSS       _Events+4, 0 
	GOTO        L_State0059
;FirmV_0_7_0.c,466 :: 		{Flasher=0;StopMotor(1);StopMotor(2);
	BCF         PORTC+0, 2 
	MOVLW       1
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
	MOVLW       2
	MOVWF       FARG_StopMotor+0 
	CALL        _StopMotor+0, 0
;FirmV_0_7_0.c,467 :: 		State=1;                }
	MOVLW       1
	MOVWF       _State+0 
L_State0059:
;FirmV_0_7_0.c,468 :: 		}
	RETURN      0
; end of _State00

_State1:

;FirmV_0_7_0.c,477 :: 		void State1()
;FirmV_0_7_0.c,479 :: 		char delay=3;
	MOVLW       3
	MOVWF       State1_delay_L0+0 
;FirmV_0_7_0.c,482 :: 		Flasher=0;
	BCF         PORTC+0, 2 
;FirmV_0_7_0.c,484 :: 		if(Events.Keys==2)
	MOVF        _Events+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State160
;FirmV_0_7_0.c,485 :: 		{State=100;MenuPointer=0;}
	MOVLW       100
	MOVWF       _State+0 
	CLRF        _MenuPointer+0 
L_State160:
;FirmV_0_7_0.c,487 :: 		ActiveDoors=3-Events.Remote;
	MOVF        _Events+4, 0 
	SUBLW       3
	MOVWF       _ActiveDoors+0 
;FirmV_0_7_0.c,491 :: 		if(Events.Remote!=0)
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State161
;FirmV_0_7_0.c,494 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,495 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,496 :: 		AddTask(ms500+1,12);
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
;FirmV_0_7_0.c,497 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,498 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,499 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State162
;FirmV_0_7_0.c,500 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
;FirmV_0_7_0.c,502 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
;FirmV_0_7_0.c,503 :: 		temp=ms500+OpenSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,504 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,505 :: 		temp=ms500+OpenSoftStartTime+delay;
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
;FirmV_0_7_0.c,506 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,507 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State164
;FirmV_0_7_0.c,508 :: 		{temp=ms500+Door1OpenTime-OpenSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
;FirmV_0_7_0.c,509 :: 		temp=ms500+Door1OpenTime+delay;
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
;FirmV_0_7_0.c,510 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,512 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State167
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State167
L__State1544:
;FirmV_0_7_0.c,514 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,515 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,516 :: 		if(OpenSoftStartTime!=0)
	MOVF        _OpenSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State168
;FirmV_0_7_0.c,517 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,8); M2isSlow=1;}//speed down
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
;FirmV_0_7_0.c,519 :: 		{temp=ms500+ActionTimeDiff+delay;AddTask(temp,6); M2isSlow=0;}//speed up
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
;FirmV_0_7_0.c,520 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,521 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,522 :: 		temp=ms500+ActionTimeDiff+OpenSoftStartTime+delay;
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
;FirmV_0_7_0.c,523 :: 		AddTask(temp,6);//Speed up after soft start
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
;FirmV_0_7_0.c,524 :: 		if(OpenSoftStopTime!=0)
	MOVF        _OpenSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State170
;FirmV_0_7_0.c,525 :: 		{temp=ms500+ActionTimeDiff+Door2OpenTime-OpenSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
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
;FirmV_0_7_0.c,526 :: 		temp=ms500+Door2OpenTime+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,527 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,528 :: 		}
L_State167:
;FirmV_0_7_0.c,530 :: 		if(AutoCloseTime!=0)
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State1636
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State1636:
	BTFSC       STATUS+0, 2 
	GOTO        L_State171
;FirmV_0_7_0.c,531 :: 		{temp=ms500+AutoCloseTime+delay;AddTask(ms500+AutoCloseTime+delay,9);}
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
;FirmV_0_7_0.c,533 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,534 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,535 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,536 :: 		State=3;
	MOVLW       3
	MOVWF       _State+0 
;FirmV_0_7_0.c,537 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,538 :: 		}
L_State161:
;FirmV_0_7_0.c,539 :: 		}
	RETURN      0
; end of _State1

_State2:

;FirmV_0_7_0.c,553 :: 		void State2()
;FirmV_0_7_0.c,555 :: 		char delay=2;
	MOVLW       2
	MOVWF       State2_delay_L0+0 
;FirmV_0_7_0.c,557 :: 		Flasher=0;
	BCF         PORTC+0, 2 
;FirmV_0_7_0.c,559 :: 		if((Events.Remote!=0)||(CheckTask(9)==1))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State2549
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State2549
	GOTO        L_State274
L__State2549:
;FirmV_0_7_0.c,562 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,563 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State2548
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State2548
	GOTO        L_State277
L__State2548:
;FirmV_0_7_0.c,565 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,566 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,567 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State278
;FirmV_0_7_0.c,568 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
;FirmV_0_7_0.c,570 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
;FirmV_0_7_0.c,571 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,572 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,573 :: 		temp=ms500+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,574 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,575 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State280
;FirmV_0_7_0.c,576 :: 		{temp=ms500+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
;FirmV_0_7_0.c,577 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State281
;FirmV_0_7_0.c,578 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
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
;FirmV_0_7_0.c,580 :: 		{temp=ms500+Door1CloseTime+delay;AddTask(temp,3);}
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
;FirmV_0_7_0.c,582 :: 		}
L_State277:
;FirmV_0_7_0.c,584 :: 		if((Door2CloseTime!=0)&&(ActiveDoors=2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State285
	MOVLW       2
	MOVWF       _ActiveDoors+0 
L__State2547:
;FirmV_0_7_0.c,586 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,587 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,588 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State286
;FirmV_0_7_0.c,589 :: 		{AddTask(temp,8); M2isSlow=1;}//speed down
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
;FirmV_0_7_0.c,591 :: 		{AddTask(temp,6); M2isSlow=0;}//speed up
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
;FirmV_0_7_0.c,592 :: 		temp=ms500+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,593 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,594 :: 		temp=ms500+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,595 :: 		AddTask(temp,6);//Speed up after soft start
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
;FirmV_0_7_0.c,596 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State288
;FirmV_0_7_0.c,597 :: 		{temp=ms500+Door2CloseTime-CloseSoftStopTime+delay;AddTask(temp,8);}//Speed down for soft stop
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
;FirmV_0_7_0.c,599 :: 		temp=ms500+Door2CloseTime+delay;
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
;FirmV_0_7_0.c,600 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,604 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,605 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,606 :: 		if(CloseSoftStartTime!=0)
	MOVF        _CloseSoftStartTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State289
;FirmV_0_7_0.c,607 :: 		{AddTask(temp,7); M1isSlow=1;}//speed down
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
;FirmV_0_7_0.c,609 :: 		{AddTask(temp,5); M1isSlow=0;}//speed up
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
;FirmV_0_7_0.c,610 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+OverloadDelay+delay;
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
;FirmV_0_7_0.c,611 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,612 :: 		temp=ms500+ActionTimeDiff+CloseSoftStartTime+delay;
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
;FirmV_0_7_0.c,613 :: 		AddTask(temp,5);//Speed up after soft start
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
;FirmV_0_7_0.c,614 :: 		if(CloseSoftStopTime!=0)
	MOVF        _CloseSoftStopTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State291
;FirmV_0_7_0.c,615 :: 		{temp=ms500+ActionTimeDiff+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}//Speed down for soft stop
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
;FirmV_0_7_0.c,616 :: 		if(LockForce!=0)
	MOVF        _LockForce+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State292
;FirmV_0_7_0.c,617 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,5);AddTask(temp+LockForceTime,3);}
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
;FirmV_0_7_0.c,619 :: 		{temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,3);}
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
;FirmV_0_7_0.c,621 :: 		}
L_State285:
;FirmV_0_7_0.c,624 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,625 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,626 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,627 :: 		State=4;
	MOVLW       4
	MOVWF       _State+0 
;FirmV_0_7_0.c,628 :: 		}
L_State274:
;FirmV_0_7_0.c,630 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State296
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2637
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State2637:
	BTFSC       STATUS+0, 2 
	GOTO        L_State296
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State296
L__State2546:
;FirmV_0_7_0.c,631 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S2 Auto Close Deleted");}
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
;FirmV_0_7_0.c,633 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State299
	BTFSC       _Events+6, 0 
	GOTO        L_State299
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State2638
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State2638:
	BTFSC       STATUS+0, 2 
	GOTO        L_State299
L__State2545:
;FirmV_0_7_0.c,634 :: 		if(CloseAfterPass==0)
	MOVF        _CloseAfterPass+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State2100
;FirmV_0_7_0.c,635 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:");Logger(t);}
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
;FirmV_0_7_0.c,637 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:");Logger(t);}
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
;FirmV_0_7_0.c,639 :: 		}
	RETURN      0
; end of _State2

_State3:

;FirmV_0_7_0.c,654 :: 		void State3()
;FirmV_0_7_0.c,656 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,658 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3102
;FirmV_0_7_0.c,659 :: 		{StartMotor(1,_Open);Logger("S3 Motor1Start"); Lock=0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,661 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3103
;FirmV_0_7_0.c,662 :: 		{StartMotor(2,_Open);Logger("S3 Motor2Start"); Lock=0;}
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
;FirmV_0_7_0.c,664 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3104
;FirmV_0_7_0.c,665 :: 		{SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;Logger("S3 Motor1 Fast");}
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
;FirmV_0_7_0.c,667 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3105
;FirmV_0_7_0.c,668 :: 		{SetMotorSpeed(0,Motor2FullSpeed); M1isSlow=1;Logger("S3 Motor1 Slow");}
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
;FirmV_0_7_0.c,670 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3106
;FirmV_0_7_0.c,671 :: 		{SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;Logger("S3 Motor2 Fast");}
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
;FirmV_0_7_0.c,673 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3107
;FirmV_0_7_0.c,674 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S3 Motor2 Slow");}
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
;FirmV_0_7_0.c,676 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3108
;FirmV_0_7_0.c,677 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S3 Overflow Flag1 Set");}
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
;FirmV_0_7_0.c,679 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3109
;FirmV_0_7_0.c,680 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S3 Overflow Flag2 Set");}
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
;FirmV_0_7_0.c,682 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3110
;FirmV_0_7_0.c,683 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S3 Motor1 Stop");}
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
;FirmV_0_7_0.c,685 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3111
;FirmV_0_7_0.c,686 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S3 Motor2 Stop");}
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
;FirmV_0_7_0.c,688 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3112
;FirmV_0_7_0.c,689 :: 		{Lock=1;}
	BSF         PORTD+0, 7 
L_State3112:
;FirmV_0_7_0.c,691 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
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
L__State3555:
;FirmV_0_7_0.c,692 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor1 Collision");ClearTasks(9);
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
;FirmV_0_7_0.c,693 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,695 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
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
L__State3554:
;FirmV_0_7_0.c,696 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor2 Collision");ClearTasks(9);
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
;FirmV_0_7_0.c,697 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,699 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State3553
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State3553
	GOTO        L_State3121
L__State3553:
;FirmV_0_7_0.c,700 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State3121:
;FirmV_0_7_0.c,702 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State3124
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3124
L__State3552:
;FirmV_0_7_0.c,703 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Photocell Int");ClearTasks(9);
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
;FirmV_0_7_0.c,704 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,706 :: 		if(Events.Remote.b0==1)
	BTFSS       _Events+4, 0 
	GOTO        L_State3125
;FirmV_0_7_0.c,707 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Remote Stoped");ClearTasks(9);
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
;FirmV_0_7_0.c,708 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,710 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State3128
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State3128
L__State3551:
;FirmV_0_7_0.c,711 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Limit Switch Stoped");ClearTasks(9);
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
;FirmV_0_7_0.c,712 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,714 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State3129
;FirmV_0_7_0.c,715 :: 		{State=2; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_blank,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,717 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State3550
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State3550
	GOTO        L_State3132
L__State3550:
;FirmV_0_7_0.c,718 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S3 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State3639
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State3639:
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
;FirmV_0_7_0.c,720 :: 		}
	RETURN      0
; end of _State3

_State4:

;FirmV_0_7_0.c,734 :: 		void State4()
;FirmV_0_7_0.c,736 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,738 :: 		bytetostr(Events.Task1,LCDLine1);
	MOVF        _Events+1, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,739 :: 		bytetostr(Events.Task2,LCDLine2);
	MOVF        _Events+2, 0 
	MOVWF       FARG_ByteToStr_input+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_ByteToStr_output+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,740 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,742 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4134
;FirmV_0_7_0.c,743 :: 		{StartMotor(1,_Close);Logger("S4 Motor1Start");memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,745 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4135
;FirmV_0_7_0.c,746 :: 		{StartMotor(2,_Close);Logger("S4 Motor2Start");}
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
;FirmV_0_7_0.c,748 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4136
;FirmV_0_7_0.c,749 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S4 M1 Overload Check");}
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
;FirmV_0_7_0.c,751 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4137
;FirmV_0_7_0.c,752 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S4 M2 Overload Check");}
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
;FirmV_0_7_0.c,754 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4138
;FirmV_0_7_0.c,755 :: 		{SetMotorSpeed(1,Motor2FullSpeed); OverloadCheckFlag1=0; M1isSlow=0;Logger("S4 M1 Speed UP");}
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
;FirmV_0_7_0.c,757 :: 		if(CheckTask(7))
	MOVLW       7
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4139
;FirmV_0_7_0.c,758 :: 		{SetMotorSpeed(0,Motor2FullSpeed); OverloadCheckFlag2=0; M1isSlow=1;Logger("S4 M1 Speed Down");}
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
;FirmV_0_7_0.c,760 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4140
;FirmV_0_7_0.c,761 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S4 M2 Speed UP");}
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
;FirmV_0_7_0.c,763 :: 		if(CheckTask(8))
	MOVLW       8
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4141
;FirmV_0_7_0.c,764 :: 		{SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S4 M2 Speed Down");}
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
;FirmV_0_7_0.c,766 :: 		if(CheckTask(3))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4142
;FirmV_0_7_0.c,767 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S4 M1 Stoped");}
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
;FirmV_0_7_0.c,769 :: 		if(CheckTask(4))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4143
;FirmV_0_7_0.c,770 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S4 M2 Stoped");}
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
;FirmV_0_7_0.c,772 :: 		if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
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
L__State4560:
;FirmV_0_7_0.c,773 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M1 Overloaded");ClearTasks(9);
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
;FirmV_0_7_0.c,774 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,776 :: 		if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
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
L__State4559:
;FirmV_0_7_0.c,777 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M2 Overloaded");ClearTasks(9);
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
;FirmV_0_7_0.c,778 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,780 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State4558
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State4558
	GOTO        L_State4152
L__State4558:
;FirmV_0_7_0.c,781 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State4152:
;FirmV_0_7_0.c,783 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State4153
;FirmV_0_7_0.c,784 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S4 Photocell Int");ClearTasks(9);
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
;FirmV_0_7_0.c,785 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,787 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State4156
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State4156
L__State4557:
;FirmV_0_7_0.c,788 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Limit Switch Stop");ClearTasks(9);
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
;FirmV_0_7_0.c,789 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,791 :: 		if((Events.Remote.b0==1))
	BTFSS       _Events+4, 0 
	GOTO        L_State4157
;FirmV_0_7_0.c,792 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Remote Pressed");ClearTasks(9);
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
;FirmV_0_7_0.c,793 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,795 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State4158
;FirmV_0_7_0.c,796 :: 		{State=1; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,798 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State4556
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State4556
	GOTO        L_State4161
L__State4556:
;FirmV_0_7_0.c,799 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S4 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State4640
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State4640:
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
;FirmV_0_7_0.c,801 :: 		}
	RETURN      0
; end of _State4

_State5:

;FirmV_0_7_0.c,816 :: 		void State5()
;FirmV_0_7_0.c,818 :: 		char delay=2;
	MOVLW       2
	MOVWF       State5_delay_L0+0 
;FirmV_0_7_0.c,819 :: 		Flasher=0;
	BCF         PORTC+0, 2 
;FirmV_0_7_0.c,820 :: 		if((Events.Remote!=0)||(CheckTask(9)==1))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State5565
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5565
	GOTO        L_State5165
L__State5565:
;FirmV_0_7_0.c,822 :: 		if((Door2CloseTime==0)||(ActiveDoors==1))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State5564
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State5564
	GOTO        L_State5168
L__State5564:
;FirmV_0_7_0.c,824 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,825 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,826 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,827 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,828 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,829 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,830 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,831 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,832 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,833 :: 		}
L_State5168:
;FirmV_0_7_0.c,834 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State5171
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State5171
L__State5563:
;FirmV_0_7_0.c,836 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,837 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,838 :: 		AddTask(temp,2);
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
;FirmV_0_7_0.c,839 :: 		AddTask(temp,6);
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
;FirmV_0_7_0.c,840 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,841 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,842 :: 		AddTask(temp,11); //overload check
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
;FirmV_0_7_0.c,843 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,844 :: 		AddTask(temp,4);//Stop motor
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
;FirmV_0_7_0.c,849 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,850 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,851 :: 		temp=ms500+ActionTimeDiff+delay;
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
;FirmV_0_7_0.c,852 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,853 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,854 :: 		temp=ms500+ActionTimeDiff+OverloadDelay+delay;
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
;FirmV_0_7_0.c,855 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,856 :: 		temp=ms500+Door2CloseTime+delay;
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
;FirmV_0_7_0.c,857 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,858 :: 		}
L_State5171:
;FirmV_0_7_0.c,859 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,860 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,861 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,862 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,863 :: 		}
L_State5165:
;FirmV_0_7_0.c,865 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State5174
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State5641
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State5641:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5174
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State5174
L__State5562:
;FirmV_0_7_0.c,866 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S5 Auto Close Deleted");}
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
;FirmV_0_7_0.c,868 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State5177
	BTFSC       _Events+6, 0 
	GOTO        L_State5177
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State5642
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State5642:
	BTFSC       STATUS+0, 2 
	GOTO        L_State5177
L__State5561:
;FirmV_0_7_0.c,871 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:");Logger(t);}
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
;FirmV_0_7_0.c,873 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:");Logger(t);}
L_State5179:
;FirmV_0_7_0.c,874 :: 		}
L_State5177:
;FirmV_0_7_0.c,876 :: 		}
	RETURN      0
; end of _State5

_State6:

;FirmV_0_7_0.c,896 :: 		void State6()
;FirmV_0_7_0.c,900 :: 		char delay=3;
	MOVLW       3
	MOVWF       State6_delay_L0+0 
;FirmV_0_7_0.c,901 :: 		Flasher=0;
	BCF         PORTC+0, 2 
;FirmV_0_7_0.c,902 :: 		if((Events.Remote!=0)||(PhotocellOpenFlag))
	MOVF        _Events+4, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__State6570
	MOVF        _PhotocellOpenFlag+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6570
	GOTO        L_State6182
L__State6570:
;FirmV_0_7_0.c,904 :: 		PhotocellOpenFlag=0;
	CLRF        _PhotocellOpenFlag+0 
;FirmV_0_7_0.c,905 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,906 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,907 :: 		AddTask(ms500+1,12);
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
;FirmV_0_7_0.c,908 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,909 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,910 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,911 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,912 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,913 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,914 :: 		temp=ms500+Door1OpenTime+delay;
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
;FirmV_0_7_0.c,915 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,916 :: 		if((Door2OpenTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6185
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6185
L__State6569:
;FirmV_0_7_0.c,918 :: 		AddTask(ms500+ActionTimeDiff+delay,2);
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
;FirmV_0_7_0.c,919 :: 		AddTask(ms500+ActionTimeDiff+delay,6);
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
;FirmV_0_7_0.c,920 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,921 :: 		AddTask(ms500+ActionTimeDiff+OverloadDelay+delay,11); //overload check
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
;FirmV_0_7_0.c,922 :: 		AddTask(ms500+Door2OpenTime+delay,4);//Stop motor
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
;FirmV_0_7_0.c,923 :: 		}
L_State6185:
;FirmV_0_7_0.c,924 :: 		OpenDone=3;
	MOVLW       3
	MOVWF       _OpenDone+0 
;FirmV_0_7_0.c,925 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,926 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,927 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,928 :: 		State=8;
	MOVLW       8
	MOVWF       _State+0 
;FirmV_0_7_0.c,929 :: 		}
L_State6182:
;FirmV_0_7_0.c,932 :: 		if(CheckTask(9)==1)
	MOVLW       9
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6186
;FirmV_0_7_0.c,934 :: 		ClearTasks(9);
	MOVLW       9
	MOVWF       FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
;FirmV_0_7_0.c,935 :: 		temp=ms500+delay;
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
;FirmV_0_7_0.c,936 :: 		AddTask(temp,1);
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
;FirmV_0_7_0.c,937 :: 		AddTask(temp,5);
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
;FirmV_0_7_0.c,938 :: 		M1isSlow=0;//speed up
	CLRF        _M1isSlow+0 
;FirmV_0_7_0.c,939 :: 		temp=ms500+OverloadDelay+delay;
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
;FirmV_0_7_0.c,940 :: 		AddTask(temp,10); //overload check
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
;FirmV_0_7_0.c,941 :: 		temp=ms500+Door1CloseTime+delay;
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
;FirmV_0_7_0.c,942 :: 		AddTask(temp,3);//Stop motor
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
;FirmV_0_7_0.c,944 :: 		if((Door2CloseTime!=0)&&(ActiveDoors==2))
	MOVF        _Door2CloseTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_State6189
	MOVF        _ActiveDoors+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_State6189
L__State6568:
;FirmV_0_7_0.c,946 :: 		AddTask(ms500+ActionTimeDiff+delay,2);
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
;FirmV_0_7_0.c,947 :: 		AddTask(ms500+ActionTimeDiff+delay,6);
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
;FirmV_0_7_0.c,948 :: 		M2isSlow=0;//speed up
	CLRF        _M2isSlow+0 
;FirmV_0_7_0.c,949 :: 		AddTask(ms500+ActionTimeDiff+OverloadDelay+delay,11); //overload check
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
;FirmV_0_7_0.c,950 :: 		AddTask(ms500+Door1CloseTime+delay,4);//Stop motor
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
;FirmV_0_7_0.c,951 :: 		}
L_State6189:
;FirmV_0_7_0.c,952 :: 		CloseDone=3;
	MOVLW       3
	MOVWF       _CloseDone+0 
;FirmV_0_7_0.c,953 :: 		OverloadCheckFlag1=0;
	CLRF        _OverloadCheckFlag1+0 
;FirmV_0_7_0.c,954 :: 		OverloadCheckFlag2=0;
	CLRF        _OverloadCheckFlag2+0 
;FirmV_0_7_0.c,955 :: 		PassFlag=0;
	CLRF        _PassFlag+0 
;FirmV_0_7_0.c,956 :: 		State=7;
	MOVLW       7
	MOVWF       _State+0 
;FirmV_0_7_0.c,957 :: 		}
L_State6186:
;FirmV_0_7_0.c,959 :: 		if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
	BTFSS       _Events+6, 0 
	GOTO        L_State6192
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6643
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State6643:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6192
	MOVF        _PassFlag+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State6192
L__State6567:
;FirmV_0_7_0.c,960 :: 		{PassFlag=1; _AC=GetAutocloseTime();Logger("S6 Auto Close Deleted");}
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
;FirmV_0_7_0.c,962 :: 		if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
	MOVF        _PassFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State6195
	BTFSC       _Events+6, 0 
	GOTO        L_State6195
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State6644
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State6644:
	BTFSC       STATUS+0, 2 
	GOTO        L_State6195
L__State6566:
;FirmV_0_7_0.c,964 :: 		{temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:");Logger(t);}
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
;FirmV_0_7_0.c,966 :: 		{temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:");Logger(t);}
L_State6197:
;FirmV_0_7_0.c,967 :: 		}
L_State6195:
;FirmV_0_7_0.c,969 :: 		}
	RETURN      0
; end of _State6

_State7:

;FirmV_0_7_0.c,991 :: 		void State7()
;FirmV_0_7_0.c,993 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,995 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7198
;FirmV_0_7_0.c,996 :: 		{StartMotor(1,_Close);Logger("S7 Motor1Start");memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,998 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7199
;FirmV_0_7_0.c,999 :: 		{StartMotor(2,_Close);Logger("S7 Motor2Start");}
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
;FirmV_0_7_0.c,1001 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7200
;FirmV_0_7_0.c,1002 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S7 M1 Overload Check");}
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
;FirmV_0_7_0.c,1004 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7201
;FirmV_0_7_0.c,1005 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S7 M2 Overload Check");}
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
;FirmV_0_7_0.c,1007 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7202
;FirmV_0_7_0.c,1008 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S7 M1 Speed UP");}
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
;FirmV_0_7_0.c,1010 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7203
;FirmV_0_7_0.c,1011 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S7 M2 Speed UP");}
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
;FirmV_0_7_0.c,1013 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(CloseDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7578
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7579
	BTFSS       _Events+5, 0 
	GOTO        L__State7579
	GOTO        L__State7578
L__State7579:
	GOTO        L_State7210
L__State7578:
	BTFSS       _CloseDone+0, 0 
	GOTO        L_State7210
L__State7577:
;FirmV_0_7_0.c,1014 :: 		{CloseDone.b0=0; StopMotor(1);Logger("S7 M1 Stoped");}
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
;FirmV_0_7_0.c,1016 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(CloseDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7575
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State7576
	BTFSS       _Events+5, 1 
	GOTO        L__State7576
	GOTO        L__State7575
L__State7576:
	GOTO        L_State7217
L__State7575:
	BTFSS       _CloseDone+0, 1 
	GOTO        L_State7217
L__State7574:
;FirmV_0_7_0.c,1017 :: 		{CloseDone.b1=0; StopMotor(2);Logger("S7 M2 Stoped");}
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
;FirmV_0_7_0.c,1019 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State7573
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State7573
	GOTO        L_State7220
L__State7573:
;FirmV_0_7_0.c,1020 :: 		CloseDone.b1=0;
	BCF         _CloseDone+0, 1 
L_State7220:
;FirmV_0_7_0.c,1022 :: 		if((Events.Photocell.b0==1))
	BTFSS       _Events+6, 0 
	GOTO        L_State7221
;FirmV_0_7_0.c,1023 :: 		{StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S7 Photocell Int");ClearTasks(9);
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
;FirmV_0_7_0.c,1024 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1026 :: 		if((Events.Remote.b0==1))
	BTFSS       _Events+4, 0 
	GOTO        L_State7222
;FirmV_0_7_0.c,1027 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Remote Pressed");ClearTasks(9);
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
;FirmV_0_7_0.c,1028 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1030 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State7225
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State7225
L__State7572:
;FirmV_0_7_0.c,1031 :: 		{StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Limit Switch Stop");ClearTasks(9);
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
;FirmV_0_7_0.c,1032 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1034 :: 		if(CloseDone==0)
	MOVF        _CloseDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State7226
;FirmV_0_7_0.c,1035 :: 		{State=1; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1037 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State7571
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State7571
	GOTO        L_State7229
L__State7571:
;FirmV_0_7_0.c,1038 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S7 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State7645
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State7645:
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
;FirmV_0_7_0.c,1041 :: 		}
	RETURN      0
; end of _State7

_State8:

;FirmV_0_7_0.c,1058 :: 		void State8()
;FirmV_0_7_0.c,1060 :: 		Flasher=1;
	BSF         PORTC+0, 2 
;FirmV_0_7_0.c,1062 :: 		if(CheckTask(1))
	MOVLW       1
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8231
;FirmV_0_7_0.c,1063 :: 		{StartMotor(1,_Open);Logger("S8 Motor1Start"); Lock=0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1065 :: 		if(CheckTask(2))
	MOVLW       2
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8232
;FirmV_0_7_0.c,1066 :: 		{StartMotor(2,_Open);Logger("S8 Motor2Start"); Lock=0;}
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
;FirmV_0_7_0.c,1068 :: 		if(CheckTask(10))
	MOVLW       10
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8233
;FirmV_0_7_0.c,1069 :: 		{OverloadCheckFlag1=1; OverloadInit(1);Logger("S8 Overflow Flag1 Set");}
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
;FirmV_0_7_0.c,1071 :: 		if(CheckTask(11))
	MOVLW       11
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8234
;FirmV_0_7_0.c,1072 :: 		{OverloadCheckFlag2=1; OverloadInit(2);Logger("S8 Overflow Flag2 Set");}
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
;FirmV_0_7_0.c,1074 :: 		if(CheckTask(5))
	MOVLW       5
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8235
;FirmV_0_7_0.c,1075 :: 		{SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S8 Motor1 Fast");}
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
;FirmV_0_7_0.c,1077 :: 		if(CheckTask(6))
	MOVLW       6
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8236
;FirmV_0_7_0.c,1078 :: 		{SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S8 Motor2 Fast");}
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
;FirmV_0_7_0.c,1080 :: 		if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(OpenDone.b0))
	MOVLW       3
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8588
	MOVF        _OverloadCheckFlag1+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8589
	BTFSS       _Events+5, 0 
	GOTO        L__State8589
	GOTO        L__State8588
L__State8589:
	GOTO        L_State8243
L__State8588:
	BTFSS       _OpenDone+0, 0 
	GOTO        L_State8243
L__State8587:
;FirmV_0_7_0.c,1081 :: 		{OpenDone.b0=0; StopMotor(1);Logger("S8 Motor1 Stop");}
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
;FirmV_0_7_0.c,1083 :: 		if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(OpenDone.b1))
	MOVLW       4
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8585
	MOVF        _OverloadCheckFlag2+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__State8586
	BTFSS       _Events+5, 1 
	GOTO        L__State8586
	GOTO        L__State8585
L__State8586:
	GOTO        L_State8250
L__State8585:
	BTFSS       _OpenDone+0, 1 
	GOTO        L_State8250
L__State8584:
;FirmV_0_7_0.c,1084 :: 		{OpenDone.b1=0; StopMotor(2);Logger("S8 Motor2 Stop");}
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
;FirmV_0_7_0.c,1086 :: 		if(CheckTask(12))
	MOVLW       12
	MOVWF       FARG_CheckTask+0 
	CALL        _CheckTask+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8251
;FirmV_0_7_0.c,1087 :: 		{Lock=1;}
	BSF         PORTD+0, 7 
L_State8251:
;FirmV_0_7_0.c,1089 :: 		if((Door2OpenTime==0)||(ActiveDoors==1))
	MOVF        _Door2OpenTime+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__State8583
	MOVF        _ActiveDoors+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__State8583
	GOTO        L_State8254
L__State8583:
;FirmV_0_7_0.c,1090 :: 		OpenDone.b1=0;
	BCF         _OpenDone+0, 1 
L_State8254:
;FirmV_0_7_0.c,1092 :: 		if((Events.Photocell.b0==1)&&(OpenPhEnable))
	BTFSS       _Events+6, 0 
	GOTO        L_State8257
	MOVF        _OpenPhEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8257
L__State8582:
;FirmV_0_7_0.c,1093 :: 		{StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S8 Photocell Int");ClearTasks(9);
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
;FirmV_0_7_0.c,1094 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1096 :: 		if((Events.Remote.b0==1))
	BTFSS       _Events+4, 0 
	GOTO        L_State8258
;FirmV_0_7_0.c,1097 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Motors Stoped (Remote)");ClearTasks(9);
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
;FirmV_0_7_0.c,1098 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1100 :: 		if((Events.Limiter==1)&&(LimiterEnable))
	MOVF        _Events+7, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_State8261
	MOVF        _LimiterEnable+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_State8261
L__State8581:
;FirmV_0_7_0.c,1101 :: 		{StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Limit Switch Stop");ClearTasks(9);
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
;FirmV_0_7_0.c,1102 :: 		memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1104 :: 		if(OpenDone==0)
	MOVF        _OpenDone+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_State8262
;FirmV_0_7_0.c,1105 :: 		{State=2; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1107 :: 		if((State==5)||(State==6))
	MOVF        _State+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__State8580
	MOVF        _State+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__State8580
	GOTO        L_State8265
L__State8580:
;FirmV_0_7_0.c,1108 :: 		{ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S8 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}
	CLRF        FARG_ClearTasks+0 
	CALL        _ClearTasks+0, 0
	MOVLW       0
	XORWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__State8646
	MOVLW       0
	XORWF       _AutoCloseTime+0, 0 
L__State8646:
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
;FirmV_0_7_0.c,1111 :: 		}
	RETURN      0
; end of _State8

_LCDUpdater:

;FirmV_0_7_0.c,1120 :: 		void LCDUpdater()
;FirmV_0_7_0.c,1122 :: 		if(LCDUpdateFlag==1)
	MOVF        _LCDUpdateFlag+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_LCDUpdater267
;FirmV_0_7_0.c,1124 :: 		lcd_out(1,1,LCDLine1);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _LCDLine1+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_LCDLine1+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;FirmV_0_7_0.c,1125 :: 		lcd_out(2,1,LCDLine2);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _LCDLine2+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_LCDLine2+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;FirmV_0_7_0.c,1126 :: 		LCDUpdateFlag=0;
	CLRF        _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1127 :: 		}
L_LCDUpdater267:
;FirmV_0_7_0.c,1129 :: 		if(LCDFlash)
	MOVF        _LCDFlash+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater268
;FirmV_0_7_0.c,1131 :: 		if(LCDFlashFlag)
	MOVF        _LCDFlashFlag+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_LCDUpdater269
;FirmV_0_7_0.c,1132 :: 		lcd_out(2,1,"               ");
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
;FirmV_0_7_0.c,1134 :: 		lcd_out(2,1,LCDLine2);
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
;FirmV_0_7_0.c,1135 :: 		}
L_LCDUpdater268:
;FirmV_0_7_0.c,1138 :: 		}
	RETURN      0
; end of _LCDUpdater

_Init:

;FirmV_0_7_0.c,1158 :: 		void Init()
;FirmV_0_7_0.c,1160 :: 		char i=0;
	CLRF        Init_i_L0+0 
;FirmV_0_7_0.c,1162 :: 		porta=0;
	CLRF        PORTA+0 
;FirmV_0_7_0.c,1163 :: 		portb=0;
	CLRF        PORTB+0 
;FirmV_0_7_0.c,1164 :: 		portc=0;
	CLRF        PORTC+0 
;FirmV_0_7_0.c,1165 :: 		portd=0;
	CLRF        PORTD+0 
;FirmV_0_7_0.c,1166 :: 		porte=0;
	CLRF        PORTE+0 
;FirmV_0_7_0.c,1167 :: 		trisa=0b111111;
	MOVLW       63
	MOVWF       TRISA+0 
;FirmV_0_7_0.c,1168 :: 		trisb=0b00000111;
	MOVLW       7
	MOVWF       TRISB+0 
;FirmV_0_7_0.c,1169 :: 		trisc=0b10000000;
	MOVLW       128
	MOVWF       TRISC+0 
;FirmV_0_7_0.c,1170 :: 		trisd=0b01111111;
	MOVLW       127
	MOVWF       TRISD+0 
;FirmV_0_7_0.c,1171 :: 		trise=0b001;
	MOVLW       1
	MOVWF       TRISE+0 
;FirmV_0_7_0.c,1172 :: 		adcon1=0b1001;  // an6 and an7 is digital
	MOVLW       9
	MOVWF       ADCON1+0 
;FirmV_0_7_0.c,1177 :: 		lcd_init();
	CALL        _Lcd_Init+0, 0
;FirmV_0_7_0.c,1178 :: 		lcd_cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;FirmV_0_7_0.c,1181 :: 		ms500=0;
	CLRF        _ms500+0 
	CLRF        _ms500+1 
	CLRF        _ms500+2 
	CLRF        _ms500+3 
;FirmV_0_7_0.c,1182 :: 		t0con=0b10000101; //enable tmr0 and prescalar
	MOVLW       133
	MOVWF       T0CON+0 
;FirmV_0_7_0.c,1183 :: 		intcon.b7=1;   //global int enable
	BSF         INTCON+0, 7 
;FirmV_0_7_0.c,1184 :: 		intcon.b5=1;  //tmr0 int enable
	BSF         INTCON+0, 5 
;FirmV_0_7_0.c,1185 :: 		intcon.b2=0; //tmr0 flag
	BCF         INTCON+0, 2 
;FirmV_0_7_0.c,1186 :: 		tmr0h=0xF3;
	MOVLW       243
	MOVWF       TMR0H+0 
;FirmV_0_7_0.c,1187 :: 		tmr0l=0xCA;
	MOVLW       202
	MOVWF       TMR0L+0 
;FirmV_0_7_0.c,1190 :: 		INT1IP_bit=1;
	BSF         INT1IP_bit+0, 6 
;FirmV_0_7_0.c,1191 :: 		INT1E_bit=1;
	BSF         INT1E_bit+0, 3 
;FirmV_0_7_0.c,1192 :: 		INT1F_bit=0;
	BCF         INT1F_bit+0, 0 
;FirmV_0_7_0.c,1193 :: 		INT2IP_bit=1;
	BSF         INT2IP_bit+0, 7 
;FirmV_0_7_0.c,1194 :: 		INT2E_bit=1;
	BSF         INT2E_bit+0, 4 
;FirmV_0_7_0.c,1195 :: 		INT2F_bit=0;
	BCF         INT2F_bit+0, 1 
;FirmV_0_7_0.c,1196 :: 		INTEDG1_bit=1;
	BSF         INTEDG1_bit+0, 5 
;FirmV_0_7_0.c,1197 :: 		INTEDG2_bit=1;
	BSF         INTEDG2_bit+0, 4 
;FirmV_0_7_0.c,1200 :: 		INT0F_bit=0;
	BCF         INT0F_bit+0, 1 
;FirmV_0_7_0.c,1201 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, 4 
;FirmV_0_7_0.c,1204 :: 		for(i=0;i<20;i++)
	CLRF        Init_i_L0+0 
L_Init271:
	MOVLW       20
	SUBWF       Init_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Init272
;FirmV_0_7_0.c,1205 :: 		Tasks[i].Expired=1;
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
;FirmV_0_7_0.c,1204 :: 		for(i=0;i<20;i++)
	INCF        Init_i_L0+0, 1 
;FirmV_0_7_0.c,1205 :: 		Tasks[i].Expired=1;
	GOTO        L_Init271
L_Init272:
;FirmV_0_7_0.c,1208 :: 		Events.Keys=0;
	CLRF        _Events+0 
;FirmV_0_7_0.c,1209 :: 		Events.Task1=0;
	CLRF        _Events+1 
;FirmV_0_7_0.c,1210 :: 		Events.Task2=0;
	CLRF        _Events+2 
;FirmV_0_7_0.c,1211 :: 		Events.Task3=0;
	CLRF        _Events+3 
;FirmV_0_7_0.c,1212 :: 		Events.Remote=0;
	CLRF        _Events+4 
;FirmV_0_7_0.c,1213 :: 		Events.Overload=0;
	CLRF        _Events+5 
;FirmV_0_7_0.c,1214 :: 		Events.Photocell=0;
	CLRF        _Events+6 
;FirmV_0_7_0.c,1217 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,1220 :: 		UART1_init(115200);
	MOVLW       21
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;FirmV_0_7_0.c,1223 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,1225 :: 		}
	RETURN      0
; end of _Init

_TaskManager:

;FirmV_0_7_0.c,1239 :: 		void TaskManager()
;FirmV_0_7_0.c,1241 :: 		char i=0;
	CLRF        TaskManager_i_L0+0 
;FirmV_0_7_0.c,1242 :: 		for(i=0;i<20;i++)
	CLRF        TaskManager_i_L0+0 
L_TaskManager274:
	MOVLW       20
	SUBWF       TaskManager_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_TaskManager275
;FirmV_0_7_0.c,1243 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Time==ms500)&&(Tasks[i].Fired==0))
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
	GOTO        L__TaskManager647
	MOVF        R3, 0 
	XORWF       _ms500+2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager647
	MOVF        R2, 0 
	XORWF       _ms500+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TaskManager647
	MOVF        R1, 0 
	XORWF       _ms500+0, 0 
L__TaskManager647:
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
L__TaskManager590:
;FirmV_0_7_0.c,1244 :: 		Tasks[i].Fired=1;
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
;FirmV_0_7_0.c,1242 :: 		for(i=0;i<20;i++)
	INCF        TaskManager_i_L0+0, 1 
;FirmV_0_7_0.c,1244 :: 		Tasks[i].Fired=1;
	GOTO        L_TaskManager274
L_TaskManager275:
;FirmV_0_7_0.c,1245 :: 		}
	RETURN      0
; end of _TaskManager

_AddTask:

;FirmV_0_7_0.c,1257 :: 		void AddTask(unsigned long OccTime,char tcode)
;FirmV_0_7_0.c,1260 :: 		for(i=0;i<20;i++)
	CLRF        AddTask_i_L0+0 
L_AddTask280:
	MOVLW       20
	SUBWF       AddTask_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_AddTask281
;FirmV_0_7_0.c,1261 :: 		if(Tasks[i].Expired==1)
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
;FirmV_0_7_0.c,1263 :: 		Tasks[i].TaskCode=tcode;
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
;FirmV_0_7_0.c,1264 :: 		Tasks[i].Time=OccTime;
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
;FirmV_0_7_0.c,1265 :: 		Tasks[i].Expired=0;
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
;FirmV_0_7_0.c,1266 :: 		Tasks[i].Fired=0;
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
;FirmV_0_7_0.c,1267 :: 		break;
	GOTO        L_AddTask281
;FirmV_0_7_0.c,1268 :: 		}
L_AddTask283:
;FirmV_0_7_0.c,1260 :: 		for(i=0;i<20;i++)
	INCF        AddTask_i_L0+0, 1 
;FirmV_0_7_0.c,1268 :: 		}
	GOTO        L_AddTask280
L_AddTask281:
;FirmV_0_7_0.c,1269 :: 		}
	RETURN      0
; end of _AddTask

_EventHandler:

;FirmV_0_7_0.c,1279 :: 		void EventHandler()
;FirmV_0_7_0.c,1282 :: 		Events.ExternalKeys=GetExternalKeysState();
	CALL        _GetExternalKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+8 
;FirmV_0_7_0.c,1283 :: 		Events.Limiter=GetLimitSwitchState();
	CALL        _GetLimitSwitchState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+7 
;FirmV_0_7_0.c,1284 :: 		Events.Keys=GetKeysState();
	CALL        _GetKeysState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+0 
;FirmV_0_7_0.c,1285 :: 		Events.Remote=GetRemoteState();
	CALL        _GetRemoteState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+4 
;FirmV_0_7_0.c,1286 :: 		Events.Overload=GetOverloadState();
	CALL        _GetOverloadState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+5 
;FirmV_0_7_0.c,1287 :: 		Events.Photocell=GetPhotocellState();
	CALL        _GetPhotocellState+0, 0
	MOVF        R0, 0 
	MOVWF       _Events+6 
;FirmV_0_7_0.c,1289 :: 		for(i=0;i<20;i++)
	CLRF        EventHandler_i_L0+0 
L_EventHandler284:
	MOVLW       20
	SUBWF       EventHandler_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_EventHandler285
;FirmV_0_7_0.c,1290 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].Fired==1))
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
L__EventHandler591:
;FirmV_0_7_0.c,1292 :: 		if(Events.Task1==0)
	MOVF        _Events+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler290
;FirmV_0_7_0.c,1293 :: 		{Events.Task1=Tasks[i].TaskCode; Tasks[i].Expired=1;Tasks[i].Fired=0;}
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
;FirmV_0_7_0.c,1294 :: 		else if(Events.Task2==0)
	MOVF        _Events+2, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler292
;FirmV_0_7_0.c,1295 :: 		{Events.Task2=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
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
;FirmV_0_7_0.c,1296 :: 		else if(Events.Task3==0)
	MOVF        _Events+3, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_EventHandler294
;FirmV_0_7_0.c,1297 :: 		{Events.Task3=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
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
;FirmV_0_7_0.c,1298 :: 		}
L_EventHandler289:
;FirmV_0_7_0.c,1289 :: 		for(i=0;i<20;i++)
	INCF        EventHandler_i_L0+0, 1 
;FirmV_0_7_0.c,1298 :: 		}
	GOTO        L_EventHandler284
L_EventHandler285:
;FirmV_0_7_0.c,1299 :: 		}
	RETURN      0
; end of _EventHandler

_GetKeysState:

;FirmV_0_7_0.c,1309 :: 		char GetKeysState()
;FirmV_0_7_0.c,1311 :: 		unsigned res=0;
	CLRF        GetKeysState_res_L0+0 
	CLRF        GetKeysState_res_L0+1 
;FirmV_0_7_0.c,1315 :: 		char resch=0,fin;
	CLRF        GetKeysState_resch_L0+0 
;FirmV_0_7_0.c,1316 :: 		res=ADC_Read(5);
	MOVLW       5
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       GetKeysState_res_L0+0 
	MOVF        R1, 0 
	MOVWF       GetKeysState_res_L0+1 
;FirmV_0_7_0.c,1317 :: 		if(((res>>2)>160)&&((res>>2)<185))
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
	GOTO        L__GetKeysState648
	MOVF        R2, 0 
	SUBLW       160
L__GetKeysState648:
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
	GOTO        L__GetKeysState649
	MOVLW       185
	SUBWF       R1, 0 
L__GetKeysState649:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState297
L__GetKeysState598:
;FirmV_0_7_0.c,1318 :: 		resch.b2=1;
	BSF         GetKeysState_resch_L0+0, 2 
L_GetKeysState297:
;FirmV_0_7_0.c,1319 :: 		if(((res>>2)>100)&&((res>>2)<160))
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
	GOTO        L__GetKeysState650
	MOVF        R1, 0 
	SUBLW       100
L__GetKeysState650:
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
	GOTO        L__GetKeysState651
	MOVLW       160
	SUBWF       R1, 0 
L__GetKeysState651:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState300
L__GetKeysState597:
;FirmV_0_7_0.c,1320 :: 		resch.b1=1;
	BSF         GetKeysState_resch_L0+0, 1 
L_GetKeysState300:
;FirmV_0_7_0.c,1321 :: 		if((res>>2)<50)
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
	MOVLW       50
	SUBWF       R1, 0 
L__GetKeysState652:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetKeysState301
;FirmV_0_7_0.c,1322 :: 		resch.b0=1;
	BSF         GetKeysState_resch_L0+0, 0 
L_GetKeysState301:
;FirmV_0_7_0.c,1324 :: 		if((resch==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState302
;FirmV_0_7_0.c,1326 :: 		if(Pressed==0)
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState303
;FirmV_0_7_0.c,1327 :: 		{Repeat=0;Pressed=0;fin=0;RepeatRate=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState303:
;FirmV_0_7_0.c,1328 :: 		if(Pressed==1)
	MOVF        _Pressed+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState304
;FirmV_0_7_0.c,1329 :: 		if(DebouncingDelay>=DebouncingFix)
	MOVLW       5
	SUBWF       _DebouncingDelay+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetKeysState305
;FirmV_0_7_0.c,1330 :: 		{Repeat=0;Pressed=0;fin=0;RepeatRate=0;}
	CLRF        GetKeysState_Repeat_L0+0 
	CLRF        _Pressed+0 
	CLRF        GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState305:
L_GetKeysState304:
;FirmV_0_7_0.c,1331 :: 		}
L_GetKeysState302:
;FirmV_0_7_0.c,1332 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0)&&(ms500==PressTime+KeyRepeatDelay))
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
	GOTO        L__GetKeysState653
	MOVF        _ms500+2, 0 
	XORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState653
	MOVF        _ms500+1, 0 
	XORWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetKeysState653
	MOVF        _ms500+0, 0 
	XORWF       R1, 0 
L__GetKeysState653:
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState308
L__GetKeysState596:
;FirmV_0_7_0.c,1333 :: 		Repeat=1;
	MOVLW       1
	MOVWF       GetKeysState_Repeat_L0+0 
L_GetKeysState308:
;FirmV_0_7_0.c,1335 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==0))
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
L__GetKeysState595:
;FirmV_0_7_0.c,1336 :: 		fin=0;
	CLRF        GetKeysState_fin_L0+0 
L_GetKeysState311:
;FirmV_0_7_0.c,1338 :: 		if((resch!=0)&&(Pressed==1)&&(Repeat==1))
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
L__GetKeysState594:
;FirmV_0_7_0.c,1339 :: 		{fin=resch*RepeatRate;RepeatRate=0;}
	MOVF        GetKeysState_resch_L0+0, 0 
	MULWF       GetKeysState_RepeatRate_L0+0 
	MOVF        PRODL+0, 0 
	MOVWF       GetKeysState_fin_L0+0 
	CLRF        GetKeysState_RepeatRate_L0+0 
L_GetKeysState314:
;FirmV_0_7_0.c,1342 :: 		if((resch!=0)&&(Pressed==0))
	MOVF        GetKeysState_resch_L0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetKeysState317
	MOVF        _Pressed+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_GetKeysState317
L__GetKeysState593:
;FirmV_0_7_0.c,1343 :: 		{fin=resch; Pressed=1;PressTime=ms500;DebouncingDelay=0;}
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
;FirmV_0_7_0.c,1345 :: 		if((Repeat==1)&&(msCounter%10==0))
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
L__GetKeysState592:
;FirmV_0_7_0.c,1346 :: 		RepeatRate=1;
	MOVLW       1
	MOVWF       GetKeysState_RepeatRate_L0+0 
L_GetKeysState320:
;FirmV_0_7_0.c,1348 :: 		return fin;
	MOVF        GetKeysState_fin_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1349 :: 		}
	RETURN      0
; end of _GetKeysState

_GetExternalKeysState:

;FirmV_0_7_0.c,1359 :: 		char GetExternalKeysState()
;FirmV_0_7_0.c,1361 :: 		char out=0;
	CLRF        GetExternalKeysState_out_L0+0 
;FirmV_0_7_0.c,1362 :: 		if(D1ExKey==0)
	BTFSC       PORTD+0, 3 
	GOTO        L_GetExternalKeysState321
;FirmV_0_7_0.c,1363 :: 		out.b0=1;
	BSF         GetExternalKeysState_out_L0+0, 0 
L_GetExternalKeysState321:
;FirmV_0_7_0.c,1364 :: 		if(D2ExKey==0)
	BTFSC       PORTD+0, 4 
	GOTO        L_GetExternalKeysState322
;FirmV_0_7_0.c,1365 :: 		out.b1=1;
	BSF         GetExternalKeysState_out_L0+0, 1 
L_GetExternalKeysState322:
;FirmV_0_7_0.c,1366 :: 		return out;
	MOVF        GetExternalKeysState_out_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1367 :: 		}
	RETURN      0
; end of _GetExternalKeysState

_GetLimitSwitchState:

;FirmV_0_7_0.c,1380 :: 		char GetLimitSwitchState()
;FirmV_0_7_0.c,1382 :: 		if((Limit1==0)||(Limit2==0))
	BTFSS       PORTD+0, 1 
	GOTO        L__GetLimitSwitchState599
	BTFSS       PORTD+0, 2 
	GOTO        L__GetLimitSwitchState599
	GOTO        L_GetLimitSwitchState325
L__GetLimitSwitchState599:
;FirmV_0_7_0.c,1383 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_GetLimitSwitchState325:
;FirmV_0_7_0.c,1385 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1386 :: 		}
	RETURN      0
; end of _GetLimitSwitchState

_GetRemoteState:

;FirmV_0_7_0.c,1395 :: 		char GetRemoteState()
;FirmV_0_7_0.c,1397 :: 		char res=0;
	CLRF        GetRemoteState_res_L0+0 
;FirmV_0_7_0.c,1398 :: 		res.b0=RemoteAFlag.b0;
	BTFSC       _RemoteAFlag+0, 0 
	GOTO        L__GetRemoteState654
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState655
L__GetRemoteState654:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState655:
;FirmV_0_7_0.c,1399 :: 		res.b1=RemoteBFlag.b0;
	BTFSC       _RemoteBFlag+0, 0 
	GOTO        L__GetRemoteState656
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState657
L__GetRemoteState656:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState657:
;FirmV_0_7_0.c,1400 :: 		RemoteAFlag=0;
	CLRF        _RemoteAFlag+0 
;FirmV_0_7_0.c,1401 :: 		RemoteBFlag=0;
	CLRF        _RemoteBFlag+0 
;FirmV_0_7_0.c,1402 :: 		res.b0=res.b0|(~D1ExKey);
	BTFSC       PORTD+0, 3 
	GOTO        L__GetRemoteState658
	BSF         4056, 0 
	GOTO        L__GetRemoteState659
L__GetRemoteState658:
	BCF         4056, 0 
L__GetRemoteState659:
	BTFSC       GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState660
	BTFSC       4056, 0 
	GOTO        L__GetRemoteState660
	BCF         GetRemoteState_res_L0+0, 0 
	GOTO        L__GetRemoteState661
L__GetRemoteState660:
	BSF         GetRemoteState_res_L0+0, 0 
L__GetRemoteState661:
;FirmV_0_7_0.c,1403 :: 		res.b1=res.b1|(~D2ExKey);
	BTFSC       PORTD+0, 4 
	GOTO        L__GetRemoteState662
	BSF         4056, 0 
	GOTO        L__GetRemoteState663
L__GetRemoteState662:
	BCF         4056, 0 
L__GetRemoteState663:
	BTFSC       GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState664
	BTFSC       4056, 0 
	GOTO        L__GetRemoteState664
	BCF         GetRemoteState_res_L0+0, 1 
	GOTO        L__GetRemoteState665
L__GetRemoteState664:
	BSF         GetRemoteState_res_L0+0, 1 
L__GetRemoteState665:
;FirmV_0_7_0.c,1404 :: 		return res;
	MOVF        GetRemoteState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1405 :: 		}
	RETURN      0
; end of _GetRemoteState

_GetOverloadState:

;FirmV_0_7_0.c,1415 :: 		char GetOverloadState()
;FirmV_0_7_0.c,1417 :: 		char res=0;
	CLRF        GetOverloadState_res_L0+0 
;FirmV_0_7_0.c,1419 :: 		VCapM1=ADC_Read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       GetOverloadState_VCapM1_L0+0 
	MOVF        R1, 0 
	MOVWF       GetOverloadState_VCapM1_L0+1 
;FirmV_0_7_0.c,1420 :: 		VCapM2=ADC_Read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       GetOverloadState_VCapM2_L0+0 
	MOVF        R1, 0 
	MOVWF       GetOverloadState_VCapM2_L0+1 
;FirmV_0_7_0.c,1421 :: 		if(Motor1FullSpeed!=0)
	MOVF        _Motor1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState327
;FirmV_0_7_0.c,1423 :: 		if(VCapM1<OverloadTreshold)
	MOVF        _OverloadTreshold+1, 0 
	SUBWF       GetOverloadState_VCapM1_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState666
	MOVF        _OverloadTreshold+0, 0 
	SUBWF       GetOverloadState_VCapM1_L0+0, 0 
L__GetOverloadState666:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState328
;FirmV_0_7_0.c,1425 :: 		if(OverloadCounter1<255)
	MOVLW       255
	SUBWF       _OverloadCounter1+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState329
;FirmV_0_7_0.c,1426 :: 		OverloadCounter1=OverloadCounter1+1;
	INCF        _OverloadCounter1+0, 1 
L_GetOverloadState329:
;FirmV_0_7_0.c,1427 :: 		}
	GOTO        L_GetOverloadState330
L_GetOverloadState328:
;FirmV_0_7_0.c,1430 :: 		if(OverloadCounter1>0)
	MOVF        _OverloadCounter1+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState331
;FirmV_0_7_0.c,1431 :: 		OverloadCounter1=OverloadCounter1-1;
	DECF        _OverloadCounter1+0, 1 
L_GetOverloadState331:
;FirmV_0_7_0.c,1432 :: 		}
L_GetOverloadState330:
;FirmV_0_7_0.c,1433 :: 		}
	GOTO        L_GetOverloadState332
L_GetOverloadState327:
;FirmV_0_7_0.c,1435 :: 		{OverloadCounter1=0;}
	CLRF        _OverloadCounter1+0 
L_GetOverloadState332:
;FirmV_0_7_0.c,1437 :: 		if (OverloadCounter1>OverloadDuration)
	MOVF        _OverloadCounter1+0, 0 
	SUBWF       _OverloadDuration+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState333
;FirmV_0_7_0.c,1438 :: 		res.b0=1;
	BSF         GetOverloadState_res_L0+0, 0 
L_GetOverloadState333:
;FirmV_0_7_0.c,1443 :: 		if(Motor2FullSpeed!=0)
	MOVF        _Motor2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_GetOverloadState334
;FirmV_0_7_0.c,1445 :: 		if(VCapM2<OverloadTreshold)
	MOVF        _OverloadTreshold+1, 0 
	SUBWF       GetOverloadState_VCapM2_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetOverloadState667
	MOVF        _OverloadTreshold+0, 0 
	SUBWF       GetOverloadState_VCapM2_L0+0, 0 
L__GetOverloadState667:
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState335
;FirmV_0_7_0.c,1447 :: 		if(OverloadCounter2<255)
	MOVLW       255
	SUBWF       _OverloadCounter2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState336
;FirmV_0_7_0.c,1448 :: 		OverloadCounter2=OverloadCounter2+1;
	INCF        _OverloadCounter2+0, 1 
L_GetOverloadState336:
;FirmV_0_7_0.c,1449 :: 		}
	GOTO        L_GetOverloadState337
L_GetOverloadState335:
;FirmV_0_7_0.c,1452 :: 		if(OverloadCounter2>0)
	MOVF        _OverloadCounter2+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState338
;FirmV_0_7_0.c,1453 :: 		OverloadCounter2=OverloadCounter2-1;
	DECF        _OverloadCounter2+0, 1 
L_GetOverloadState338:
;FirmV_0_7_0.c,1454 :: 		}
L_GetOverloadState337:
;FirmV_0_7_0.c,1455 :: 		}
	GOTO        L_GetOverloadState339
L_GetOverloadState334:
;FirmV_0_7_0.c,1457 :: 		{OverloadCounter2=0;}
	CLRF        _OverloadCounter2+0 
L_GetOverloadState339:
;FirmV_0_7_0.c,1460 :: 		if (OverloadCounter2>OverloadDuration)
	MOVF        _OverloadCounter2+0, 0 
	SUBWF       _OverloadDuration+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetOverloadState340
;FirmV_0_7_0.c,1461 :: 		res.b1=1;
	BSF         GetOverloadState_res_L0+0, 1 
L_GetOverloadState340:
;FirmV_0_7_0.c,1463 :: 		return res;
	MOVF        GetOverloadState_res_L0+0, 0 
	MOVWF       R0 
;FirmV_0_7_0.c,1464 :: 		}
	RETURN      0
; end of _GetOverloadState

_GetPhotocellState:

;FirmV_0_7_0.c,1477 :: 		char GetPhotocellState()
;FirmV_0_7_0.c,1479 :: 		if(Phcell==0)
	BTFSC       PORTD+0, 0 
	GOTO        L_GetPhotocellState341
;FirmV_0_7_0.c,1480 :: 		{if(PhotocellCount<=20)PhotocellCount=PhotocellCount+1;}
	MOVF        _PhotocellCount+0, 0 
	SUBLW       20
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState342
	INCF        _PhotocellCount+0, 1 
L_GetPhotocellState342:
	GOTO        L_GetPhotocellState343
L_GetPhotocellState341:
;FirmV_0_7_0.c,1482 :: 		{PhotocellCount=0;}
	CLRF        _PhotocellCount+0 
L_GetPhotocellState343:
;FirmV_0_7_0.c,1483 :: 		if(PhotocellCount>=20)
	MOVLW       20
	SUBWF       _PhotocellCount+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_GetPhotocellState344
;FirmV_0_7_0.c,1484 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_GetPhotocellState344:
;FirmV_0_7_0.c,1486 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1487 :: 		}
	RETURN      0
; end of _GetPhotocellState

_SetMotorSpeed:

;FirmV_0_7_0.c,1499 :: 		void SetMotorSpeed(char M1FullSpeed,char M2FullSpeed)
;FirmV_0_7_0.c,1501 :: 		if((M1FullSpeed==0)||(M2FullSpeed==0))
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed600
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L__SetMotorSpeed600
	GOTO        L_SetMotorSpeed348
L__SetMotorSpeed600:
;FirmV_0_7_0.c,1502 :: 		INT0E_bit=1;
	BSF         INT0E_bit+0, 4 
	GOTO        L_SetMotorSpeed349
L_SetMotorSpeed348:
;FirmV_0_7_0.c,1504 :: 		INT0E_bit=0;
	BCF         INT0E_bit+0, 4 
L_SetMotorSpeed349:
;FirmV_0_7_0.c,1506 :: 		Motor1FullSpeed=M1FullSpeed;
	MOVF        FARG_SetMotorSpeed_M1FullSpeed+0, 0 
	MOVWF       _Motor1FullSpeed+0 
;FirmV_0_7_0.c,1507 :: 		Motor2FullSpeed=M2FullSpeed;
	MOVF        FARG_SetMotorSpeed_M2FullSpeed+0, 0 
	MOVWF       _Motor2FullSpeed+0 
;FirmV_0_7_0.c,1508 :: 		}
	RETURN      0
; end of _SetMotorSpeed

_OverloadInit:

;FirmV_0_7_0.c,1519 :: 		void OverloadInit(char ch)
;FirmV_0_7_0.c,1521 :: 		if(ch==1)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit350
;FirmV_0_7_0.c,1523 :: 		OverloadCounter1=0;
	CLRF        _OverloadCounter1+0 
;FirmV_0_7_0.c,1524 :: 		Events.Overload.b0=0;
	BCF         _Events+5, 0 
;FirmV_0_7_0.c,1525 :: 		}
L_OverloadInit350:
;FirmV_0_7_0.c,1527 :: 		if(ch==2)
	MOVF        FARG_OverloadInit_ch+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_OverloadInit351
;FirmV_0_7_0.c,1529 :: 		OverloadCounter2=0;
	CLRF        _OverloadCounter2+0 
;FirmV_0_7_0.c,1530 :: 		Events.Overload.b1=0;
	BCF         _Events+5, 1 
;FirmV_0_7_0.c,1531 :: 		}
L_OverloadInit351:
;FirmV_0_7_0.c,1532 :: 		}
	RETURN      0
; end of _OverloadInit

_SaveConfigs:

;FirmV_0_7_0.c,1543 :: 		void SaveConfigs()
;FirmV_0_7_0.c,1546 :: 		EEPROM_Write(1,Door1OpenTime);
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1547 :: 		EEPROM_Write(2,Door2OpenTime);
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1548 :: 		EEPROM_Write(3,Door1CloseTime);
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1549 :: 		EEPROM_Write(4,Door2CloseTime);
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1550 :: 		EEPROM_Write(5,ActionTimeDiff);
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1551 :: 		EEPROM_Write(6,OpenSoftStartTime);
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1552 :: 		EEPROM_Write(7,OpenSoftStopTime);
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1553 :: 		EEPROM_Write(8,CloseSoftStartTime);
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1554 :: 		EEPROM_Write(9,CloseSoftStopTime);
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1555 :: 		EEPROM_Write(10,Hi(AutoCloseTime));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _AutoCloseTime+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1556 :: 		EEPROM_Write(11,Lo(AutoCloseTime));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1557 :: 		EEPROM_Write(12,OverloadSens);
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OverloadSens+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1558 :: 		SetOverloadParams(9-OverloadSens);
	MOVF        _OverloadSens+0, 0 
	SUBLW       9
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1559 :: 		EEPROM_Write(13,CloseAfterPass);
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1560 :: 		EEPROM_Write(14,LockForce);
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _LockForce+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1561 :: 		EEPROM_Write(15,OpenPhEnable);
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _OpenPhEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1562 :: 		EEPROM_Write(16,LimiterEnable);
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _LimiterEnable+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;FirmV_0_7_0.c,1564 :: 		}
	RETURN      0
; end of _SaveConfigs

_LoadConfigs:

;FirmV_0_7_0.c,1577 :: 		void LoadConfigs()
;FirmV_0_7_0.c,1579 :: 		Door1OpenTime=EEPROM_Read(1);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1580 :: 		Door2OpenTime=EEPROM_Read(2);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1581 :: 		Door1CloseTime=EEPROM_Read(3);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1582 :: 		Door2CloseTime=EEPROM_Read(4);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1583 :: 		ActionTimeDiff=EEPROM_Read(5);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1584 :: 		OpenSoftStartTime=EEPROM_Read(6);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1585 :: 		OpenSoftStopTime=EEPROM_Read(7);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1586 :: 		CloseSoftStartTime=EEPROM_Read(8);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1587 :: 		CloseSoftStopTime=EEPROM_Read(9);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1588 :: 		AutoCloseTime=EEPROM_Read(10);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _AutoCloseTime+0 
	MOVLW       0
	MOVWF       _AutoCloseTime+1 
;FirmV_0_7_0.c,1589 :: 		AutoCloseTime=AutoCloseTime<<8;
	MOVF        _AutoCloseTime+0, 0 
	MOVWF       _AutoCloseTime+1 
	CLRF        _AutoCloseTime+0 
;FirmV_0_7_0.c,1590 :: 		AutoCloseTime=AutocloseTime|EEPROM_Read(11);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	IORWF       _AutoCloseTime+0, 1 
	MOVLW       0
	IORWF       _AutoCloseTime+1, 1 
;FirmV_0_7_0.c,1591 :: 		OverloadSens=EEPROM_Read(12);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OverloadSens+0 
;FirmV_0_7_0.c,1592 :: 		SetOverloadParams(9-OverloadSens);
	MOVF        R0, 0 
	SUBLW       9
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1593 :: 		CloseAfterPass=EEPROM_Read(13);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _CloseAfterPass+0 
;FirmV_0_7_0.c,1594 :: 		LockForce=EEPROM_Read(14);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LockForce+0 
;FirmV_0_7_0.c,1595 :: 		OpenPhEnable=EEPROM_Read(15);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _OpenPhEnable+0 
;FirmV_0_7_0.c,1596 :: 		LimiterEnable=EEPROM_Read(16);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _LimiterEnable+0 
;FirmV_0_7_0.c,1598 :: 		}
	RETURN      0
; end of _LoadConfigs

_FactorySettings:

;FirmV_0_7_0.c,1611 :: 		void FactorySettings()
;FirmV_0_7_0.c,1613 :: 		Door1OpenTime=20;
	MOVLW       20
	MOVWF       _Door1OpenTime+0 
;FirmV_0_7_0.c,1614 :: 		Door1CloseTime=20;
	MOVLW       20
	MOVWF       _Door1CloseTime+0 
;FirmV_0_7_0.c,1615 :: 		Door2OpenTime=20;
	MOVLW       20
	MOVWF       _Door2OpenTime+0 
;FirmV_0_7_0.c,1616 :: 		Door2CloseTime=20;
	MOVLW       20
	MOVWF       _Door2CloseTime+0 
;FirmV_0_7_0.c,1617 :: 		OverloadSens=5;
	MOVLW       5
	MOVWF       _OverloadSens+0 
;FirmV_0_7_0.c,1618 :: 		SetOverloadParams(4);  //9-5
	MOVLW       4
	MOVWF       FARG_SetOverloadParams+0 
	CALL        _SetOverloadParams+0, 0
;FirmV_0_7_0.c,1619 :: 		OpenSoftStopTime=10;
	MOVLW       10
	MOVWF       _OpenSoftStopTime+0 
;FirmV_0_7_0.c,1620 :: 		OpenSoftStartTime=4;
	MOVLW       4
	MOVWF       _OpenSoftStartTime+0 
;FirmV_0_7_0.c,1621 :: 		CloseSoftStopTime=10;
	MOVLW       10
	MOVWF       _CloseSoftStopTime+0 
;FirmV_0_7_0.c,1622 :: 		CloseSoftStartTime=4;
	MOVLW       4
	MOVWF       _CloseSoftStartTime+0 
;FirmV_0_7_0.c,1623 :: 		ActionTimeDiff=12;
	MOVLW       12
	MOVWF       _ActionTimeDiff+0 
;FirmV_0_7_0.c,1624 :: 		AutoCloseTime=0;
	CLRF        _AutoCloseTime+0 
	CLRF        _AutoCloseTime+1 
;FirmV_0_7_0.c,1625 :: 		LockForce=0;
	CLRF        _LockForce+0 
;FirmV_0_7_0.c,1626 :: 		OpenPhEnable=0;
	CLRF        _OpenPhEnable+0 
;FirmV_0_7_0.c,1627 :: 		LimiterEnable=0;
	CLRF        _LimiterEnable+0 
;FirmV_0_7_0.c,1628 :: 		CloseAfterPass=0;
	CLRF        _CloseAfterPass+0 
;FirmV_0_7_0.c,1630 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,1631 :: 		}
	RETURN      0
; end of _FactorySettings

_StartMotor:

;FirmV_0_7_0.c,1637 :: 		void StartMotor(char Mx,char Dir)
;FirmV_0_7_0.c,1639 :: 		if(Mx==1)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor352
;FirmV_0_7_0.c,1641 :: 		Motor1Start=1;
	MOVLW       1
	MOVWF       _Motor1Start+0 
;FirmV_0_7_0.c,1642 :: 		Motor1Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor668
	BCF         PORTC+0, 4 
	GOTO        L__StartMotor669
L__StartMotor668:
	BSF         PORTC+0, 4 
L__StartMotor669:
;FirmV_0_7_0.c,1643 :: 		Motor1=1;
	BSF         PORTC+0, 1 
;FirmV_0_7_0.c,1644 :: 		}
L_StartMotor352:
;FirmV_0_7_0.c,1646 :: 		if(Mx==2)
	MOVF        FARG_StartMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StartMotor353
;FirmV_0_7_0.c,1648 :: 		Motor2Start=1;
	MOVLW       1
	MOVWF       _Motor2Start+0 
;FirmV_0_7_0.c,1649 :: 		Motor2Dir=Dir;
	BTFSC       FARG_StartMotor_Dir+0, 0 
	GOTO        L__StartMotor670
	BCF         PORTC+0, 3 
	GOTO        L__StartMotor671
L__StartMotor670:
	BSF         PORTC+0, 3 
L__StartMotor671:
;FirmV_0_7_0.c,1650 :: 		Motor2=1;
	BSF         PORTC+0, 0 
;FirmV_0_7_0.c,1651 :: 		}
L_StartMotor353:
;FirmV_0_7_0.c,1652 :: 		}
	RETURN      0
; end of _StartMotor

_StopMotor:

;FirmV_0_7_0.c,1655 :: 		void StopMotor(char Mx)
;FirmV_0_7_0.c,1657 :: 		if(Mx==1)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor354
;FirmV_0_7_0.c,1659 :: 		Motor1Start=0;
	CLRF        _Motor1Start+0 
;FirmV_0_7_0.c,1660 :: 		Motor1=0;
	BCF         PORTC+0, 1 
;FirmV_0_7_0.c,1661 :: 		}
L_StopMotor354:
;FirmV_0_7_0.c,1663 :: 		if(Mx==2)
	MOVF        FARG_StopMotor_Mx+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_StopMotor355
;FirmV_0_7_0.c,1665 :: 		Motor2Start=0;
	CLRF        _Motor2Start+0 
;FirmV_0_7_0.c,1666 :: 		Motor2=0;
	BCF         PORTC+0, 0 
;FirmV_0_7_0.c,1667 :: 		}
L_StopMotor355:
;FirmV_0_7_0.c,1668 :: 		}
	RETURN      0
; end of _StopMotor

_CheckTask:

;FirmV_0_7_0.c,1680 :: 		char CheckTask(char TaskCode)
;FirmV_0_7_0.c,1682 :: 		if(Events.Task1==TaskCode)
	MOVF        _Events+1, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask356
;FirmV_0_7_0.c,1683 :: 		{Events.Task1=0; return 1;}
	CLRF        _Events+1 
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_CheckTask356:
;FirmV_0_7_0.c,1685 :: 		if(Events.Task2==TaskCode)
	MOVF        _Events+2, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask357
;FirmV_0_7_0.c,1686 :: 		{Events.Task2=0; return 1;}
	CLRF        _Events+2 
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_CheckTask357:
;FirmV_0_7_0.c,1688 :: 		if(Events.Task3==TaskCode)
	MOVF        _Events+3, 0 
	XORWF       FARG_CheckTask_TaskCode+0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_CheckTask358
;FirmV_0_7_0.c,1689 :: 		{Events.Task3=0; return 1;}
	CLRF        _Events+3 
	MOVLW       1
	MOVWF       R0 
	RETURN      0
L_CheckTask358:
;FirmV_0_7_0.c,1691 :: 		return 0;
	CLRF        R0 
;FirmV_0_7_0.c,1693 :: 		}
	RETURN      0
; end of _CheckTask

_GetAutocloseTime:

;FirmV_0_7_0.c,1701 :: 		char GetAutocloseTime()
;FirmV_0_7_0.c,1705 :: 		for(i=0;i<20;i++)
	CLRF        GetAutocloseTime_i_L0+0 
L_GetAutocloseTime359:
	MOVLW       20
	SUBWF       GetAutocloseTime_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_GetAutocloseTime360
;FirmV_0_7_0.c,1707 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode==9))
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
L__GetAutocloseTime601:
;FirmV_0_7_0.c,1708 :: 		t=Tasks[i].Time;
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
;FirmV_0_7_0.c,1709 :: 		Tasks[i].Expired=1;
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
;FirmV_0_7_0.c,1705 :: 		for(i=0;i<20;i++)
	INCF        GetAutocloseTime_i_L0+0, 1 
;FirmV_0_7_0.c,1710 :: 		}
	GOTO        L_GetAutocloseTime359
L_GetAutocloseTime360:
;FirmV_0_7_0.c,1711 :: 		i=t-ms500;
	MOVF        _ms500+0, 0 
	SUBWF       GetAutocloseTime_t_L0+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       GetAutocloseTime_i_L0+0 
;FirmV_0_7_0.c,1712 :: 		return i;
;FirmV_0_7_0.c,1713 :: 		}
	RETURN      0
; end of _GetAutocloseTime

_ClearTasks:

;FirmV_0_7_0.c,1730 :: 		void ClearTasks(char except)
;FirmV_0_7_0.c,1733 :: 		for(i=0;i<20;i++)
	CLRF        ClearTasks_i_L0+0 
L_ClearTasks365:
	MOVLW       20
	SUBWF       ClearTasks_i_L0+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_ClearTasks366
;FirmV_0_7_0.c,1734 :: 		if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode!=except))
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
L__ClearTasks602:
;FirmV_0_7_0.c,1735 :: 		Tasks[i].Expired=1;
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
;FirmV_0_7_0.c,1733 :: 		for(i=0;i<20;i++)
	INCF        ClearTasks_i_L0+0, 1 
;FirmV_0_7_0.c,1735 :: 		Tasks[i].Expired=1;
	GOTO        L_ClearTasks365
L_ClearTasks366:
;FirmV_0_7_0.c,1736 :: 		}
	RETURN      0
; end of _ClearTasks

_Menu0:

;FirmV_0_7_0.c,1751 :: 		void Menu0()
;FirmV_0_7_0.c,1753 :: 		memcpy(LCDLine2,"                ",16);
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
;FirmV_0_7_0.c,1755 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0371
;FirmV_0_7_0.c,1756 :: 		{memcpy(LCDLine1,"00 Learning Mode",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1757 :: 		if(LearningMode==0)memcpy(LCDLine2,"      Auto      ",16);
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
;FirmV_0_7_0.c,1758 :: 		if(LearningMode==1)memcpy(LCDLine2,"     Manual     ",16);}
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
;FirmV_0_7_0.c,1760 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0374
;FirmV_0_7_0.c,1761 :: 		{memcpy(LCDLine1,"01 D1 Open Time ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1762 :: 		charValueToStr(Door1OpenTime,LCDLine2+6);}
	MOVF        _Door1OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0374:
;FirmV_0_7_0.c,1764 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0375
;FirmV_0_7_0.c,1765 :: 		{memcpy(LCDLine1,"02 D2 Open Time ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1766 :: 		charValueToStr(Door2OpenTime,LCDLine2+6);}
	MOVF        _Door2OpenTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0375:
;FirmV_0_7_0.c,1768 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0376
;FirmV_0_7_0.c,1769 :: 		{memcpy(LCDLine1,"03 D1 Close Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1770 :: 		charValueToStr(Door1CloseTime,LCDLine2+6);}
	MOVF        _Door1CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0376:
;FirmV_0_7_0.c,1772 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0377
;FirmV_0_7_0.c,1773 :: 		{memcpy(LCDLine1,"04 D2 Close Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1774 :: 		charValueToStr(Door2CloseTime,LCDLine2+6);}
	MOVF        _Door2CloseTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0377:
;FirmV_0_7_0.c,1776 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0378
;FirmV_0_7_0.c,1777 :: 		{memcpy(LCDLine1,"05 Op Soft Start",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1778 :: 		charValueToStr(OpenSoftStartTime,LCDLine2+6);}
	MOVF        _OpenSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0378:
;FirmV_0_7_0.c,1780 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0379
;FirmV_0_7_0.c,1781 :: 		{memcpy(LCDLine1,"06 Op Soft Stop ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1782 :: 		charValueToStr(OpenSoftStopTime,LCDLine2+6);}
	MOVF        _OpenSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0379:
;FirmV_0_7_0.c,1784 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0380
;FirmV_0_7_0.c,1785 :: 		{memcpy(LCDLine1,"07 Cl Soft Start",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1786 :: 		charValueToStr(CloseSoftStartTime,LCDLine2+6);}
	MOVF        _CloseSoftStartTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0380:
;FirmV_0_7_0.c,1788 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0381
;FirmV_0_7_0.c,1789 :: 		{memcpy(LCDLine1,"08 Cl Soft Stop ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1790 :: 		charValueToStr(CloseSoftStopTime,LCDLine2+6);}
	MOVF        _CloseSoftStopTime+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0381:
;FirmV_0_7_0.c,1792 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0382
;FirmV_0_7_0.c,1793 :: 		{memcpy(LCDLine1,"09 Power        ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1794 :: 		bytetostr(OverloadSens,LCDLine2+6);LCDLine2[9]=' ';}
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
;FirmV_0_7_0.c,1796 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0383
;FirmV_0_7_0.c,1797 :: 		{memcpy(LCDLine1,"10 Interval Time",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1798 :: 		charValueToStr(ActionTimeDiff,LCDLine2+6);}
	MOVF        _ActionTimeDiff+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0383:
;FirmV_0_7_0.c,1800 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0384
;FirmV_0_7_0.c,1801 :: 		{memcpy(LCDLine1,"11 Auto-close T ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1802 :: 		intValueToStr(AutoCloseTime,LCDLine2+4);}
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
;FirmV_0_7_0.c,1804 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0385
;FirmV_0_7_0.c,1805 :: 		{memcpy(LCDLine1,"12 Factory Reset",16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1807 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0386
;FirmV_0_7_0.c,1808 :: 		{memcpy(LCDLine1,"13 Open Photo En",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1809 :: 		if(OpenPhEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
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
;FirmV_0_7_0.c,1811 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0389
;FirmV_0_7_0.c,1812 :: 		{memcpy(LCDLine1,"14 Limit Enable ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1813 :: 		if(LimiterEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
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
;FirmV_0_7_0.c,1815 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0392
;FirmV_0_7_0.c,1816 :: 		{memcpy(LCDLine1,"15 Lock Force   ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1817 :: 		if(LockForce==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}
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
;FirmV_0_7_0.c,1819 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0395
;FirmV_0_7_0.c,1820 :: 		{memcpy(LCDLine1,"16 Au-Cl Pass   ",16);LCDUpdateFlag=1;
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
;FirmV_0_7_0.c,1821 :: 		charValueToStr(CloseAfterPass,LCDLine2+6);}
	MOVF        _CloseAfterPass+0, 0 
	MOVWF       FARG_charValueToStr+0 
	MOVLW       _LCDLine2+6
	MOVWF       FARG_charValueToStr+0 
	MOVLW       hi_addr(_LCDLine2+6)
	MOVWF       FARG_charValueToStr+1 
	CALL        _charValueToStr+0, 0
L_Menu0395:
;FirmV_0_7_0.c,1823 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0396
;FirmV_0_7_0.c,1824 :: 		{memcpy(LCDLine1,"17 Save Changes ",16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1826 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu0397
;FirmV_0_7_0.c,1827 :: 		{memcpy(LCDLine1,"18 Discard Exit ",16);LCDUpdateFlag=1;}
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
;FirmV_0_7_0.c,1830 :: 		State=101;
	MOVLW       101
	MOVWF       _State+0 
;FirmV_0_7_0.c,1831 :: 		}
	RETURN      0
; end of _Menu0

_Menu1:

;FirmV_0_7_0.c,1848 :: 		void Menu1()
;FirmV_0_7_0.c,1851 :: 		if((Events.Keys.b0==1))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu1398
;FirmV_0_7_0.c,1852 :: 		{if(MenuPointer==0){MenuPointer=18;}else{MenuPointer=MenuPointer-1;}State=100;}
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
;FirmV_0_7_0.c,1854 :: 		if((Events.Keys.b2==1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu1401
;FirmV_0_7_0.c,1855 :: 		{if(MenuPointer==18){MenuPointer=0;}else{MenuPointer=MenuPointer+1;}State=100;}
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
;FirmV_0_7_0.c,1857 :: 		if((Events.Keys.b1==1))
	BTFSS       _Events+0, 1 
	GOTO        L_Menu1404
;FirmV_0_7_0.c,1858 :: 		{State=102;}
	MOVLW       102
	MOVWF       _State+0 
L_Menu1404:
;FirmV_0_7_0.c,1861 :: 		}
	RETURN      0
; end of _Menu1

_Menu2:

;FirmV_0_7_0.c,1869 :: 		void Menu2()
;FirmV_0_7_0.c,1872 :: 		LCDFlash=1;
	MOVLW       1
	MOVWF       _LCDFlash+0 
;FirmV_0_7_0.c,1874 :: 		if(Events.Keys.b1==1)
	BTFSS       _Events+0, 1 
	GOTO        L_Menu2405
;FirmV_0_7_0.c,1876 :: 		LCDFlash=0;LCDFlashFlag=0;State=101;
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
	MOVLW       101
	MOVWF       _State+0 
;FirmV_0_7_0.c,1877 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2406
;FirmV_0_7_0.c,1879 :: 		if(LearningMode==0)
	MOVF        _LearningMode+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2407
;FirmV_0_7_0.c,1880 :: 		State=200;
	MOVLW       200
	MOVWF       _State+0 
L_Menu2407:
;FirmV_0_7_0.c,1881 :: 		if(LearningMode==1)
	MOVF        _LearningMode+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2408
;FirmV_0_7_0.c,1882 :: 		State=201;
	MOVLW       201
	MOVWF       _State+0 
L_Menu2408:
;FirmV_0_7_0.c,1883 :: 		}
L_Menu2406:
;FirmV_0_7_0.c,1884 :: 		}
L_Menu2405:
;FirmV_0_7_0.c,1887 :: 		if(MenuPointer==0)
	MOVF        _MenuPointer+0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2409
;FirmV_0_7_0.c,1888 :: 		{ if((Events.Keys.b0==1)&&(LearningMode>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2412
	MOVF        _LearningMode+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2412
L__Menu2634:
;FirmV_0_7_0.c,1889 :: 		{LearningMode=LearningMode-1;Menu0();State=102;}
	DECF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2412:
;FirmV_0_7_0.c,1890 :: 		if((Events.Keys.b2==1)&&(LearningMode<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2415
	MOVLW       1
	SUBWF       _LearningMode+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2415
L__Menu2633:
;FirmV_0_7_0.c,1891 :: 		{LearningMode=LearningMode+1;Menu0();State=102;}
	INCF        _LearningMode+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2415:
;FirmV_0_7_0.c,1892 :: 		}
L_Menu2409:
;FirmV_0_7_0.c,1896 :: 		if(MenuPointer==1)
	MOVF        _MenuPointer+0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2416
;FirmV_0_7_0.c,1897 :: 		{ if((Events.Keys.b0==1)&&(Door1OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2419
	MOVF        _Door1OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2419
L__Menu2632:
;FirmV_0_7_0.c,1898 :: 		{Door1OpenTime=Door1OpenTime-1;Menu0();State=102;}
	DECF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2419:
;FirmV_0_7_0.c,1899 :: 		if((Events.Keys.b2==1)&&(Door1OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2422
	MOVLW       255
	SUBWF       _Door1OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2422
L__Menu2631:
;FirmV_0_7_0.c,1900 :: 		{Door1OpenTime=Door1OpenTime+1;Menu0();State=102;}
	INCF        _Door1OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2422:
;FirmV_0_7_0.c,1901 :: 		}
L_Menu2416:
;FirmV_0_7_0.c,1905 :: 		if(MenuPointer==2)
	MOVF        _MenuPointer+0, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2423
;FirmV_0_7_0.c,1906 :: 		{ if((Events.Keys.b0==1)&&(Door2OpenTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2426
	MOVF        _Door2OpenTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2426
L__Menu2630:
;FirmV_0_7_0.c,1907 :: 		{Door2OpenTime=Door2OpenTime-1;Menu0();State=102;}
	DECF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2426:
;FirmV_0_7_0.c,1908 :: 		if((Events.Keys.b2==1)&&(Door2OpenTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2429
	MOVLW       255
	SUBWF       _Door2OpenTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2429
L__Menu2629:
;FirmV_0_7_0.c,1909 :: 		{Door2OpenTime=Door2OpenTime+1;Menu0();State=102;}
	INCF        _Door2OpenTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2429:
;FirmV_0_7_0.c,1910 :: 		}
L_Menu2423:
;FirmV_0_7_0.c,1913 :: 		if(MenuPointer==3)
	MOVF        _MenuPointer+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2430
;FirmV_0_7_0.c,1914 :: 		{ if((Events.Keys.b0==1)&&(Door1CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2433
	MOVF        _Door1CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2433
L__Menu2628:
;FirmV_0_7_0.c,1915 :: 		{Door1CloseTime=Door1CloseTime-1;Menu0();State=102;}
	DECF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2433:
;FirmV_0_7_0.c,1916 :: 		if((Events.Keys.b2==1)&&(Door1CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2436
	MOVLW       255
	SUBWF       _Door1CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2436
L__Menu2627:
;FirmV_0_7_0.c,1917 :: 		{Door1CloseTime=Door1CloseTime+1;Menu0();State=102;}
	INCF        _Door1CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2436:
;FirmV_0_7_0.c,1918 :: 		}
L_Menu2430:
;FirmV_0_7_0.c,1921 :: 		if(MenuPointer==4)
	MOVF        _MenuPointer+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2437
;FirmV_0_7_0.c,1922 :: 		{ if((Events.Keys.b0==1)&&(Door2CloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2440
	MOVF        _Door2CloseTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2440
L__Menu2626:
;FirmV_0_7_0.c,1923 :: 		{Door2CloseTime=Door2CloseTime-1;Menu0();State=102;}
	DECF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2440:
;FirmV_0_7_0.c,1924 :: 		if((Events.Keys.b2==1)&&(Door2CloseTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2443
	MOVLW       255
	SUBWF       _Door2CloseTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2443
L__Menu2625:
;FirmV_0_7_0.c,1925 :: 		{Door2CloseTime=Door2CloseTime+1;Menu0();State=102;}
	INCF        _Door2CloseTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2443:
;FirmV_0_7_0.c,1926 :: 		}
L_Menu2437:
;FirmV_0_7_0.c,1930 :: 		if(MenuPointer==5)
	MOVF        _MenuPointer+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2444
;FirmV_0_7_0.c,1931 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2447
	MOVF        _OpenSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2447
L__Menu2624:
;FirmV_0_7_0.c,1932 :: 		{OpenSoftStartTime=OpenSoftStartTime-1;Menu0();State=102;}
	DECF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2447:
;FirmV_0_7_0.c,1933 :: 		if((Events.Keys.b2==1)&&(OpenSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2450
	MOVLW       255
	SUBWF       _OpenSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2450
L__Menu2623:
;FirmV_0_7_0.c,1934 :: 		{OpenSoftStartTime=OpenSoftStartTime+1;Menu0();State=102;}
	INCF        _OpenSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2450:
;FirmV_0_7_0.c,1935 :: 		}
L_Menu2444:
;FirmV_0_7_0.c,1938 :: 		if(MenuPointer==6)
	MOVF        _MenuPointer+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2451
;FirmV_0_7_0.c,1939 :: 		{ if((Events.Keys.b0==1)&&(OpenSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2454
	MOVF        _OpenSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2454
L__Menu2622:
;FirmV_0_7_0.c,1940 :: 		{OpenSoftStopTime=OpenSoftStopTime-1;Menu0();State=102;}
	DECF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2454:
;FirmV_0_7_0.c,1941 :: 		if((Events.Keys.b2==1)&&(OpenSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2457
	MOVLW       255
	SUBWF       _OpenSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2457
L__Menu2621:
;FirmV_0_7_0.c,1942 :: 		{OpenSoftStopTime=OpenSoftStopTime+1;Menu0();State=102;}
	INCF        _OpenSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2457:
;FirmV_0_7_0.c,1943 :: 		}
L_Menu2451:
;FirmV_0_7_0.c,1946 :: 		if(MenuPointer==7)
	MOVF        _MenuPointer+0, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2458
;FirmV_0_7_0.c,1947 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStartTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2461
	MOVF        _CloseSoftStartTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2461
L__Menu2620:
;FirmV_0_7_0.c,1948 :: 		{CloseSoftStartTime=CloseSoftStartTime-1;Menu0();State=102;}
	DECF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2461:
;FirmV_0_7_0.c,1949 :: 		if((Events.Keys.b2==1)&&(CloseSoftStartTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2464
	MOVLW       255
	SUBWF       _CloseSoftStartTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2464
L__Menu2619:
;FirmV_0_7_0.c,1950 :: 		{CloseSoftStartTime=CloseSoftStartTime+1;Menu0();State=102;}
	INCF        _CloseSoftStartTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2464:
;FirmV_0_7_0.c,1951 :: 		}
L_Menu2458:
;FirmV_0_7_0.c,1954 :: 		if(MenuPointer==8)
	MOVF        _MenuPointer+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2465
;FirmV_0_7_0.c,1955 :: 		{ if((Events.Keys.b0==1)&&(CloseSoftStopTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2468
	MOVF        _CloseSoftStopTime+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2468
L__Menu2618:
;FirmV_0_7_0.c,1956 :: 		{CloseSoftStopTime=CloseSoftStopTime-1;Menu0();State=102;}
	DECF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2468:
;FirmV_0_7_0.c,1957 :: 		if((Events.Keys.b2==1)&&(CloseSoftStopTime<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2471
	MOVLW       255
	SUBWF       _CloseSoftStopTime+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2471
L__Menu2617:
;FirmV_0_7_0.c,1958 :: 		{CloseSoftStopTime=CloseSoftStopTime+1;Menu0();State=102;}
	INCF        _CloseSoftStopTime+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2471:
;FirmV_0_7_0.c,1959 :: 		}
L_Menu2465:
;FirmV_0_7_0.c,1963 :: 		if(MenuPointer==9)
	MOVF        _MenuPointer+0, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2472
;FirmV_0_7_0.c,1964 :: 		{ if((Events.Keys.b0==1)&&(OverloadSens>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2475
	MOVF        _OverloadSens+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2475
L__Menu2616:
;FirmV_0_7_0.c,1965 :: 		{OverloadSens=OverloadSens-1;Menu0();State=102;}
	DECF        _OverloadSens+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2475:
;FirmV_0_7_0.c,1966 :: 		if((Events.Keys.b2==1)&&(OverloadSens<9))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2478
	MOVLW       9
	SUBWF       _OverloadSens+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2478
L__Menu2615:
;FirmV_0_7_0.c,1967 :: 		{OverloadSens=OverloadSens+1;Menu0();State=102;}
	INCF        _OverloadSens+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2478:
;FirmV_0_7_0.c,1968 :: 		}
L_Menu2472:
;FirmV_0_7_0.c,1971 :: 		if(MenuPointer==10)
	MOVF        _MenuPointer+0, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2479
;FirmV_0_7_0.c,1972 :: 		{ if((Events.Keys.b0==1)&&(ActionTimeDiff>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2482
	MOVF        _ActionTimeDiff+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2482
L__Menu2614:
;FirmV_0_7_0.c,1973 :: 		{ActionTimeDiff=ActionTimeDiff-1;Menu0();State=102;}
	DECF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2482:
;FirmV_0_7_0.c,1974 :: 		if((Events.Keys.b2==1)&&(ActionTimeDiff<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2485
	MOVLW       255
	SUBWF       _ActionTimeDiff+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2485
L__Menu2613:
;FirmV_0_7_0.c,1975 :: 		{ActionTimeDiff=ActionTimeDiff+1;Menu0();State=102;}
	INCF        _ActionTimeDiff+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2485:
;FirmV_0_7_0.c,1976 :: 		}
L_Menu2479:
;FirmV_0_7_0.c,1979 :: 		if(MenuPointer==11)
	MOVF        _MenuPointer+0, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2486
;FirmV_0_7_0.c,1980 :: 		{ if((Events.Keys.b0==1)&&(AutoCloseTime>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2489
	MOVLW       0
	MOVWF       R0 
	MOVF        _AutoCloseTime+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu2672
	MOVF        _AutoCloseTime+0, 0 
	SUBLW       0
L__Menu2672:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2489
L__Menu2612:
;FirmV_0_7_0.c,1981 :: 		{AutoCloseTime=AutoCloseTime-1;Menu0();State=102;}
	MOVLW       1
	SUBWF       _AutoCloseTime+0, 1 
	MOVLW       0
	SUBWFB      _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2489:
;FirmV_0_7_0.c,1982 :: 		if((Events.Keys.b2==1)&&(AutoCloseTime<65000))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2492
	MOVLW       253
	SUBWF       _AutoCloseTime+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__Menu2673
	MOVLW       232
	SUBWF       _AutoCloseTime+0, 0 
L__Menu2673:
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2492
L__Menu2611:
;FirmV_0_7_0.c,1983 :: 		{AutoCloseTime=AutoCloseTime+1;Menu0();State=102;}
	INFSNZ      _AutoCloseTime+0, 1 
	INCF        _AutoCloseTime+1, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2492:
;FirmV_0_7_0.c,1984 :: 		}
L_Menu2486:
;FirmV_0_7_0.c,1987 :: 		if(MenuPointer==12)
	MOVF        _MenuPointer+0, 0 
	XORLW       12
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2493
;FirmV_0_7_0.c,1989 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,1990 :: 		memcpy(LCDLine1,"                ",16);
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
;FirmV_0_7_0.c,1991 :: 		memcpy(LCDLine2,"                ",16);
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
;FirmV_0_7_0.c,1992 :: 		LCDFlash=0; LCDFlashFlag=0;
	CLRF        _LCDFlash+0 
	CLRF        _LCDFlashFlag+0 
;FirmV_0_7_0.c,1993 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,1994 :: 		FactorySettings();
	CALL        _FactorySettings+0, 0
;FirmV_0_7_0.c,1995 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,1996 :: 		}
L_Menu2493:
;FirmV_0_7_0.c,1999 :: 		if(MenuPointer==13)
	MOVF        _MenuPointer+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2494
;FirmV_0_7_0.c,2000 :: 		{ if((Events.Keys.b0==1)&&(OpenPhEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2497
	MOVF        _OpenPhEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2497
L__Menu2610:
;FirmV_0_7_0.c,2001 :: 		{OpenPhEnable=OpenPhEnable-1;Menu0();State=102;}
	DECF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2497:
;FirmV_0_7_0.c,2002 :: 		if((Events.Keys.b2==1)&&(OpenPhEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2500
	MOVLW       1
	SUBWF       _OpenPhEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2500
L__Menu2609:
;FirmV_0_7_0.c,2003 :: 		{OpenPhEnable=OpenPhEnable+1;Menu0();State=102;}
	INCF        _OpenPhEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2500:
;FirmV_0_7_0.c,2004 :: 		}
L_Menu2494:
;FirmV_0_7_0.c,2008 :: 		if(MenuPointer==14)
	MOVF        _MenuPointer+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2501
;FirmV_0_7_0.c,2009 :: 		{ if((Events.Keys.b0==1)&&(LimiterEnable>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2504
	MOVF        _LimiterEnable+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2504
L__Menu2608:
;FirmV_0_7_0.c,2010 :: 		{LimiterEnable=LimiterEnable-1;Menu0();State=102;}
	DECF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2504:
;FirmV_0_7_0.c,2011 :: 		if((Events.Keys.b2==1)&&(LimiterEnable<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2507
	MOVLW       1
	SUBWF       _LimiterEnable+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2507
L__Menu2607:
;FirmV_0_7_0.c,2012 :: 		{LimiterEnable=LimiterEnable+1;Menu0();State=102;}
	INCF        _LimiterEnable+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2507:
;FirmV_0_7_0.c,2013 :: 		}
L_Menu2501:
;FirmV_0_7_0.c,2016 :: 		if(MenuPointer==15)
	MOVF        _MenuPointer+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2508
;FirmV_0_7_0.c,2017 :: 		{ if((Events.Keys.b0==1)&&(LockForce>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2511
	MOVF        _LockForce+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2511
L__Menu2606:
;FirmV_0_7_0.c,2018 :: 		{LockForce=LockForce-1;Menu0();State=102;}
	DECF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2511:
;FirmV_0_7_0.c,2019 :: 		if((Events.Keys.b2==1)&&(LockForce<1))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2514
	MOVLW       1
	SUBWF       _LockForce+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2514
L__Menu2605:
;FirmV_0_7_0.c,2020 :: 		{LockForce=LockForce+1;Menu0();State=102;}
	INCF        _LockForce+0, 1 
	CALL        _Menu0+0, 0
	MOVLW       102
	MOVWF       _State+0 
L_Menu2514:
;FirmV_0_7_0.c,2021 :: 		}
L_Menu2508:
;FirmV_0_7_0.c,2024 :: 		if(MenuPointer==16)
	MOVF        _MenuPointer+0, 0 
	XORLW       16
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2515
;FirmV_0_7_0.c,2025 :: 		{ if((Events.Keys.b0==1)&&(CloseAfterPass>0))
	BTFSS       _Events+0, 0 
	GOTO        L_Menu2518
	MOVF        _CloseAfterPass+0, 0 
	SUBLW       0
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2518
L__Menu2604:
;FirmV_0_7_0.c,2026 :: 		{CloseAfterPass=CloseAfterPass-1;if(CloseAfterPass==9) CloseAfterPass=0;Menu0();State=102;}
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
;FirmV_0_7_0.c,2027 :: 		if((Events.Keys.b2==1)&&(CloseAfterPass<255))
	BTFSS       _Events+0, 2 
	GOTO        L_Menu2522
	MOVLW       255
	SUBWF       _CloseAfterPass+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_Menu2522
L__Menu2603:
;FirmV_0_7_0.c,2028 :: 		{CloseAfterPass=CloseAfterPass+1;if(CloseAfterPass==1) CloseAfterPass=10;Menu0();State=102;}
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
;FirmV_0_7_0.c,2029 :: 		}
L_Menu2515:
;FirmV_0_7_0.c,2032 :: 		if(MenuPointer==17)
	MOVF        _MenuPointer+0, 0 
	XORLW       17
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2524
;FirmV_0_7_0.c,2034 :: 		State=103;
	MOVLW       103
	MOVWF       _State+0 
;FirmV_0_7_0.c,2035 :: 		memcpy(LCDLine1,"                ",16);
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
;FirmV_0_7_0.c,2036 :: 		memcpy(LCDLine2,"                ",16);
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
;FirmV_0_7_0.c,2037 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2038 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2039 :: 		}
L_Menu2524:
;FirmV_0_7_0.c,2042 :: 		if(MenuPointer==18)
	MOVF        _MenuPointer+0, 0 
	XORLW       18
	BTFSS       STATUS+0, 2 
	GOTO        L_Menu2525
;FirmV_0_7_0.c,2044 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2045 :: 		memcpy(LCDLine1,"                ",16);
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
;FirmV_0_7_0.c,2046 :: 		memcpy(LCDLine2,"                ",16);
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
;FirmV_0_7_0.c,2047 :: 		LCDFlash=0;
	CLRF        _LCDFlash+0 
;FirmV_0_7_0.c,2048 :: 		LCDUpdateFlag=1;
	MOVLW       1
	MOVWF       _LCDUpdateFlag+0 
;FirmV_0_7_0.c,2049 :: 		LoadConfigs();
	CALL        _LoadConfigs+0, 0
;FirmV_0_7_0.c,2050 :: 		}
L_Menu2525:
;FirmV_0_7_0.c,2051 :: 		}
	RETURN      0
; end of _Menu2

_Menu3:

;FirmV_0_7_0.c,2063 :: 		void Menu3()
;FirmV_0_7_0.c,2065 :: 		SaveConfigs();
	CALL        _SaveConfigs+0, 0
;FirmV_0_7_0.c,2066 :: 		State=0;
	CLRF        _State+0 
;FirmV_0_7_0.c,2067 :: 		}
	RETURN      0
; end of _Menu3

_LearnAuto:

;FirmV_0_7_0.c,2081 :: 		void LearnAuto()
;FirmV_0_7_0.c,2083 :: 		}
	RETURN      0
; end of _LearnAuto

_LearnManual:

;FirmV_0_7_0.c,2096 :: 		void LearnManual()
;FirmV_0_7_0.c,2098 :: 		}
	RETURN      0
; end of _LearnManual

_charValueToStr:

;FirmV_0_7_0.c,2106 :: 		void charValueToStr(char val, char * string)
;FirmV_0_7_0.c,2108 :: 		bytetostr(val>>1,string);
	MOVF        FARG_charValueToStr_val+0, 0 
	MOVWF       FARG_ByteToStr_input+0 
	RRCF        FARG_ByteToStr_input+0, 1 
	BCF         FARG_ByteToStr_input+0, 7 
	MOVF        FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_ByteToStr_output+0 
	MOVF        FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_ByteToStr_output+1 
	CALL        _ByteToStr+0, 0
;FirmV_0_7_0.c,2109 :: 		if((val%2)==1)
	MOVLW       1
	ANDWF       FARG_charValueToStr_val+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_charValueToStr526
;FirmV_0_7_0.c,2110 :: 		memcpy(string+3,".5s",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       46
	MOVWF       ?lstr103_FirmV_0_7_0+0 
	MOVLW       53
	MOVWF       ?lstr103_FirmV_0_7_0+1 
	MOVLW       115
	MOVWF       ?lstr103_FirmV_0_7_0+2 
	CLRF        ?lstr103_FirmV_0_7_0+3 
	MOVLW       ?lstr103_FirmV_0_7_0+0
	MOVWF       FARG_memcpy_s1+0 
	MOVLW       hi_addr(?lstr103_FirmV_0_7_0+0)
	MOVWF       FARG_memcpy_s1+1 
	MOVLW       4
	MOVWF       FARG_memcpy_n+0 
	MOVLW       0
	MOVWF       FARG_memcpy_n+1 
	CALL        _memcpy+0, 0
	GOTO        L_charValueToStr527
L_charValueToStr526:
;FirmV_0_7_0.c,2112 :: 		memcpy(string+3,"s  ",4);
	MOVLW       3
	ADDWF       FARG_charValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_charValueToStr_string+1, 0 
	MOVWF       FARG_memcpy_d1+1 
	MOVLW       115
	MOVWF       ?lstr104_FirmV_0_7_0+0 
	MOVLW       32
	MOVWF       ?lstr104_FirmV_0_7_0+1 
	MOVLW       32
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
L_charValueToStr527:
;FirmV_0_7_0.c,2113 :: 		}
	RETURN      0
; end of _charValueToStr

_intValueToStr:

;FirmV_0_7_0.c,2126 :: 		void intValueToStr(unsigned val, char * string)
;FirmV_0_7_0.c,2128 :: 		wordtostr(val>>1,string);
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
;FirmV_0_7_0.c,2129 :: 		if((val%2)==1)
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
	GOTO        L__intValueToStr674
	MOVLW       1
	XORWF       R1, 0 
L__intValueToStr674:
	BTFSS       STATUS+0, 2 
	GOTO        L_intValueToStr528
;FirmV_0_7_0.c,2130 :: 		memcpy(string+5,".5s",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
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
	GOTO        L_intValueToStr529
L_intValueToStr528:
;FirmV_0_7_0.c,2132 :: 		memcpy(string+5,"s  ",4);
	MOVLW       5
	ADDWF       FARG_intValueToStr_string+0, 0 
	MOVWF       FARG_memcpy_d1+0 
	MOVLW       0
	ADDWFC      FARG_intValueToStr_string+1, 0 
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
L_intValueToStr529:
;FirmV_0_7_0.c,2133 :: 		}
	RETURN      0
; end of _intValueToStr

_SetOverloadParams:

;FirmV_0_7_0.c,2145 :: 		void SetOverloadParams(char p)
;FirmV_0_7_0.c,2148 :: 		switch(p)
	GOTO        L_SetOverloadParams530
;FirmV_0_7_0.c,2150 :: 		case 0: OverloadTreshold=0;OverloadDuration=255; break;
L_SetOverloadParams532:
	CLRF        _OverloadTreshold+0 
	CLRF        _OverloadTreshold+1 
	MOVLW       255
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams531
;FirmV_0_7_0.c,2152 :: 		case 1: OverloadTreshold=400;OverloadDuration=200; break;
L_SetOverloadParams533:
	MOVLW       144
	MOVWF       _OverloadTreshold+0 
	MOVLW       1
	MOVWF       _OverloadTreshold+1 
	MOVLW       200
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams531
;FirmV_0_7_0.c,2154 :: 		case 2: OverloadTreshold=450;OverloadDuration=150; break;
L_SetOverloadParams534:
	MOVLW       194
	MOVWF       _OverloadTreshold+0 
	MOVLW       1
	MOVWF       _OverloadTreshold+1 
	MOVLW       150
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams531
;FirmV_0_7_0.c,2156 :: 		case 3: OverloadTreshold=500;OverloadDuration=100; break;
L_SetOverloadParams535:
	MOVLW       244
	MOVWF       _OverloadTreshold+0 
	MOVLW       1
	MOVWF       _OverloadTreshold+1 
	MOVLW       100
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams531
;FirmV_0_7_0.c,2158 :: 		case 4: OverloadTreshold=550;OverloadDuration=80; break;
L_SetOverloadParams536:
	MOVLW       38
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       80
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams531
;FirmV_0_7_0.c,2160 :: 		case 5: OverloadTreshold=600;OverloadDuration=150; break;
L_SetOverloadParams537:
	MOVLW       88
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       150
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams531
;FirmV_0_7_0.c,2162 :: 		case 6: OverloadTreshold=600;OverloadDuration=100; break;
L_SetOverloadParams538:
	MOVLW       88
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       100
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams531
;FirmV_0_7_0.c,2164 :: 		case 7: OverloadTreshold=600;OverloadDuration=50; break;
L_SetOverloadParams539:
	MOVLW       88
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       50
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams531
;FirmV_0_7_0.c,2166 :: 		case 8: OverloadTreshold=700;OverloadDuration=100; break;
L_SetOverloadParams540:
	MOVLW       188
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       100
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams531
;FirmV_0_7_0.c,2168 :: 		case 9: OverloadTreshold=700;OverloadDuration=50; break;
L_SetOverloadParams541:
	MOVLW       188
	MOVWF       _OverloadTreshold+0 
	MOVLW       2
	MOVWF       _OverloadTreshold+1 
	MOVLW       50
	MOVWF       _OverloadDuration+0 
	GOTO        L_SetOverloadParams531
;FirmV_0_7_0.c,2170 :: 		}
L_SetOverloadParams530:
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams532
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams533
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams534
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams535
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams536
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams537
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams538
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams539
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams540
	MOVF        FARG_SetOverloadParams_p+0, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SetOverloadParams541
L_SetOverloadParams531:
;FirmV_0_7_0.c,2171 :: 		}
	RETURN      0
; end of _SetOverloadParams
