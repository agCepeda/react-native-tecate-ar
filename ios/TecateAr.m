
#import <UIKit/UIKit.h>

#import "TecateAr.h"
#import "TecateAr-Swift.h"
#import "ViewerViewController.h"

@implementation TecateAr
@class AnotherViewController;

RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(sampleMethod:(NSString *)stringArgument numberParameter:(nonnull NSNumber *)numberArgument callback:(RCTResponseSenderBlock)callback)
{
    // TODO: Implement some actually useful functionality
    callback(@[[NSString stringWithFormat: @"numberArgument: %@ stringArgument: %@", numberArgument, stringArgument]]);
}

RCT_EXPORT_METHOD(openViewer) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
        AnotherViewController *viewer = [[AnotherViewController alloc] init];
        [rootViewController presentViewController:viewer animated:true completion:nil];
    });
}

@end
