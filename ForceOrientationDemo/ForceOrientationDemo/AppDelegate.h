//
//  AppDelegate.h
//  ForceOrientationDemo
//
//  Created by KODIE on 2018/1/10.
//  Copyright © 2018年 kodie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, assign) BOOL isForcePortrait;
@property(nonatomic, assign) BOOL isForceLandscape;

@end

