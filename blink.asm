;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.0 #9253 (Apr  3 2018) (Linux)
; This file was generated Wed Dec 30 20:13:01 2020
;--------------------------------------------------------
	.module blink
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _DS18B20_ReadTemperature
	.globl _DS18B20_ReadByte
	.globl _DS18B20_WriteByte
	.globl _DS18B20_Init
	.globl _send
	.globl _short_pulse
	.globl _long_pulse
	.globl _delayTenMicro
	.globl __delay_us
	.globl _InitializeSystemClock
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)
;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ;reset
	int 0x0000 ;trap
	int 0x0000 ;int0
	int 0x0000 ;int1
	int 0x0000 ;int2
	int 0x0000 ;int3
	int 0x0000 ;int4
	int 0x0000 ;int5
	int 0x0000 ;int6
	int 0x0000 ;int7
	int 0x0000 ;int8
	int 0x0000 ;int9
	int 0x0000 ;int10
	int 0x0000 ;int11
	int 0x0000 ;int12
	int 0x0000 ;int13
	int 0x0000 ;int14
	int 0x0000 ;int15
	int 0x0000 ;int16
	int 0x0000 ;int17
	int 0x0000 ;int18
	int 0x0000 ;int19
	int 0x0000 ;int20
	int 0x0000 ;int21
	int 0x0000 ;int22
	int 0x0000 ;int23
	int 0x0000 ;int24
	int 0x0000 ;int25
	int 0x0000 ;int26
	int 0x0000 ;int27
	int 0x0000 ;int28
	int 0x0000 ;int29
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
__sdcc_gs_init_startup:
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	blink.c: 25: void InitializeSystemClock() {
;	-----------------------------------------
;	 function InitializeSystemClock
;	-----------------------------------------
_InitializeSystemClock:
;	blink.c: 26: CLK_ICKR = 0;                       //  Reset the Internal Clock Register.
	mov	0x50c0+0, #0x00
;	blink.c: 27: CLK_ICKR = CLK_HSIEN;               //  Enable the HSI.
	mov	0x50c0+0, #0x01
;	blink.c: 28: CLK_ECKR = 0;                       //  Disable the external clock.
	mov	0x50c1+0, #0x00
;	blink.c: 29: while ((CLK_ICKR & CLK_HSIRDY) == 0);       //  Wait for the HSI to be ready for use.
00101$:
	ldw	x, #0x50c0
	ld	a, (x)
	bcp	a, #0x02
	jreq	00101$
;	blink.c: 30: CLK_CKDIVR = 0;                     //  Ensure the clocks are running at full speed.
	mov	0x50c6+0, #0x00
;	blink.c: 31: CLK_PCKENR1 = 0xff;                 //  Enable all peripheral clocks.
	mov	0x50c7+0, #0xff
;	blink.c: 32: CLK_PCKENR2 = 0xff;                 //  Ditto.
	mov	0x50ca+0, #0xff
;	blink.c: 33: CLK_CCOR = 0;                       //  Turn off CCO.
	mov	0x50c9+0, #0x00
;	blink.c: 34: CLK_HSITRIMR = 0;                   //  Turn off any HSIU trimming.
	mov	0x50cc+0, #0x00
;	blink.c: 35: CLK_SWIMCCR = 0;                    //  Set SWIM to run at clock / 2.
	mov	0x50cd+0, #0x00
;	blink.c: 36: CLK_SWR = 0xe1;                     //  Use HSI as the clock source.
	mov	0x50c4+0, #0xe1
;	blink.c: 37: CLK_SWCR = 0;                       //  Reset the clock switch control register.
	mov	0x50c5+0, #0x00
;	blink.c: 38: CLK_SWCR = CLK_SWEN;                //  Enable switching.
	mov	0x50c5+0, #0x02
;	blink.c: 39: while ((CLK_SWCR & CLK_SWBSY) != 0);        //  Pause while the clock switch is busy.
00104$:
	ldw	x, #0x50c5
	ld	a, (x)
	srl	a
	jrc	00104$
	ret
;	blink.c: 42: void _delay_us(unsigned int i)
;	-----------------------------------------
;	 function _delay_us
;	-----------------------------------------
__delay_us:
;	blink.c: 44: i *= 3;
	ldw	x, (0x03, sp)
	pushw	x
	push	#0x03
	push	#0x00
	call	__mulint
	addw	sp, #4
	ldw	(0x03, sp), x
;	blink.c: 45: while(--i);
	ldw	x, (0x03, sp)
00101$:
	decw	x
	tnzw	x
	jrne	00101$
	ret
;	blink.c: 50: void delayTenMicro (void) {
;	-----------------------------------------
;	 function delayTenMicro
;	-----------------------------------------
_delayTenMicro:
	sub	sp, #4
;	blink.c: 52: for (a = 0; a < 16000; ++a)
	ldw	x, #0x3e80
	ldw	(0x03, sp), x
	clrw	x
	ldw	(0x01, sp), x
00104$:
;	blink.c: 53: __asm__("nop");
	nop
	ldw	y, (0x03, sp)
	subw	y, #0x0001
	ld	a, (0x02, sp)
	sbc	a, #0x00
	ld	xl, a
	ld	a, (0x01, sp)
	sbc	a, #0x00
	ld	xh, a
	ldw	(0x03, sp), y
	ldw	(0x01, sp), x
;	blink.c: 52: for (a = 0; a < 16000; ++a)
	tnzw	y
	jrne	00104$
	tnzw	x
	jrne	00104$
	addw	sp, #4
	ret
;	blink.c: 58: void long_pulse (void){
;	-----------------------------------------
;	 function long_pulse
;	-----------------------------------------
_long_pulse:
;	blink.c: 59: PB_ODR = (1 << LED_PIN);
	mov	0x5005+0, #0x20
;	blink.c: 60: delayTenMicro();
	call	_delayTenMicro
;	blink.c: 61: delayTenMicro();
	call	_delayTenMicro
;	blink.c: 62: delayTenMicro();
	call	_delayTenMicro
;	blink.c: 63: PB_ODR = (0 << LED_PIN);
	mov	0x5005+0, #0x00
;	blink.c: 64: delayTenMicro();
	call	_delayTenMicro
;	blink.c: 65: delayTenMicro();
	call	_delayTenMicro
;	blink.c: 66: delayTenMicro();
	jp	_delayTenMicro
;	blink.c: 70: void short_pulse (void){
;	-----------------------------------------
;	 function short_pulse
;	-----------------------------------------
_short_pulse:
;	blink.c: 71: PB_ODR = (1 << LED_PIN);
	mov	0x5005+0, #0x20
;	blink.c: 72: delayTenMicro();
	call	_delayTenMicro
;	blink.c: 73: PB_ODR = (0 << LED_PIN);
	mov	0x5005+0, #0x00
;	blink.c: 74: delayTenMicro();
	jp	_delayTenMicro
;	blink.c: 79: void send(int sensor, int value)
;	-----------------------------------------
;	 function send
;	-----------------------------------------
_send:
	sub	sp, #2
;	blink.c: 82: for (i=0;i<8;++i)
	clrw	x
	ldw	(0x01, sp), x
00109$:
;	blink.c: 84: if (sensor & (1<<i))  short_pulse();
	ldw	x, #0x0001
	ld	a, (0x02, sp)
	jreq	00138$
00137$:
	sllw	x
	dec	a
	jrne	00137$
00138$:
	ld	a, xl
	and	a, (0x06, sp)
	rlwa	x
	and	a, (0x05, sp)
	ld	xh, a
	tnzw	x
	jreq	00102$
	call	_short_pulse
	jra	00110$
00102$:
;	blink.c: 86: long_pulse();
	call	_long_pulse
00110$:
;	blink.c: 82: for (i=0;i<8;++i)
	ldw	x, (0x01, sp)
	incw	x
	ldw	(0x01, sp), x
	ldw	x, (0x01, sp)
	cpw	x, #0x0008
	jrslt	00109$
;	blink.c: 89: for (i=0;i<8;++i)
	clrw	x
	ldw	(0x01, sp), x
00111$:
;	blink.c: 91: if (value & (1<<i))  short_pulse();
	ldw	x, #0x0001
	ld	a, (0x02, sp)
	jreq	00142$
00141$:
	sllw	x
	dec	a
	jrne	00141$
00142$:
	ld	a, xl
	and	a, (0x08, sp)
	rlwa	x
	and	a, (0x07, sp)
	ld	xh, a
	tnzw	x
	jreq	00106$
	call	_short_pulse
	jra	00112$
00106$:
;	blink.c: 93: long_pulse();
	call	_long_pulse
00112$:
;	blink.c: 89: for (i=0;i<8;++i)
	ldw	x, (0x01, sp)
	incw	x
	ldw	(0x01, sp), x
	ldw	x, (0x01, sp)
	cpw	x, #0x0008
	jrslt	00111$
	addw	sp, #2
	ret
;	blink.c: 101: void DS18B20_Init(void)
;	-----------------------------------------
;	 function DS18B20_Init
;	-----------------------------------------
_DS18B20_Init:
;	blink.c: 103: DS18B20_DQ_OUT;   
	ldw	x, #0x5002
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
;	blink.c: 104: DS18B20_DQ_PUSH_PULL;    
	ldw	x, #0x5003
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
;	blink.c: 105: DS18B20_DQ_HIGH;   
	ldw	x, #0x5000
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
;	blink.c: 106: _delay_us(10);
	push	#0x0a
	push	#0x00
	call	__delay_us
	addw	sp, #2
;	blink.c: 107: DS18B20_DQ_LOW;   
	ldw	x, #0x5000
	ld	a, (x)
	and	a, #0xf7
	ld	(x), a
;	blink.c: 108: _delay_us(600);     //????
	push	#0x58
	push	#0x02
	call	__delay_us
	addw	sp, #2
;	blink.c: 110: DS18B20_DQ_IN;   
	ldw	x, #0x5002
	ld	a, (x)
	and	a, #0xf7
	ld	(x), a
;	blink.c: 111: DS18B20_DQ_PULL_UP;    
	ldw	x, #0x5003
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
;	blink.c: 112: _delay_us(100);     
	push	#0x64
	push	#0x00
	call	__delay_us
	addw	sp, #2
;	blink.c: 114: _delay_us(400);
	push	#0x90
	push	#0x01
	call	__delay_us
	addw	sp, #2
	ret
;	blink.c: 118: void DS18B20_WriteByte(unsigned char _data)
;	-----------------------------------------
;	 function DS18B20_WriteByte
;	-----------------------------------------
_DS18B20_WriteByte:
	push	a
;	blink.c: 122: DS18B20_DQ_OUT;
	ldw	x, #0x5002
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
;	blink.c: 123: for (i = 0; i < 8; i++)
	clr	(0x01, sp)
00104$:
;	blink.c: 125: DS18B20_DQ_LOW;
	ldw	x, #0x5000
	ld	a, (x)
	and	a, #0xf7
	ld	(x), a
;	blink.c: 126: _delay_us(2);
	push	#0x02
	push	#0x00
	call	__delay_us
	addw	sp, #2
;	blink.c: 127: if (_data & 0x01)
	ld	a, (0x04, sp)
	srl	a
	jrnc	00102$
;	blink.c: 129: DS18B20_DQ_HIGH;
	ldw	x, #0x5000
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
00102$:
;	blink.c: 131: _data >>= 1;
	ld	a, (0x04, sp)
	srl	a
	ld	(0x04, sp), a
;	blink.c: 132: _delay_us(60);
	push	#0x3c
	push	#0x00
	call	__delay_us
	addw	sp, #2
;	blink.c: 133: DS18B20_DQ_HIGH;
	ldw	x, #0x5000
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
;	blink.c: 123: for (i = 0; i < 8; i++)
	inc	(0x01, sp)
	ld	a, (0x01, sp)
	cp	a, #0x08
	jrc	00104$
	pop	a
	ret
;	blink.c: 137: unsigned char DS18B20_ReadByte(void)
;	-----------------------------------------
;	 function DS18B20_ReadByte
;	-----------------------------------------
_DS18B20_ReadByte:
	sub	sp, #2
;	blink.c: 139: unsigned char i = 0, _data = 0;
	clr	(0x02, sp)
;	blink.c: 141: for (i = 0; i < 8; i++)
	clr	(0x01, sp)
00104$:
;	blink.c: 143: DS18B20_DQ_OUT;
	ldw	x, #0x5002
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
;	blink.c: 144: DS18B20_DQ_LOW;
	ldw	x, #0x5000
	ld	a, (x)
	and	a, #0xf7
	ld	(x), a
;	blink.c: 145: _delay_us(5);
	push	#0x05
	push	#0x00
	call	__delay_us
	addw	sp, #2
;	blink.c: 146: _data >>= 1;
	srl	(0x02, sp)
;	blink.c: 147: DS18B20_DQ_HIGH;
	ldw	x, #0x5000
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
;	blink.c: 148: DS18B20_DQ_IN;
	ldw	x, #0x5002
	ld	a, (x)
	and	a, #0xf7
	ld	(x), a
;	blink.c: 149: if (DS18B20_DQ_VALUE)
	ldw	x, #0x5001
	ld	a, (x)
	bcp	a, #0x08
	jreq	00102$
;	blink.c: 151: _data |= 0x80;
	ld	a, (0x02, sp)
	or	a, #0x80
	ld	(0x02, sp), a
00102$:
;	blink.c: 153: DS18B20_DQ_OUT; 
	ldw	x, #0x5002
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
;	blink.c: 154: DS18B20_DQ_HIGH;
	ldw	x, #0x5000
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
;	blink.c: 155: _delay_us(60);
	push	#0x3c
	push	#0x00
	call	__delay_us
	addw	sp, #2
;	blink.c: 141: for (i = 0; i < 8; i++)
	inc	(0x01, sp)
	ld	a, (0x01, sp)
	cp	a, #0x08
	jrc	00104$
;	blink.c: 158: return _data;
	ld	a, (0x02, sp)
	addw	sp, #2
	ret
;	blink.c: 161: float DS18B20_ReadTemperature(void)
;	-----------------------------------------
;	 function DS18B20_ReadTemperature
;	-----------------------------------------
_DS18B20_ReadTemperature:
	sub	sp, #14
;	blink.c: 175: DS18B20_Init();
	call	_DS18B20_Init
;	blink.c: 176: DS18B20_WriteByte(0xcc);
	push	#0xcc
	call	_DS18B20_WriteByte
	pop	a
;	blink.c: 177: DS18B20_WriteByte(0x44);
	push	#0x44
	call	_DS18B20_WriteByte
	pop	a
;	blink.c: 179: DS18B20_Init();
	call	_DS18B20_Init
;	blink.c: 180: DS18B20_WriteByte(0xcc);
	push	#0xcc
	call	_DS18B20_WriteByte
	pop	a
;	blink.c: 181: DS18B20_WriteByte(0xbe);
	push	#0xbe
	call	_DS18B20_WriteByte
	pop	a
;	blink.c: 183: temp = DS18B20_ReadByte();
	call	_DS18B20_ReadByte
;	blink.c: 184: t = (((temp & 0xf0) >> 4) + (temp & 0x07) * 0.125); 
	ld	xh, a
	and	a, #0xf0
	swap	a
	and	a, #0x0f
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ld	a, xh
	and	a, #0x07
	push	a
	call	___uchar2fs
	pop	a
	pushw	x
	pushw	y
	clrw	x
	pushw	x
	push	#0x00
	push	#0x3e
	call	___fsmul
	addw	sp, #8
	ldw	(0x07, sp), y
	pushw	x
	ldw	y, (0x03, sp)
	pushw	y
	call	___sint2fs
	addw	sp, #2
	ldw	(0x0f, sp), x
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	pushw	y
	call	___fsadd
	addw	sp, #8
	ldw	(0x05, sp), x
	ldw	(0x03, sp), y
;	blink.c: 185: temp = DS18B20_ReadByte();
	call	_DS18B20_ReadByte
;	blink.c: 186: t += ((temp & 0x0f) << 4);
	and	a, #0x0f
	clrw	x
	ld	xl, a
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	pushw	x
	call	___sint2fs
	addw	sp, #2
	pushw	x
	pushw	y
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	call	___fsadd
;	blink.c: 187: return t;
	addw	sp, #22
	ret
;	blink.c: 194: void main() {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #16
;	blink.c: 198: InitializeSystemClock();
	call	_InitializeSystemClock
;	blink.c: 199: PB_DDR |= (1 << LED_PIN);
	ldw	x, #0x5007
	ld	a, (x)
	or	a, #0x20
	ld	(x), a
;	blink.c: 200: PB_CR1 |= (1 << LED_PIN);
	ldw	x, #0x5008
	ld	a, (x)
	or	a, #0x20
	ld	(x), a
;	blink.c: 202: while (1) {
00114$:
;	blink.c: 203: send(3,3); //start message
	push	#0x03
	push	#0x00
	push	#0x03
	push	#0x00
	call	_send
	addw	sp, #4
;	blink.c: 207: objTemp = DS18B20_ReadTemperature();  
	call	_DS18B20_ReadTemperature
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	blink.c: 208: while (objTemp > 1000) {
00101$:
	clrw	x
	pushw	x
	push	#0x7a
	push	#0x44
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	call	___fsgt
	addw	sp, #8
	tnz	a
	jreq	00121$
;	blink.c: 210: objTemp-=1000;
	clrw	x
	pushw	x
	push	#0x7a
	push	#0x44
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	call	___fssub
	addw	sp, #8
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
	jra	00101$
;	blink.c: 212: while (objTemp > 100) {
00121$:
	clrw	x
	ldw	(0x05, sp), x
00104$:
	clrw	x
	pushw	x
	push	#0xc8
	push	#0x42
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	call	___fsgt
	addw	sp, #8
	tnz	a
	jreq	00128$
;	blink.c: 213: derde+=1;
	ldw	x, (0x05, sp)
	incw	x
	ldw	(0x05, sp), x
;	blink.c: 214: objTemp-=100;
	clrw	x
	pushw	x
	push	#0xc8
	push	#0x42
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	call	___fssub
	addw	sp, #8
	exgw	x, y
	ldw	(0x03, sp), y
	ldw	(0x01, sp), x
	jra	00104$
;	blink.c: 216: while (objTemp > 10) {
00128$:
	ldw	y, (0x05, sp)
	ldw	(0x0b, sp), y
	clrw	x
	ldw	(0x09, sp), x
00107$:
	clrw	x
	pushw	x
	push	#0x20
	push	#0x41
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	call	___fsgt
	addw	sp, #8
	tnz	a
	jreq	00129$
;	blink.c: 217: tweede+=1;
	ldw	x, (0x09, sp)
	incw	x
	ldw	(0x09, sp), x
;	blink.c: 218: objTemp-=10;
	clrw	x
	pushw	x
	push	#0x20
	push	#0x41
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	call	___fssub
	addw	sp, #8
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
	jra	00107$
;	blink.c: 220: while (objTemp > 0)
00129$:
	ldw	y, (0x09, sp)
	ldw	(0x0d, sp), y
	clrw	x
	ldw	(0x07, sp), x
00110$:
	clrw	x
	pushw	x
	clrw	x
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	call	___fsgt
	addw	sp, #8
	tnz	a
	jreq	00112$
;	blink.c: 222: eerste+=1;
	ldw	x, (0x07, sp)
	incw	x
	ldw	(0x07, sp), x
;	blink.c: 223: objTemp-=1;
	clrw	x
	pushw	x
	push	#0x80
	push	#0x3f
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	call	___fssub
	addw	sp, #8
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
	jra	00110$
00112$:
;	blink.c: 226: temp=derde*100+tweede*10+eerste;
	ldw	x, (0x0b, sp)
	pushw	x
	push	#0x64
	push	#0x00
	call	__mulint
	addw	sp, #4
	ldw	(0x0f, sp), x
	ldw	x, (0x0d, sp)
	pushw	x
	push	#0x0a
	push	#0x00
	call	__mulint
	addw	sp, #4
	addw	x, (0x0f, sp)
	addw	x, (0x07, sp)
;	blink.c: 229: send(99, temp);
	pushw	x
	push	#0x63
	push	#0x00
	call	_send
	addw	sp, #4
	jp	00114$
	addw	sp, #16
	ret
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
