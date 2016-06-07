// This software is part of OpenMono, see http://developer.openmono.com
// Released under the MIT license, see LICENSE.txt

#ifndef functions_h
#define functions_h

/*
 // C++ ONLY include:
 #include "WCharacter.h"
 #include "WString.h"
 #include "Tone.h"
 #include "WMath.h"
 #include "HardwareSerial.h"
 #include "wiring_pulse.h"
 */

/// MARK: Digital IO
#include "Pins.h"
#include "wiring_constants.h"
#include "wiring_digital.h"

/// MARK: Analog IO


/// MARK: Advanced IO

// tone API no implemented
#include "wiring_shift.h"
// pulseIn() not implemented

/// MARK: Time

// Defined in: timing.c
uint32_t millis();
uint32_t micros();
void delay(uint32_t ms);
void delayMicroseconds(uint32_t us);

/// MARK: Math

// Defined in wring_constants.h:
// min(...)
// max(...)
// abs(...)
// constrain(...)

#include <math.h>
// math.h defines:
// sqrt()
// pow()

#ifdef __cplusplus
#include "WMath.h"
// defines:
// map(..)
#endif

/// MARK: Trigonometry

// math.h defines:
// sin()
// cos()
// tan()

/// MARK: Characters
#ifdef __cplusplus
#include "WCharacter.h"
#endif

/// MARK: Random Numbers

// randomSeed() and random() are defined in WMath.h

/// MARK: Bits and bytes

// bits and byte functions defined in wiring_constants.h

/// MARK: External Interrupts
// implemented in external_interrupts.c
void attachInterrupt(uint32_t pin, void (*callback)(void), uint32_t mode);
void detachInterrupt(uint32_t pin);

/// MARK: Interrupts

// enabled and disabled of interrupts are defined in wiring_contants.h and
// maps to __enable_irq() and __disable_irq()

/// MARK: Communication
#ifdef __cplusplus
#include "serial.h"
#endif

#endif /* functions_h */
