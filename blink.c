#include "stm8.h"
#define LED_PIN     5






//http://www.cnblogs.com/chenlidong/articles/1823542.html
#define DS18B20_DQ_OUT          PA_DDR |= (1<<3)   //??
#define DS18B20_DQ_IN           PA_DDR &= ~(1<<3)   //??
#define DS18B20_DQ_HIGH         PA_ODR |= (1<<3)   //??
#define DS18B20_DQ_LOW          PA_ODR &= ~(1<<3)    //??
#define DS18B20_DQ_PULL_UP      PA_CR1 |= (1<<3)   //??
#define DS18B20_DQ_FLOATING     PA_CR1 &=  ~(1<<3)  //??
#define DS18B20_DQ_PUSH_PULL    PA_CR1 |= (1<<3)   //??
#define DS18B20_DQ_OPEN_DRAIN   PA_CR1 &= ~(1<<3)   //??
#define DS18B20_DQ_VALUE        PA_IDR & (1<<3)      //DQ?






void InitializeSystemClock() {
	CLK_ICKR = 0;                       //  Reset the Internal Clock Register.
	CLK_ICKR = CLK_HSIEN;               //  Enable the HSI.
	CLK_ECKR = 0;                       //  Disable the external clock.
	while ((CLK_ICKR & CLK_HSIRDY) == 0);       //  Wait for the HSI to be ready for use.
	CLK_CKDIVR = 0;                     //  Ensure the clocks are running at full speed.
	CLK_PCKENR1 = 0xff;                 //  Enable all peripheral clocks.
	CLK_PCKENR2 = 0xff;                 //  Ditto.
	CLK_CCOR = 0;                       //  Turn off CCO.
	CLK_HSITRIMR = 0;                   //  Turn off any HSIU trimming.
	CLK_SWIMCCR = 0;                    //  Set SWIM to run at clock / 2.
	CLK_SWR = 0xe1;                     //  Use HSI as the clock source.
	CLK_SWCR = 0;                       //  Reset the clock switch control register.
	CLK_SWCR = CLK_SWEN;                //  Enable switching.
	while ((CLK_SWCR & CLK_SWBSY) != 0);        //  Pause while the clock switch is busy.
}

void _delay_us(unsigned int i)
{
	i *= 3;
	while(--i);
}



void delayTenMicro (void) {
	long int a;
	for (a = 0; a < 16000; ++a)
		__asm__("nop");
}



void long_pulse (void){
	PB_ODR = (1 << LED_PIN);
	delayTenMicro();
	delayTenMicro();
	delayTenMicro();
	PB_ODR = (0 << LED_PIN);
	delayTenMicro();
	delayTenMicro();
	delayTenMicro();

}

void short_pulse (void){
	PB_ODR = (1 << LED_PIN);
	delayTenMicro();
	PB_ODR = (0 << LED_PIN);
	delayTenMicro();

}


void send(int sensor, int value)
{
	int i;
	for (i=0;i<8;++i)
	{
		if (sensor & (1<<i))  short_pulse();
		else
			long_pulse();
	}

	for (i=0;i<8;++i)
	{
		if (value & (1<<i))  short_pulse();
		else
			long_pulse();
	}

}




void DS18B20_Init(void)
{
	DS18B20_DQ_OUT;   
	DS18B20_DQ_PUSH_PULL;    
	DS18B20_DQ_HIGH;   
	_delay_us(10);
	DS18B20_DQ_LOW;   
	_delay_us(600);     //????

	DS18B20_DQ_IN;   
	DS18B20_DQ_PULL_UP;    
	_delay_us(100);     
	while(DS18B20_DQ_VALUE == 1);
	_delay_us(400);
}


void DS18B20_WriteByte(unsigned char _data)
{
	unsigned char i = 0;

	DS18B20_DQ_OUT;
	for (i = 0; i < 8; i++)
	{
		DS18B20_DQ_LOW;
		_delay_us(2);
		if (_data & 0x01)
		{
			DS18B20_DQ_HIGH;
		}
		_data >>= 1;
		_delay_us(60);
		DS18B20_DQ_HIGH;
	}
}

unsigned char DS18B20_ReadByte(void)
{
	unsigned char i = 0, _data = 0;

	for (i = 0; i < 8; i++)
	{
		DS18B20_DQ_OUT;
		DS18B20_DQ_LOW;
		_delay_us(5);
		_data >>= 1;
		DS18B20_DQ_HIGH;
		DS18B20_DQ_IN;
		if (DS18B20_DQ_VALUE)
		{
			_data |= 0x80;
		}
		DS18B20_DQ_OUT; 
		DS18B20_DQ_HIGH;
		_delay_us(60);
	}

	return _data;
}

float DS18B20_ReadTemperature(void)
{
	unsigned char temp = 0;
	float t = 0;
	/*
	 *
	 *  
	 *  0x44 is the command to calculate the temperature and save it in the scratchpad.  This takes up to 750 milliseconds.
	 *
	 *  0xBE is the command to send the contents of of the scratchpad.
	 *
	 *  What you are sending is "Everybody: Send your Scratchpad".  This only works if you only have one device.  
	 *
	 */
	DS18B20_Init();
	DS18B20_WriteByte(0xcc);
	DS18B20_WriteByte(0x44);

	DS18B20_Init();
	DS18B20_WriteByte(0xcc);
	DS18B20_WriteByte(0xbe);

	temp = DS18B20_ReadByte();
	t = (((temp & 0xf0) >> 4) + (temp & 0x07) * 0.125); 
	temp = DS18B20_ReadByte();
	t += ((temp & 0x0f) << 4);
	return t;
}





void main() {
	unsigned short sensor1=99, temp=3;
	int vierde,derde,tweede,eerste;
	float objTemp;
	InitializeSystemClock();
	PB_DDR |= (1 << LED_PIN);
	PB_CR1 |= (1 << LED_PIN);

	while (1) {
		send(3,3); //start message
		//sensor ID and value
		eerste=0;tweede=0;derde=0;vierde=0;
		//make measurement suitable for display
		objTemp = DS18B20_ReadTemperature();  
		while (objTemp > 1000) {
			vierde+=1;
			objTemp-=1000;
		}
		while (objTemp > 100) {
			derde+=1;
			objTemp-=100;
		}
		while (objTemp > 10) {
			tweede+=1;
			objTemp-=10;
		}
		while (objTemp > 0)
		{
			eerste+=1;
			objTemp-=1;
		}

		temp=derde*100+tweede*10+eerste;

		//temp = round(DS18B20_ReadTemperature());  
		send(99, temp);
	}
}
