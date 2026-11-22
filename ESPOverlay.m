
#import "ESPOverlay.h"

@implementation ESPOverlay

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        self.backgroundColor = UIColor.clearColor;
        self.opaque = NO;
        self.userInteractionEnabled = NO;
        self.targets = @[];
    }

    return self;
}

- (void)setTargets:(NSArray<ESPDetectedTarget *> *)targets {
    _targets = [targets copy];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    if (!context) return;

    CGContextSetStrokeColorWithColor(
        context,
        UIColor.greenColor.CGColor
    );

    CGContextSetLineWidth(context, 2.0);

    for (ESPDetectedTarget *target in self.targets) {
        CGRect box = target.bounds;

        CGFloat x = box.origin.x * self.bounds.size.width;
        CGFloat y = (1.0 - CGRectGetMaxY(box))
                    * self.bounds.size.height;
        CGFloat w = box.size.width * self.bounds.size.width;
        CGFloat h = box.size.height * self.bounds.size.height;

        CGRect frame = CGRectMake(x, y, w, h);

        CGContextStrokeRect(context, frame);
    }
}

@end
