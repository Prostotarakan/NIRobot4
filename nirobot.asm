
;CodeVisionAVR C Compiler V1.25.9 Standard
;(C) Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega1281
;Program type           : Application
;Clock frequency        : 14,740000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External SRAM size     : 0
;Data Stack size        : 2048 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : No
;char is unsigned       : Yes
;8 bit enums            : Yes
;Word align FLASH struct: No
;Enhanced core instructions    : On
;Smart register allocation : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega1281
	#pragma AVRPART MEMORY PROG_FLASH 131072
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 8192
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x200

	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU WDTCSR=0x60
	.EQU UCSR0A=0xC0
	.EQU UDR0=0xC6
	.EQU RAMPZ=0x3B
	.EQU EIND=0x3C
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x74
	.EQU XMCRB=0x75
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM
	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM
	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM
	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ANDI R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ORI  R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	LDI  R22,BYTE3(2*@0+@1)
	LDI  R23,BYTE4(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+@3)
	LDI  R@1,HIGH(@2*2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+@2
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+@3
	LDS  R@1,@2+@3+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+@1,R0
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "nirobot.vec"
	.INCLUDE "nirobot.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRA,R30
	STS  XMCRB,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	WDR
	IN   R26,MCUSR
	CBR  R26,8
	OUT  MCUSR,R26
	STS  WDTCSR,R31
	STS  WDTCSR,R30

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x2000)
	LDI  R25,HIGH(0x2000)
	LDI  R26,LOW(0x200)
	LDI  R27,HIGH(0x200)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

	OUT  RAMPZ,R24

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x21FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x21FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0xA00)
	LDI  R29,HIGH(0xA00)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0xA00
;       1 // New version of our code (it's name in txt is all_code_var3, last code's name is all_code_var2, Changed it at 11'th of October, Kate)
;       2 /*****************************************************
;       3 NIRobot_4
;       4 YTC.B-71 :)
;       5 
;       6 Chip type           : ATmega1281
;       7 Program type        : Application
;       8 Clock frequency     : 14,740000 MHz
;       9 Memory model        : Small
;      10 External SRAM size  : 0
;      11 Data Stack size     : 2048
;      12 
;      13 functions:
;      14 char getchar1(void) and  void putchar1(char c) - are for USART1, created bu this program
;      15 void putnumber( int count) - put big integers (decimal!)
;      16 
;      17 interrupt [TIM5_COMPA] void timer5_compa_isr(void) - left wheel's PWM change to stabilize when it move forvard ('w')
;      18 
;      19 void rotate(char c) - turn left('l') or right('r')   //make america great again and this code so
;      20 
;      21 
;      22 //Main part
;      23 void main(void)
;      24 letters and commands:
;      25  f                              f1
;      26 'w' :  // Move forward!         w   //flag for interrupt Timer5
;      27 's' :  // Move back!            w (s)
;      28 'd' :  // Move left!            d
;      29 'a' :  // Move right!           a
;      30 'f' :  // Move stop!            f
;      31 
;      32 'z' :  // Move fast!
;      33 'x' :  // Move slow!
;      34 
;      35 'u' :  // Move forward-left     f
;      36 'i' :  // Move forward-right    f
;      37 'o' :  // Move back-left        f
;      38 'p' :  // Move back-right       f
;      39 
;      40 'q' :  // Info about rotate
;      41 
;      42 'l' :  // Turn left, 90         f
;      43 'r' :  // Turn right, 90        f
;      44 *****************************************************/
;      45 
;      46 #include <mega1281.h>
;      47 	#ifndef __SLEEP_DEFINED__
	#ifndef __SLEEP_DEFINED__
;      48 	#define __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
;      49 	.EQU __se_bit=0x01
	.EQU __se_bit=0x01
;      50 	.EQU __sm_mask=0x0E
	.EQU __sm_mask=0x0E
;      51 	.EQU __sm_powerdown=0x04
	.EQU __sm_powerdown=0x04
;      52 	.EQU __sm_powersave=0x06
	.EQU __sm_powersave=0x06
;      53 	.EQU __sm_standby=0x0C
	.EQU __sm_standby=0x0C
;      54 	.EQU __sm_ext_standby=0x0E
	.EQU __sm_ext_standby=0x0E
;      55 	.EQU __sm_adc_noise_red=0x02
	.EQU __sm_adc_noise_red=0x02
;      56 	.SET power_ctrl_reg=smcr
	.SET power_ctrl_reg=smcr
;      57 	#endif
	#endif
;      58 #include <stdio.h>
;      59 #include <stdlib.h>
;      60 #include <string.h>
;      61 
;      62 
;      63 #define RXB8 1
;      64 #define TXB8 0
;      65 #define UPE 2
;      66 #define OVR 3
;      67 #define FE 4
;      68 #define UDRE 5
;      69 #define RXC 7
;      70 
;      71 #define FRAMING_ERROR (1<<FE)
;      72 #define PARITY_ERROR (1<<UPE)
;      73 #define DATA_OVERRUN (1<<OVR)
;      74 #define DATA_REGISTER_EMPTY (1<<UDRE)
;      75 #define RX_COMPLETE (1<<RXC)
;      76 
;      77 //
;      78 
;      79 // Get a character from the USART1 Receiver
;      80 #pragma used+
;      81 char getchar1(void)
;      82 {

	.CSEG
_getchar1:
;      83 char status,data;
;      84 while (1)
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
_0x3:
;      85       {
;      86       while (((status=UCSR1A) & RX_COMPLETE)==0);
_0x6:
	LDS  R30,200
	MOV  R17,R30
	ANDI R30,LOW(0x80)
	BREQ _0x6
;      87       data=UDR1;
	LDS  R16,206
;      88       if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x9
;      89          return data;
	MOV  R30,R16
	RJMP _0x17C
;      90       };
_0x9:
	RJMP _0x3
;      91 }
_0x17C:
	LD   R16,Y+
	LD   R17,Y+
	RET
;      92 #pragma used-
;      93 
;      94 // Write a character to the USART1 Transmitter
;      95 #pragma used+
;      96 void putchar1(char c)
;      97 {
_putchar1:
;      98 while ((UCSR1A & DATA_REGISTER_EMPTY)==0);
;	c -> Y+0
_0xA:
	LDS  R30,200
	ANDI R30,LOW(0x20)
	BREQ _0xA
;      99 UDR1=c;
	LD   R30,Y
	STS  206,R30
;     100 }
	ADIW R28,1
	RET
;     101 #pragma used-
;     102 
;     103 //
;     104 
;     105 // Declare your global variables here
;     106 char f,f1;//,*str;  //command and flag
;     107 int count1,count3,i; // impulse counters
;     108 int PWML,PWMR; //PWM main parameters
;     109 int C_PWML, C_PWMR, C_PWM=50; //PWM add parameters

	.DSEG
