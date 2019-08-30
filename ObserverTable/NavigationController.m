//
//  NavigationController.m
//  ObserverTable
//
//  Created by ZZJ on 2019/7/23.
//  Copyright © 2019 天天. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)self.navigationBar.translucent = NO;
    self.interactivePopGestureRecognizer.delegate = self;
    
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationBar setBackgroundImage:[self imageWithColor:[UIColor clearColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)] forBarMetrics:UIBarMetricsDefault];
    
}

// 实现代理方法
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // 判断如果不是根控制器 才需要pop返回手势
    return self.childViewControllers.count > 1;
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <=0 || size.height <=0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
