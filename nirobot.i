// New version of our code (it's name in txt is all_code_var3, last code's name is all_code_var2, Changed it at 11'th of October, Kate)
/*****************************************************
NIRobot_4
YTC.B-71 :)

Chip type           : ATmega1281
Program type        : Application
Clock frequency     : 14,740000 MHz
Memory model        : Small
External SRAM size  : 0
Data Stack size     : 2048       

functions:     
char getchar1(void) and  void putchar1(char c) - are for USART1, created bu this program    
void putnumber( int count) - put big integers (decimal!)

interrupt [TIM5_COMPA] void timer5_compa_isr(void) - left wheel's PWM change to stabilize when it move forvard ('w')
 
void rotate(char c) - turn left('l') or right('r')   //make america great again and this code so


//Main part
void main(void)
letters and commands:   
 f                              f1
'w' :  // Move forward!         w   //flag for interrupt Timer5
's' :  // Move back!            w (s)
'd' :  // Move left!            d
'a' :  // Move right!           a
'f' :  // Move stop!            f

'z' :  // Move fast!            
'x' :  // Move slow!            
 
'u' :  // Move forward-left     f
'i' :  // Move forward-right    f
'o' :  // Move back-left        f
'p' :  // Move back-right       f

'q' :  // Info about rotate

'l' :  // Turn left, 90         f
'r' :  // Turn right, 90        f
*****************************************************/
// CodeVisionAVR C Compiler
// (C) 1998-2005 Pavel Haiduc, HP InfoTech S.R.L.
// I/O registers definitions for the ATmega1281
#pragma used+
#pragma used+
sfrb PINA=0;
sfrb DDRA=1;
sfrb PORTA=2;
sfrb PINB=3;
sfrb DDRB=4;
sfrb PORTB=5;
sfrb PINC=6;
sfrb DDRC=7;
sfrb PORTC=8;
sfrb PIND=9;
sfrb DDRD=0xa;
sfrb PORTD=0xb;
sfrb PINE=0xc;
sfrb DDRE=0xd;
sfrb PORTE=0xe;
sfrb PINF=0xf;
sfrb DDRF=0x10;
sfrb PORTF=0x11;
sfrb PING=0x12;
sfrb DDRG=0x13;
sfrb PORTG=0x14;
sfrb TIFR0=0x15;
sfrb TIFR1=0x16;
sfrb TIFR2=0x17;
sfrb TIFR3=0x18;
sfrb TIFR4=0x19;
sfrb TIFR5=0x1a;
sfrb PCIFR=0x1b;
sfrb EIFR=0x1c;
sfrb EIMSK=0x1d;
sfrb GPIOR0=0x1e;
sfrb EECR=0x1f;
sfrb EEDR=0x20;
sfrb EEARL=0x21;
sfrb EEARH=0x22;
sfrw EEAR=0X21;   // 16 bit access
sfrb GTCCR=0x23;
sfrb TCCR0A=0x24;
sfrb TCCR0B=0x25;
sfrb TCNT0=0x26;
sfrb OCR0A=0x27;
sfrb OCR0B=0x28;
sfrb GPIOR1=0x2a;
sfrb GPIOR2=0x2b;
sfrb SPCR=0x2c;
sfrb SPSR=0x2d;
sfrb SPDR=0x2e;
sfrb ACSR=0x30;
sfrb OCDR=0x31;
sfrb MONDR=0x31;
sfrb SMCR=0x33;
sfrb MCUSR=0x34;
sfrb MCUCR=0x35;
sfrb SPMCSR=0x37;
sfrb RAMPZ=0x3b;
sfrb EIND=0x3c;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-
// Interrupt vectors definitions
// Needed by the power management functions (sleep.h)
#asm
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.EQU __sm_adc_noise_red=0x02
	.SET power_ctrl_reg=smcr
	#endif