_C_PWML:
	.BYTE 0x2
_C_PWMR:
	.BYTE 0x2
_C_PWM:
	.BYTE 0x2
;     110 ///we should understand what size of C_PWM is good. 10 is too slow for normal forvard. 50 is norm
;     111 //float time=0.1, vr=0.0, vl=0.0;
;     112 
;     113 //
;     114 
;     115 //Timer 5 interrupt  //Left wheel's PWM change to stabilize
;     116 // Timer 5 output compare A interrupt service routine
;     117 interrupt [TIM5_COMPA] void timer5_compa_isr(void)
;     118 {

	.CSEG
_timer5_compa_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;     119 // Place your code here
;     120  #asm("sei")
	sei
;     121 // Place your code here
;     122 count1 = TCNT1L;//low part of left wheel impulse
	LDS  R5,132
	CLR  R6
;     123 count3 = TCNT3L; //low part of right wheel impulse
	LDS  R7,148
	CLR  R8
;     124 
;     125 TCNT3L=0x00;TCNT1L=0x00; //clear low impulse counters
	CALL SUBOPT_0x0
;     126 
;     127 //stabilize when move forvard
;     128 if ( f1 == 'w') {
	LDI  R30,LOW(119)
	CP   R30,R3
	BRNE _0xE
;     129 if ( (count3-count1) >= 1 ){ //right is faster
	__GETW2R 7,8
	SUB  R26,R5
	SBC  R27,R6
	SBIW R26,1
	BRLT _0xF
;     130     PWML=PWML+1;//++; // rise left PWM
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 11,12,30,31
;     131     //input information
;     132     //putchar1('r');
;     133     //putchar1((count3-count1)+'0');
;     134 }
;     135 else if ( (count1-count3) >= 1 ) { //left is faster
	RJMP _0x10
_0xF:
	__GETW2R 5,6
	SUB  R26,R7
	SBC  R27,R8
	SBIW R26,1
	BRLT _0x11
;     136     PWML=PWML-1;//--; // low left PWM
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__SUBWRR 11,12,30,31
;     137     //input information
;     138     //putchar1('l');
;     139     //putchar1((count1-count3)+'0');
;     140 }
;     141 OCR0A=PWML; // left PWM
_0x11:
_0x10:
	__GETW1R 11,12
	OUT  0x27,R30
;     142 }
;     143 
;     144 
;     145 } //end of Timer 5 interrupt
_0xE:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;     146 
;     147 
;     148 //
;     149 
;     150 //input string from integer
;     151 void putnumber( int count)
;     152 {
_putnumber:
;     153     char *str;
;     154     itoa(count,str);
	ST   -Y,R17
	ST   -Y,R16
;	count -> Y+2
;	*str -> R16,R17
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	CALL _itoa
;     155     for (i=0;i<=strlen(str);i++)
	CLR  R9
	CLR  R10
_0x13:
	ST   -Y,R17
	ST   -Y,R16
	CALL _strlen
	CP   R30,R9
	CPC  R31,R10
	BRLO _0x14
;     156     {
;     157         putchar1(str[i]);
	__GETW1R 9,10
	ADD  R30,R16
	ADC  R31,R17
	LD   R30,Z
	ST   -Y,R30
	CALL _putchar1
;     158     }
	__GETW1R 9,10
	ADIW R30,1
	__PUTW1R 9,10
	SBIW R30,1
	RJMP _0x13
_0x14:
;     159 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
;     160 
;     161 //
;     162 
;     163 // turn left or right
;     164 void rotate(char c)
;     165 {
_rotate:
;     166         int c0,c1,c2,c3,counter_l,counter_h;
;     167         int angle_H=0x15, angle_L=0x7C;   // 0x157C = 5500 impulses = 1 full wheel rotation   //0x0ABE = 2750 = 1/2 full wheel rotation
;     168         //stop mashine
;     169         PORTC.0 = 0;
	SBIW R28,10
	LDI  R24,4
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x15*2)
	LDI  R31,HIGH(_0x15*2)
	CALL __INITLOCB
	CALL __SAVELOCR6
;	c -> Y+16
;	c0 -> R16,R17
;	c1 -> R18,R19
;	c2 -> R20,R21
;	c3 -> Y+14
;	counter_l -> Y+12
;	counter_h -> Y+10
;	angle_H -> Y+8
;	angle_L -> Y+6
	CALL SUBOPT_0x1
;     170         PORTC.1 = 0;
;     171 
;     172         PORTC.2 = 0;
;     173         PORTC.3 = 0;
;     174         OCR0A=PWML;  //normal speed
	__GETW1R 11,12
	OUT  0x27,R30
;     175         OCR2A=PWMR;
	__GETW1R 13,14
	STS  179,R30
;     176         f1='f';
	LDI  R30,LOW(102)
	MOV  R3,R30
;     177         TCNT3H=0x00;TCNT1H=0x00; //clear impulse counters high
	CALL SUBOPT_0x2
;     178         TCNT3L=0x00;TCNT1L=0x00; //clear impulse counters low
;     179 
;     180         /*putnumber(TCNT3H);
;     181         putnumber(TCNT3L); */
;     182         if (c=='r')   //turn right        left pwm work
	LDD  R26,Y+16
	CPI  R26,LOW(0x72)
	BRNE _0x1E
;     183         {
;     184                 c0=1;
	__GETWRN 16,17,1
;     185                 c1=0;
	__GETWRN 18,19,0
;     186                 c2=0;
	__GETWRN 20,21,0
;     187                 c3=0;
	LDI  R30,0
	STD  Y+14,R30
	STD  Y+14+1,R30
;     188         }
;     189         else //(c=='l') turn left    right pwm work
	RJMP _0x1F
_0x1E:
;     190         {
;     191                 c0=0;
	__GETWRN 16,17,0
;     192                 c1=0;
	__GETWRN 18,19,0
;     193                 c2=0;
	__GETWRN 20,21,0
;     194                 c3=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STD  Y+14,R30
	STD  Y+14+1,R31
;     195         }
_0x1F:
;     196         counter_h=0;
	CALL SUBOPT_0x3
;     197         counter_l=0;
;     198         while ((counter_h<(angle_H))||(counter_l<angle_L))
_0x20:
	CALL SUBOPT_0x4
	CP   R26,R30
	CPC  R27,R31
	BRLT _0x23
	CALL SUBOPT_0x5
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x22
_0x23:
;     199         {
;     200                 if (c=='r')   //turn right
	LDD  R26,Y+16
	CPI  R26,LOW(0x72)
	BRNE _0x25
;     201                 {
;     202                         counter_l=TCNT1L;   //counters for left wheel
	CALL SUBOPT_0x6
	STD  Y+12,R30
	STD  Y+12+1,R31
;     203                         counter_h=TCNT1H;
	LDS  R30,133
	RJMP _0x17D
;     204                 }
;     205                 else //(c=='l') turn left
_0x25:
;     206                 {
;     207                         counter_l=TCNT3L;   //counters for right wheel
	CALL SUBOPT_0x7
	STD  Y+12,R30
	STD  Y+12+1,R31
;     208                         counter_h=TCNT3H;
	LDS  R30,149
_0x17D:
	LDI  R31,0
	STD  Y+10,R30
	STD  Y+10+1,R31
;     209                 }
;     210 
;     211                 PORTC.0 = c0;
	MOVW R30,R16
	CPI  R30,0
	BRNE _0x27
	CBI  0x8,0
	RJMP _0x28
_0x27:
	SBI  0x8,0
_0x28:
;     212                 PORTC.1 = c1;
	MOVW R30,R18
	CPI  R30,0
	BRNE _0x29
	CBI  0x8,1
	RJMP _0x2A
_0x29:
	SBI  0x8,1
_0x2A:
;     213                 PORTC.2 = c2;
	MOVW R30,R20
	CPI  R30,0
	BRNE _0x2B
	CBI  0x8,2
	RJMP _0x2C
_0x2B:
	SBI  0x8,2
_0x2C:
;     214                 PORTC.3 = c3;
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	CPI  R30,0
	BRNE _0x2D
	CBI  0x8,3
	RJMP _0x2E
_0x2D:
	SBI  0x8,3
_0x2E:
;     215 
;     216                 if  ((counter_h>(angle_H))&&(counter_l>angle_L))
	CALL SUBOPT_0x4
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x30
	CALL SUBOPT_0x5
	CP   R30,R26
	CPC  R31,R27
	BRLT _0x31
_0x30:
	RJMP _0x2F
_0x31:
;     217                 {
;     218                 break;
	RJMP _0x22
;     219                 }
;     220         }
_0x2F:
	RJMP _0x20
_0x22:
;     221 
;     222         //stop mashine
;     223         PORTC.0 = 0;
	CALL SUBOPT_0x1
;     224         PORTC.1 = 0;
;     225 
;     226         PORTC.2 = 0;
;     227         PORTC.3 = 0;
;     228         f1='f';
	LDI  R30,LOW(102)
	MOV  R3,R30
;     229 
;     230         /*putnumber(TCNT1H);   // real  left  angle_H_angle_L
;     231         putnumber(TCNT1L);
;     232         putchar1('_');
;     233         putnumber(TCNT3H);   // real  right angle_H_angle_L
;     234         putnumber(TCNT3L);
;     235         putchar1('_');  */
;     236 
;     237         //antiterror
;     238         //work about it
;     239         if (c=='r')   //turn right   left pwm work
	LDD  R26,Y+16
	CPI  R26,LOW(0x72)
	BRNE _0x3A
;     240         {
;     241                 c0=0;
	__GETWRN 16,17,0
;     242                 c1=0;
	__GETWRN 18,19,0
;     243                 c2=1;
	__GETWRN 20,21,1
;     244                 c3=0;
	LDI  R30,0
	STD  Y+14,R30
	STD  Y+14+1,R30
;     245                 angle_L=TCNT3L;
	CALL SUBOPT_0x7
	STD  Y+6,R30
	STD  Y+6+1,R31
;     246                 angle_H=TCNT3H;
	LDS  R30,149
	RJMP _0x17E
;     247         }
;     248         else //(c=='l') turn left    right pwm work
_0x3A:
;     249         {
;     250                 c0=0;
	__GETWRN 16,17,0
;     251                 c1=1;
	__GETWRN 18,19,1
;     252                 c2=0;
	__GETWRN 20,21,0
;     253                 c3=0;
	LDI  R30,0
	STD  Y+14,R30
	STD  Y+14+1,R30
;     254                 angle_L=TCNT1L;
	CALL SUBOPT_0x6
	STD  Y+6,R30
	STD  Y+6+1,R31
;     255                 angle_H=TCNT1H;
	LDS  R30,133
_0x17E:
	LDI  R31,0
	STD  Y+8,R30
	STD  Y+8+1,R31
;     256         }
;     257         TCNT3H=0x00;TCNT1H=0x00; //clear impulse counters high
	CALL SUBOPT_0x2
;     258         TCNT3L=0x00;TCNT1L=0x00; //clear impulse counters low
;     259         counter_h=0;
	CALL SUBOPT_0x3
;     260         counter_l=0;
;     261         while ((counter_h<(angle_H))||(counter_l<angle_L))
_0x3C:
	CALL SUBOPT_0x4
	CP   R26,R30
	CPC  R27,R31
	BRLT _0x3F
	CALL SUBOPT_0x5
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x3E
_0x3F:
;     262         {
;     263                 if (c=='l')   //toturn right
	LDD  R26,Y+16
	CPI  R26,LOW(0x6C)
	BRNE _0x41
;     264                 {
;     265                         counter_l=TCNT1L;   //counters for left wheel
	CALL SUBOPT_0x6
	STD  Y+12,R30
	STD  Y+12+1,R31
;     266                         counter_h=TCNT1H;
	LDS  R30,133
	RJMP _0x17F
;     267                 }
;     268                 else //(c=='r') toturn left
_0x41:
;     269                 {
;     270                         counter_l=TCNT3L;   //counters for right wheel
	CALL SUBOPT_0x7
	STD  Y+12,R30
	STD  Y+12+1,R31
;     271                         counter_h=TCNT3H;
	LDS  R30,149
_0x17F:
	LDI  R31,0
	STD  Y+10,R30
	STD  Y+10+1,R31
;     272                 }
;     273 
;     274                 PORTC.0 = c0;
	MOVW R30,R16
	CPI  R30,0
	BRNE _0x43
	CBI  0x8,0
	RJMP _0x44
_0x43:
	SBI  0x8,0
_0x44:
;     275                 PORTC.1 = c1;
	MOVW R30,R18
	CPI  R30,0
	BRNE _0x45
	CBI  0x8,1
	RJMP _0x46
_0x45:
	SBI  0x8,1
_0x46:
;     276                 PORTC.2 = c2;
	MOVW R30,R20
	CPI  R30,0
	BRNE _0x47
	CBI  0x8,2
	RJMP _0x48
_0x47:
	SBI  0x8,2
_0x48:
;     277                 PORTC.3 = c3;
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	CPI  R30,0
	BRNE _0x49
	CBI  0x8,3
	RJMP _0x4A
_0x49:
	SBI  0x8,3
_0x4A:
;     278 
;     279                 if  ((counter_h>(angle_H))&&(counter_l>angle_L))
	CALL SUBOPT_0x4
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x4C
	CALL SUBOPT_0x5
	CP   R30,R26
	CPC  R31,R27
	BRLT _0x4D
_0x4C:
	RJMP _0x4B
_0x4D:
;     280                 {
;     281                 break;
	RJMP _0x3E
;     282                 }
;     283         }
_0x4B:
	RJMP _0x3C
_0x3E:
;     284 
;     285         //stop mashine
;     286         PORTC.0 = 0;
	CALL SUBOPT_0x1
;     287         PORTC.1 = 0;
;     288 
;     289         PORTC.2 = 0;
;     290         PORTC.3 = 0;
;     291         f1='f';
	LDI  R30,LOW(102)
	MOV  R3,R30
;     292         /*putnumber(counter_h-TC);       // good   angle_H_angle_L
;     293         putnumber(counter_l); */
;     294         /*putchar1('_');
;     295         putnumber(TCNT1H);
;     296         putnumber(TCNT1L);         // real   angle_H_angle_L
;     297         putchar1('_');
;     298         putnumber(TCNT3H);
;     299         putnumber(TCNT3L);
;     300         putchar1('_');  */
;     301         /*itoa(counter_h-TC,str);
;     302         for (i=0;i<=strlen(str);i++){
;     303                 putchar1(str[i]);
;     304         }
;     305         itoa(counter_l,str);
;     306         for (i=0;i<=strlen(str);i++){
;     307                 putchar1(str[i]);
;     308         }
;     309         putchar1('_');
;     310         itoa(angle_H-TC,str);          //sravnivaem
;     311         for (i=0;i<=strlen(str);i++){
;     312                 putchar1(str[i]);
;     313         }
;     314         itoa(angle_L,str);
;     315         for (i=0;i<=strlen(str);i++){
;     316                 putchar1(str[i]);
;     317         }
;     318         putchar1('_');  */
;     319 
;     320 
;     321 }
	CALL __LOADLOCR6
	ADIW R28,17
	RET
