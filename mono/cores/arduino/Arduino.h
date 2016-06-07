/*
  Arduino.h - Main include file for the Arduino SDK
  Copyright (c) 2005-2013 Arduino Team.  All right reserved.

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation; either
  version 2.1 of the License, or (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General Public
  License along with this library; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
*/

#ifndef Arduino_h
#define Arduino_h

#include <stdint.h>
#include <stdlib.h>
#include <string.h>


// some libraries and sketches depend on this
// AVR stuff, assuming Arduino.h or WProgram.h
// automatically includes it...
//#include <avr/pgmspace.h>
//#include <avr/interrupt.h>
//
//#include "binary.h"
//#include "itoa.h"

#ifdef __cplusplus
extern "C"{
#endif // __cplusplus

#include <wait_api.h>
inline void delay(unsigned long ms) { wait_ms(ms); }

#define clockCyclesPerMicrosecond() ( SystemCoreClock / 1000000L )
#define clockCyclesToMicroseconds(a) ( ((a) * 1000L) / (SystemCoreClock / 1000L) )
#define microsecondsToClockCycles(a) ( (a) * (SystemCoreClock / 1000000L) )


/* sketch */
extern void setup( void ) ;
extern void loop( void ) ;

//#define NOT_A_PIN 0  // defined in pio.h/EPioType
#define NOT_A_PORT           0

#define NOT_AN_INTERRUPT -1

/* Define attribute */
#if defined   ( __CC_ARM   ) /* Keil uVision 4 */
    #define WEAK (__attribute__ ((weak)))
#elif defined ( __ICCARM__ ) /* IAR Ewarm 5.41+ */
    #define WEAK __weak
#elif defined (  __GNUC__  ) /* GCC CS */
    #define WEAK __attribute__ ((weak))
#endif


#ifdef __cplusplus
}
#endif

#include "functions.h"

#endif // Arduino_h
