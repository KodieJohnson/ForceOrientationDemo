//
//  ViewController.m
//  ForceOrientationDemo
//
//  Created by KODIE on 2018/1/10.
//  Copyright © 2018年 kodie. All rights reserved.
//

#import "ViewController.h"
#import "UIDevice+TFDevice.h"
#import "AppDelegate.h"

@interface ViewController ()
@property(nonatomic, weak) UIButton *forceLandscapeBtn;
@property(nonatomic, weak) UIButton *forcePortraitBtn;
@property(nonatomic, weak) UIView *maskView;
@end

@implementation ViewController

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    _maskView.center = self.view.center;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initConfig];
    [self addMaskView];
    [self addForcePortraitBtn];
    [self addForceLandscapeBtn];
    [self setInitialBtnsStatus];
}
- (void)initConfig{
    self.view.backgroundColor = [UIColor colorWithRed:218/255.0 green:98/255.0 blue:73/255.0 alpha:1.0];
}
- (void)addMaskView{
    UIView *maskView = [[UIView alloc] init];
    maskView.frame = CGRectMake(0, 0, 200, 150);
    maskView.center = self.view.center;
    [self.view addSubview:maskView];
    maskView.backgroundColor = [UIColor clearColor];
    _maskView = maskView;
}
- (void)addForcePortraitBtn{
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(0, 0, 200, 50);
    btn.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = YES;
    [_maskView addSubview:btn];
    [btn setTitle:@"点我强制竖屏" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:218/255.0 green:98/255.0 blue:73/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickForcePortraitBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _forcePortraitBtn = btn;
}
- (void)addForceLandscapeBtn{
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = CGRectMake(0, 100, 200, 50);
    btn.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = YES;
    [_maskView addSubview:btn];
    [btn setTitle:@"点我强制横屏" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:218/255.0 green:98/255.0 blue:73/255.0 alpha:1.0] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickForceLandscapeBtn) forControlEvents:UIControlEventTouchUpInside];
    
    _forceLandscapeBtn = btn;
}
- (void)didClickForceLandscapeBtn{
    _forceLandscapeBtn.selected = !_forceLandscapeBtn.selected;
    _forceLandscapeBtn.userInteractionEnabled = !_forceLandscapeBtn.selected;
    _forcePortraitBtn.selected = !_forceLandscapeBtn.selected;
    _forcePortraitBtn.userInteractionEnabled = !_forcePortraitBtn.selected;
    
    _forcePortraitBtn.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    _forceLandscapeBtn.backgroundColor = [UIColor lightGrayColor];
    [self forceOrientationLandscape];
}
- (void)didClickForcePortraitBtn{
    _forcePortraitBtn.selected = !_forcePortraitBtn.selected;
    _forcePortraitBtn.userInteractionEnabled = !_forcePortraitBtn.selected;
    _forceLandscapeBtn.selected = !_forcePortraitBtn.selected;
    _forceLandscapeBtn.userInteractionEnabled = !_forceLandscapeBtn.selected;
    
    _forceLandscapeBtn.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    _forcePortraitBtn.backgroundColor = [UIColor lightGrayColor];
    [self forceOrientationPortrait];
}
- (void)setInitialBtnsStatus{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            _forcePortraitBtn.selected = YES;
            _forcePortraitBtn.userInteractionEnabled = !_forcePortraitBtn.selected;
            _forceLandscapeBtn.selected = !_forcePortraitBtn.selected;
            _forceLandscapeBtn.userInteractionEnabled = !_forceLandscapeBtn.selected;
            
            _forceLandscapeBtn.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
            _forcePortraitBtn.backgroundColor = [UIColor lightGrayColor];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
        {
            _forceLandscapeBtn.selected = YES;
            _forceLandscapeBtn.userInteractionEnabled = !_forceLandscapeBtn.selected;
            _forcePortraitBtn.selected = !_forceLandscapeBtn.selected;
            _forcePortraitBtn.userInteractionEnabled = !_forcePortraitBtn.selected;
            
            _forcePortraitBtn.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
            _forceLandscapeBtn.backgroundColor = [UIColor lightGrayColor];
        }
            break;
        default:
            //UIInterfaceOrientationUnknown
            break;
    }
}

#pragma  mark - 强制横竖屏设置(这个要结合Appdelegate进行处理)
- (void)forceOrientationLandscape { //强制横屏
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.isForcePortrait = NO;
    appDelegate.isForceLandscape = YES;
    [UIDevice switchNewOrientation:UIInterfaceOrientationLandscapeRight];
}
- (void)forceOrientationPortrait  { //强制竖屏
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.isForcePortrait = YES;
    appDelegate.isForceLandscape = NO;
    [UIDevice switchNewOrientation:UIInterfaceOrientationPortrait];
}

@end