;     322 
;     323 
;     324 //
;     325 
;     326 //Main part
;     327 void main(void)
;     328 {
_main:
;     329 // Declare your local variables here
;     330 
;     331 
;     332 // Crystal Oscillator division factor: 1
;     333 #pragma optsize-
;     334 CLKPR=0x80;
	LDI  R30,LOW(128)
	STS  97,R30
;     335 CLKPR=0x00;
	LDI  R30,LOW(0)
	STS  97,R30
;     336 #ifdef _OPTIMIZE_SIZE_
;     337 #pragma optsize+
;     338 #endif
;     339 
;     340 // Input/Output Ports initialization
;     341 // Port A initialization
;     342 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;     343 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;     344 PORTA=0x00;
	OUT  0x2,R30
;     345 DDRA=0x00;
	OUT  0x1,R30
;     346 
;     347 // Port B initialization
;     348 // Func7=Out Func6=In Func5=In Func4=Out Func3=In Func2=In Func1=In Func0=In
;     349 // State7=0 State6=T State5=T State4=0 State3=T State2=T State1=T State0=T
;     350 PORTB=0x00;
	OUT  0x5,R30
;     351 DDRB=0x90;
	LDI  R30,LOW(144)
	OUT  0x4,R30
;     352 
;     353 // Port C initialization
;     354 // Func7=In Func6=In Func5=In Func4=In Func3=Out Func2=Out Func1=Out Func0=Out
;     355 // State7=T State6=T State5=T State4=T State3=0 State2=0 State1=0 State0=0
;     356 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x8,R30
;     357 DDRC=0x0F;
	LDI  R30,LOW(15)
	OUT  0x7,R30
;     358 
;     359 // Port D initialization
;     360 // Func7=In Func6=In Func5=Out Func4=In Func3=In Func2=In Func1=In Func0=In
;     361 // State7=T State6=T State5=0 State4=T State3=T State2=T State1=T State0=T
;     362 PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0xB,R30
;     363 DDRD=0x20;
	LDI  R30,LOW(32)
	OUT  0xA,R30
;     364 
;     365 // Port E initialization
;     366 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=Out Func0=In
;     367 // State7=T State6=T State5=T State4=T State3=T State2=T State1=0 State0=T
;     368 PORTE=0x00;
	LDI  R30,LOW(0)
	OUT  0xE,R30
;     369 DDRE=0x02;
	LDI  R30,LOW(2)
	OUT  0xD,R30
;     370 
;     371 // Port F initialization
;     372 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;     373 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;     374 PORTF=0x00;
	LDI  R30,LOW(0)
	OUT  0x11,R30
;     375 DDRF=0x00;
	OUT  0x10,R30
;     376 
;     377 // Port G initialization
;     378 // Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;     379 // State5=T State4=T State3=T State2=T State1=T State0=T
;     380 PORTG=0x00;
	OUT  0x14,R30
;     381 DDRG=0x00;
	OUT  0x13,R30
;     382 
;     383 
;     384 // Timer 0
;     385 // Left wheel's PWM
;     386 // Timer/Counter 0 initialization
;     387 // Clock source: System Clock
;     388 // Clock value: 230,313 kHz
;     389 // Mode: Fast PWM top=FFh
;     390 // OC0A output: Non-Inverted PWM
;     391 // OC0B output: Disconnected
;     392 TCCR0A=0x83;
	LDI  R30,LOW(131)
	OUT  0x24,R30
;     393 TCCR0B=0x03;
	LDI  R30,LOW(3)
	OUT  0x25,R30
;     394 TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x26,R30
;     395 OCR0A=0x4F;
	LDI  R30,LOW(79)
	OUT  0x27,R30
;     396 OCR0B=0x00;
	LDI  R30,LOW(0)
	OUT  0x28,R30
;     397 
;     398 // Timer 2
;     399 // Right wheel's PWM
;     400 // Timer/Counter 2 initialization
;     401 // Clock source: System Clock
;     402 // Clock value: 230,313 kHz
;     403 // Mode: Fast PWM top=FFh
;     404 // OC2A output: Non-Inverted PWM
;     405 // OC2B output: Disconnected
;     406 ASSR=0x00;
	STS  182,R30
;     407 TCCR2A=0x83;
	LDI  R30,LOW(131)
	STS  176,R30
;     408 TCCR2B=0x03;
	LDI  R30,LOW(3)
	STS  177,R30
;     409 TCNT2=0x00;
	LDI  R30,LOW(0)
	STS  178,R30
;     410 OCR2A=0x4F;
	LDI  R30,LOW(79)
	STS  179,R30
;     411 OCR2B=0x00;
	LDI  R30,LOW(0)
	STS  180,R30
;     412 
;     413 // Timer 1
;     414 // Left wheel's impulse counter
;     415 // Timer/Counter 1 initialization
;     416 // Clock source: T1 pin Falling Edge
;     417 // Mode: Normal top=FFFFh
;     418 // Noise Canceler: Off
;     419 // Input Capture on Falling Edge
;     420 // OC3A output: Discon.
;     421 // OC3B output: Discon.
;     422 // OC3C output: Discon.
;     423 // Timer 1 Overflow Interrupt: Off
;     424 // Input Capture Interrupt: Off
;     425 // Compare A Match Interrupt: Off
;     426 // Compare B Match Interrupt: Off
;     427 // Compare C Match Interrupt: Off
;     428 TCCR1A=0x00;
	STS  128,R30
;     429 TCCR1B=0x06;
	LDI  R30,LOW(6)
	STS  129,R30
;     430 TCNT1H=0x00;
	LDI  R30,LOW(0)
	STS  133,R30
;     431 TCNT1L=0x00;
	STS  132,R30
;     432 ICR1H=0x00;
	STS  135,R30
;     433 ICR1L=0x00;
	STS  134,R30
;     434 OCR1AH=0x00;
	STS  137,R30
;     435 OCR1AL=0x00;
	STS  136,R30
;     436 OCR1BH=0x00;
	STS  139,R30
;     437 OCR1BL=0x00;
	STS  138,R30
;     438 OCR1CH=0x00;
	STS  141,R30
;     439 OCR1CL=0x00;
	STS  140,R30
;     440 
;     441 // Timer 3
;     442 // Right wheel's impulse counter
;     443 // Timer/Counter 3 initialization
;     444 // Clock source: T3 pin Falling Edge
;     445 // Mode: Normal top=FFFFh
;     446 // Noise Canceler: Off
;     447 // Input Capture on Falling Edge
;     448 // OC3A output: Discon.
;     449 // OC3B output: Discon.
;     450 // OC3C output: Discon.
;     451 // Timer 3 Overflow Interrupt: Off
;     452 // Input Capture Interrupt: Off
;     453 // Compare A Match Interrupt: Off
;     454 // Compare B Match Interrupt: Off
;     455 // Compare C Match Interrupt: Off
;     456 TCCR3A=0x00;
	STS  144,R30
;     457 TCCR3B=0x06;
	LDI  R30,LOW(6)
	STS  145,R30
;     458 TCNT3H=0x00;
	LDI  R30,LOW(0)
	STS  149,R30
;     459 TCNT3L=0x00;
	STS  148,R30
;     460 ICR3H=0x00;
	STS  151,R30
;     461 ICR3L=0x00;
	STS  150,R30
;     462 OCR3AH=0x00;
	STS  153,R30
;     463 OCR3AL=0x00;
	STS  152,R30
;     464 OCR3BH=0x00;
	STS  155,R30
;     465 OCR3BL=0x00;
	STS  154,R30
;     466 OCR3CH=0x00;
	STS  157,R30
;     467 OCR3CL=0x00;
	STS  156,R30
;     468 
;     469 // Timer 5
;     470 // Time counter for Timer 1 and 3
;     471 // Timer/Counter 5 initialization
;     472 // Clock source: System Clock
;     473 // Clock value: 14,395 kHz
;     474 // Mode: CTC top=OCR5A
;     475 // OC5A output: Discon.
;     476 // OC5B output: Discon.
;     477 // OC5C output: Discon.
;     478 // Noise Canceler: Off
;     479 // Input Capture on Falling Edge
;     480 // Timer 5 Overflow Interrupt: Off
;     481 // Input Capture Interrupt: Off
;     482 // Compare A Match Interrupt: On
;     483 // Compare B Match Interrupt: Off
;     484 // Compare C Match Interrupt: Off
;     485 TCCR5A=0x00;
	STS  288,R30
;     486 TCCR5B=0x0D;
	LDI  R30,LOW(13)
	STS  289,R30
;     487 TCNT5H=0x00;
	LDI  R30,LOW(0)
	STS  293,R30
;     488 TCNT5L=0x00;
	STS  292,R30
;     489 ICR5H=0x00;
	STS  295,R30
;     490 ICR5L=0x00;
	STS  294,R30
;     491 OCR5AH=0x05;  //59F - 1439 Hz  -> time=0.1c - time for interrupt
	CALL SUBOPT_0x8
;     492 OCR5AL=0x9F;
;     493 OCR5BH=0x00;
	LDI  R30,LOW(0)
	STS  299,R30
;     494 OCR5BL=0x00;
	STS  298,R30
;     495 OCR5CH=0x00;
	STS  301,R30
;     496 OCR5CL=0x00;
	STS  300,R30
;     497 
;     498 
;     499 // Timer 4
;     500 // no used
;     501 // Timer/Counter 4 initialization
;     502 // Clock source: System Clock
;     503 // Clock value: Timer 4 Stopped
;     504 // Mode: Normal top=FFFFh
;     505 // OC4A output: Discon.
;     506 // OC4B output: Discon.
;     507 // OC4C output: Discon.
;     508 // Noise Canceler: Off
;     509 // Input Capture on Falling Edge
;     510 // Timer 4 Overflow Interrupt: Off
;     511 // Input Capture Interrupt: Off
;     512 // Compare A Match Interrupt: Off
;     513 // Compare B Match Interrupt: Off
;     514 // Compare C Match Interrupt: Off
;     515 TCCR4A=0x00;
	STS  160,R30
;     516 TCCR4B=0x00;
	STS  161,R30
;     517 TCNT4H=0x00;
	STS  165,R30
;     518 TCNT4L=0x00;
	STS  164,R30
;     519 ICR4H=0x00;
	STS  167,R30
;     520 ICR4L=0x00;
	STS  166,R30
;     521 OCR4AH=0x00;
	STS  169,R30
;     522 OCR4AL=0x00;
	STS  168,R30
;     523 OCR4BH=0x00;
	STS  171,R30
;     524 OCR4BL=0x00;
	STS  170,R30
;     525 OCR4CH=0x00;
	STS  173,R30
;     526 OCR4CL=0x00;
	STS  172,R30
;     527 
;     528 
;     529 // External Interrupt(s) initialization
;     530 // INT0: Off
;     531 // INT1: Off
;     532 // INT2: Off
;     533 // INT3: Off
;     534 // INT4: Off
;     535 // INT5: Off
;     536 // INT6: Off
;     537 // INT7: Off
;     538 EICRA=0x00;
	STS  105,R30
;     539 EICRB=0x00;
	STS  106,R30
;     540 EIMSK=0x00;
	OUT  0x1D,R30
;     541 
;     542 // PCINT0 interrupt: Off
;     543 // PCINT1 interrupt: Off
;     544 // PCINT2 interrupt: Off
;     545 // PCINT3 interrupt: Off
;     546 // PCINT4 interrupt: Off
;     547 // PCINT5 interrupt: Off
;     548 // PCINT6 interrupt: Off
;     549 // PCINT7 interrupt: Off
;     550 // PCINT8 interrupt: Off
;     551 // PCINT9 interrupt: Off
;     552 // PCINT10 interrupt: Off
;     553 // PCINT11 interrupt: Off
;     554 // PCINT12 interrupt: Off
;     555 // PCINT13 interrupt: Off
;     556 // PCINT14 interrupt: Off
;     557 // PCINT15 interrupt: Off
;     558 // PCINT16 interrupt: Off
;     559 // PCINT17 interrupt: Off
;     560 // PCINT18 interrupt: Off
;     561 // PCINT19 interrupt: Off
;     562 // PCINT20 interrupt: Off
;     563 // PCINT21 interrupt: Off
;     564 // PCINT22 interrupt: Off
;     565 // PCINT23 interrupt: Off
;     566 PCMSK0=0x00;
	STS  107,R30
;     567 PCMSK1=0x00;
	STS  108,R30
;     568 PCMSK2=0x00;
	STS  109,R30
;     569 PCICR=0x00;
	STS  104,R30
;     570 
;     571 // Timer/Counter 0 Interrupt(s) initialization
;     572 TIMSK0=0x00;
	STS  110,R30
;     573 // Timer/Counter 1 Interrupt(s) initialization
;     574 TIMSK1=0x00;
	STS  111,R30
;     575 // Timer/Counter 2 Interrupt(s) initialization
;     576 TIMSK2=0x00;
	STS  112,R30
;     577 // Timer/Counter 3 Interrupt(s) initialization
;     578 TIMSK3=0x00;
	STS  113,R30
;     579 // Timer/Counter 4 Interrupt(s) initialization
;     580 TIMSK4=0x00;
	STS  114,R30
;     581 // Timer/Counter 5 Interrupt(s) initialization
;     582 TIMSK5=0x02;
	LDI  R30,LOW(2)
	STS  115,R30
;     583 
;     584 
;     585 // USART1 initialization
;     586 // Communication Parameters: 8 Data, 1 Stop, No Parity
;     587 // USART1 Receiver: On
;     588 // USART1 Transmitter: On
;     589 // USART1 Mode: Asynchronous
;     590 // USART1 Baud Rate: 9600 /// why did we change it? It was 57600 and 0F
;     591 UCSR1A=0x00;
	LDI  R30,LOW(0)
	STS  200,R30
;     592 UCSR1B=0x18;
	LDI  R30,LOW(24)
	STS  201,R30
;     593 UCSR1C=0x06;
	LDI  R30,LOW(6)
	STS  202,R30
;     594 UBRR1H=0x00;
	LDI  R30,LOW(0)
	STS  205,R30
;     595 UBRR1L=0x5F;    // 0F - 57600 //5F - 9600
	LDI  R30,LOW(95)
	STS  204,R30
;     596 
;     597 
;     598 // Analog Comparator initialization
;     599 // Analog Comparator: Off
;     600 // Analog Comparator Input Capture by Timer/Counter 1: Off
;     601 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x30,R30
;     602 ADCSRB=0x00;
	LDI  R30,LOW(0)
	STS  123,R30
;     603 
;     604 #asm("sei")
	sei
;     605 count1=0;
	CLR  R5
	CLR  R6
;     606 count3=0;
	CLR  R7
	CLR  R8
;     607 PWML=OCR0A;
	IN   R11,39
	CLR  R12
;     608 PWMR=OCR2A;
	LDS  R13,179
	CLR  R14
;     609 C_PWML=0;
	CALL SUBOPT_0x9
;     610 C_PWMR=0;
;     611 //PWML,PWMR - PWM main parameters
;     612 //C_PWML, C_PWMR - PWM add parameters
;     613 // Realy main part
;     614 while (1)
_0x56:
;     615       {
;     616       PORTB.7 = 1;//left wheel start
	SBI  0x5,7
;     617       PORTB.4 = 1;//right wheel start
	SBI  0x5,4
;     618 
;     619       //direction regulation
;     620       f=getchar1(); //read the command
	CALL _getchar1
	MOV  R4,R30
;     621 
;     622       switch (f) {
	MOV  R30,R4
;     623         case 'w' :  // Move forward!
	CPI  R30,LOW(0x77)
	BRNE _0x60
;     624           //Start Timer5
;     625           TCCR5B=0x0D;  //Timer5 parameters
	LDI  R30,LOW(13)
	STS  289,R30
;     626           OCR5AH=0x05;
	CALL SUBOPT_0x8
;     627           OCR5AL=0x9F;
;     628           TIMSK5=0x02;  //Timer5 interrupt
	LDI  R30,LOW(2)
	STS  115,R30
;     629 
;     630           PORTC.0 = 1;
	CALL SUBOPT_0xA
;     631           PORTC.1 = 0;
;     632 
;     633           PORTC.2 = 0;
;     634           PORTC.3 = 1;
;     635 
;     636           C_PWML=0;
	CALL SUBOPT_0x9
;     637           C_PWMR=0;
;     638 
;     639           f1='w';
	LDI  R30,LOW(119)
	MOV  R3,R30
;     640           break;
	RJMP _0x5F
;     641 
;     642         case 's' :  // Move back!
_0x60:
	CPI  R30,LOW(0x73)
	BRNE _0x69
;     643           //Start Timer5
;     644           TCCR5B=0x0D;  //Timer5 parameters
	LDI  R30,LOW(13)
	STS  289,R30
;     645           OCR5AH=0x05;
	CALL SUBOPT_0x8
;     646           OCR5AL=0x9F;
;     647           TIMSK5=0x02;  //Timer5 interrupt
	LDI  R30,LOW(2)
	STS  115,R30
;     648 
;     649           PORTC.0 = 0;
	CALL SUBOPT_0xB
;     650           PORTC.1 = 1;
;     651 
;     652           PORTC.2 = 1;
;     653           PORTC.3 = 0;
;     654 
;     655           C_PWML=0;
	CALL SUBOPT_0x9
;     656           C_PWMR=0;
;     657 
;     658           f1='w';    //try
	LDI  R30,LOW(119)
	MOV  R3,R30
;     659           break;
	RJMP _0x5F
;     660 
;     661         case 'd' :  // Move left!
_0x69:
	CPI  R30,LOW(0x64)
	BRNE _0x72
;     662           //Stop Timer5
;     663           TCCR5B=0x00;  //Timer5 parameters
	CALL SUBOPT_0xC
;     664           OCR5AH=0x00;
;     665           OCR5AL=0x00;
;     666           TIMSK5=0x00;  //Timer5 interrupt
;     667 
;     668           PORTC.0 = 1;
	SBI  0x8,0
;     669           PORTC.1 = 0;
	CBI  0x8,1
;     670 
;     671           PORTC.2 = 1;
	SBI  0x8,2
;     672           PORTC.3 = 0;
	CBI  0x8,3
;     673 
;     674           C_PWML=0;
	CALL SUBOPT_0x9
;     675           C_PWMR=0;
;     676 
;     677           f1='d';
	LDI  R30,LOW(100)
	MOV  R3,R30
;     678           break;
	RJMP _0x5F
;     679 
;     680         case 'a' :  // Move right!
_0x72:
	CPI  R30,LOW(0x61)
	BRNE _0x7B
;     681           //Stop Timer5
;     682           TCCR5B=0x00;  //Timer5 parameters
	CALL SUBOPT_0xC
;     683           OCR5AH=0x00;
;     684           OCR5AL=0x00;
;     685           TIMSK5=0x00;  //Timer5 interrupt
;     686 
;     687           PORTC.0 = 0;
	CBI  0x8,0
;     688           PORTC.1 = 1;
	SBI  0x8,1
;     689 
;     690           PORTC.2 = 0;
	CBI  0x8,2
;     691           PORTC.3 = 1;
	SBI  0x8,3
;     692 
;     693           C_PWML=0;
	CALL SUBOPT_0x9
;     694           C_PWMR=0;
;     695 
;     696           f1='a';
	LDI  R30,LOW(97)
	MOV  R3,R30
;     697           break;
	RJMP _0x5F
;     698 
;     699         case 'f' :  // Move stop!
_0x7B:
	CPI  R30,LOW(0x66)
	BRNE _0x84
;     700           //Stop Timer5
;     701           TCCR5B=0x00;  //Timer5 parameters
	CALL SUBOPT_0xC
;     702           OCR5AH=0x00;
;     703           OCR5AL=0x00;
;     704           TIMSK5=0x00;  //Timer5 interrupt
;     705 
;     706           PORTC.0 = 0;
	CALL SUBOPT_0x1
;     707           PORTC.1 = 0;
;     708 
;     709           PORTC.2 = 0;
;     710           PORTC.3 = 0;
;     711 
;     712           C_PWML=0;
	CALL SUBOPT_0x9
;     713           C_PWMR=0;
;     714 
;     715           f1='f';
	LDI  R30,LOW(102)
	MOV  R3,R30
;     716           break;
	RJMP _0x5F
;     717 
;     718         case 'z' :  // Move fast!
_0x84:
	CPI  R30,LOW(0x7A)
	BRNE _0x8D
;     719           PWML++;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__ADDWRR 11,12,30,31
;     720           PWMR++;
	__ADDWRR 13,14,30,31
;     721           break;
	RJMP _0x5F
;     722 
;     723         case 'x' :  // Move slow!
_0x8D:
	CPI  R30,LOW(0x78)
	BRNE _0x8E
;     724           PWML--;
	__GETW1R 11,12
	SBIW R30,1
	__PUTW1R 11,12
;     725           PWMR--;
	__GETW1R 13,14
	SBIW R30,1
	__PUTW1R 13,14
;     726           break;
	RJMP _0x5F
;     727 
;     728         case 'u' :  // Move forward-left
_0x8E:
	CPI  R30,LOW(0x75)
	BRNE _0x8F
;     729           //Stop Timer5
;     730           TCCR5B=0x00;  //Timer5 parameters
	CALL SUBOPT_0xC
;     731           OCR5AH=0x00;
;     732           OCR5AL=0x00;
;     733           TIMSK5=0x00;  //Timer5 interrupt
;     734 
;     735           C_PWML=0;
	CALL SUBOPT_0xD
;     736           C_PWMR=C_PWM;
;     737 
;     738           PORTC.0 = 1;
	CALL SUBOPT_0xA
;     739           PORTC.1 = 0;
;     740 
;     741           PORTC.2 = 0;
;     742           PORTC.3 = 1;
;     743 
;     744 
;     745           f1='f';
	LDI  R30,LOW(102)
	MOV  R3,R30
;     746           break;
	RJMP _0x5F
;     747 
;     748         case 'i' :  // Move forward-right
_0x8F:
	CPI  R30,LOW(0x69)
	BRNE _0x98
;     749           //Stop Timer5
;     750           TCCR5B=0x00;  //Timer5 parameters
	CALL SUBOPT_0xC
;     751           OCR5AH=0x00;
;     752           OCR5AL=0x00;
;     753           TIMSK5=0x00;  //Timer5 interrupt
;     754 
;     755           C_PWML=C_PWM;
	CALL SUBOPT_0xE
;     756           C_PWMR=0;
;     757 
;     758           PORTC.0 = 1;
	CALL SUBOPT_0xA
;     759           PORTC.1 = 0;
;     760 
;     761           PORTC.2 = 0;
;     762           PORTC.3 = 1;
;     763 
;     764           f1='f';
	LDI  R30,LOW(102)
	MOV  R3,R30
;     765           break;
	RJMP _0x5F
;     766 
;     767         case 'o' :  // Move back-left
_0x98:
	CPI  R30,LOW(0x6F)
	BRNE _0xA1
;     768           //Stop Timer5
;     769           TCCR5B=0x00;  //Timer5 parameters
	CALL SUBOPT_0xC
;     770           OCR5AH=0x00;
;     771           OCR5AL=0x00;
;     772           TIMSK5=0x00;  //Timer5 interrupt
;     773 
;     774           C_PWML=0;
	CALL SUBOPT_0xD
;     775           C_PWMR=C_PWM;
;     776 
;     777           PORTC.0 = 0;
	CALL SUBOPT_0xB
;     778           PORTC.1 = 1;
;     779 
;     780           PORTC.2 = 1;
;     781           PORTC.3 = 0;
;     782 
;     783           f1='f';
	LDI  R30,LOW(102)
	MOV  R3,R30
;     784           break;
	RJMP _0x5F
;     785 
;     786         case 'p' :  // Move back-right
_0xA1:
	CPI  R30,LOW(0x70)
	BRNE _0xAA
;     787           //Stop Timer5
;     788           TCCR5B=0x00;  //Timer5 parameters
	CALL SUBOPT_0xC
;     789           OCR5AH=0x00;
;     790           OCR5AL=0x00;
;     791           TIMSK5=0x00;  //Timer5 interrupt
;     792 
;     793           C_PWML=C_PWM;
	CALL SUBOPT_0xE
;     794           C_PWMR=0;
;     795 
;     796           PORTC.0 = 0;
	CALL SUBOPT_0xB
;     797           PORTC.1 = 1;
;     798 
;     799           PORTC.2 = 1;
;     800           PORTC.3 = 0;
;     801 
;     802           f1='f';
	LDI  R30,LOW(102)
	MOV  R3,R30
;     803           break;
	RJMP _0x5F
;     804 
;     805         case 'q' :  // Info about rotate
_0xAA:
	CPI  R30,LOW(0x71)
	BRNE _0xB3
;     806           putchar1('l');
	LDI  R30,LOW(108)
	ST   -Y,R30
	CALL _putchar1
;     807           putnumber(TCNT1L);
	CALL SUBOPT_0x6
	CALL SUBOPT_0xF
;     808           putnumber(TCNT1H);
	LDS  R30,133
	LDI  R31,0
	CALL SUBOPT_0xF
;     809           putchar1('_');
	CALL SUBOPT_0x10
;     810           putchar1('r');
	LDI  R30,LOW(114)
	ST   -Y,R30
	CALL _putchar1
;     811           putnumber(TCNT3L);
	CALL SUBOPT_0x7
	CALL SUBOPT_0xF
;     812           putnumber(TCNT3H);
	LDS  R30,149
	LDI  R31,0
	CALL SUBOPT_0xF
;     813           putchar1('_');
	CALL SUBOPT_0x10
;     814           putchar1('_');
	CALL SUBOPT_0x10
;     815           /*itoa(TCNT1H,str);
;     816           for (i=0;i<=strlen(str);i++){
;     817            putchar1(str[i]);
;     818           }
;     819           itoa(TCNT1L,str);
;     820           for (i=0;i<=strlen(str);i++){
;     821            putchar1(str[i]);
;     822           }
;     823           putchar1(' ');
;     824           putchar1(' ');*/
;     825           break;
	RJMP _0x5F
;     826 
;     827         case 'l' :  // Turn left, 90
_0xB3:
	CPI  R30,LOW(0x6C)
	BRNE _0xB4
;     828           //Stop Timer5
;     829           TCCR5B=0x00;  //Timer5 parameters
	CALL SUBOPT_0xC
;     830           OCR5AH=0x00;
;     831           OCR5AL=0x00;
;     832           TIMSK5=0x00;  //Timer5 interrupt
;     833 
;     834           rotate('l');
	LDI  R30,LOW(108)
	ST   -Y,R30
	CALL _rotate
;     835           C_PWML=0;
	CALL SUBOPT_0x9
;     836           C_PWMR=0;
;     837 
;     838           f1='f';
	LDI  R30,LOW(102)
	MOV  R3,R30
;     839           break;
	RJMP _0x5F
;     840 
;     841 
;     842         case 'r' :  // Turn right, 90
_0xB4:
	CPI  R30,LOW(0x72)
	BRNE _0xB6
;     843           //Stop Timer5
;     844           TCCR5B=0x00;  //Timer5 parameters
	CALL SUBOPT_0xC
;     845           OCR5AH=0x00;
;     846           OCR5AL=0x00;
;     847           TIMSK5=0x00;  //Timer5 interrupt
;     848 
;     849           rotate('r');
	LDI  R30,LOW(114)
	ST   -Y,R30
	CALL _rotate
;     850           C_PWML=0;
	CALL SUBOPT_0x9
;     851           C_PWMR=0;
;     852 
;     853           f1='f';
	LDI  R30,LOW(102)
	MOV  R3,R30
;     854           break;
;     855 
;     856         default:
_0xB6:
;     857           break;
;     858       } //and of switch
_0x5F:
;     859 
;     860       OCR0A=PWML+C_PWML;   // left PWM
	LDS  R30,_C_PWML
	LDS  R31,_C_PWML+1
	ADD  R30,R11
	ADC  R31,R12
	OUT  0x27,R30
;     861       OCR2A=PWMR+C_PWMR;   // right PWM
	LDS  R30,_C_PWMR
	LDS  R31,_C_PWMR+1
	ADD  R30,R13
	ADC  R31,R14
	STS  179,R30
;     862       } //end of main while
	RJMP _0x56
;     863 } //end of main main
_0xB7:
	RJMP _0xB7
