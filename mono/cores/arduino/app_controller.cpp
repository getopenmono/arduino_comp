//
//  app_controller.cpp
//
//
//
//  
//

#include "app_controller.h"
#include "Arduino.h"

AppController::AppController() :
    bg(mono::display::BlackColor),
    ard(mono::geo::Rect(0,100,172,35), "Arduino")
{
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

    ardTimer.attach<AppController>(this, &AppController::ardTimerFire, 3);

	setup();
}

void AppController::taskHandler()
{
	loop();
}

void AppController::ardTimerFire()
{
    mono::display::IDisplayController *ctrl = mono::IApplicationContext::Instance->DisplayController;

    if (ctrl->Brightness() <= 10)
    {
        ardTimer.detach();
        ctrl->setBrightness(10);
    }
    else
    {
        ctrl->setBrightness(ctrl->Brightness() - 2);
        ardTimer.attach_us<AppController>(this, &AppController::ardTimerFire, 20000);
    }
}

void AppController::monoWillGotoSleep()
{
	
}

void AppController::monoWakeFromSleep()
{
    mono::IApplicationContext::SoftwareResetToApplication();
}