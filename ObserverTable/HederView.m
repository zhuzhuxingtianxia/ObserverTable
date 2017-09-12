//
//  HederView.m
//  ObserverTable
//
//  Created by Jion on 2017/7/19.
//  Copyright © 2017年 天天. All rights reserved.
//

#import "HederView.h"
@interface HederView()
{
    CGFloat sizeH;
   __weak UIViewController *currentVC;
}
@property(nonatomic,strong)UIImageView  *bgImgView;
@end
@implementation HederView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //self.backgroundColor = [UIColor orangeColor];
        self.bgImgView.frame = self.bounds;
        [self addSubview:self.bgImgView];
        sizeH = self.bgImgView.bounds.size.height;
    }
    return self;
}

-(void)setSource:(id)source{
    if (!source) {
        NSAssert(YES, @"source不能为空");
        return;
    }
    
    if (_source) {
        [self.superview removeObserver:self forKeyPath:@"contentOffset" context:(__bridge void * _Nullable)(NSStringFromClass([self class]))];
    }
    _source = source;
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        currentVC = [self currentViewController];
        [self.superview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:(__bridge void * _Nullable)(NSStringFromClass([self class]))]; 
        
    }
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        //NSLog(@"observe == %@",NSStringFromCGPoint(((UIScrollView*)self.superview).contentOffset));
        id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
        CGPoint oldPoint;
        [(NSValue*)oldValue getValue:&oldPoint];
        
        id value = [change objectForKey:NSKeyValueChangeNewKey];
        CGPoint point = [(NSValue*)value CGPointValue];
        [self zoomSetting:point.y];
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

-(void)zoomSetting:(CGFloat)y{
    //NSLog(@"y==%f",y);
    CGFloat changeH;
    if (currentVC.navigationController.navigationBarHidden || !currentVC ||!currentVC.navigationController) {
        changeH = y;
    }else{
       changeH = y+64;
    }
    CGFloat cazle = (sizeH-changeH)/sizeH;
    if (cazle>1.0) {
        self.bgImgView.frame = CGRectMake(changeH, changeH, self.bounds.size.width*cazle, self.bounds.size.height*cazle);
        //self.bgImgView.transform = CGAffineTransformMakeScale(cazle, cazle);
        
    }else{
       self.bgImgView.frame = CGRectMake(0, changeH, self.bounds.size.width, self.bounds.size.height*cazle);
    }
}

-(UIImageView*)bgImgView{
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] init];
        //_bgImgView.contentMode = UIViewContentModeScaleAspectFit;
        _bgImgView.image = [UIImage imageNamed:@"accoutSingin"];
    }
    return _bgImgView;
}

- (UIViewController *)currentViewController{
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = [[UIApplication sharedApplication] keyWindow].rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}



-(void)dealloc{
    NSLog(@"dealloc remove == %@",self.superview);
}

@end
