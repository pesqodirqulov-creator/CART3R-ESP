
#import "ESPScanner.h"
#import <Vision/Vision.h>

@implementation ESPScanner

+ (void)scanImage:(UIImage *)image
       completion:(void (^)(NSArray<NSValue *> *, NSError *))completion {

    if (!image.CGImage) {
        NSError *error = [NSError errorWithDomain:@"CART3R_ESP"
                                             code:1
                                         userInfo:@{
            NSLocalizedDescriptionKey: @"Rasmni o'qib bo'lmadi."
        }];

        completion(@[], error);
        return;
    }

    VNDetectHumanRectanglesRequest *request =
        [[VNDetectHumanRectanglesRequest alloc] init];

    request.upperBodyOnly = NO;
    request.minimumConfidence = 0.35;

    VNImageRequestHandler *handler =
        [[VNImageRequestHandler alloc]
            initWithCGImage:image.CGImage
                orientation:kCGImagePropertyOrientationUp
                    options:@{}];

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{

        NSError *error = nil;

        BOOL success = [handler performRequests:@[request]
                                          error:&error];

        NSMutableArray<NSValue *> *boxes = [NSMutableArray array];

        if (success) {
            for (VNHumanObservation *observation in request.results) {

                CGRect box = observation.boundingBox;

                if (box.size.width <= 0 || box.size.height <= 0)
                    continue;

                [boxes addObject:[NSValue valueWithCGRect:box]];
            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            completion(boxes, error);
        });
    });
}

@end
