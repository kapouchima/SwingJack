#line 1 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
#line 10 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
sbit LCD_RS at RE2_bit;
sbit LCD_EN at RE1_bit;
sbit LCD_D4 at RB4_bit;
sbit LCD_D5 at RB5_bit;
sbit LCD_D6 at RB6_bit;
sbit LCD_D7 at RB7_bit;

sbit LCD_RS_Direction at TRISE2_bit;
sbit LCD_EN_Direction at TRISE1_bit;
sbit LCD_D4_Direction at TRISB4_bit;
sbit LCD_D5_Direction at TRISB5_bit;
sbit LCD_D6_Direction at TRISB6_bit;
sbit LCD_D7_Direction at TRISB7_bit;
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/built_in.h"
#line 64 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
typedef struct
{
char TaskCode;
unsigned long Time;
char Expired;
char Fired;
} Task;


typedef struct
{
char Keys;
char Task1;
char Task2;
char Task3;
char Remote;
char Overload;
char Photocell;
char Limiter;
char ExternalKeys;
} Eve;


 char _opening[]="Door Opening    ";
 char _closing[]="Door Closing    ";
 char _open[]= "Door is Open    ";
 char _close[]= "Door is Close   ";
 char _stop[]= "Door Stoped     ";
 char _autoclose[]="Autoclose Enable";
 char _errRemote[]="Err Remote      ";
 char _errPhoto[]= "Err Photocell   ";
 char _errOverload[]="Err Overload    ";
 char _errLimit[]= "Err Limit Switch";
 char _Blank[]= "                ";




unsigned long ms500=0;
char msCounter=0,ms20A=0,ms20B,Flag20ms=1,Flag500ms=1,State=0,LCDUpdateFlag=0,LCDFlashFlag=0,RemotePulse1=0,RemotePulse2=0;
char PrevRemotePulseTime1=0,PrevRemotePulseTime2=0,RemoteAFlag=0,RemoteBFlag=0,Motor1FullSpeed=1,Motor2FullSpeed=1;
char Motor1Start=0,Motor2Start=0,ZCCounter=0,OverloadCounter1=0,OverloadCounter2=0,PhotocellOpenFlag=0,ActiveDoors=0;
char OverloadCheckFlag1=0,OverloadCheckFlag2=0,OpenDone=3,CloseDone=3,M1isSlow=0,M2isSlow=0,PassFlag=0;
char _AC=0,PhotocellCount=0,MenuPointer=0,DebouncingDelay=0,LCDFlash=0,Pressed=0,OverloadSens=5,LearningMode=0;
char t[11];
unsigned long temp;

char Door1OpenTime,Door2OpenTime,Door1CloseTime,Door2CloseTime,OverloadDuration,OpenPhEnable,LimiterEnable;
char OpenSoftStopTime,CloseSoftStopTime,OpenSoftStartTime,CloseSoftStartTime,ActionTimeDiff,LockForce,CloseAfterPass;
unsigned AutoCloseTime,OverloadTreshold;

char LCDLine1[17]="                ";
char LCDLine2[17]="                ";
Task Tasks[20];
Eve Events;
#line 134 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void Init();
void TaskManager();
void AddTask(unsigned long,char);
void EventHandler();
char GetKeysState();
char GetRemoteState();
char GetOverloadState();
char GetPhotocellState();
char GetExternalKeysState();
char GetLimitSwitchState();
void StateManager();
void LCDUpdater();
void State0();
void State1();
void State2();
void State3();
void State4();
void State5();
void State6();
void State7();
void State8();
void State00();
void StateTest();
void Menu0();
void Menu1();
void Menu2();
void Menu3();
void LearnAuto();
void LearnManual();

void SetMotorSpeed(char,char);
void OverloadInit(char);
void SaveConfigs();
void LoadConfigs();
void StartMotor(char,char);
void StopMotor(char);
char CheckTask(char);
char GetAutocloseTime();
void FactorySettings();
void Logger(char *);
void ClearTasks(char);
void charValueToStr(char,char*);
void intValueToStr(unsigned,char*);
void SetOverloadParams(char);
#line 191 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void interrupt()
{
 if(TMR0IF_bit)
 {
 msCounter=msCounter+1;
  portb.b3 =1;
 Flag20ms=1;
 if(ms20A==255)
 {ms20A=0;RemotePulse1=0;}
 else
 ms20A=ms20A+1;

 if(ms20B==255)
 {ms20B=0;RemotePulse2=0;}
 else
 ms20B=ms20B+1;

 if(msCounter>=25)
 {
 msCounter=0;
 ms500=ms500+1;
 LCDFlashFlag=!LCDFlashFlag;
  portb.b3 =0;
 Flag500ms=1;
 }
 tmr0h=0xF3;
 tmr0l=0xCA;
 TMR0IF_bit=0;
 }


 if(INT1F_bit)
 {
 if(RemotePulse1==0)
 { RemotePulse1=RemotePulse1+1;ms20A=0;}
 else
 { RemotePulse1=RemotePulse1+1;}
 if(RemotePulse1>=5)
 if((ms20A>=19)&&(ms20A<=21))
 {RemoteAFlag=1;RemotePulse1=0;}
 else
 RemotePulse1=0;
 INT1IF_bit=0;
 }



 if(INT2IF_bit)
 {
 if(RemotePulse2==0)
 { RemotePulse2=RemotePulse2+1;ms20B=0;}
 else
 { RemotePulse2=RemotePulse2+1;}
 if(RemotePulse2>=5)
 if((ms20B>=19)&&(ms20B<=21))
 {RemoteBFlag=1;RemotePulse2=0;}
 else
 RemotePulse2=0;
 INT2IF_bit=0;
 }




 if(INT0F_bit==1)
 {
 ZCCounter=ZCCounter+1;
 if(ZCCounter==255)
 ZCCounter=0;
 if(ZCCounter%3==1)
 {
 if(Motor1Start)
 if(Motor1FullSpeed)
  portc.b1 =1;
 else
  portc.b1 =0;

 if(Motor2Start)
 if(Motor2FullSpeed)
  portc.b0 =1;
 else
  portc.b0 =0;
 }
 if(ZCCounter%3==0)
 {
 if(Motor1Start)
  portc.b1 =1;

 if(Motor2Start)
  portc.b0 =1;
 }
 INT0F_bit=0;
 }
}
#line 297 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void ResetTaskEvents()
{
 Events.Task1=0;
 Events.Task2=0;
 Events.Task3=0;
}
#line 314 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void Logger(char* text)
{
 char time[11];
 longwordtostrwithzeros(ms500,time);
 uart_write_text(time);
 uart1_write_text(": ");
 uart1_write_text(text);
 uart1_write(10);
 uart1_write(13);
}
#line 340 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void main() {

 portc.b5 =1;

