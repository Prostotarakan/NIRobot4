C/C++

NIRobot_4
YTC.B-71-81 :)

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
 
void rotate(char c) - turn left('l') or right('r')   


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

