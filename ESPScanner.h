
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ESPDetectedTarget : NSObject

@property (nonatomic, assign) CGRect bounds;
@property (nonatomic, assign) CGFloat confidence;

@end

@interface ESPScanner : NSObject

- (void)scanImage:(UIImage *)image
       completion:(void (^)(NSArray<ESPDetectedTarget *> *targets,
                            NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