#endasm
// CodeVisionAVR C Compiler
// (C) 1998-2006 Pavel Haiduc, HP InfoTech S.R.L.
// Prototypes for standard I/O functions
// CodeVisionAVR C Compiler
// (C) 1998-2002 Pavel Haiduc, HP InfoTech S.R.L.
// Variable length argument list macros
typedef char *va_list;
typedef char *va_list;
typedef char *va_list;
#pragma used+
char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);
char *gets(char *str,unsigned int len);
void printf(char flash *fmtstr,...);
void sprintf(char *str, char flash *fmtstr,...);
void snprintf(char *str, unsigned int size, char flash *fmtstr,...);
void vprintf (char flash * fmtstr, va_list argptr);
void vsprintf (char *str, char flash * fmtstr, va_list argptr);
void vsnprintf (char *str, unsigned int size, char flash * fmtstr, va_list argptr);
signed char scanf(char flash *fmtstr,...);
signed char sscanf(char *str, char flash *fmtstr,...);
                                               #pragma used-
#pragma library stdio.lib
/* CodeVisionAVR C Compiler
   Prototypes for standard library functions

   (C) 1998-2003 Pavel Haiduc, HP InfoTech S.R.L.
*/
#pragma used+
#pragma used+
int atoi(char *str);
long int atol(char *str);
float atof(char *str);
void itoa(int n,char *str);
void ltoa(long int n,char *str);
void ftoa(float n,unsigned char decimals,char *str);
void ftoe(float n,unsigned char decimals,char *str);
void srand(int seed);
int rand(void);
void *malloc(unsigned int size);
void *calloc(unsigned int num, unsigned int size);
void *realloc(void *ptr, unsigned int size); 
void free(void *ptr);
#pragma used-
#pragma library stdlib.lib
// CodeVisionAVR C Compiler
// (C) 1998-2007 Pavel Haiduc, HP InfoTech S.R.L.
// Prototypes for string functions
#pragma used+
#pragma used+
char *strcat(char *str1,char *str2);
char *strcatf(char *str1,char flash *str2);
char *strchr(char *str,char c);
signed char strcmp(char *str1,char *str2);
signed char strcmpf(char *str1,char flash *str2);
char *strcpy(char *dest,char *src);
char *strcpyf(char *dest,char flash *src);
unsigned int strlenf(char flash *str);
char *strncat(char *str1,char *str2,unsigned char n);
char *strncatf(char *str1,char flash *str2,unsigned char n);
signed char strncmp(char *str1,char *str2,unsigned char n);
signed char strncmpf(char *str1,char flash *str2,unsigned char n);
char *strncpy(char *dest,char *src,unsigned char n);
char *strncpyf(char *dest,char flash *src,unsigned char n);
char *strpbrk(char *str,char *set);
char *strpbrkf(char *str,char flash *set);
char *strrchr(char *str,char c);
char *strrpbrk(char *str,char *set);
char *strrpbrkf(char *str,char flash *set);
char *strstr(char *str1,char *str2);
char *strstrf(char *str1,char flash *str2);
char *strtok(char *str1,char flash *str2);
 unsigned int strlen(char *str);
void *memccpy(void *dest,void *src,char c,unsigned n);
void *memchr(void *buf,unsigned char c,unsigned n);
signed char memcmp(void *buf1,void *buf2,unsigned n);
signed char memcmpf(void *buf1,void flash *buf2,unsigned n);
void *memcpy(void *dest,void *src,unsigned n);
void *memcpyf(void *dest,void flash *src,unsigned n);
void *memmove(void *dest,void *src,unsigned n);
void *memset(void *buf,unsigned char c,unsigned n);
unsigned int strcspn(char *str,char *set);
unsigned int strcspnf(char *str,char flash *set);
int strpos(char *str,char c);
int strrpos(char *str,char c);
unsigned int strspn(char *str,char *set);
unsigned int strspnf(char *str,char flash *set);
#pragma used-
#pragma library string.lib
//
 // Get a character from the USART1 Receiver
