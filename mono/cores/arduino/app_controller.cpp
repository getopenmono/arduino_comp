

#ifndef MONO_BYO_APP_CONTROLLER

#include "app_controller.h"
#include "Arduino.h"

bool AppController::resetOnWake = true;
mbed::FunctionPointer AppController::wakeUpHandler;
mbed::FunctionPointer AppController::sleepHandler;

AppController *AppController::ArduinoAppController = 0;

AppController::AppController()
{
    AppController::ArduinoAppController = this;
    this->singleShot = false;
}

void AppController::monoWakeFromReset()
{
    mono::IApplicationContext::Instance->RunLoop->addDynamicTask(this);

    setup();
}

void AppController::taskHandler()
{
    loop();
}

void AppController::monoWillGotoSleep()
{
    sleepHandler.call();
}

void AppController::monoWakeFromSleep()
{
    if (resetOnWake)
        mono::IApplicationContext::SoftwareResetToApplication();
	else
        wakeUpHandler.call();

}

#endif /** BYO AppController */
