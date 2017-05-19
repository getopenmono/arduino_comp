//static const int A0 = 

#include <analogin_api.h>
#include <string.h>

static const int _analog_map[8] = {
	A0,
	A1,
	A2,
	A3,
	A4,
	A5,
    J_RING1,
    J_RING2
};

int analogRead(uint8_t pin)
{
	analogin_t ana;
	
	if (pin > 7)
		return 0;
	
	analogin_init(&ana, _analog_map[pin]);
	return analogin_read_u16(&ana) >> 6;
}

// void analogReference(uint8_t mode)
// {
//
// }

// void analogWrite(uint8_t pin, int value)
// {
//
// }