#pragma used+ 
char getchar1(void)
{
char status,data;
while (1)
      {
      while (((status=(*(unsigned char *) 0xc8)) & (1<<7))==0);
      data=(*(unsigned char *) 0xce);
      if ((status & ((1<<4) | (1<<2) | (1<<3)))==0)
         return data;
      };
}
#pragma used-
// Write a character to the USART1 Transmitter
#pragma used+
void putchar1(char c)
{
while (((*(unsigned char *) 0xc8) & (1<<5))==0);
(*(unsigned char *) 0xce)=c;
}
#pragma used-
//
// Declare your global variables here 
char f,f1;//,*str;  //command and flag
int count1,count3,i; // impulse counters  
int PWML,PWMR; //PWM main parameters
int C_PWML, C_PWMR, C_PWM=50; //PWM add parameters
///we should understand what size of C_PWM is good. 10 is too slow for normal forvard. 50 is norm  
//float time=0.1, vr=0.0, vl=0.0; 
//
//Timer 5 interrupt  //Left wheel's PWM change to stabilize
// Timer 5 output compare A interrupt service routine
interrupt [48] void timer5_compa_isr(void)
{
// Place your code here
 #asm("sei")
// Place your code here
count1 = (*(unsigned char *) 0x84);//low part of left wheel impulse
count3 = (*(unsigned char *) 0x94); //low part of right wheel impulse
   (*(unsigned char *) 0x94)=0x00;(*(unsigned char *) 0x84)=0x00; //clear low impulse counters
//stabilize when move forvard
if ( f1 == 'w') {
if ( (count3-count1) >= 1 ){ //right is faster
    PWML=PWML+1;//++; // rise left PWM
    //input information
    //putchar1('r');   
    //putchar1((count3-count1)+'0');
}    
else if ( (count1-count3) >= 1 ) { //left is faster
    PWML=PWML-1;//--; // low left PWM
    //input information   
    //putchar1('l');
    //putchar1((count1-count3)+'0');
}  
OCR0A=PWML; // left PWM 
}
} //end of Timer 5 interrupt
//
//input string from integer
void putnumber( int count)
{   
    char *str; 
    itoa(count,str);        
    for (i=0;i<=strlen(str);i++)
    {
        putchar1(str[i]);       
    }  
}
//
// turn left or right
void rotate(char c)
{       
        int c0,c1,c2,c3,counter_l,counter_h; 
        int angle_H=0x15, angle_L=0x7C;   // 0x157C = 5500 impulses = 1 full wheel rotation   //0x0ABE = 2750 = 1/2 full wheel rotation
        //stop mashine
        PORTC.0 = 0;
        PORTC.1 = 0;
              PORTC.2 = 0;
        PORTC.3 = 0;  
        OCR0A=PWML;  //normal speed
        (*(unsigned char *) 0xb3)=PWMR;
        f1='f'; 
        (*(unsigned char *) 0x95)=0x00;(*(unsigned char *) 0x85)=0x00; //clear impulse counters high
        (*(unsigned char *) 0x94)=0x00;(*(unsigned char *) 0x84)=0x00; //clear impulse counters low
                    /*putnumber(TCNT3H);
        putnumber(TCNT3L); */
        if (c=='r')   //turn right        left pwm work
        {  
                c0=1; 
                c1=0;
                c2=0;
                c3=0;
        } 
        else //(c=='l') turn left    right pwm work
        {  
                c0=0;  
                c1=0;
                c2=0;
                c3=1;
        }
        counter_h=0;
        counter_l=0;
        while ((counter_h<(angle_H))||(counter_l<angle_L))
        {
                if (c=='r')   //turn right 
                { 
                        counter_l=(*(unsigned char *) 0x84);   //counters for left wheel
                        counter_h=(*(unsigned char *) 0x85);
                }
                else //(c=='l') turn left    
                { 
                        counter_l=(*(unsigned char *) 0x94);   //counters for right wheel
                        counter_h=(*(unsigned char *) 0x95);
                }
                                       PORTC.0 = c0;
                PORTC.1 = c1;
                PORTC.2 = c2;
                PORTC.3 = c3;  
                                if  ((counter_h>(angle_H))&&(counter_l>angle_L))  
                {
                break;
                }
        }
                //stop mashine
        PORTC.0 = 0;
        PORTC.1 = 0;
              PORTC.2 = 0;
        PORTC.3 = 0;
        f1='f';
                /*putnumber(TCNT1H);   // real  left  angle_H_angle_L 
        putnumber(TCNT1L);          
        putchar1('_');  
        putnumber(TCNT3H);   // real  right angle_H_angle_L
        putnumber(TCNT3L);
        putchar1('_');  */ 
                //antiterror
        //work about it
        if (c=='r')   //turn right   left pwm work
        {  
                c0=0; 
                c1=0;
                c2=1;
                c3=0;
                angle_L=(*(unsigned char *) 0x94);
                angle_H=(*(unsigned char *) 0x95);
        } 
        else //(c=='l') turn left    right pwm work
        {  
                c0=0;  
                c1=1;
                c2=0;
                c3=0;
                angle_L=(*(unsigned char *) 0x84);
                angle_H=(*(unsigned char *) 0x85);
        }
        (*(unsigned char *) 0x95)=0x00;(*(unsigned char *) 0x85)=0x00; //clear impulse counters high
        (*(unsigned char *) 0x94)=0x00;(*(unsigned char *) 0x84)=0x00; //clear impulse counters low
        counter_h=0;
        counter_l=0;
        while ((counter_h<(angle_H))||(counter_l<angle_L))
        {
                if (c=='l')   //toturn right 
                { 
                        counter_l=(*(unsigned char *) 0x84);   //counters for left wheel
                        counter_h=(*(unsigned char *) 0x85);
                }
                else //(c=='r') toturn left    
                { 
                        counter_l=(*(unsigned char *) 0x94);   //counters for right wheel
                        counter_h=(*(unsigned char *) 0x95);
                }    
                                PORTC.0 = c0;
                PORTC.1 = c1;
                PORTC.2 = c2;
                PORTC.3 = c3;  
                                if  ((counter_h>(angle_H))&&(counter_l>angle_L))  
                {
                break;
                }
        }
                //stop mashine
        PORTC.0 = 0;
        PORTC.1 = 0;
              PORTC.2 = 0;
        PORTC.3 = 0;
        f1='f';  
        /*putnumber(counter_h-TC);       // good   angle_H_angle_L      
        putnumber(counter_l); */
        /*putchar1('_');
        putnumber(TCNT1H);
        putnumber(TCNT1L);         // real   angle_H_angle_L  
        putchar1('_');  
        putnumber(TCNT3H);
        putnumber(TCNT3L);
        putchar1('_');  */ 
        /*itoa(counter_h-TC,str);        
        for (i=0;i<=strlen(str);i++){
                putchar1(str[i]);       
        } 
        itoa(counter_l,str);     
        for (i=0;i<=strlen(str);i++){
                putchar1(str[i]);       
        }  
        putchar1('_');   
        itoa(angle_H-TC,str);          //sravnivaem
        for (i=0;i<=strlen(str);i++){
                putchar1(str[i]);       
        } 
        itoa(angle_L,str);     
        for (i=0;i<=strlen(str);i++){
                putchar1(str[i]);       
        }  
        putchar1('_');  */   
                } 
