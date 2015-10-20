//
//  RCTOrientationListener.m
//
//  Created by Ken Wheeler on 9/9/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "RCTOrientationListener.h"
#import "RCTBridge.h"

@implementation RCTOrientationListener

@synthesize bridge = _bridge;

- (instancetype)init
{
    if ((self = [super init])) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    }
    return self;

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)deviceOrientationDidChange:(NSNotification *)notification
{

    UIDevice *currentDevice = [UIDevice currentDevice];
    UIDeviceOrientation orientation = [currentDevice orientation];

    NSString *orientationStr;
    NSString *preciseOrientationStr;
    switch (orientation) {
        case UIDeviceOrientationPortrait:
            preciseOrientationStr = @"PORTRAIT";
            orientationStr = @"PORTRAIT";
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            preciseOrientationStr = @"PORTRAIT-UPSIDE-DOWN";
            orientationStr = @"PORTRAIT";
            break;
        case UIDeviceOrientationLandscapeLeft:
            preciseOrientationStr = @"LANDSCAPE-LEFT";
            orientationStr = @"LANDSCAPE";
            break;
        case UIDeviceOrientationLandscapeRight:
            preciseOrientationStr = @"LANDSCAPE-RIGHT";
            orientationStr = @"LANDSCAPE";
            break;
        default:
            preciseOrientationStr = @"UNKNOWN";
            orientationStr = @"UNKNOWN";
            break;
    }

    NSString *deviceStr = [currentDevice model];

    [_bridge.eventDispatcher sendDeviceEventWithName:@"orientationDidChange"
                                                body:@{@"preciseOrientation": preciseOrientationStr, @"orientation": orientationStr, @"device": deviceStr}];
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(getOrientation:(RCTResponseSenderBlock)callback)
{

    UIDevice *currentDevice = [UIDevice currentDevice];
    UIDeviceOrientation orientation = [currentDevice orientation];

    NSString *orientationStr;
    NSString *preciseOrientationStr;
    switch (orientation) {
        case UIDeviceOrientationPortrait:
            preciseOrientationStr = @"PORTRAIT";
            orientationStr = @"PORTRAIT";
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            preciseOrientationStr = @"PORTRAIT-UPSIDE-DOWN";
            orientationStr = @"PORTRAIT";
            break;
        case UIDeviceOrientationLandscapeLeft:
            preciseOrientationStr = @"LANDSCAPE-LEFT";
            orientationStr = @"LANDSCAPE";
            break;
        case UIDeviceOrientationLandscapeRight:
            preciseOrientationStr = @"LANDSCAPE-RIGHT";
            orientationStr = @"LANDSCAPE";
            break;
        default:
            preciseOrientationStr = @"UNKNOWN";
            orientationStr = @"UNKNOWN";
            break;
    }

    NSString *deviceStr = [currentDevice model];

    NSArray *orientationArray = @[orientationStr, deviceStr, preciseOrientationStr];
    callback(orientationArray);
}

@end