Init();

Logger("Start ...");



while(1)
{
 if(Flag20ms==1)
 {
 if(DebouncingDelay< 5 )
 DebouncingDelay=DebouncingDelay+1;
 LCDUpdater();
 Flag20ms=0;
 }

 if(Flag500ms==1)
 {
 ResetTaskEvents();
 TaskManager();
 Flag500ms=0;
 }
 EventHandler();
 StateManager();
}

}
#line 395 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void StateManager()
{




switch(State)
{

case 0: State1(); break;

case 1: State1(); break;

case 2: State2(); break;

case 3: State3(); break;

case 4: State4(); break;

case 5: State5(); break;

case 6: State6(); break;

case 7: State7(); break;

case 8: State8(); break;

case 10:State00(); break;

case 100:Menu0(); break;

case 101:Menu1(); break;

case 102:Menu2(); break;

case 103:Menu3(); break;

case 200:LearnAuto(); break;

case 201:LearnManual(); break;

}
}



void StateTest()
{
 if (Events.Photocell==1)
 LCDLine1[0]='1';
 else
 LCDLine1[0]='0';

 LCDUpdateFlag=1;

}



void State00()
{



  portc.b2 =1;
 StartMotor(1, 0 );
 StartMotor(2, 0 );



 if(Events.Remote.b0==1)
 { portc.b2 =0;StopMotor(1);StopMotor(2);
 State=1; }
}








