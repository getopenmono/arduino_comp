//
//  app_controller.cpp
//
//
//
//  
//

#include "app_controller.h"
#include "Arduino.h"

void AppController::monoWakeFromReset()
{
	//force the serial port to iterate
	mono::defaultSerial.printf("");
	
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
    setup();
}