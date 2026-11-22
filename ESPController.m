
#import "ESPController.h"

@implementation ESPController

- (instancetype)init {
    self = [super init];

    if (self) {
        _scanner = [[ESPScanner alloc] init];
    }

    return self;
}

- (void)processImage:(UIImage *)image {
    __weak typeof(self) weakSelf = self;

    [self.scanner scanImage:image
                 completion:^(NSArray *targets, NSError *error) {

        if (error) {
            NSLog(@"ESP Error: %@", error);
            return;
        }

        weakSelf.overlay.targets = targets;
    }];
}

@end
