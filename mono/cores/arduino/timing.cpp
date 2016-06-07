// This software is part of OpenMono, see http://developer.openmono.com
// Released under the MIT license, see LICENSE.txt


#include <mbed.h>
#include <application_context_interface.h>
#include <application_run_loop.h>

uint32_t millis()
{
    return us_ticker_read() / 1000;
}

uint32_t micros()
{
    return us_ticker_read();
}

void delayMicroseconds(uint32_t us)
{
    uint32_t begin = us_ticker_read();

    while (us_ticker_read() - begin < us)
    {
        mono::IApplicationContext::Instance->RunLoop->CheckUsbDtr();
    }
}

void delay(uint32_t ms)
{
    delayMicroseconds(ms*1000);
}