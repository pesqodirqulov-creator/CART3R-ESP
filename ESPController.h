
#import <UIKit/UIKit.h>
#import "ESPScanner.h"
#import "ESPOverlay.h"

@interface ESPController : NSObject

@property (nonatomic, strong) ESPScanner *scanner;
@property (nonatomic, strong) ESPOverlay *overlay;

- (void)processImage:(UIImage *)image;

@end
