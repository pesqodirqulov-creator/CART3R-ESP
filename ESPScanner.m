
#import "ESPScanner.h"
#import <Vision/Vision.h>

@implementation ESPDetectedTarget
@end

@implementation ESPScanner

- (void)scanImage:(UIImage *)image
       completion:(void (^)(NSArray<ESPDetectedTarget *> *,
                            NSError *))completion {

    if (!image.CGImage) {
        completion(@[], nil);
        return;
    }

    VNDetectHumanRectanglesRequest *request =
        [[VNDetectHumanRectanglesRequest alloc] init];

    request.upperBodyOnly = NO;

    VNImageRequestHandler *handler =
        [[VNImageRequestHandler alloc]
            initWithCGImage:image.CGImage
                    options:@{}];

    NSError *error = nil;

    BOOL success = [handler performRequests:@[request]
                                      error:&error];

    if (!success) {
        completion(@[], error);
        return;
    }

    NSMutableArray *results = [NSMutableArray array];

    for (VNHumanObservation *observation in request.results) {
        ESPDetectedTarget *target =
            [[ESPDetectedTarget alloc] init];

        target.bounds = observation.boundingBox;
        target.confidence = observation.confidence;

        [results addObject:target];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        completion(results, nil);
    });
}

@end
