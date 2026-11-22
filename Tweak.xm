#import <UIKit/UIKit.h>
#import "ESPController.h"

static ESPController *cart3rController;

%ctor {
    @autoreleasepool {
        cart3rController = [[ESPController alloc] init];
        NSLog(@"[CART3R] ESP Controller loaded");
    }
}
