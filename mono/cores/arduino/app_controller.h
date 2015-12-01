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

extern "C" {
extern void setup();
extern void loop();
}

class AppController : public mono::IApplication, mono::IRunLoopTask {
protected:
	
	void taskHandler();
    
public:
    
    void monoWakeFromReset();

    void monoWillGotoSleep();

    void monoWakeFromSleep();
    
    
};

#endif /* app_controller_h */
