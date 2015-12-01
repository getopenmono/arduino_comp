# Arduino Compability
This repository contains the source code for Mono's Arduino compability layer, 
that enable you to use Arduino famous `setup()` and `loop()` functions.

### Arduino IDE Board package
This repository also contains our Arduino board package plugin for Arduino IDE version 1.6.x. 
This enable you to add mono as a taget platform from THe IDE's *Board Manager*.

As we get to a stable codebase we will provide the download URL for the board package, to use with Arduino IDE.

### Arduino API Compability
To ease the learning curve of programming for mono, impement the standard Arduino API's like `pinMode()` and `delay()`.
You have access to all the standand [Arduino functions](https://www.arduino.cc/en/Reference/HomePage), as well as the complete mono framework.
All from within the `setup()` and `loop()` functions of the Arduino IDE.

For those familiar with Arduino, we think this is a great starting point for coding mono applications.
