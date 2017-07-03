[![Build Status](https://travis-ci.org/getopenmono/arduino_comp.svg?branch=master)](https://travis-ci.org/getopenmono/arduino_comp)

# Arduino Compability
This repository contains the source code for Mono's Arduino compability layer, 
that enable you to use Arduino famous `setup()` and `loop()` functions.

### Arduino IDE Board package
This repository also contains our Arduino board package plugin for Arduino IDE version 1.6.x. 
This enable you to add mono as a taget platform from THe IDE's *Board Manager*.

#### Install in Arduino IDE

Install the board package source by opening Arduino *Settings* / *Preferences* and insert this URL into the *Additional Board Manager URLs* field:

```
https://github.com/getopenmono/arduino_comp/releases/download/current/package_openmono_index.json
```

Then, goto the *Board Manager* and Mono will appear under *Contributed*.

### Arduino API Compability

To ease the learning curve of programming for mono, impement the standard Arduino API's like `pinMode()` and `delay()`.
You have access to all the standand [Arduino functions](https://www.arduino.cc/en/Reference/HomePage), as well as the complete mono framework.
All from within the `setup()` and `loop()` functions of the Arduino IDE.

For those familiar with Arduino, we think this is a great starting point for coding mono applications.

#### Platform support

* *Windows*: Supported
* *macOS*: Supported
* *Debian*: Not supported. (Due to *sudo* privileges needed to install UDEV rules for serial port.)