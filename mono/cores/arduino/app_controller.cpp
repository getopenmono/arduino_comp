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

AppController::AppController() :
    bg(mono::display::BlackColor),
    ard(mono::geo::Rect(0,100,172,35), "Arduino")
{
    AppController::ArduinoAppController = this;
    ard.setAlignment(mono::ui::TextLabelView::ALIGN_CENTER);
    ard.setTextColor(mono::display::WhiteColor);
    ard.setBackgroundColor(mono::display::BlackColor);
    ard.setTextSize(2);
    
    this->singleShot = false;
}

void AppController::monoWakeFromReset()
{
    bg.show();
    ard.show();
    
    mono::IApplicationContext::Instance->DisplayController->setBrightness(128);
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