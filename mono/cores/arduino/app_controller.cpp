//
//  app_controller.cpp
//
//
//
//  
//

#include "app_controller.h"
#include "Arduino.h"

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
	
}

void AppController::monoWakeFromSleep()
{
    mono::IApplicationContext::SoftwareResetToApplication();
}