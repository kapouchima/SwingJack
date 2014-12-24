#line 1 "C:/Users/baghi/Desktop/Sina/SwingJack/COGLCDDriver.c"
void LCD_Init(unsigned char lines)
{
 I2C1_Start();
 I2C1_wr(0x7c);

 I2C1_wr(0x80);
 if(lines==2)
 I2C1_wr(0x38);
 if(lines==1)
 I2C1_wr(0x34);

 I2C1_wr(0x80);
 if(lines==2)
 I2C1_wr(0x39);
 if(lines==1)
 I2C1_wr(0x35);

 I2C1_wr(0x80);
 I2C1_wr(0x1c);

 I2C1_wr(0x80);
 I2C1_wr(0x72);

 I2C1_wr(0x80);
 I2C1_wr(0x55);

 I2C1_wr(0x80);
 I2C1_wr(0x6c);

 I2C1_wr(0x80);
 I2C1_wr(0x0c);

 I2C1_wr(0x80);
 I2C1_wr(0x01);

 I2C1_wr(0x80);
 I2C1_wr(0x06);

 I2C1_wr(0x80);
 I2C1_wr(0x02);

 I2C1_Stop();

}


void SetContrast(unsigned char val)
{
 unsigned char valh=0,vall=0;
 val=val&0b00111111;
 valh=0x54;
 valh|=(val>>4);
 vall=0x70;
 vall|=(val&0b1111);
 I2C1_Start();

 I2C1_wr(0x7c);
 I2C1_wr(0x80);
 I2C1_wr(valh);

 I2C1_wr(0x80);
 I2C1_wr(vall);
 I2C1_Stop();
 delay_ms(1);
}

void LCD_Putch(unsigned char dat,unsigned char add,unsigned char Nline)
{
 if(Nline==1)
 add=0x80+add;
 if(Nline==2)
 add=0xc0+add;
 I2C1_Start();
 I2C1_wr(0x7c);
 I2C1_wr(0x80);
 I2C1_wr(add);
 I2C1_wr(0x40);
 I2C1_wr(dat);
 I2C1_Stop();
 delay_ms(1);

 return;
}


void LCD_out(unsigned char line,unsigned char offset,unsigned char* dat)
{
 unsigned char i=0,add=0;
 if(line==1)
 add=0x80+offset;
 if(line==2)
 add=0xc0+offset;
 I2C1_Start();
 I2C1_wr(0x7c);
 I2C1_wr(0x80);
 I2C1_wr(add);
 I2C1_wr(0x40);
 while((dat[i]!='\n')&&(i<=16))
 {I2C1_wr(dat[i]);i=i+1;}
 I2C1_Stop();
 delay_ms(1);

 return;
}
