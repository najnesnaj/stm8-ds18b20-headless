                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 3.5.0 #9253 (Apr  3 2018) (Linux)
                                      4 ; This file was generated Wed Dec 30 20:13:01 2020
                                      5 ;--------------------------------------------------------
                                      6 	.module blink
                                      7 	.optsdcc -mstm8
                                      8 	
                                      9 ;--------------------------------------------------------
                                     10 ; Public variables in this module
                                     11 ;--------------------------------------------------------
                                     12 	.globl _main
                                     13 	.globl _DS18B20_ReadTemperature
                                     14 	.globl _DS18B20_ReadByte
                                     15 	.globl _DS18B20_WriteByte
                                     16 	.globl _DS18B20_Init
                                     17 	.globl _send
                                     18 	.globl _short_pulse
                                     19 	.globl _long_pulse
                                     20 	.globl _delayTenMicro
                                     21 	.globl __delay_us
                                     22 	.globl _InitializeSystemClock
                                     23 ;--------------------------------------------------------
                                     24 ; ram data
                                     25 ;--------------------------------------------------------
                                     26 	.area DATA
                                     27 ;--------------------------------------------------------
                                     28 ; ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area INITIALIZED
                                     31 ;--------------------------------------------------------
                                     32 ; Stack segment in internal ram 
                                     33 ;--------------------------------------------------------
                                     34 	.area	SSEG
      000001                         35 __start__stack:
      000001                         36 	.ds	1
                                     37 
                                     38 ;--------------------------------------------------------
                                     39 ; absolute external ram data
                                     40 ;--------------------------------------------------------
                                     41 	.area DABS (ABS)
                                     42 ;--------------------------------------------------------
                                     43 ; interrupt vector 
                                     44 ;--------------------------------------------------------
                                     45 	.area HOME
      008000                         46 __interrupt_vect:
      008000 82 00 80 83             47 	int s_GSINIT ;reset
      008004 82 00 00 00             48 	int 0x0000 ;trap
      008008 82 00 00 00             49 	int 0x0000 ;int0
      00800C 82 00 00 00             50 	int 0x0000 ;int1
      008010 82 00 00 00             51 	int 0x0000 ;int2
      008014 82 00 00 00             52 	int 0x0000 ;int3
      008018 82 00 00 00             53 	int 0x0000 ;int4
      00801C 82 00 00 00             54 	int 0x0000 ;int5
      008020 82 00 00 00             55 	int 0x0000 ;int6
      008024 82 00 00 00             56 	int 0x0000 ;int7
      008028 82 00 00 00             57 	int 0x0000 ;int8
      00802C 82 00 00 00             58 	int 0x0000 ;int9
      008030 82 00 00 00             59 	int 0x0000 ;int10
      008034 82 00 00 00             60 	int 0x0000 ;int11
      008038 82 00 00 00             61 	int 0x0000 ;int12
      00803C 82 00 00 00             62 	int 0x0000 ;int13
      008040 82 00 00 00             63 	int 0x0000 ;int14
      008044 82 00 00 00             64 	int 0x0000 ;int15
      008048 82 00 00 00             65 	int 0x0000 ;int16
      00804C 82 00 00 00             66 	int 0x0000 ;int17
      008050 82 00 00 00             67 	int 0x0000 ;int18
      008054 82 00 00 00             68 	int 0x0000 ;int19
      008058 82 00 00 00             69 	int 0x0000 ;int20
      00805C 82 00 00 00             70 	int 0x0000 ;int21
      008060 82 00 00 00             71 	int 0x0000 ;int22
      008064 82 00 00 00             72 	int 0x0000 ;int23
      008068 82 00 00 00             73 	int 0x0000 ;int24
      00806C 82 00 00 00             74 	int 0x0000 ;int25
      008070 82 00 00 00             75 	int 0x0000 ;int26
      008074 82 00 00 00             76 	int 0x0000 ;int27
      008078 82 00 00 00             77 	int 0x0000 ;int28
      00807C 82 00 00 00             78 	int 0x0000 ;int29
                                     79 ;--------------------------------------------------------
                                     80 ; global & static initialisations
                                     81 ;--------------------------------------------------------
                                     82 	.area HOME
                                     83 	.area GSINIT
                                     84 	.area GSFINAL
                                     85 	.area GSINIT
      008083                         86 __sdcc_gs_init_startup:
      008083                         87 __sdcc_init_data:
                                     88 ; stm8_genXINIT() start
      008083 AE 00 00         [ 2]   89 	ldw x, #l_DATA
      008086 27 07            [ 1]   90 	jreq	00002$
      008088                         91 00001$:
      008088 72 4F 00 00      [ 1]   92 	clr (s_DATA - 1, x)
      00808C 5A               [ 2]   93 	decw x
      00808D 26 F9            [ 1]   94 	jrne	00001$
      00808F                         95 00002$:
      00808F AE 00 00         [ 2]   96 	ldw	x, #l_INITIALIZER
      008092 27 09            [ 1]   97 	jreq	00004$
      008094                         98 00003$:
      008094 D6 8C B8         [ 1]   99 	ld	a, (s_INITIALIZER - 1, x)
      008097 D7 00 00         [ 1]  100 	ld	(s_INITIALIZED - 1, x), a
      00809A 5A               [ 2]  101 	decw	x
      00809B 26 F7            [ 1]  102 	jrne	00003$
      00809D                        103 00004$:
                                    104 ; stm8_genXINIT() end
                                    105 	.area GSFINAL
      00809D CC 80 80         [ 2]  106 	jp	__sdcc_program_startup
                                    107 ;--------------------------------------------------------
                                    108 ; Home
                                    109 ;--------------------------------------------------------
                                    110 	.area HOME
                                    111 	.area HOME
      008080                        112 __sdcc_program_startup:
      008080 CC 83 18         [ 2]  113 	jp	_main
                                    114 ;	return from main will return to caller
                                    115 ;--------------------------------------------------------
                                    116 ; code
                                    117 ;--------------------------------------------------------
                                    118 	.area CODE
                                    119 ;	blink.c: 25: void InitializeSystemClock() {
                                    120 ;	-----------------------------------------
                                    121 ;	 function InitializeSystemClock
                                    122 ;	-----------------------------------------
      0080A0                        123 _InitializeSystemClock:
                                    124 ;	blink.c: 26: CLK_ICKR = 0;                       //  Reset the Internal Clock Register.
      0080A0 35 00 50 C0      [ 1]  125 	mov	0x50c0+0, #0x00
                                    126 ;	blink.c: 27: CLK_ICKR = CLK_HSIEN;               //  Enable the HSI.
      0080A4 35 01 50 C0      [ 1]  127 	mov	0x50c0+0, #0x01
                                    128 ;	blink.c: 28: CLK_ECKR = 0;                       //  Disable the external clock.
      0080A8 35 00 50 C1      [ 1]  129 	mov	0x50c1+0, #0x00
                                    130 ;	blink.c: 29: while ((CLK_ICKR & CLK_HSIRDY) == 0);       //  Wait for the HSI to be ready for use.
      0080AC                        131 00101$:
      0080AC AE 50 C0         [ 2]  132 	ldw	x, #0x50c0
      0080AF F6               [ 1]  133 	ld	a, (x)
      0080B0 A5 02            [ 1]  134 	bcp	a, #0x02
      0080B2 27 F8            [ 1]  135 	jreq	00101$
                                    136 ;	blink.c: 30: CLK_CKDIVR = 0;                     //  Ensure the clocks are running at full speed.
      0080B4 35 00 50 C6      [ 1]  137 	mov	0x50c6+0, #0x00
                                    138 ;	blink.c: 31: CLK_PCKENR1 = 0xff;                 //  Enable all peripheral clocks.
      0080B8 35 FF 50 C7      [ 1]  139 	mov	0x50c7+0, #0xff
                                    140 ;	blink.c: 32: CLK_PCKENR2 = 0xff;                 //  Ditto.
      0080BC 35 FF 50 CA      [ 1]  141 	mov	0x50ca+0, #0xff
                                    142 ;	blink.c: 33: CLK_CCOR = 0;                       //  Turn off CCO.
      0080C0 35 00 50 C9      [ 1]  143 	mov	0x50c9+0, #0x00
                                    144 ;	blink.c: 34: CLK_HSITRIMR = 0;                   //  Turn off any HSIU trimming.
      0080C4 35 00 50 CC      [ 1]  145 	mov	0x50cc+0, #0x00
                                    146 ;	blink.c: 35: CLK_SWIMCCR = 0;                    //  Set SWIM to run at clock / 2.
      0080C8 35 00 50 CD      [ 1]  147 	mov	0x50cd+0, #0x00
                                    148 ;	blink.c: 36: CLK_SWR = 0xe1;                     //  Use HSI as the clock source.
      0080CC 35 E1 50 C4      [ 1]  149 	mov	0x50c4+0, #0xe1
                                    150 ;	blink.c: 37: CLK_SWCR = 0;                       //  Reset the clock switch control register.
      0080D0 35 00 50 C5      [ 1]  151 	mov	0x50c5+0, #0x00
                                    152 ;	blink.c: 38: CLK_SWCR = CLK_SWEN;                //  Enable switching.
      0080D4 35 02 50 C5      [ 1]  153 	mov	0x50c5+0, #0x02
                                    154 ;	blink.c: 39: while ((CLK_SWCR & CLK_SWBSY) != 0);        //  Pause while the clock switch is busy.
      0080D8                        155 00104$:
      0080D8 AE 50 C5         [ 2]  156 	ldw	x, #0x50c5
      0080DB F6               [ 1]  157 	ld	a, (x)
      0080DC 44               [ 1]  158 	srl	a
      0080DD 25 F9            [ 1]  159 	jrc	00104$
      0080DF 81               [ 4]  160 	ret
                                    161 ;	blink.c: 42: void _delay_us(unsigned int i)
                                    162 ;	-----------------------------------------
                                    163 ;	 function _delay_us
                                    164 ;	-----------------------------------------
      0080E0                        165 __delay_us:
                                    166 ;	blink.c: 44: i *= 3;
      0080E0 1E 03            [ 2]  167 	ldw	x, (0x03, sp)
      0080E2 89               [ 2]  168 	pushw	x
      0080E3 4B 03            [ 1]  169 	push	#0x03
      0080E5 4B 00            [ 1]  170 	push	#0x00
      0080E7 CD 88 4B         [ 4]  171 	call	__mulint
      0080EA 5B 04            [ 2]  172 	addw	sp, #4
      0080EC 1F 03            [ 2]  173 	ldw	(0x03, sp), x
                                    174 ;	blink.c: 45: while(--i);
      0080EE 1E 03            [ 2]  175 	ldw	x, (0x03, sp)
      0080F0                        176 00101$:
      0080F0 5A               [ 2]  177 	decw	x
      0080F1 5D               [ 2]  178 	tnzw	x
      0080F2 26 FC            [ 1]  179 	jrne	00101$
      0080F4 81               [ 4]  180 	ret
                                    181 ;	blink.c: 50: void delayTenMicro (void) {
                                    182 ;	-----------------------------------------
                                    183 ;	 function delayTenMicro
                                    184 ;	-----------------------------------------
      0080F5                        185 _delayTenMicro:
      0080F5 52 04            [ 2]  186 	sub	sp, #4
                                    187 ;	blink.c: 52: for (a = 0; a < 16000; ++a)
      0080F7 AE 3E 80         [ 2]  188 	ldw	x, #0x3e80
      0080FA 1F 03            [ 2]  189 	ldw	(0x03, sp), x
      0080FC 5F               [ 1]  190 	clrw	x
      0080FD 1F 01            [ 2]  191 	ldw	(0x01, sp), x
      0080FF                        192 00104$:
                                    193 ;	blink.c: 53: __asm__("nop");
      0080FF 9D               [ 1]  194 	nop
      008100 16 03            [ 2]  195 	ldw	y, (0x03, sp)
      008102 72 A2 00 01      [ 2]  196 	subw	y, #0x0001
      008106 7B 02            [ 1]  197 	ld	a, (0x02, sp)
      008108 A2 00            [ 1]  198 	sbc	a, #0x00
      00810A 97               [ 1]  199 	ld	xl, a
      00810B 7B 01            [ 1]  200 	ld	a, (0x01, sp)
      00810D A2 00            [ 1]  201 	sbc	a, #0x00
      00810F 95               [ 1]  202 	ld	xh, a
      008110 17 03            [ 2]  203 	ldw	(0x03, sp), y
      008112 1F 01            [ 2]  204 	ldw	(0x01, sp), x
                                    205 ;	blink.c: 52: for (a = 0; a < 16000; ++a)
      008114 90 5D            [ 2]  206 	tnzw	y
      008116 26 E7            [ 1]  207 	jrne	00104$
      008118 5D               [ 2]  208 	tnzw	x
      008119 26 E4            [ 1]  209 	jrne	00104$
      00811B 5B 04            [ 2]  210 	addw	sp, #4
      00811D 81               [ 4]  211 	ret
                                    212 ;	blink.c: 58: void long_pulse (void){
                                    213 ;	-----------------------------------------
                                    214 ;	 function long_pulse
                                    215 ;	-----------------------------------------
      00811E                        216 _long_pulse:
                                    217 ;	blink.c: 59: PB_ODR = (1 << LED_PIN);
      00811E 35 20 50 05      [ 1]  218 	mov	0x5005+0, #0x20
                                    219 ;	blink.c: 60: delayTenMicro();
      008122 CD 80 F5         [ 4]  220 	call	_delayTenMicro
                                    221 ;	blink.c: 61: delayTenMicro();
      008125 CD 80 F5         [ 4]  222 	call	_delayTenMicro
                                    223 ;	blink.c: 62: delayTenMicro();
      008128 CD 80 F5         [ 4]  224 	call	_delayTenMicro
                                    225 ;	blink.c: 63: PB_ODR = (0 << LED_PIN);
      00812B 35 00 50 05      [ 1]  226 	mov	0x5005+0, #0x00
                                    227 ;	blink.c: 64: delayTenMicro();
      00812F CD 80 F5         [ 4]  228 	call	_delayTenMicro
                                    229 ;	blink.c: 65: delayTenMicro();
      008132 CD 80 F5         [ 4]  230 	call	_delayTenMicro
                                    231 ;	blink.c: 66: delayTenMicro();
      008135 CC 80 F5         [ 2]  232 	jp	_delayTenMicro
                                    233 ;	blink.c: 70: void short_pulse (void){
                                    234 ;	-----------------------------------------
                                    235 ;	 function short_pulse
                                    236 ;	-----------------------------------------
      008138                        237 _short_pulse:
                                    238 ;	blink.c: 71: PB_ODR = (1 << LED_PIN);
      008138 35 20 50 05      [ 1]  239 	mov	0x5005+0, #0x20
                                    240 ;	blink.c: 72: delayTenMicro();
      00813C CD 80 F5         [ 4]  241 	call	_delayTenMicro
                                    242 ;	blink.c: 73: PB_ODR = (0 << LED_PIN);
      00813F 35 00 50 05      [ 1]  243 	mov	0x5005+0, #0x00
                                    244 ;	blink.c: 74: delayTenMicro();
      008143 CC 80 F5         [ 2]  245 	jp	_delayTenMicro
                                    246 ;	blink.c: 79: void send(int sensor, int value)
                                    247 ;	-----------------------------------------
                                    248 ;	 function send
                                    249 ;	-----------------------------------------
      008146                        250 _send:
      008146 52 02            [ 2]  251 	sub	sp, #2
                                    252 ;	blink.c: 82: for (i=0;i<8;++i)
      008148 5F               [ 1]  253 	clrw	x
      008149 1F 01            [ 2]  254 	ldw	(0x01, sp), x
      00814B                        255 00109$:
                                    256 ;	blink.c: 84: if (sensor & (1<<i))  short_pulse();
      00814B AE 00 01         [ 2]  257 	ldw	x, #0x0001
      00814E 7B 02            [ 1]  258 	ld	a, (0x02, sp)
      008150 27 04            [ 1]  259 	jreq	00138$
      008152                        260 00137$:
      008152 58               [ 2]  261 	sllw	x
      008153 4A               [ 1]  262 	dec	a
      008154 26 FC            [ 1]  263 	jrne	00137$
      008156                        264 00138$:
      008156 9F               [ 1]  265 	ld	a, xl
      008157 14 06            [ 1]  266 	and	a, (0x06, sp)
      008159 02               [ 1]  267 	rlwa	x
      00815A 14 05            [ 1]  268 	and	a, (0x05, sp)
      00815C 95               [ 1]  269 	ld	xh, a
      00815D 5D               [ 2]  270 	tnzw	x
      00815E 27 05            [ 1]  271 	jreq	00102$
      008160 CD 81 38         [ 4]  272 	call	_short_pulse
      008163 20 03            [ 2]  273 	jra	00110$
      008165                        274 00102$:
                                    275 ;	blink.c: 86: long_pulse();
      008165 CD 81 1E         [ 4]  276 	call	_long_pulse
      008168                        277 00110$:
                                    278 ;	blink.c: 82: for (i=0;i<8;++i)
      008168 1E 01            [ 2]  279 	ldw	x, (0x01, sp)
      00816A 5C               [ 2]  280 	incw	x
      00816B 1F 01            [ 2]  281 	ldw	(0x01, sp), x
      00816D 1E 01            [ 2]  282 	ldw	x, (0x01, sp)
      00816F A3 00 08         [ 2]  283 	cpw	x, #0x0008
      008172 2F D7            [ 1]  284 	jrslt	00109$
                                    285 ;	blink.c: 89: for (i=0;i<8;++i)
      008174 5F               [ 1]  286 	clrw	x
      008175 1F 01            [ 2]  287 	ldw	(0x01, sp), x
      008177                        288 00111$:
                                    289 ;	blink.c: 91: if (value & (1<<i))  short_pulse();
      008177 AE 00 01         [ 2]  290 	ldw	x, #0x0001
      00817A 7B 02            [ 1]  291 	ld	a, (0x02, sp)
      00817C 27 04            [ 1]  292 	jreq	00142$
      00817E                        293 00141$:
      00817E 58               [ 2]  294 	sllw	x
      00817F 4A               [ 1]  295 	dec	a
      008180 26 FC            [ 1]  296 	jrne	00141$
      008182                        297 00142$:
      008182 9F               [ 1]  298 	ld	a, xl
      008183 14 08            [ 1]  299 	and	a, (0x08, sp)
      008185 02               [ 1]  300 	rlwa	x
      008186 14 07            [ 1]  301 	and	a, (0x07, sp)
      008188 95               [ 1]  302 	ld	xh, a
      008189 5D               [ 2]  303 	tnzw	x
      00818A 27 05            [ 1]  304 	jreq	00106$
      00818C CD 81 38         [ 4]  305 	call	_short_pulse
      00818F 20 03            [ 2]  306 	jra	00112$
      008191                        307 00106$:
                                    308 ;	blink.c: 93: long_pulse();
      008191 CD 81 1E         [ 4]  309 	call	_long_pulse
      008194                        310 00112$:
                                    311 ;	blink.c: 89: for (i=0;i<8;++i)
      008194 1E 01            [ 2]  312 	ldw	x, (0x01, sp)
      008196 5C               [ 2]  313 	incw	x
      008197 1F 01            [ 2]  314 	ldw	(0x01, sp), x
      008199 1E 01            [ 2]  315 	ldw	x, (0x01, sp)
      00819B A3 00 08         [ 2]  316 	cpw	x, #0x0008
      00819E 2F D7            [ 1]  317 	jrslt	00111$
      0081A0 5B 02            [ 2]  318 	addw	sp, #2
      0081A2 81               [ 4]  319 	ret
                                    320 ;	blink.c: 101: void DS18B20_Init(void)
                                    321 ;	-----------------------------------------
                                    322 ;	 function DS18B20_Init
                                    323 ;	-----------------------------------------
      0081A3                        324 _DS18B20_Init:
                                    325 ;	blink.c: 103: DS18B20_DQ_OUT;   
      0081A3 AE 50 02         [ 2]  326 	ldw	x, #0x5002
      0081A6 F6               [ 1]  327 	ld	a, (x)
      0081A7 AA 08            [ 1]  328 	or	a, #0x08
      0081A9 F7               [ 1]  329 	ld	(x), a
                                    330 ;	blink.c: 104: DS18B20_DQ_PUSH_PULL;    
      0081AA AE 50 03         [ 2]  331 	ldw	x, #0x5003
      0081AD F6               [ 1]  332 	ld	a, (x)
      0081AE AA 08            [ 1]  333 	or	a, #0x08
      0081B0 F7               [ 1]  334 	ld	(x), a
                                    335 ;	blink.c: 105: DS18B20_DQ_HIGH;   
      0081B1 AE 50 00         [ 2]  336 	ldw	x, #0x5000
      0081B4 F6               [ 1]  337 	ld	a, (x)
      0081B5 AA 08            [ 1]  338 	or	a, #0x08
      0081B7 F7               [ 1]  339 	ld	(x), a
                                    340 ;	blink.c: 106: _delay_us(10);
      0081B8 4B 0A            [ 1]  341 	push	#0x0a
      0081BA 4B 00            [ 1]  342 	push	#0x00
      0081BC CD 80 E0         [ 4]  343 	call	__delay_us
      0081BF 5B 02            [ 2]  344 	addw	sp, #2
                                    345 ;	blink.c: 107: DS18B20_DQ_LOW;   
      0081C1 AE 50 00         [ 2]  346 	ldw	x, #0x5000
      0081C4 F6               [ 1]  347 	ld	a, (x)
      0081C5 A4 F7            [ 1]  348 	and	a, #0xf7
      0081C7 F7               [ 1]  349 	ld	(x), a
                                    350 ;	blink.c: 108: _delay_us(600);     //????
      0081C8 4B 58            [ 1]  351 	push	#0x58
      0081CA 4B 02            [ 1]  352 	push	#0x02
      0081CC CD 80 E0         [ 4]  353 	call	__delay_us
      0081CF 5B 02            [ 2]  354 	addw	sp, #2
                                    355 ;	blink.c: 110: DS18B20_DQ_IN;   
      0081D1 AE 50 02         [ 2]  356 	ldw	x, #0x5002
      0081D4 F6               [ 1]  357 	ld	a, (x)
      0081D5 A4 F7            [ 1]  358 	and	a, #0xf7
      0081D7 F7               [ 1]  359 	ld	(x), a
                                    360 ;	blink.c: 111: DS18B20_DQ_PULL_UP;    
      0081D8 AE 50 03         [ 2]  361 	ldw	x, #0x5003
      0081DB F6               [ 1]  362 	ld	a, (x)
      0081DC AA 08            [ 1]  363 	or	a, #0x08
      0081DE F7               [ 1]  364 	ld	(x), a
                                    365 ;	blink.c: 112: _delay_us(100);     
      0081DF 4B 64            [ 1]  366 	push	#0x64
      0081E1 4B 00            [ 1]  367 	push	#0x00
      0081E3 CD 80 E0         [ 4]  368 	call	__delay_us
      0081E6 5B 02            [ 2]  369 	addw	sp, #2
                                    370 ;	blink.c: 114: _delay_us(400);
      0081E8 4B 90            [ 1]  371 	push	#0x90
      0081EA 4B 01            [ 1]  372 	push	#0x01
      0081EC CD 80 E0         [ 4]  373 	call	__delay_us
      0081EF 5B 02            [ 2]  374 	addw	sp, #2
      0081F1 81               [ 4]  375 	ret
                                    376 ;	blink.c: 118: void DS18B20_WriteByte(unsigned char _data)
                                    377 ;	-----------------------------------------
                                    378 ;	 function DS18B20_WriteByte
                                    379 ;	-----------------------------------------
      0081F2                        380 _DS18B20_WriteByte:
      0081F2 88               [ 1]  381 	push	a
                                    382 ;	blink.c: 122: DS18B20_DQ_OUT;
      0081F3 AE 50 02         [ 2]  383 	ldw	x, #0x5002
      0081F6 F6               [ 1]  384 	ld	a, (x)
      0081F7 AA 08            [ 1]  385 	or	a, #0x08
      0081F9 F7               [ 1]  386 	ld	(x), a
                                    387 ;	blink.c: 123: for (i = 0; i < 8; i++)
      0081FA 0F 01            [ 1]  388 	clr	(0x01, sp)
      0081FC                        389 00104$:
                                    390 ;	blink.c: 125: DS18B20_DQ_LOW;
      0081FC AE 50 00         [ 2]  391 	ldw	x, #0x5000
      0081FF F6               [ 1]  392 	ld	a, (x)
      008200 A4 F7            [ 1]  393 	and	a, #0xf7
      008202 F7               [ 1]  394 	ld	(x), a
                                    395 ;	blink.c: 126: _delay_us(2);
      008203 4B 02            [ 1]  396 	push	#0x02
      008205 4B 00            [ 1]  397 	push	#0x00
      008207 CD 80 E0         [ 4]  398 	call	__delay_us
      00820A 5B 02            [ 2]  399 	addw	sp, #2
                                    400 ;	blink.c: 127: if (_data & 0x01)
      00820C 7B 04            [ 1]  401 	ld	a, (0x04, sp)
      00820E 44               [ 1]  402 	srl	a
      00820F 24 07            [ 1]  403 	jrnc	00102$
                                    404 ;	blink.c: 129: DS18B20_DQ_HIGH;
      008211 AE 50 00         [ 2]  405 	ldw	x, #0x5000
      008214 F6               [ 1]  406 	ld	a, (x)
      008215 AA 08            [ 1]  407 	or	a, #0x08
      008217 F7               [ 1]  408 	ld	(x), a
      008218                        409 00102$:
                                    410 ;	blink.c: 131: _data >>= 1;
      008218 7B 04            [ 1]  411 	ld	a, (0x04, sp)
      00821A 44               [ 1]  412 	srl	a
      00821B 6B 04            [ 1]  413 	ld	(0x04, sp), a
                                    414 ;	blink.c: 132: _delay_us(60);
      00821D 4B 3C            [ 1]  415 	push	#0x3c
      00821F 4B 00            [ 1]  416 	push	#0x00
      008221 CD 80 E0         [ 4]  417 	call	__delay_us
      008224 5B 02            [ 2]  418 	addw	sp, #2
                                    419 ;	blink.c: 133: DS18B20_DQ_HIGH;
      008226 AE 50 00         [ 2]  420 	ldw	x, #0x5000
      008229 F6               [ 1]  421 	ld	a, (x)
      00822A AA 08            [ 1]  422 	or	a, #0x08
      00822C F7               [ 1]  423 	ld	(x), a
                                    424 ;	blink.c: 123: for (i = 0; i < 8; i++)
      00822D 0C 01            [ 1]  425 	inc	(0x01, sp)
      00822F 7B 01            [ 1]  426 	ld	a, (0x01, sp)
      008231 A1 08            [ 1]  427 	cp	a, #0x08
      008233 25 C7            [ 1]  428 	jrc	00104$
      008235 84               [ 1]  429 	pop	a
      008236 81               [ 4]  430 	ret
                                    431 ;	blink.c: 137: unsigned char DS18B20_ReadByte(void)
                                    432 ;	-----------------------------------------
                                    433 ;	 function DS18B20_ReadByte
                                    434 ;	-----------------------------------------
      008237                        435 _DS18B20_ReadByte:
      008237 52 02            [ 2]  436 	sub	sp, #2
                                    437 ;	blink.c: 139: unsigned char i = 0, _data = 0;
      008239 0F 02            [ 1]  438 	clr	(0x02, sp)
                                    439 ;	blink.c: 141: for (i = 0; i < 8; i++)
      00823B 0F 01            [ 1]  440 	clr	(0x01, sp)
      00823D                        441 00104$:
                                    442 ;	blink.c: 143: DS18B20_DQ_OUT;
      00823D AE 50 02         [ 2]  443 	ldw	x, #0x5002
      008240 F6               [ 1]  444 	ld	a, (x)
      008241 AA 08            [ 1]  445 	or	a, #0x08
      008243 F7               [ 1]  446 	ld	(x), a
                                    447 ;	blink.c: 144: DS18B20_DQ_LOW;
      008244 AE 50 00         [ 2]  448 	ldw	x, #0x5000
      008247 F6               [ 1]  449 	ld	a, (x)
      008248 A4 F7            [ 1]  450 	and	a, #0xf7
      00824A F7               [ 1]  451 	ld	(x), a
                                    452 ;	blink.c: 145: _delay_us(5);
      00824B 4B 05            [ 1]  453 	push	#0x05
      00824D 4B 00            [ 1]  454 	push	#0x00
      00824F CD 80 E0         [ 4]  455 	call	__delay_us
      008252 5B 02            [ 2]  456 	addw	sp, #2
                                    457 ;	blink.c: 146: _data >>= 1;
      008254 04 02            [ 1]  458 	srl	(0x02, sp)
                                    459 ;	blink.c: 147: DS18B20_DQ_HIGH;
      008256 AE 50 00         [ 2]  460 	ldw	x, #0x5000
      008259 F6               [ 1]  461 	ld	a, (x)
      00825A AA 08            [ 1]  462 	or	a, #0x08
      00825C F7               [ 1]  463 	ld	(x), a
                                    464 ;	blink.c: 148: DS18B20_DQ_IN;
      00825D AE 50 02         [ 2]  465 	ldw	x, #0x5002
      008260 F6               [ 1]  466 	ld	a, (x)
      008261 A4 F7            [ 1]  467 	and	a, #0xf7
      008263 F7               [ 1]  468 	ld	(x), a
                                    469 ;	blink.c: 149: if (DS18B20_DQ_VALUE)
      008264 AE 50 01         [ 2]  470 	ldw	x, #0x5001
      008267 F6               [ 1]  471 	ld	a, (x)
      008268 A5 08            [ 1]  472 	bcp	a, #0x08
      00826A 27 06            [ 1]  473 	jreq	00102$
                                    474 ;	blink.c: 151: _data |= 0x80;
      00826C 7B 02            [ 1]  475 	ld	a, (0x02, sp)
      00826E AA 80            [ 1]  476 	or	a, #0x80
      008270 6B 02            [ 1]  477 	ld	(0x02, sp), a
      008272                        478 00102$:
                                    479 ;	blink.c: 153: DS18B20_DQ_OUT; 
      008272 AE 50 02         [ 2]  480 	ldw	x, #0x5002
      008275 F6               [ 1]  481 	ld	a, (x)
      008276 AA 08            [ 1]  482 	or	a, #0x08
      008278 F7               [ 1]  483 	ld	(x), a
                                    484 ;	blink.c: 154: DS18B20_DQ_HIGH;
      008279 AE 50 00         [ 2]  485 	ldw	x, #0x5000
      00827C F6               [ 1]  486 	ld	a, (x)
      00827D AA 08            [ 1]  487 	or	a, #0x08
      00827F F7               [ 1]  488 	ld	(x), a
                                    489 ;	blink.c: 155: _delay_us(60);
      008280 4B 3C            [ 1]  490 	push	#0x3c
      008282 4B 00            [ 1]  491 	push	#0x00
      008284 CD 80 E0         [ 4]  492 	call	__delay_us
      008287 5B 02            [ 2]  493 	addw	sp, #2
                                    494 ;	blink.c: 141: for (i = 0; i < 8; i++)
      008289 0C 01            [ 1]  495 	inc	(0x01, sp)
      00828B 7B 01            [ 1]  496 	ld	a, (0x01, sp)
      00828D A1 08            [ 1]  497 	cp	a, #0x08
      00828F 25 AC            [ 1]  498 	jrc	00104$
                                    499 ;	blink.c: 158: return _data;
      008291 7B 02            [ 1]  500 	ld	a, (0x02, sp)
      008293 5B 02            [ 2]  501 	addw	sp, #2
      008295 81               [ 4]  502 	ret
                                    503 ;	blink.c: 161: float DS18B20_ReadTemperature(void)
                                    504 ;	-----------------------------------------
                                    505 ;	 function DS18B20_ReadTemperature
                                    506 ;	-----------------------------------------
      008296                        507 _DS18B20_ReadTemperature:
      008296 52 0E            [ 2]  508 	sub	sp, #14
                                    509 ;	blink.c: 175: DS18B20_Init();
      008298 CD 81 A3         [ 4]  510 	call	_DS18B20_Init
                                    511 ;	blink.c: 176: DS18B20_WriteByte(0xcc);
      00829B 4B CC            [ 1]  512 	push	#0xcc
      00829D CD 81 F2         [ 4]  513 	call	_DS18B20_WriteByte
      0082A0 84               [ 1]  514 	pop	a
                                    515 ;	blink.c: 177: DS18B20_WriteByte(0x44);
      0082A1 4B 44            [ 1]  516 	push	#0x44
      0082A3 CD 81 F2         [ 4]  517 	call	_DS18B20_WriteByte
      0082A6 84               [ 1]  518 	pop	a
                                    519 ;	blink.c: 179: DS18B20_Init();
      0082A7 CD 81 A3         [ 4]  520 	call	_DS18B20_Init
                                    521 ;	blink.c: 180: DS18B20_WriteByte(0xcc);
      0082AA 4B CC            [ 1]  522 	push	#0xcc
      0082AC CD 81 F2         [ 4]  523 	call	_DS18B20_WriteByte
      0082AF 84               [ 1]  524 	pop	a
                                    525 ;	blink.c: 181: DS18B20_WriteByte(0xbe);
      0082B0 4B BE            [ 1]  526 	push	#0xbe
      0082B2 CD 81 F2         [ 4]  527 	call	_DS18B20_WriteByte
      0082B5 84               [ 1]  528 	pop	a
                                    529 ;	blink.c: 183: temp = DS18B20_ReadByte();
      0082B6 CD 82 37         [ 4]  530 	call	_DS18B20_ReadByte
                                    531 ;	blink.c: 184: t = (((temp & 0xf0) >> 4) + (temp & 0x07) * 0.125); 
      0082B9 95               [ 1]  532 	ld	xh, a
      0082BA A4 F0            [ 1]  533 	and	a, #0xf0
      0082BC 4E               [ 1]  534 	swap	a
      0082BD A4 0F            [ 1]  535 	and	a, #0x0f
      0082BF 6B 02            [ 1]  536 	ld	(0x02, sp), a
      0082C1 0F 01            [ 1]  537 	clr	(0x01, sp)
      0082C3 9E               [ 1]  538 	ld	a, xh
      0082C4 A4 07            [ 1]  539 	and	a, #0x07
      0082C6 88               [ 1]  540 	push	a
      0082C7 CD 8B 3F         [ 4]  541 	call	___uchar2fs
      0082CA 84               [ 1]  542 	pop	a
      0082CB 89               [ 2]  543 	pushw	x
      0082CC 90 89            [ 2]  544 	pushw	y
      0082CE 5F               [ 1]  545 	clrw	x
      0082CF 89               [ 2]  546 	pushw	x
      0082D0 4B 00            [ 1]  547 	push	#0x00
      0082D2 4B 3E            [ 1]  548 	push	#0x3e
      0082D4 CD 84 5D         [ 4]  549 	call	___fsmul
      0082D7 5B 08            [ 2]  550 	addw	sp, #8
      0082D9 17 07            [ 2]  551 	ldw	(0x07, sp), y
      0082DB 89               [ 2]  552 	pushw	x
      0082DC 16 03            [ 2]  553 	ldw	y, (0x03, sp)
      0082DE 90 89            [ 2]  554 	pushw	y
      0082E0 CD 8B 2E         [ 4]  555 	call	___sint2fs
      0082E3 5B 02            [ 2]  556 	addw	sp, #2
      0082E5 1F 0F            [ 2]  557 	ldw	(0x0f, sp), x
      0082E7 1E 09            [ 2]  558 	ldw	x, (0x09, sp)
      0082E9 89               [ 2]  559 	pushw	x
      0082EA 1E 11            [ 2]  560 	ldw	x, (0x11, sp)
      0082EC 89               [ 2]  561 	pushw	x
      0082ED 90 89            [ 2]  562 	pushw	y
      0082EF CD 88 6C         [ 4]  563 	call	___fsadd
      0082F2 5B 08            [ 2]  564 	addw	sp, #8
      0082F4 1F 05            [ 2]  565 	ldw	(0x05, sp), x
      0082F6 17 03            [ 2]  566 	ldw	(0x03, sp), y
                                    567 ;	blink.c: 185: temp = DS18B20_ReadByte();
      0082F8 CD 82 37         [ 4]  568 	call	_DS18B20_ReadByte
                                    569 ;	blink.c: 186: t += ((temp & 0x0f) << 4);
      0082FB A4 0F            [ 1]  570 	and	a, #0x0f
      0082FD 5F               [ 1]  571 	clrw	x
      0082FE 97               [ 1]  572 	ld	xl, a
      0082FF 58               [ 2]  573 	sllw	x
      008300 58               [ 2]  574 	sllw	x
      008301 58               [ 2]  575 	sllw	x
      008302 58               [ 2]  576 	sllw	x
      008303 89               [ 2]  577 	pushw	x
      008304 CD 8B 2E         [ 4]  578 	call	___sint2fs
      008307 5B 02            [ 2]  579 	addw	sp, #2
      008309 89               [ 2]  580 	pushw	x
      00830A 90 89            [ 2]  581 	pushw	y
      00830C 1E 09            [ 2]  582 	ldw	x, (0x09, sp)
      00830E 89               [ 2]  583 	pushw	x
      00830F 1E 09            [ 2]  584 	ldw	x, (0x09, sp)
      008311 89               [ 2]  585 	pushw	x
      008312 CD 88 6C         [ 4]  586 	call	___fsadd
                                    587 ;	blink.c: 187: return t;
      008315 5B 16            [ 2]  588 	addw	sp, #22
      008317 81               [ 4]  589 	ret
                                    590 ;	blink.c: 194: void main() {
                                    591 ;	-----------------------------------------
                                    592 ;	 function main
                                    593 ;	-----------------------------------------
      008318                        594 _main:
      008318 52 10            [ 2]  595 	sub	sp, #16
                                    596 ;	blink.c: 198: InitializeSystemClock();
      00831A CD 80 A0         [ 4]  597 	call	_InitializeSystemClock
                                    598 ;	blink.c: 199: PB_DDR |= (1 << LED_PIN);
      00831D AE 50 07         [ 2]  599 	ldw	x, #0x5007
      008320 F6               [ 1]  600 	ld	a, (x)
      008321 AA 20            [ 1]  601 	or	a, #0x20
      008323 F7               [ 1]  602 	ld	(x), a
                                    603 ;	blink.c: 200: PB_CR1 |= (1 << LED_PIN);
      008324 AE 50 08         [ 2]  604 	ldw	x, #0x5008
      008327 F6               [ 1]  605 	ld	a, (x)
      008328 AA 20            [ 1]  606 	or	a, #0x20
      00832A F7               [ 1]  607 	ld	(x), a
                                    608 ;	blink.c: 202: while (1) {
      00832B                        609 00114$:
                                    610 ;	blink.c: 203: send(3,3); //start message
      00832B 4B 03            [ 1]  611 	push	#0x03
      00832D 4B 00            [ 1]  612 	push	#0x00
      00832F 4B 03            [ 1]  613 	push	#0x03
      008331 4B 00            [ 1]  614 	push	#0x00
      008333 CD 81 46         [ 4]  615 	call	_send
      008336 5B 04            [ 2]  616 	addw	sp, #4
                                    617 ;	blink.c: 207: objTemp = DS18B20_ReadTemperature();  
      008338 CD 82 96         [ 4]  618 	call	_DS18B20_ReadTemperature
      00833B 1F 03            [ 2]  619 	ldw	(0x03, sp), x
      00833D 17 01            [ 2]  620 	ldw	(0x01, sp), y
                                    621 ;	blink.c: 208: while (objTemp > 1000) {
      00833F                        622 00101$:
      00833F 5F               [ 1]  623 	clrw	x
      008340 89               [ 2]  624 	pushw	x
      008341 4B 7A            [ 1]  625 	push	#0x7a
      008343 4B 44            [ 1]  626 	push	#0x44
      008345 1E 07            [ 2]  627 	ldw	x, (0x07, sp)
      008347 89               [ 2]  628 	pushw	x
      008348 1E 07            [ 2]  629 	ldw	x, (0x07, sp)
      00834A 89               [ 2]  630 	pushw	x
      00834B CD 87 5F         [ 4]  631 	call	___fsgt
      00834E 5B 08            [ 2]  632 	addw	sp, #8
      008350 4D               [ 1]  633 	tnz	a
      008351 27 17            [ 1]  634 	jreq	00121$
                                    635 ;	blink.c: 210: objTemp-=1000;
      008353 5F               [ 1]  636 	clrw	x
      008354 89               [ 2]  637 	pushw	x
      008355 4B 7A            [ 1]  638 	push	#0x7a
      008357 4B 44            [ 1]  639 	push	#0x44
      008359 1E 07            [ 2]  640 	ldw	x, (0x07, sp)
      00835B 89               [ 2]  641 	pushw	x
      00835C 1E 07            [ 2]  642 	ldw	x, (0x07, sp)
      00835E 89               [ 2]  643 	pushw	x
      00835F CD 84 3A         [ 4]  644 	call	___fssub
      008362 5B 08            [ 2]  645 	addw	sp, #8
      008364 1F 03            [ 2]  646 	ldw	(0x03, sp), x
      008366 17 01            [ 2]  647 	ldw	(0x01, sp), y
      008368 20 D5            [ 2]  648 	jra	00101$
                                    649 ;	blink.c: 212: while (objTemp > 100) {
      00836A                        650 00121$:
      00836A 5F               [ 1]  651 	clrw	x
      00836B 1F 05            [ 2]  652 	ldw	(0x05, sp), x
      00836D                        653 00104$:
      00836D 5F               [ 1]  654 	clrw	x
      00836E 89               [ 2]  655 	pushw	x
      00836F 4B C8            [ 1]  656 	push	#0xc8
      008371 4B 42            [ 1]  657 	push	#0x42
      008373 1E 07            [ 2]  658 	ldw	x, (0x07, sp)
      008375 89               [ 2]  659 	pushw	x
      008376 1E 07            [ 2]  660 	ldw	x, (0x07, sp)
      008378 89               [ 2]  661 	pushw	x
      008379 CD 87 5F         [ 4]  662 	call	___fsgt
      00837C 5B 08            [ 2]  663 	addw	sp, #8
      00837E 4D               [ 1]  664 	tnz	a
      00837F 27 1D            [ 1]  665 	jreq	00128$
                                    666 ;	blink.c: 213: derde+=1;
      008381 1E 05            [ 2]  667 	ldw	x, (0x05, sp)
      008383 5C               [ 2]  668 	incw	x
      008384 1F 05            [ 2]  669 	ldw	(0x05, sp), x
                                    670 ;	blink.c: 214: objTemp-=100;
      008386 5F               [ 1]  671 	clrw	x
      008387 89               [ 2]  672 	pushw	x
      008388 4B C8            [ 1]  673 	push	#0xc8
      00838A 4B 42            [ 1]  674 	push	#0x42
      00838C 1E 07            [ 2]  675 	ldw	x, (0x07, sp)
      00838E 89               [ 2]  676 	pushw	x
      00838F 1E 07            [ 2]  677 	ldw	x, (0x07, sp)
      008391 89               [ 2]  678 	pushw	x
      008392 CD 84 3A         [ 4]  679 	call	___fssub
      008395 5B 08            [ 2]  680 	addw	sp, #8
      008397 51               [ 1]  681 	exgw	x, y
      008398 17 03            [ 2]  682 	ldw	(0x03, sp), y
      00839A 1F 01            [ 2]  683 	ldw	(0x01, sp), x
      00839C 20 CF            [ 2]  684 	jra	00104$
                                    685 ;	blink.c: 216: while (objTemp > 10) {
      00839E                        686 00128$:
      00839E 16 05            [ 2]  687 	ldw	y, (0x05, sp)
      0083A0 17 0B            [ 2]  688 	ldw	(0x0b, sp), y
      0083A2 5F               [ 1]  689 	clrw	x
      0083A3 1F 09            [ 2]  690 	ldw	(0x09, sp), x
      0083A5                        691 00107$:
      0083A5 5F               [ 1]  692 	clrw	x
      0083A6 89               [ 2]  693 	pushw	x
      0083A7 4B 20            [ 1]  694 	push	#0x20
      0083A9 4B 41            [ 1]  695 	push	#0x41
      0083AB 1E 07            [ 2]  696 	ldw	x, (0x07, sp)
      0083AD 89               [ 2]  697 	pushw	x
      0083AE 1E 07            [ 2]  698 	ldw	x, (0x07, sp)
      0083B0 89               [ 2]  699 	pushw	x
      0083B1 CD 87 5F         [ 4]  700 	call	___fsgt
      0083B4 5B 08            [ 2]  701 	addw	sp, #8
      0083B6 4D               [ 1]  702 	tnz	a
      0083B7 27 1C            [ 1]  703 	jreq	00129$
                                    704 ;	blink.c: 217: tweede+=1;
      0083B9 1E 09            [ 2]  705 	ldw	x, (0x09, sp)
      0083BB 5C               [ 2]  706 	incw	x
      0083BC 1F 09            [ 2]  707 	ldw	(0x09, sp), x
                                    708 ;	blink.c: 218: objTemp-=10;
      0083BE 5F               [ 1]  709 	clrw	x
      0083BF 89               [ 2]  710 	pushw	x
      0083C0 4B 20            [ 1]  711 	push	#0x20
      0083C2 4B 41            [ 1]  712 	push	#0x41
      0083C4 1E 07            [ 2]  713 	ldw	x, (0x07, sp)
      0083C6 89               [ 2]  714 	pushw	x
      0083C7 1E 07            [ 2]  715 	ldw	x, (0x07, sp)
      0083C9 89               [ 2]  716 	pushw	x
      0083CA CD 84 3A         [ 4]  717 	call	___fssub
      0083CD 5B 08            [ 2]  718 	addw	sp, #8
      0083CF 1F 03            [ 2]  719 	ldw	(0x03, sp), x
      0083D1 17 01            [ 2]  720 	ldw	(0x01, sp), y
      0083D3 20 D0            [ 2]  721 	jra	00107$
                                    722 ;	blink.c: 220: while (objTemp > 0)
      0083D5                        723 00129$:
      0083D5 16 09            [ 2]  724 	ldw	y, (0x09, sp)
      0083D7 17 0D            [ 2]  725 	ldw	(0x0d, sp), y
      0083D9 5F               [ 1]  726 	clrw	x
      0083DA 1F 07            [ 2]  727 	ldw	(0x07, sp), x
      0083DC                        728 00110$:
      0083DC 5F               [ 1]  729 	clrw	x
      0083DD 89               [ 2]  730 	pushw	x
      0083DE 5F               [ 1]  731 	clrw	x
      0083DF 89               [ 2]  732 	pushw	x
      0083E0 1E 07            [ 2]  733 	ldw	x, (0x07, sp)
      0083E2 89               [ 2]  734 	pushw	x
      0083E3 1E 07            [ 2]  735 	ldw	x, (0x07, sp)
      0083E5 89               [ 2]  736 	pushw	x
      0083E6 CD 87 5F         [ 4]  737 	call	___fsgt
      0083E9 5B 08            [ 2]  738 	addw	sp, #8
      0083EB 4D               [ 1]  739 	tnz	a
      0083EC 27 1C            [ 1]  740 	jreq	00112$
                                    741 ;	blink.c: 222: eerste+=1;
      0083EE 1E 07            [ 2]  742 	ldw	x, (0x07, sp)
      0083F0 5C               [ 2]  743 	incw	x
      0083F1 1F 07            [ 2]  744 	ldw	(0x07, sp), x
                                    745 ;	blink.c: 223: objTemp-=1;
      0083F3 5F               [ 1]  746 	clrw	x
      0083F4 89               [ 2]  747 	pushw	x
      0083F5 4B 80            [ 1]  748 	push	#0x80
      0083F7 4B 3F            [ 1]  749 	push	#0x3f
      0083F9 1E 07            [ 2]  750 	ldw	x, (0x07, sp)
      0083FB 89               [ 2]  751 	pushw	x
      0083FC 1E 07            [ 2]  752 	ldw	x, (0x07, sp)
      0083FE 89               [ 2]  753 	pushw	x
      0083FF CD 84 3A         [ 4]  754 	call	___fssub
      008402 5B 08            [ 2]  755 	addw	sp, #8
      008404 1F 03            [ 2]  756 	ldw	(0x03, sp), x
      008406 17 01            [ 2]  757 	ldw	(0x01, sp), y
      008408 20 D2            [ 2]  758 	jra	00110$
      00840A                        759 00112$:
                                    760 ;	blink.c: 226: temp=derde*100+tweede*10+eerste;
      00840A 1E 0B            [ 2]  761 	ldw	x, (0x0b, sp)
      00840C 89               [ 2]  762 	pushw	x
      00840D 4B 64            [ 1]  763 	push	#0x64
      00840F 4B 00            [ 1]  764 	push	#0x00
      008411 CD 88 4B         [ 4]  765 	call	__mulint
      008414 5B 04            [ 2]  766 	addw	sp, #4
      008416 1F 0F            [ 2]  767 	ldw	(0x0f, sp), x
      008418 1E 0D            [ 2]  768 	ldw	x, (0x0d, sp)
      00841A 89               [ 2]  769 	pushw	x
      00841B 4B 0A            [ 1]  770 	push	#0x0a
      00841D 4B 00            [ 1]  771 	push	#0x00
      00841F CD 88 4B         [ 4]  772 	call	__mulint
      008422 5B 04            [ 2]  773 	addw	sp, #4
      008424 72 FB 0F         [ 2]  774 	addw	x, (0x0f, sp)
      008427 72 FB 07         [ 2]  775 	addw	x, (0x07, sp)
                                    776 ;	blink.c: 229: send(99, temp);
      00842A 89               [ 2]  777 	pushw	x
      00842B 4B 63            [ 1]  778 	push	#0x63
      00842D 4B 00            [ 1]  779 	push	#0x00
      00842F CD 81 46         [ 4]  780 	call	_send
      008432 5B 04            [ 2]  781 	addw	sp, #4
      008434 CC 83 2B         [ 2]  782 	jp	00114$
      008437 5B 10            [ 2]  783 	addw	sp, #16
      008439 81               [ 4]  784 	ret
                                    785 	.area CODE
                                    786 	.area INITIALIZER
                                    787 	.area CABS (ABS)
