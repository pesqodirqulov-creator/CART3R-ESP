
#import <UIKit/UIKit.h>

@interface ESPOverlay : UIView

- (instancetype)initWithFrame:(CGRect)frame
                    imageSize:(CGSize)imageSize
                         boxes:(NSArray<NSValue *> *)boxes;

@end
