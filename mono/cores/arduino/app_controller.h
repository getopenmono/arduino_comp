

#ifndef MONO_BYO_APP_CONTROLLER

#ifndef app_controller_h
#define app_controller_h

#include <mono.h>
#include <FunctionPointer.h>

class AppController : public mono::IApplication, mono::IRunLoopTask {
public:

    static bool resetOnWake;
    static mbed::FunctionPointer wakeUpHandler;
    static mbed::FunctionPointer sleepHandler;
    
    void taskHandler();

    static AppController *ArduinoAppController;

    AppController();

    void monoWakeFromReset();

    void monoWillGotoSleep();

    void monoWakeFromSleep();

};

#endif /* app_controller_h */

#endif /* BYO AppController */
