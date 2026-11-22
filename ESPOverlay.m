
#import "ESPOverlay.h"

@interface ESPOverlay ()

@property(nonatomic) CGSize imageSize;
@property(nonatomic, copy) NSArray<NSValue *> *boxes;

@end

@implementation ESPOverlay

- (instancetype)initWithFrame:(CGRect)frame
                    imageSize:(CGSize)imageSize
                        boxes:(NSArray<NSValue *> *)boxes {

    self = [super initWithFrame:frame];

    if (self) {
        _imageSize = imageSize;
        _boxes = [boxes copy];

        self.backgroundColor =
            [UIColor colorWithWhite:0 alpha:0.12];

        self.userInteractionEnabled = YES;

        UIButton *close = [UIButton buttonWithType:UIButtonTypeSystem];

        close.frame = CGRectMake(frame.size.width - 65, 55, 48, 48);
        close.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;

        close.backgroundColor =
            [UIColor colorWithRed:0.65 green:0.02 blue:0.08 alpha:0.95];

        close.layer.cornerRadius = 24;

        [close setTitle:@"X" forState:UIControlStateNormal];
        [close setTitleColor:UIColor.whiteColor
                    forState:UIControlStateNormal];

        [close addTarget:self
                  action:@selector(closeOverlay)
        forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:close];
    }

    return self;
}

- (void)closeOverlay {
    [self removeFromSuperview];
}

- (void)drawRect:(CGRect)rect {

    CGContextRef context = UIGraphicsGetCurrentContext();

    if (!context || self.imageSize.width <= 0 ||
        self.imageSize.height <= 0) return;

    CGFloat scale = MIN(
        self.bounds.size.width / self.imageSize.width,
        self.bounds.size.height / self.imageSize.height
    );

    CGFloat renderedWidth = self.imageSize.width * scale;
    CGFloat renderedHeight = self.imageSize.height * scale;

    CGFloat offsetX = (self.bounds.size.width - renderedWidth) / 2;
    CGFloat offsetY = (self.bounds.size.height - renderedHeight) / 2;

    CGContextSetStrokeColorWithColor(
        context,
        [UIColor colorWithRed:0.05 green:1.0 blue:0.28 alpha:1].CGColor
    );

    CGContextSetLineWidth(context, 2.0);

    for (NSValue *value in self.boxes) {

        CGRect normalized = value.CGRectValue;

        CGRect box = CGRectMake(
            offsetX + normalized.origin.x * renderedWidth,
            offsetY + (1.0 - CGRectGetMaxY(normalized)) * renderedHeight,
            normalized.size.width * renderedWidth,
            normalized.size.height * renderedHeight
        );

        CGContextStrokeRect(context, box);

        NSString *label = @"DETECTED";

        [label drawAtPoint:
            CGPointMake(box.origin.x, MAX(0, box.origin.y - 17))
            withAttributes:@{
                NSForegroundColorAttributeName: UIColor.whiteColor,
                NSFontAttributeName:
                    [UIFont boldSystemFontOfSize:11]
            }];
    }

    NSString *status = [NSString stringWithFormat:
        @"CART3R ESP | DETECTED: %lu",
        (unsigned long)self.boxes.count
    ];

    [status drawAtPoint:CGPointMake(20, 60)
         withAttributes:@{
        NSForegroundColorAttributeName: UIColor.greenColor,
        NSFontAttributeName: [UIFont boldSystemFontOfSize:13]
    }];
}

@end
