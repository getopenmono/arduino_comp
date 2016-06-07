// This software is part of OpenMono, see http://developer.openmono.com
// Released under the MIT license, see LICENSE.txt

#include <gpio_irq_api.h>
#include <stdint.h>
#include "wiring_constants.h"

// int  gpio_irq_init(gpio_irq_t *obj, PinName pin, gpio_irq_handler handler, uint64_t id);

void interrupt_handler(uint32_t id, gpio_irq_event event)
{
    if (id == 0)
        return;

    void (*callback)(void) = (void (*)(void))id;
    callback();
}

void attachInterrupt(uint32_t pin, void (*callback)(void), uint32_t mode)
{
    gpio_irq_event event;
    switch (mode) {
        case RISING:
            event = IRQ_RISE;
            break;
        case FALLING:
            event = IRQ_FALL;
            break;
        default:
            event = IRQ_NONE;
            break;
    }

    gpio_irq_t obj;
    gpio_irq_init(&obj, pin, interrupt_handler, (uint32_t)*callback);
    gpio_irq_set(&obj, event, 1);
}

void detachInterrupt(uint32_t pin)
{
    gpio_irq_t obj;
    gpio_irq_init(&obj, pin, 0, 0);
    gpio_irq_free(&obj);
}