void State1()
{
 char delay=3;


  portc.b2 =0;

 if(Events.Keys==2)
 {State=100;MenuPointer=0;}

 ActiveDoors=3-Events.Remote;



 if(Events.Remote!=0)
 {

 ClearTasks(9);
  portc.b2 =1;
 AddTask(ms500+1,12);
 temp=ms500+delay;
 AddTask(temp,1);
 if(OpenSoftStartTime!=0)
 {AddTask(temp,7); M1isSlow=1;}
 else
 {AddTask(temp,5); M1isSlow=0;}
 temp=ms500+OpenSoftStartTime+ 2 +delay;
 AddTask(temp,10);
 temp=ms500+OpenSoftStartTime+delay;
 AddTask(temp,5);
 if(OpenSoftStopTime!=0)
 {temp=ms500+Door1OpenTime-OpenSoftStopTime+delay;AddTask(temp,7);}
 temp=ms500+Door1OpenTime+delay;
 AddTask(temp,3);

 if((Door2OpenTime!=0)&&(ActiveDoors==2))
 {
 temp=ms500+ActionTimeDiff+delay;
 AddTask(temp,2);
 if(OpenSoftStartTime!=0)
 {temp=ms500+ActionTimeDiff+delay;AddTask(temp,8); M2isSlow=1;}
 else
 {temp=ms500+ActionTimeDiff+delay;AddTask(temp,6); M2isSlow=0;}
 temp=ms500+ActionTimeDiff+OpenSoftStartTime+ 2 +delay;
 AddTask(temp,11);
 temp=ms500+ActionTimeDiff+OpenSoftStartTime+delay;
 AddTask(temp,6);
 if(OpenSoftStopTime!=0)
 {temp=ms500+ActionTimeDiff+Door2OpenTime-OpenSoftStopTime+delay;AddTask(temp,8);}
 temp=ms500+Door2OpenTime+ActionTimeDiff+delay;
 AddTask(temp,4);
 }

 if(AutoCloseTime!=0)
 {temp=ms500+AutoCloseTime+delay;AddTask(ms500+AutoCloseTime+delay,9);}

 OpenDone=3;
 OverloadCheckFlag1=0;
 OverloadCheckFlag2=0;
 State=3;
 PassFlag=0;
 }
}
#line 553 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void State2()
{
 char delay=2;

  portc.b2 =0;

 if((Events.Remote!=0)||(CheckTask(9)==1))
 {

 ClearTasks(9);
 if((Door2CloseTime==0)||(ActiveDoors==1))
 {
 temp=ms500+delay;
 AddTask(temp,1);
 if(CloseSoftStartTime!=0)
 {AddTask(temp,7); M1isSlow=1;}
 else
 {AddTask(temp,5); M1isSlow=0;}
 temp=ms500+CloseSoftStartTime+ 2 +delay;
 AddTask(temp,10);
 temp=ms500+CloseSoftStartTime+delay;
 AddTask(temp,5);
 if(CloseSoftStopTime!=0)
 {temp=ms500+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}
 if(LockForce!=0)
 {temp=ms500+Door1CloseTime+delay;AddTask(temp,5);AddTask(temp+ 3 ,3);}
 else
 {temp=ms500+Door1CloseTime+delay;AddTask(temp,3);}

 }

 if((Door2CloseTime!=0)&&(ActiveDoors=2))
 {
 temp=ms500+delay;
 AddTask(temp,2);
 if(CloseSoftStartTime!=0)
 {AddTask(temp,8); M2isSlow=1;}
 else
 {AddTask(temp,6); M2isSlow=0;}
 temp=ms500+CloseSoftStartTime+ 2 +delay;
 AddTask(temp,11);
 temp=ms500+CloseSoftStartTime+delay;
 AddTask(temp,6);
 if(CloseSoftStopTime!=0)
 {temp=ms500+Door2CloseTime-CloseSoftStopTime+delay;AddTask(temp,8);}

 temp=ms500+Door2CloseTime+delay;
 AddTask(temp,4);



 temp=ms500+ActionTimeDiff+delay;
 AddTask(temp,1);
 if(CloseSoftStartTime!=0)
 {AddTask(temp,7); M1isSlow=1;}
 else
 {AddTask(temp,5); M1isSlow=0;}
 temp=ms500+ActionTimeDiff+CloseSoftStartTime+ 2 +delay;
 AddTask(temp,10);
 temp=ms500+ActionTimeDiff+CloseSoftStartTime+delay;
 AddTask(temp,5);
 if(CloseSoftStopTime!=0)
 {temp=ms500+ActionTimeDiff+Door1CloseTime-CloseSoftStopTime+delay;AddTask(temp,7);}
 if(LockForce!=0)
 {temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,5);AddTask(temp+ 3 ,3);}
 else
 {temp=ms500+Door1CloseTime+ActionTimeDiff+delay;AddTask(temp,3);}

 }


 CloseDone=3;
 OverloadCheckFlag1=0;
 OverloadCheckFlag2=0;
 State=4;
 }

 if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
 {PassFlag=1; _AC=GetAutocloseTime();Logger("S2 Auto Close Deleted");}

 if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
 if(CloseAfterPass==0)
 {temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:");Logger(t);}
 else
 {temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S2 Insert 9 at:");Logger(t);}

}
#line 654 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void State3()
{
  portc.b2 =1;

 if(CheckTask(1))
 {StartMotor(1, 1 );Logger("S3 Motor1Start");  portd.b7 =0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}

 if(CheckTask(2))
 {StartMotor(2, 1 );Logger("S3 Motor2Start");  portd.b7 =0;}

 if(CheckTask(5))
 {SetMotorSpeed(1,Motor2FullSpeed);OverloadCheckFlag1=0; M1isSlow=0;Logger("S3 Motor1 Fast");}

 if(CheckTask(7))
 {SetMotorSpeed(0,Motor2FullSpeed); M1isSlow=1;Logger("S3 Motor1 Slow");}

 if(CheckTask(6))
 {SetMotorSpeed(Motor1FullSpeed,1);OverloadCheckFlag2=0; M2isSlow=0;Logger("S3 Motor2 Fast");}

 if(CheckTask(8))
 {SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S3 Motor2 Slow");}

 if(CheckTask(10))
 {OverloadCheckFlag1=1; OverloadInit(1);Logger("S3 Overflow Flag1 Set");}

 if(CheckTask(11))
 {OverloadCheckFlag2=1; OverloadInit(2);Logger("S3 Overflow Flag2 Set");}

 if(CheckTask(3))
 {OpenDone.b0=0; StopMotor(1);Logger("S3 Motor1 Stop");}

 if(CheckTask(4))
 {OpenDone.b1=0; StopMotor(2);Logger("S3 Motor2 Stop");}

 if(CheckTask(12))
 { portd.b7 =1;}

 if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
 {StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor1 Collision");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}

 if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
 {StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S3 Motor2 Collision");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}

 if((Door2OpenTime==0)||(ActiveDoors==1))
 OpenDone.b1=0;

 if((Events.Photocell.b0==1)&&(OpenPhEnable))
 {StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Photocell Int");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}

 if(Events.Remote!=0)
 {StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Remote Stoped");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}

 if((Events.Limiter==1)&&(LimiterEnable))
 {StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S3 Limit Switch Stoped");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}

 if(OpenDone==0)
 {State=2; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_blank,16);LCDUpdateFlag=1;}

 if((State==5)||(State==6))
 {ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S3 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}

}
#line 734 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void State4()
{
 portc.b2 =1;

 bytetostr(Events.Task1,LCDLine1);
 bytetostr(Events.Task2,LCDLine2);
 LCDUpdateFlag=1;

 if(CheckTask(1))
 {StartMotor(1, 0 );Logger("S4 Motor1Start");memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}

 if(CheckTask(2))
 {StartMotor(2, 0 );Logger("S4 Motor2Start");}

 if(CheckTask(10))
 {OverloadCheckFlag1=1; OverloadInit(1);Logger("S4 M1 Overload Check");}

 if(CheckTask(11))
 {OverloadCheckFlag2=1; OverloadInit(2);Logger("S4 M2 Overload Check");}

 if(CheckTask(5))
 {SetMotorSpeed(1,Motor2FullSpeed); OverloadCheckFlag1=0; M1isSlow=0;Logger("S4 M1 Speed UP");}

 if(CheckTask(7))
 {SetMotorSpeed(0,Motor2FullSpeed); OverloadCheckFlag2=0; M1isSlow=1;Logger("S4 M1 Speed Down");}

 if(CheckTask(6))
 {SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S4 M2 Speed UP");}

 if(CheckTask(8))
 {SetMotorSpeed(Motor1FullSpeed,0); M2isSlow=1;Logger("S4 M2 Speed Down");}

 if(CheckTask(3))
 {CloseDone.b0=0; StopMotor(1);Logger("S4 M1 Stoped");}

 if(CheckTask(4))
 {CloseDone.b1=0; StopMotor(2);Logger("S4 M2 Stoped");}

 if((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)&&(M1isSlow==0))
 {StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M1 Overloaded");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}

 if((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)&&(M2isSlow==0))
 {StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 M2 Overloaded");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrOverload,16);LCDUpdateFlag=1;}

 if((Door2OpenTime==0)||(ActiveDoors==1))
 CloseDone.b1=0;

 if((Events.Photocell.b0==1))
 {StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S4 Photocell Int");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}

 if((Events.Limiter==1)&&(LimiterEnable))
 {StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Limit Switch Stop");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}

 if((Events.Remote!=0))
 {StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S4 Remote Pressed");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}

 if(CloseDone==0)
 {State=1; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}

 if((State==5)||(State==6))
 {ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S4 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}

}
#line 816 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void State5()
{
 char delay=2;
  portc.b2 =0;
 if((Events.Remote!=0)||(CheckTask(9)==1))
 {
 if((Door2CloseTime==0)||(ActiveDoors==1))
 {
 ClearTasks(9);
 temp=ms500+delay;
 AddTask(temp,1);
 AddTask(temp,5);
 M1isSlow=0;
 temp=ms500+ 2 +delay;
 AddTask(temp,10);
 temp=ms500+Door1CloseTime+delay;
 AddTask(temp,3);
 }
 if((Door2CloseTime!=0)&&(ActiveDoors==2))
 {
 ClearTasks(9);
 temp=ms500+delay;
 AddTask(temp,2);
 AddTask(temp,6);
 M1isSlow=0;
 temp=ms500+ 2 +delay;
 AddTask(temp,11);
 temp=ms500+Door1CloseTime+delay;
 AddTask(temp,4);




 temp=ms500+ActionTimeDiff+delay;
 AddTask(temp,1);
 temp=ms500+ActionTimeDiff+delay;
 AddTask(temp,5);
 M2isSlow=0;
 temp=ms500+ActionTimeDiff+ 2 +delay;
 AddTask(temp,10);
 temp=ms500+Door2CloseTime+delay;
 AddTask(temp,3);
 }
 CloseDone=3;
 OverloadCheckFlag1=0;
 OverloadCheckFlag2=0;
 State=7;
 }

 if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
 {PassFlag=1; _AC=GetAutocloseTime();Logger("S5 Auto Close Deleted");}

 if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
 {
 if(1)
 {temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:");Logger(t);}
 else
 {temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S5 Insert 9 at:");Logger(t);}
 }

}
#line 896 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void State6()
{


 char delay=3;
  portc.b2 =0;
 if((Events.Remote!=0)||(PhotocellOpenFlag))
 {
 PhotocellOpenFlag=0;
  portc.b2 =1;
 ClearTasks(9);
 AddTask(ms500+1,12);
 temp=ms500+delay;
 AddTask(temp,1);
 AddTask(temp,5);
 M1isSlow=0;
 temp=ms500+ 2 +delay;
 AddTask(temp,10);
 temp=ms500+Door1OpenTime+delay;
 AddTask(temp,3);
 if((Door2OpenTime!=0)&&(ActiveDoors==2))
 {
 AddTask(ms500+ActionTimeDiff+delay,2);
 AddTask(ms500+ActionTimeDiff+delay,6);
 M2isSlow=0;
 AddTask(ms500+ActionTimeDiff+ 2 +delay,11);
 AddTask(ms500+Door2OpenTime+delay,4);
 }
 OpenDone=3;
 OverloadCheckFlag1=0;
 OverloadCheckFlag2=0;
 PassFlag=0;
 State=8;
 }


 if(CheckTask(9)==1)
 {
 ClearTasks(9);
 temp=ms500+delay;
 AddTask(temp,1);
 AddTask(temp,5);
 M1isSlow=0;
 temp=ms500+ 2 +delay;
 AddTask(temp,10);
 temp=ms500+Door1CloseTime+delay;
 AddTask(temp,3);

 if((Door2CloseTime!=0)&&(ActiveDoors==2))
 {
 AddTask(ms500+ActionTimeDiff+delay,2);
 AddTask(ms500+ActionTimeDiff+delay,6);
 M2isSlow=0;
 AddTask(ms500+ActionTimeDiff+ 2 +delay,11);
 AddTask(ms500+Door1CloseTime+delay,4);
 }
 CloseDone=3;
 OverloadCheckFlag1=0;
 OverloadCheckFlag2=0;
 PassFlag=0;
 State=7;
 }

 if((Events.Photocell.b0==1)&&(AutoCloseTime!=0)&&(PassFlag==0))
 {PassFlag=1; _AC=GetAutocloseTime();Logger("S6 Auto Close Deleted");}

 if((PassFlag==1)&&(Events.Photocell.b0==0)&&(AutoCloseTime!=0))
 {if(1)
 {temp=ms500+_AC;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:");Logger(t);}
 else
 {temp=ms500+CloseAfterPass;AddTask(temp,9);PassFlag=0;longwordtostrwithzeros(temp,t);Logger("S6 Insert 9 at:");Logger(t);}
 }

}
#line 991 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void State7()
{
  portc.b2 =1;

 if(CheckTask(1))
 {StartMotor(1, 0 );Logger("S7 Motor1Start");memcpy(LCDLine1,_closing,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}

 if(CheckTask(2))
 {StartMotor(2, 0 );Logger("S7 Motor2Start");}

 if(CheckTask(10))
 {OverloadCheckFlag1=1; OverloadInit(1);Logger("S7 M1 Overload Check");}

 if(CheckTask(11))
 {OverloadCheckFlag2=1; OverloadInit(2);Logger("S7 M2 Overload Check");}

 if(CheckTask(5))
 {SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S7 M1 Speed UP");}

 if(CheckTask(6))
 {SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S7 M2 Speed UP");}

 if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(CloseDone.b0))
 {CloseDone.b0=0; StopMotor(1);Logger("S7 M1 Stoped");}

 if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(CloseDone.b1))
 {CloseDone.b1=0; StopMotor(2);Logger("S7 M2 Stoped");}

 if((Door2OpenTime==0)||(ActiveDoors==1))
 CloseDone.b1=0;

 if((Events.Photocell.b0==1))
 {StopMotor(1); StopMotor(2); OverloadCheckFlag1=0;OverloadCheckFlag2=0;State=6;PhotocellOpenFlag=1;Logger("S7 Photocell Int");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}

 if((Events.Remote!=0))
 {StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Remote Pressed");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}

 if((Events.Limiter==1)&&(LimiterEnable))
 {StopMotor(1); StopMotor(2); State=6;OverloadCheckFlag1=0;OverloadCheckFlag2=0;Logger("S7 Limit Switch Stop");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}

 if(CloseDone==0)
 {State=1; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_close,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}

 if((State==5)||(State==6))
 {ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S7 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}


}
#line 1058 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void State8()
{
  portc.b2 =1;

 if(CheckTask(1))
 {StartMotor(1, 1 );Logger("S8 Motor1Start");  portd.b7 =0;memcpy(LCDLine1,_opening,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}

 if(CheckTask(2))
 {StartMotor(2, 1 );Logger("S8 Motor2Start");  portd.b7 =0;}

 if(CheckTask(10))
 {OverloadCheckFlag1=1; OverloadInit(1);Logger("S8 Overflow Flag1 Set");}

 if(CheckTask(11))
 {OverloadCheckFlag2=1; OverloadInit(2);Logger("S8 Overflow Flag2 Set");}

 if(CheckTask(5))
 {SetMotorSpeed(1,Motor2FullSpeed); M1isSlow=0;Logger("S8 Motor1 Fast");}

 if(CheckTask(6))
 {SetMotorSpeed(Motor1FullSpeed,1); M2isSlow=0;Logger("S8 Motor2 Fast");}

 if((CheckTask(3)||((OverloadCheckFlag1==1)&&(Events.Overload.b0==1)))&&(OpenDone.b0))
 {OpenDone.b0=0; StopMotor(1);Logger("S8 Motor1 Stop");}

 if((CheckTask(4)||((OverloadCheckFlag2==1)&&(Events.Overload.b1==1)))&&(OpenDone.b1))
 {OpenDone.b1=0; StopMotor(2);Logger("S8 Motor2 Stop");}

 if(CheckTask(12))
 { portd.b7 =1;}

 if((Door2OpenTime==0)||(ActiveDoors==1))
 OpenDone.b1=0;

 if((Events.Photocell.b0==1)&&(OpenPhEnable))
 {StopMotor(1); StopMotor(2);OverloadCheckFlag1=0;OverloadCheckFlag2=0; State=5;Logger("S8 Photocell Int");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrPhoto,16);LCDUpdateFlag=1;}

 if((Events.Remote!=0))
 {StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Motors Stoped (Remote)");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrRemote,16);LCDUpdateFlag=1;}

 if((Events.Limiter==1)&&(LimiterEnable))
 {StopMotor(1); StopMotor(2); State=5;OverloadCheckFlag1=0;OverloadCheckFlag2=0; Logger("S8 Limit Switch Stop");ClearTasks(9);
 memcpy(LCDLine1,_stop,16);memcpy(LCDLine2,_ErrLimit,16);LCDUpdateFlag=1;}

 if(OpenDone==0)
 {State=2; PassFlag=0;ClearTasks(9);memcpy(LCDLine1,_open,16);memcpy(LCDLine2,_Blank,16);LCDUpdateFlag=1;}

 if((State==5)||(State==6))
 {ClearTasks(0);if(AutoCloseTime!=0){AddTask(ms500+AutoCloseTime,9);Logger("S8 Autoclose Renewed");memcpy(LCDLine2,_autoclose,16);LCDUpdateFlag=1;}}


}








void LCDUpdater()
{
 if(LCDUpdateFlag==1)
 {
 lcd_out(1,1,LCDLine1);
 lcd_out(2,1,LCDLine2);
 LCDUpdateFlag=0;
 }

 if(LCDFlash)
 {
 if(LCDFlashFlag)
 lcd_out(2,1,"               ");
 else
 lcd_out(2,1,LCDLine2);
 }


}
#line 1158 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void Init()
{
char i=0;

porta=0;
portb=0;
portc=0;
portd=0;
porte=0;
trisa=0b111111;
trisb=0b00000111;
trisc=0b10000000;
trisd=0b01111111;
trise=0b001;
adcon1=0b1001;




lcd_init();
lcd_cmd(_LCD_CURSOR_OFF);


ms500=0;
t0con=0b10000101;
intcon.b7=1;
intcon.b5=1;
intcon.b2=0;
tmr0h=0xF3;
tmr0l=0xCA;


INT1IP_bit=1;
INT1E_bit=1;
INT1F_bit=0;
INT2IP_bit=1;
INT2E_bit=1;
INT2F_bit=0;
INTEDG1_bit=1;
INTEDG2_bit=1;


INT0F_bit=0;
INT0E_bit=0;


for(i=0;i<20;i++)
 Tasks[i].Expired=1;


Events.Keys=0;
Events.Task1=0;
Events.Task2=0;
Events.Task3=0;
Events.Remote=0;
Events.Overload=0;
Events.Photocell=0;


State=0;


UART1_init(115200);


LoadConfigs();

}
#line 1239 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void TaskManager()
{
char i=0;
for(i=0;i<20;i++)
 if((Tasks[i].Expired==0)&&(Tasks[i].Time==ms500)&&(Tasks[i].Fired==0))
 Tasks[i].Fired=1;
}
#line 1257 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void AddTask(unsigned long OccTime,char tcode)
{
char i;
for(i=0;i<20;i++)
 if(Tasks[i].Expired==1)
 {
 Tasks[i].TaskCode=tcode;
 Tasks[i].Time=OccTime;
 Tasks[i].Expired=0;
 Tasks[i].Fired=0;
 break;
 }
}









void EventHandler()
{
 char i;
 Events.ExternalKeys=GetExternalKeysState();
 Events.Limiter=GetLimitSwitchState();
 Events.Keys=GetKeysState();
 Events.Remote=GetRemoteState();
 Events.Overload=GetOverloadState();
 Events.Photocell=GetPhotocellState();

 for(i=0;i<20;i++)
 if((Tasks[i].Expired==0)&&(Tasks[i].Fired==1))
 {
 if(Events.Task1==0)
 {Events.Task1=Tasks[i].TaskCode; Tasks[i].Expired=1;Tasks[i].Fired=0;}
 else if(Events.Task2==0)
 {Events.Task2=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
 else if(Events.Task3==0)
 {Events.Task3=Tasks[i].TaskCode;Tasks[i].Expired=1;Tasks[i].Fired=0;}
 }
}









char GetKeysState()
{
unsigned res=0;
char t[4];
static unsigned long PressTime;
static char Repeat,RepeatRate;
char resch=0,fin;
res=ADC_Read(5);
if(((res>>2)>160)&&((res>>2)<185))
 resch.b2=1;
if(((res>>2)>100)&&((res>>2)<160))
 resch.b1=1;
if((res>>2)<50)
 resch.b0=1;

if((resch==0))
{
 if(Pressed==0)
 {Repeat=0;Pressed=0;fin=0;RepeatRate=0;}
 if(Pressed==1)
 if(DebouncingDelay>= 5 )
 {Repeat=0;Pressed=0;fin=0;RepeatRate=0;}
}
if((resch!=0)&&(Pressed==1)&&(Repeat==0)&&(ms500==PressTime+ 3 ))
 Repeat=1;

if((resch!=0)&&(Pressed==1)&&(Repeat==0))
 fin=0;

if((resch!=0)&&(Pressed==1)&&(Repeat==1))
 {fin=resch*RepeatRate;RepeatRate=0;}


if((resch!=0)&&(Pressed==0))
 {fin=resch; Pressed=1;PressTime=ms500;DebouncingDelay=0;}

if((Repeat==1)&&(msCounter%10==0))
 RepeatRate=1;

return fin;
}









char GetExternalKeysState()
{
 char out=0;
 if( portd.b3 ==0)
 out.b0=1;
 if( portd.b4 ==0)
 out.b1=1;
 return out;
}
#line 1380 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
char GetLimitSwitchState()
{
 if(( portd.b1 ==0)||( portd.b2 ==0))
 return 1;
 else
 return 0;
}








char GetRemoteState()
{
char res=0;
res.b0=RemoteAFlag.b0;
res.b1=RemoteBFlag.b0;
RemoteAFlag=0;
RemoteBFlag=0;
res.b0=res.b0|(~ portd.b3 );
res.b1=res.b1|(~ portd.b4 );
return res;
}









char GetOverloadState()
{
char res=0;
unsigned VCapM1,VCapM2;
VCapM1=ADC_Read(0);
VCapM2=ADC_Read(1);
if(Motor1FullSpeed!=0)
{
 if(VCapM1<OverloadTreshold)
 {
 if(OverloadCounter1<255)
 OverloadCounter1=OverloadCounter1+1;
 }
 else
 {
 if(OverloadCounter1>0)
 OverloadCounter1=OverloadCounter1-1;
 }
}
else
{OverloadCounter1=0;}

if (OverloadCounter1>OverloadDuration)
 res.b0=1;




if(Motor2FullSpeed!=0)
{
 if(VCapM2<OverloadTreshold)
 {
 if(OverloadCounter2<255)
 OverloadCounter2=OverloadCounter2+1;
 }
 else
 {
 if(OverloadCounter2>0)
 OverloadCounter2=OverloadCounter2-1;
 }
}
else
{OverloadCounter2=0;}


if (OverloadCounter2>OverloadDuration)
 res.b1=1;

return res;
}
#line 1477 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
char GetPhotocellState()
{
if( portd.b0 ==0)
 {if(PhotocellCount<=20)PhotocellCount=PhotocellCount+1;}
else
 {PhotocellCount=0;}
if(PhotocellCount>=20)
 return 1;
else
 return 0;
}
#line 1499 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void SetMotorSpeed(char M1FullSpeed,char M2FullSpeed)
{
if((M1FullSpeed==0)||(M2FullSpeed==0))
 INT0E_bit=1;
else
 INT0E_bit=0;

Motor1FullSpeed=M1FullSpeed;
Motor2FullSpeed=M2FullSpeed;
}










void OverloadInit(char ch)
{
if(ch==1)
{
 OverloadCounter1=0;
 Events.Overload.b0=0;
}

if(ch==2)
{
 OverloadCounter2=0;
 Events.Overload.b1=0;
}
}










void SaveConfigs()
{

 EEPROM_Write(1,Door1OpenTime);
 EEPROM_Write(2,Door2OpenTime);
 EEPROM_Write(3,Door1CloseTime);
 EEPROM_Write(4,Door2CloseTime);
 EEPROM_Write(5,ActionTimeDiff);
 EEPROM_Write(6,OpenSoftStartTime);
 EEPROM_Write(7,OpenSoftStopTime);
 EEPROM_Write(8,CloseSoftStartTime);
 EEPROM_Write(9,CloseSoftStopTime);
 EEPROM_Write(10, ((char *)&AutoCloseTime)[1] );
 EEPROM_Write(11, ((char *)&AutoCloseTime)[0] );
 EEPROM_Write(12,OverloadSens);
 SetOverloadParams(9-OverloadSens);
 EEPROM_Write(13,CloseAfterPass);
 EEPROM_Write(14,LockForce);
 EEPROM_Write(15,OpenPhEnable);
 EEPROM_Write(16,LimiterEnable);

}
#line 1577 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void LoadConfigs()
{
 Door1OpenTime=EEPROM_Read(1);
 Door2OpenTime=EEPROM_Read(2);
 Door1CloseTime=EEPROM_Read(3);
 Door2CloseTime=EEPROM_Read(4);
 ActionTimeDiff=EEPROM_Read(5);
 OpenSoftStartTime=EEPROM_Read(6);
 OpenSoftStopTime=EEPROM_Read(7);
 CloseSoftStartTime=EEPROM_Read(8);
 CloseSoftStopTime=EEPROM_Read(9);
 AutoCloseTime=EEPROM_Read(10);
 AutoCloseTime=AutoCloseTime<<8;
 AutoCloseTime=AutocloseTime|EEPROM_Read(11);
 OverloadSens=EEPROM_Read(12);
 SetOverloadParams(9-OverloadSens);
 CloseAfterPass=EEPROM_Read(13);
 LockForce=EEPROM_Read(14);
 OpenPhEnable=EEPROM_Read(15);
 LimiterEnable=EEPROM_Read(16);

}
#line 1611 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void FactorySettings()
{
 Door1OpenTime=20;
 Door1CloseTime=20;
 Door2OpenTime=20;
 Door2CloseTime=20;
 OverloadSens=5;
 SetOverloadParams(4);
 OpenSoftStopTime=10;
 OpenSoftStartTime=4;
 CloseSoftStopTime=10;
 CloseSoftStartTime=4;
 ActionTimeDiff=12;
 AutoCloseTime=0;
 LockForce=0;
 OpenPhEnable=0;
 LimiterEnable=0;
 CloseAfterPass=0;

 SaveConfigs();
}





void StartMotor(char Mx,char Dir)
{
 if(Mx==1)
 {
 Motor1Start=1;
  portc.b4 =Dir;
  portc.b1 =1;
 }

 if(Mx==2)
 {
 Motor2Start=1;
  portc.b3 =Dir;
  portc.b0 =1;
 }
}


void StopMotor(char Mx)
{
 if(Mx==1)
 {
 Motor1Start=0;
  portc.b1 =0;
 }

 if(Mx==2)
 {
 Motor2Start=0;
  portc.b0 =0;
 }
}
#line 1680 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
char CheckTask(char TaskCode)
{
 if(Events.Task1==TaskCode)
 {Events.Task1=0; return 1;}

 if(Events.Task2==TaskCode)
 {Events.Task2=0; return 1;}

 if(Events.Task3==TaskCode)
 {Events.Task3=0; return 1;}

 return 0;

}







char GetAutocloseTime()
{
 char i;
 unsigned long t;
 for(i=0;i<20;i++)
 {
 if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode==9))
 t=Tasks[i].Time;
 Tasks[i].Expired=1;
 }
 i=t-ms500;
 return i;
}
#line 1730 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void ClearTasks(char except)
{
 char i;
 for(i=0;i<20;i++)
 if((Tasks[i].Expired==0)&&(Tasks[i].TaskCode!=except))
 Tasks[i].Expired=1;
}
#line 1751 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void Menu0()
{
 memcpy(LCDLine2,"                ",16);

if(MenuPointer==0)
 {memcpy(LCDLine1,"00 Learning Mode",16);LCDUpdateFlag=1;
 if(LearningMode==0)memcpy(LCDLine2,"      Auto      ",16);
 if(LearningMode==1)memcpy(LCDLine2,"     Manual     ",16);}

 if(MenuPointer==1)
 {memcpy(LCDLine1,"01 D1 Open Time ",16);LCDUpdateFlag=1;
 charValueToStr(Door1OpenTime,LCDLine2+6);}

 if(MenuPointer==2)
 {memcpy(LCDLine1,"02 D2 Open Time ",16);LCDUpdateFlag=1;
 charValueToStr(Door2OpenTime,LCDLine2+6);}

 if(MenuPointer==3)
 {memcpy(LCDLine1,"03 D1 Close Time",16);LCDUpdateFlag=1;
 charValueToStr(Door1CloseTime,LCDLine2+6);}

 if(MenuPointer==4)
 {memcpy(LCDLine1,"04 D2 Close Time",16);LCDUpdateFlag=1;
 charValueToStr(Door2CloseTime,LCDLine2+6);}

 if(MenuPointer==5)
 {memcpy(LCDLine1,"05 Op Soft Start",16);LCDUpdateFlag=1;
 charValueToStr(OpenSoftStartTime,LCDLine2+6);}

 if(MenuPointer==6)
 {memcpy(LCDLine1,"06 Op Soft Stop ",16);LCDUpdateFlag=1;
 charValueToStr(OpenSoftStopTime,LCDLine2+6);}

 if(MenuPointer==7)
 {memcpy(LCDLine1,"07 Cl Soft Start",16);LCDUpdateFlag=1;
 charValueToStr(CloseSoftStartTime,LCDLine2+6);}

 if(MenuPointer==8)
 {memcpy(LCDLine1,"08 Cl Soft Stop ",16);LCDUpdateFlag=1;
 charValueToStr(CloseSoftStopTime,LCDLine2+6);}

 if(MenuPointer==9)
 {memcpy(LCDLine1,"09 Power        ",16);LCDUpdateFlag=1;
 bytetostr(OverloadSens,LCDLine2+6);LCDLine2[9]=' ';}

 if(MenuPointer==10)
 {memcpy(LCDLine1,"10 Interval Time",16);LCDUpdateFlag=1;
 charValueToStr(ActionTimeDiff,LCDLine2+6);}

 if(MenuPointer==11)
 {memcpy(LCDLine1,"11 Auto-close T ",16);LCDUpdateFlag=1;
 intValueToStr(AutoCloseTime,LCDLine2+4);}

if(MenuPointer==12)
 {memcpy(LCDLine1,"12 Factory Reset",16);LCDUpdateFlag=1;}

 if(MenuPointer==13)
 {memcpy(LCDLine1,"13 Open Photo En",16);LCDUpdateFlag=1;
 if(OpenPhEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}

 if(MenuPointer==14)
 {memcpy(LCDLine1,"14 Limit Enable ",16);LCDUpdateFlag=1;
 if(LimiterEnable==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}

 if(MenuPointer==15)
 {memcpy(LCDLine1,"15 Lock Force   ",16);LCDUpdateFlag=1;
 if(LockForce==0) memcpy(LCDLine2+6,"No     ",7);else memcpy(LCDLine2+6,"Yes     ",8);}

 if(MenuPointer==16)
 {memcpy(LCDLine1,"16 Au-Cl Pass   ",16);LCDUpdateFlag=1;
 charValueToStr(CloseAfterPass,LCDLine2+6);}

 if(MenuPointer==17)
 {memcpy(LCDLine1,"17 Save Changes ",16);LCDUpdateFlag=1;}

 if(MenuPointer==18)
 {memcpy(LCDLine1,"18 Discard Exit ",16);LCDUpdateFlag=1;}


 State=101;
}
#line 1848 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void Menu1()
{

 if((Events.Keys.b0==1))
 {if(MenuPointer==0){MenuPointer=18;}else{MenuPointer=MenuPointer-1;}State=100;}

 if((Events.Keys.b2==1))
 {if(MenuPointer==18){MenuPointer=0;}else{MenuPointer=MenuPointer+1;}State=100;}

 if((Events.Keys.b1==1))
 {State=102;}


}







void Menu2()
{

 LCDFlash=1;

 if(Events.Keys.b1==1)
 {
 LCDFlash=0;LCDFlashFlag=0;State=101;
 if(MenuPointer==0)
 {
 if(LearningMode==0)
 State=200;
 if(LearningMode==1)
 State=201;
 }
 }


 if(MenuPointer==0)
 { if((Events.Keys.b0==1)&&(LearningMode>0))
 {LearningMode=LearningMode-1;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(LearningMode<1))
 {LearningMode=LearningMode+1;Menu0();State=102;}
 }



 if(MenuPointer==1)
 { if((Events.Keys.b0==1)&&(Door1OpenTime>0))
 {Door1OpenTime=Door1OpenTime-1;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(Door1OpenTime<255))
 {Door1OpenTime=Door1OpenTime+1;Menu0();State=102;}
 }



 if(MenuPointer==2)
 { if((Events.Keys.b0==1)&&(Door2OpenTime>0))
 {Door2OpenTime=Door2OpenTime-1;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(Door2OpenTime<255))
 {Door2OpenTime=Door2OpenTime+1;Menu0();State=102;}
 }


 if(MenuPointer==3)
 { if((Events.Keys.b0==1)&&(Door1CloseTime>0))
 {Door1CloseTime=Door1CloseTime-1;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(Door1CloseTime<255))
 {Door1CloseTime=Door1CloseTime+1;Menu0();State=102;}
 }


 if(MenuPointer==4)
 { if((Events.Keys.b0==1)&&(Door2CloseTime>0))
 {Door2CloseTime=Door2CloseTime-1;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(Door2CloseTime<255))
 {Door2CloseTime=Door2CloseTime+1;Menu0();State=102;}
 }



 if(MenuPointer==5)
 { if((Events.Keys.b0==1)&&(OpenSoftStartTime>0))
 {OpenSoftStartTime=OpenSoftStartTime-1;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(OpenSoftStartTime<255))
 {OpenSoftStartTime=OpenSoftStartTime+1;Menu0();State=102;}
 }


 if(MenuPointer==6)
 { if((Events.Keys.b0==1)&&(OpenSoftStopTime>0))
 {OpenSoftStopTime=OpenSoftStopTime-1;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(OpenSoftStopTime<255))
 {OpenSoftStopTime=OpenSoftStopTime+1;Menu0();State=102;}
 }


 if(MenuPointer==7)
 { if((Events.Keys.b0==1)&&(CloseSoftStartTime>0))
 {CloseSoftStartTime=CloseSoftStartTime-1;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(CloseSoftStartTime<255))
 {CloseSoftStartTime=CloseSoftStartTime+1;Menu0();State=102;}
 }


 if(MenuPointer==8)
 { if((Events.Keys.b0==1)&&(CloseSoftStopTime>0))
 {CloseSoftStopTime=CloseSoftStopTime-1;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(CloseSoftStopTime<255))
 {CloseSoftStopTime=CloseSoftStopTime+1;Menu0();State=102;}
 }



 if(MenuPointer==9)
 { if((Events.Keys.b0==1)&&(OverloadSens>0))
 {OverloadSens=OverloadSens-1;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(OverloadSens<9))
 {OverloadSens=OverloadSens+1;Menu0();State=102;}
 }


 if(MenuPointer==10)
 { if((Events.Keys.b0==1)&&(ActionTimeDiff>0))
 {ActionTimeDiff=ActionTimeDiff-1;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(ActionTimeDiff<255))
 {ActionTimeDiff=ActionTimeDiff+1;Menu0();State=102;}
 }


 if(MenuPointer==11)
 { if((Events.Keys.b0==1)&&(AutoCloseTime>0))
 {AutoCloseTime=AutoCloseTime-1;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(AutoCloseTime<65000))
 {AutoCloseTime=AutoCloseTime+1;Menu0();State=102;}
 }


 if(MenuPointer==12)
 {
 State=0;
 memcpy(LCDLine1,"                ",16);
 memcpy(LCDLine2,"                ",16);
 LCDFlash=0; LCDFlashFlag=0;
 LCDUpdateFlag=1;
 FactorySettings();
 SaveConfigs();
 }


 if(MenuPointer==13)
 { if((Events.Keys.b0==1)&&(OpenPhEnable>0))
 {OpenPhEnable=OpenPhEnable-1;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(OpenPhEnable<1))
 {OpenPhEnable=OpenPhEnable+1;Menu0();State=102;}
 }



 if(MenuPointer==14)
 { if((Events.Keys.b0==1)&&(LimiterEnable>0))
 {LimiterEnable=LimiterEnable-1;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(LimiterEnable<1))
 {LimiterEnable=LimiterEnable+1;Menu0();State=102;}
 }


 if(MenuPointer==15)
 { if((Events.Keys.b0==1)&&(LockForce>0))
 {LockForce=LockForce-1;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(LockForce<1))
 {LockForce=LockForce+1;Menu0();State=102;}
 }


 if(MenuPointer==16)
 { if((Events.Keys.b0==1)&&(CloseAfterPass>0))
 {CloseAfterPass=CloseAfterPass-1;if(CloseAfterPass==9) CloseAfterPass=0;Menu0();State=102;}
 if((Events.Keys.b2==1)&&(CloseAfterPass<255))
 {CloseAfterPass=CloseAfterPass+1;if(CloseAfterPass==1) CloseAfterPass=10;Menu0();State=102;}
 }


 if(MenuPointer==17)
 {
 State=103;
 memcpy(LCDLine1,"                ",16);
 memcpy(LCDLine2,"                ",16);
 LCDFlash=0;
 LCDUpdateFlag=1;
 }


 if(MenuPointer==18)
 {
 State=0;
 memcpy(LCDLine1,"                ",16);
 memcpy(LCDLine2,"                ",16);
 LCDFlash=0;
 LCDUpdateFlag=1;
 LoadConfigs();
 }
}
#line 2063 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void Menu3()
{
 SaveConfigs();
 State=0;
}
#line 2081 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void LearnAuto()
{
}
#line 2096 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void LearnManual()
{
}







void charValueToStr(char val, char * string)
{
 bytetostr(val>>1,string);
 if((val%2)==1)
 memcpy(string+3,".5s",4);
 else
 memcpy(string+3,"s  ",4);
}
#line 2126 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void intValueToStr(unsigned val, char * string)
{
 wordtostr(val>>1,string);
 if((val%2)==1)
 memcpy(string+5,".5s",4);
 else
 memcpy(string+5,"s  ",4);
}
#line 2145 "C:/Users/baghi/Desktop/Sina/SwingJack/FirmV_0_7_0.c"
void SetOverloadParams(char p)
{

 switch(p)
 {
 case 0: OverloadTreshold=0;OverloadDuration=255; break;

 case 1: OverloadTreshold=400;OverloadDuration=200; break;

 case 2: OverloadTreshold=450;OverloadDuration=150; break;

 case 3: OverloadTreshold=500;OverloadDuration=100; break;

 case 4: OverloadTreshold=550;OverloadDuration=80; break;

 case 5: OverloadTreshold=600;OverloadDuration=150; break;

 case 6: OverloadTreshold=600;OverloadDuration=100; break;

 case 7: OverloadTreshold=600;OverloadDuration=50; break;

 case 8: OverloadTreshold=700;OverloadDuration=100; break;

 case 9: OverloadTreshold=700;OverloadDuration=50; break;

 }
}
