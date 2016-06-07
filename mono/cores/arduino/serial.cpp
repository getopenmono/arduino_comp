

#include "serial.h"
#include <consoles.h>

Serial_::Serial_() {}

void Serial_::begin(uint32_t baud_count)
{

}

void Serial_::begin(uint32_t baud_count, uint8_t config)
{

}

void Serial_::end(void)
{

}

int Serial_::available(void)
{
    return mono::defaultSerial.readable();
}

void Serial_::accept(void)
{

}

int Serial_::peek(void)
{
    return mono::defaultSerial.readable();
}

int Serial_::read(void)
{
    return mono::defaultSerial.getc();
}

void Serial_::flush(void)
{

}

size_t Serial_::write(uint8_t c)
{
    return mono::defaultSerial.putc(c);
}

size_t Serial_::write(const uint8_t *buffer, size_t size)
{
    return fwrite(buffer, size, 1, mono::defaultSerial);
}


Serial_::operator bool()
{
    return mono::defaultSerial.IsReady();
}

uint32_t Serial_::baud()
{
    return 115200;
}

uint8_t Serial_::stopbits()
{
    return 1;
}

uint8_t Serial_::paritytype()
{
    return 0;
}

uint8_t Serial_::numbits()
{
    return 8;
}

bool dtr()
{
    return mono::defaultSerial.DTR();
}

bool rts()
{
    return 0;
}

Serial_ Serial;