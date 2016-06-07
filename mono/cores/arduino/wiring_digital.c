

#include <gpio_api.h>
#include "wiring_digital.h"
#include "wiring_constants.h"
#include "Pins.h"

int digiPins[14] = {
    D0,
    D1,
    D2,
    D3,
    D4,
    D5,
    D6,
    D7,
    D8,
    D9,
    D10,
    D11,
    D12,
    D13
};

void pinMode( uint32_t dwPin, uint32_t dwMode )
{
    gpio_t gpio;
    if (dwMode == INPUT)
        gpio_init_in(&gpio, digiPins[dwPin]);
    else
        gpio_init_out(&gpio, digiPins[dwPin]);
}

void digitalWrite( uint32_t dwPin, uint32_t dwVal )
{
    gpio_t gpio;
    gpio_init(&gpio, digiPins[dwPin]);
    gpio_write(&gpio, dwVal);
}


int digitalRead( uint32_t ulPin )
{
    gpio_t gpio;
    gpio_init(&gpio, digiPins[ulPin]);
    return gpio_read(&gpio);
}