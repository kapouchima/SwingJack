void LCD_Init(unsigned char lines)
{
 I2C_Start();
 I2C_write(0x7c);  //send slave address  with write

	I2C_write(0x80);   // control byte
	if(lines==2)
	  I2C_write(0x38);   //FUNCTION SET 8 bit,N=1 2-line display mode,5*7dot
	if(lines==1)
	  I2C_write(0x34);

	I2C_write(0x80);   // control byte
	if(lines==2)
   	  I2C_write(0x39);  //FUNCTION SET 8 bit,N=1 2-line display mode,5*7dot IS=1
   	if(lines==1)
   	  I2C_write(0x35);

	I2C_write(0x80);   // control byte
   	I2C_write(0x1c);   //Internal OSC frequency adjustment 183HZ    bias will be 1/4

	I2C_write(0x80);   // control byte
	I2C_write(0x72);    //Contrast control  low byte

	I2C_write(0x80);     // control byte
	I2C_write(0x55);    //booster circuit is turn on.    /ICON display off. /Contrast control   high byte

	I2C_write(0x80);    // control byte
	I2C_write(0x6c);  //Follower control

	I2C_write(0x80);   // control byte
	I2C_write(0x0c);    //DISPLAY ON

	I2C_write(0x80);   // control byte
	I2C_write(0x01);   //CLEAR DISPLAY

	I2C_write(0x80);   // control byte
	I2C_write(0x06);   //ENTRY MODE SET  CURSOR MOVES TO RIGHT

	I2C_write(0x80);   // control byte
	I2C_write(0x02);

    I2C_Stop();

}


void SetContrast(unsigned char val)
{
 unsigned char valh=0,vall=0;
 val=val&0b00111111;
 valh=0x54;
 valh|=(val>>4);
 vall=0x70;
 vall|=(val&0b1111);
 I2C_Start();

 I2C_write(0x7c);  //send slave address  with write
        I2C_write(0x80);     // control byte
	I2C_write(valh);    //booster circuit is turn on.    /ICON display off. /Contrast control   high byte

        I2C_write(0x80);   // control byte
	I2C_write(vall);    //Contrast control  low byte
 I2C_Stop();
 delay_ms(1);
}

void LCD_Putch(unsigned char dat,unsigned char add,unsigned char Nline)
{
	if(Nline==1)
    add=0x80+add;
    if(Nline==2)
    add=0xc0+add;
    I2C_Start();
	I2C_write(0x7c);
	I2C_write(0x80);
	I2C_write(add);
	I2C_write(0x40);
	I2C_write(dat);
    I2C_Stop();
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
    I2C_Start();
	I2C_write(0x7c);
	I2C_write(0x80);
	I2C_write(add);
	I2C_write(0x40);
	while((dat[i]!='\n')&&(i<=16))
	  {I2C_write(dat[i]);i=i+1;}
    I2C_Stop();
    delay_ms(1);

    return;
}

