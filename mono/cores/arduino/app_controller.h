//
//  app_controller.h
//  
//
//  
//
//

#ifndef app_controller_h
#define app_controller_h

#include <mono.h>

class AppController : public mono::IApplication, mono::IRunLoopTask {
protected:

    mono::ui::BackgroundView bg;
    mono::ui::TextLabelView ard;
    mbed::Ticker ardTimer;

	void taskHandler();
    
public:

    AppController();

    void ardTimerFire();

    void ardTimerBlink();
    
    void monoWakeFromReset();

    void monoWillGotoSleep();

    void monoWakeFromSleep();
    
    
};

#endif /* app_controller_h */