//
//Main part
void main(void)
{
// Declare your local variables here
// Crystal Oscillator division factor: 1
#pragma optsize-
(*(unsigned char *) 0x61)=0x80;
(*(unsigned char *) 0x61)=0x00;
#pragma optsize+
// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x00;
DDRA=0x00;
// Port B initialization
// Func7=Out Func6=In Func5=In Func4=Out Func3=In Func2=In Func1=In Func0=In 
// State7=0 State6=T State5=T State4=0 State3=T State2=T State1=T State0=T 
PORTB=0x00;
DDRB=0x90;
// Port C initialization
// Func7=In Func6=In Func5=In Func4=In Func3=Out Func2=Out Func1=Out Func0=Out 
// State7=T State6=T State5=T State4=T State3=0 State2=0 State1=0 State0=0 
PORTC=0x00;
DDRC=0x0F;
// Port D initialization
// Func7=In Func6=In Func5=Out Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=0 State4=T State3=T State2=T State1=T State0=T 
PORTD=0x00;
DDRD=0x20;
// Port E initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=Out Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=0 State0=T 
PORTE=0x00;
DDRE=0x02;
// Port F initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTF=0x00;
DDRF=0x00;
// Port G initialization
// Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State5=T State4=T State3=T State2=T State1=T State0=T 
PORTG=0x00;
DDRG=0x00;
// Timer 0
// Left wheel's PWM
// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: 230,313 kHz
// Mode: Fast PWM top=FFh
// OC0A output: Non-Inverted PWM
// OC0B output: Disconnected
TCCR0A=0x83;
TCCR0B=0x03;
TCNT0=0x00;
OCR0A=0x4F;
OCR0B=0x00;
// Timer 2
// Right wheel's PWM
// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: 230,313 kHz
// Mode: Fast PWM top=FFh
// OC2A output: Non-Inverted PWM
// OC2B output: Disconnected
(*(unsigned char *) 0xb6)=0x00;
(*(unsigned char *) 0xb0)=0x83;
(*(unsigned char *) 0xb1)=0x03;
(*(unsigned char *) 0xb2)=0x00;
(*(unsigned char *) 0xb3)=0x4F;
(*(unsigned char *) 0xb4)=0x00;
// Timer 1
// Left wheel's impulse counter
// Timer/Counter 1 initialization
// Clock source: T1 pin Falling Edge
// Mode: Normal top=FFFFh
// Noise Canceler: Off
// Input Capture on Falling Edge
// OC3A output: Discon.
// OC3B output: Discon.
// OC3C output: Discon.
// Timer 1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
(*(unsigned char *) 0x80)=0x00;
(*(unsigned char *) 0x81)=0x06;
(*(unsigned char *) 0x85)=0x00;
(*(unsigned char *) 0x84)=0x00;
(*(unsigned char *) 0x87)=0x00;
(*(unsigned char *) 0x86)=0x00;
(*(unsigned char *) 0x89)=0x00;
(*(unsigned char *) 0x88)=0x00;
(*(unsigned char *) 0x8b)=0x00;
(*(unsigned char *) 0x8a)=0x00;
(*(unsigned char *) 0x8d)=0x00;
(*(unsigned char *) 0x8c)=0x00;
// Timer 3
// Right wheel's impulse counter
// Timer/Counter 3 initialization
// Clock source: T3 pin Falling Edge
// Mode: Normal top=FFFFh
// Noise Canceler: Off
// Input Capture on Falling Edge
// OC3A output: Discon.
// OC3B output: Discon.
// OC3C output: Discon.
// Timer 3 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
(*(unsigned char *) 0x90)=0x00;
(*(unsigned char *) 0x91)=0x06;
(*(unsigned char *) 0x95)=0x00;
(*(unsigned char *) 0x94)=0x00;
(*(unsigned char *) 0x97)=0x00;
(*(unsigned char *) 0x96)=0x00;
(*(unsigned char *) 0x99)=0x00;
(*(unsigned char *) 0x98)=0x00;
(*(unsigned char *) 0x9b)=0x00;
(*(unsigned char *) 0x9a)=0x00;
(*(unsigned char *) 0x9d)=0x00;
(*(unsigned char *) 0x9c)=0x00;
// Timer 5
// Time counter for Timer 1 and 3
// Timer/Counter 5 initialization
// Clock source: System Clock
// Clock value: 14,395 kHz
// Mode: CTC top=OCR5A
// OC5A output: Discon.
// OC5B output: Discon.
// OC5C output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer 5 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: On
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
(*(unsigned char *) 0x120)=0x00;
(*(unsigned char *) 0x121)=0x0D;
(*(unsigned char *) 0x125)=0x00;
(*(unsigned char *) 0x124)=0x00;
(*(unsigned char *) 0x127)=0x00;
(*(unsigned char *) 0x126)=0x00;
(*(unsigned char *) 0x129)=0x05;  //59F - 1439 Hz  -> time=0.1c - time for interrupt
(*(unsigned char *) 0x128)=0x9F;
(*(unsigned char *) 0x12b)=0x00;
(*(unsigned char *) 0x12a)=0x00;
(*(unsigned char *) 0x12d)=0x00;
(*(unsigned char *) 0x12c)=0x00;
// Timer 4
// no used
// Timer/Counter 4 initialization
// Clock source: System Clock
// Clock value: Timer 4 Stopped
// Mode: Normal top=FFFFh
// OC4A output: Discon.
// OC4B output: Discon.
// OC4C output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer 4 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
(*(unsigned char *) 0xa0)=0x00;
(*(unsigned char *) 0xa1)=0x00;
(*(unsigned char *) 0xa5)=0x00;
(*(unsigned char *) 0xa4)=0x00;
(*(unsigned char *) 0xa7)=0x00;
(*(unsigned char *) 0xa6)=0x00;
(*(unsigned char *) 0xa9)=0x00;
(*(unsigned char *) 0xa8)=0x00;
(*(unsigned char *) 0xab)=0x00;
(*(unsigned char *) 0xaa)=0x00;
(*(unsigned char *) 0xad)=0x00;
(*(unsigned char *) 0xac)=0x00;
// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
// INT3: Off
// INT4: Off
// INT5: Off
// INT6: Off
// INT7: Off
(*(unsigned char *) 0x69)=0x00;
(*(unsigned char *) 0x6a)=0x00;
EIMSK=0x00;
// PCINT0 interrupt: Off
// PCINT1 interrupt: Off
// PCINT2 interrupt: Off
// PCINT3 interrupt: Off
// PCINT4 interrupt: Off
// PCINT5 interrupt: Off
// PCINT6 interrupt: Off
// PCINT7 interrupt: Off
// PCINT8 interrupt: Off
// PCINT9 interrupt: Off
// PCINT10 interrupt: Off
// PCINT11 interrupt: Off
// PCINT12 interrupt: Off
// PCINT13 interrupt: Off
// PCINT14 interrupt: Off
// PCINT15 interrupt: Off
// PCINT16 interrupt: Off
// PCINT17 interrupt: Off
// PCINT18 interrupt: Off
// PCINT19 interrupt: Off
// PCINT20 interrupt: Off
// PCINT21 interrupt: Off
// PCINT22 interrupt: Off
// PCINT23 interrupt: Off
(*(unsigned char *) 0x6b)=0x00;
(*(unsigned char *) 0x6c)=0x00;
(*(unsigned char *) 0x6d)=0x00;
(*(unsigned char *) 0x68)=0x00;
// Timer/Counter 0 Interrupt(s) initialization
(*(unsigned char *) 0x6e)=0x00;
// Timer/Counter 1 Interrupt(s) initialization
(*(unsigned char *) 0x6f)=0x00;
// Timer/Counter 2 Interrupt(s) initialization
(*(unsigned char *) 0x70)=0x00;
// Timer/Counter 3 Interrupt(s) initialization
(*(unsigned char *) 0x71)=0x00;
// Timer/Counter 4 Interrupt(s) initialization
(*(unsigned char *) 0x72)=0x00;
// Timer/Counter 5 Interrupt(s) initialization
(*(unsigned char *) 0x73)=0x02;
// USART1 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART1 Receiver: On
// USART1 Transmitter: On
// USART1 Mode: Asynchronous
// USART1 Baud Rate: 9600 /// why did we change it? It was 57600 and 0F
(*(unsigned char *) 0xc8)=0x00;
(*(unsigned char *) 0xc9)=0x18;
(*(unsigned char *) 0xca)=0x06;
(*(unsigned char *) 0xcd)=0x00;
(*(unsigned char *) 0xcc)=0x5F;    // 0F - 57600 //5F - 9600
// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
(*(unsigned char *) 0x7b)=0x00;
#asm("sei")
count1=0;
count3=0;
PWML=OCR0A;
PWMR=(*(unsigned char *) 0xb3);
C_PWML=0;
C_PWMR=0;
//PWML,PWMR - PWM main parameters
//C_PWML, C_PWMR - PWM add parameters
// Realy main part 
while (1)
      {
      PORTB.7 = 1;//left wheel start
      PORTB.4 = 1;//right wheel start
      //direction regulation
      f=getchar1(); //read the command
      switch (f) { 
        case 'w' :  // Move forward!
          //Start Timer5
          (*(unsigned char *) 0x121)=0x0D;  //Timer5 parameters 
          (*(unsigned char *) 0x129)=0x05;  
          (*(unsigned char *) 0x128)=0x9F;  
          (*(unsigned char *) 0x73)=0x02;  //Timer5 interrupt 
                    PORTC.0 = 1;
          PORTC.1 = 0;
                PORTC.2 = 0;
          PORTC.3 = 1; 
                    C_PWML=0;
          C_PWMR=0; 
                    f1='w';
          break;
        case 's' :  // Move back!
          //Start Timer5
          (*(unsigned char *) 0x121)=0x0D;  //Timer5 parameters 
          (*(unsigned char *) 0x129)=0x05;  
          (*(unsigned char *) 0x128)=0x9F;  
          (*(unsigned char *) 0x73)=0x02;  //Timer5 interrupt 
                     PORTC.0 = 0;
          PORTC.1 = 1;
                PORTC.2 = 1;
          PORTC.3 = 0;
                              C_PWML=0;
          C_PWMR=0; 
                       f1='w';    //try
          break;
        case 'd' :  // Move left!
          //Stop Timer5
          (*(unsigned char *) 0x121)=0x00;  //Timer5 parameters 
          (*(unsigned char *) 0x129)=0x00;  
          (*(unsigned char *) 0x128)=0x00;  
          (*(unsigned char *) 0x73)=0x00;  //Timer5 interrupt  
                    PORTC.0 = 1;
          PORTC.1 = 0;
                PORTC.2 = 1;
          PORTC.3 = 0;
                              C_PWML=0;
          C_PWMR=0;   
                       f1='d'; 
          break;
        case 'a' :  // Move right!
          //Stop Timer5
          (*(unsigned char *) 0x121)=0x00;  //Timer5 parameters 
          (*(unsigned char *) 0x129)=0x00;  
          (*(unsigned char *) 0x128)=0x00;  
          (*(unsigned char *) 0x73)=0x00;  //Timer5 interrupt  
                    PORTC.0 = 0;
          PORTC.1 = 1;
                PORTC.2 = 0;
          PORTC.3 = 1;  
                              C_PWML=0;
          C_PWMR=0;   
                       f1='a';
          break;
        case 'f' :  // Move stop!
          //Stop Timer5
          (*(unsigned char *) 0x121)=0x00;  //Timer5 parameters 
          (*(unsigned char *) 0x129)=0x00;  
          (*(unsigned char *) 0x128)=0x00;  
          (*(unsigned char *) 0x73)=0x00;  //Timer5 interrupt  
                     PORTC.0 = 0;
          PORTC.1 = 0;
                PORTC.2 = 0;
          PORTC.3 = 0; 
                              C_PWML=0;
          C_PWMR=0;   
                       f1='f'; 
          break;
        case 'z' :  // Move fast!
          PWML++; 
          PWMR++;
          break;
        case 'x' :  // Move slow! 
          PWML--;  
          PWMR--; 
          break;
                case 'u' :  // Move forward-left 
          //Stop Timer5
          (*(unsigned char *) 0x121)=0x00;  //Timer5 parameters 
          (*(unsigned char *) 0x129)=0x00;  
          (*(unsigned char *) 0x128)=0x00;  
          (*(unsigned char *) 0x73)=0x00;  //Timer5 interrupt
                    C_PWML=0;
          C_PWMR=C_PWM; 
                    PORTC.0 = 1;
          PORTC.1 = 0;
                PORTC.2 = 0;
          PORTC.3 = 1;  
                                   f1='f'; 
          break; 
                  case 'i' :  // Move forward-right 
          //Stop Timer5
          (*(unsigned char *) 0x121)=0x00;  //Timer5 parameters 
          (*(unsigned char *) 0x129)=0x00;  
          (*(unsigned char *) 0x128)=0x00;  
          (*(unsigned char *) 0x73)=0x00;  //Timer5 interrupt   
                    C_PWML=C_PWM;
          C_PWMR=0; 
                    PORTC.0 = 1;
          PORTC.1 = 0;
                PORTC.2 = 0;
          PORTC.3 = 1;   
                       f1='f';
          break;  
                  case 'o' :  // Move back-left
          //Stop Timer5
          (*(unsigned char *) 0x121)=0x00;  //Timer5 parameters 
          (*(unsigned char *) 0x129)=0x00;  
          (*(unsigned char *) 0x128)=0x00;  
          (*(unsigned char *) 0x73)=0x00;  //Timer5 interrupt 
                    C_PWML=0;
          C_PWMR=C_PWM; 
                    PORTC.0 = 0;
          PORTC.1 = 1;
                PORTC.2 = 1;
          PORTC.3 = 0;   
                       f1='f';
          break; 
                  case 'p' :  // Move back-right 
          //Stop Timer5
          (*(unsigned char *) 0x121)=0x00;  //Timer5 parameters 
          (*(unsigned char *) 0x129)=0x00;  
          (*(unsigned char *) 0x128)=0x00;  
          (*(unsigned char *) 0x73)=0x00;  //Timer5 interrupt 
                    C_PWML=C_PWM;
          C_PWMR=0; 
                    PORTC.0 = 0;
          PORTC.1 = 1;
                PORTC.2 = 1;
          PORTC.3 = 0;   
                       f1='f';
          break;  
                  case 'q' :  // Info about rotate
          putchar1('l');
          putnumber((*(unsigned char *) 0x84));
          putnumber((*(unsigned char *) 0x85));
          putchar1('_');
          putchar1('r');
          putnumber((*(unsigned char *) 0x94));
          putnumber((*(unsigned char *) 0x95));
          putchar1('_'); 
          putchar1('_'); 
          /*itoa(TCNT1H,str);     
          for (i=0;i<=strlen(str);i++){
           putchar1(str[i]);       
          }
          itoa(TCNT1L,str);     
          for (i=0;i<=strlen(str);i++){
           putchar1(str[i]);       
          }
          putchar1(' '); 
          putchar1(' ');*/
          break;
                  case 'l' :  // Turn left, 90
          //Stop Timer5
          (*(unsigned char *) 0x121)=0x00;  //Timer5 parameters 
          (*(unsigned char *) 0x129)=0x00;  
          (*(unsigned char *) 0x128)=0x00;  
          (*(unsigned char *) 0x73)=0x00;  //Timer5 interrupt 
                    rotate('l'); 
          C_PWML=0;
          C_PWMR=0; 
             f1='f';
          break;
                        case 'r' :  // Turn right, 90
          //Stop Timer5
          (*(unsigned char *) 0x121)=0x00;  //Timer5 parameters 
          (*(unsigned char *) 0x129)=0x00;  
          (*(unsigned char *) 0x128)=0x00;  
          (*(unsigned char *) 0x73)=0x00;  //Timer5 interrupt 
                    rotate('r');
          C_PWML=0;
          C_PWMR=0; 
          f1='f';
          break;  
                  default:
          break;
      } //and of switch
      OCR0A=PWML+C_PWML;   // left PWM
      (*(unsigned char *) 0xb3)=PWMR+C_PWMR;   // right PWM
      } //end of main while
} //end of main main