;     864 
;     865 
;     866 
;     867 
;     868 
;     869 
;     870 
;     871 
;     872 
;     873 
;     874 
;     875 
;     876 
;     877 
;     878 

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
_itoa:
    ld   r26,y+
    ld   r27,y+
    ld   r30,y+
    ld   r31,y+
    adiw r30,0
    brpl __itoa0
    com  r30
    com  r31
    adiw r30,1
    ldi  r22,'-'
    st   x+,r22
__itoa0:
    clt
    ldi  r24,low(10000)
    ldi  r25,high(10000)
    rcall __itoa1
    ldi  r24,low(1000)
    ldi  r25,high(1000)
    rcall __itoa1
    ldi  r24,100
    clr  r25
    rcall __itoa1
    ldi  r24,10
    rcall __itoa1
    mov  r22,r30
    rcall __itoa5
    clr  r22
    st   x,r22
    ret

__itoa1:
    clr	 r22
__itoa2:
    cp   r30,r24
    cpc  r31,r25
    brlo __itoa3
    inc  r22
    sub  r30,r24
    sbc  r31,r25
    brne __itoa2
__itoa3:
    tst  r22
    brne __itoa4
    brts __itoa5
    ret
__itoa4:
    set
__itoa5:
    subi r22,-0x30
    st   x+,r22
    ret
