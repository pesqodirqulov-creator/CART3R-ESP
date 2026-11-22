
#import <UIKit/UIKit.h>

@interface ESPScanner : NSObject

+ (void)scanImage:(UIImage *)image
       completion:(void (^)(NSArray<NSValue *> *boxes,
                            NSError *error))completion;

@end