_strlen:
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret

	.DSEG
_p_S3C:
	.BYTE 0x2

	.CSEG

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x0:
	LDI  R30,LOW(0)
	STS  148,R30
	STS  132,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1:
	CBI  0x8,0
	CBI  0x8,1
	CBI  0x8,2
	CBI  0x8,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(0)
	STS  149,R30
	STS  133,R30
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	LDI  R30,0
	STD  Y+10,R30
	STD  Y+10+1,R30
	LDI  R30,0
	STD  Y+12,R30
	STD  Y+12+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x6:
	LDS  R30,132
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x7:
	LDS  R30,148
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x8:
	LDI  R30,LOW(5)
	STS  297,R30
	LDI  R30,LOW(159)
	STS  296,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:53 WORDS
SUBOPT_0x9:
	LDI  R30,0
	STS  _C_PWML,R30
	STS  _C_PWML+1,R30
	LDI  R30,0
	STS  _C_PWMR,R30
	STS  _C_PWMR+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	SBI  0x8,0
	CBI  0x8,1
	CBI  0x8,2
	SBI  0x8,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	CBI  0x8,0
	SBI  0x8,1
	SBI  0x8,2
	CBI  0x8,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:77 WORDS
SUBOPT_0xC:
	LDI  R30,LOW(0)
	STS  289,R30
	STS  297,R30
	STS  296,R30
	STS  115,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xD:
	LDI  R30,0
	STS  _C_PWML,R30
	STS  _C_PWML+1,R30
	LDS  R30,_C_PWM
	LDS  R31,_C_PWM+1
	STS  _C_PWMR,R30
	STS  _C_PWMR+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xE:
	LDS  R30,_C_PWM
	LDS  R31,_C_PWM+1
	STS  _C_PWML,R30
	STS  _C_PWML+1,R31
	LDI  R30,0
	STS  _C_PWMR,R30
	STS  _C_PWMR+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xF:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _putnumber

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10:
	LDI  R30,LOW(95)
	ST   -Y,R30
	JMP  _putchar1

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	ADD R26,R28
	ADC R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:
