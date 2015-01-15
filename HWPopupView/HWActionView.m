

#import "HWActionView.h"
#import "HWAlertMenu.h"
#import <QuartzCore/QuartzCore.h>


@interface HWActionView () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSMutableArray *menus;
@property (nonatomic, strong) CAAnimation *showMenuAnimation;
@property (nonatomic, strong) CAAnimation *dismissMenuAnimation;
@property (nonatomic, strong) CAAnimation *dimingAnimation;
@property (nonatomic, strong) CAAnimation *lightingAnimation;
// 点击背景取消
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@end

@implementation HWActionView

+ (HWActionView *)sharedActionView
{
    static HWActionView *actionView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGRect rect = [[UIScreen mainScreen] bounds];
        actionView = [[HWActionView alloc] initWithFrame:rect];
    });
    
    return actionView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _menus = [NSMutableArray array];
        
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        _tapGesture.delegate = self;
        [self addGestureRecognizer:_tapGesture];
    }
    return self;
}

- (void)dealloc{
    [self removeGestureRecognizer:_tapGesture];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGesture{
    CGPoint touchPoint = [tapGesture locationInView:self];

    HWAlertMenu *menu = self.menus.lastObject;
    if (!CGRectContainsPoint(menu.frame, touchPoint)) {
        [[HWActionView sharedActionView] dismissView:menu Animated:YES];
        [self.menus removeObject:menu];
    }
}



#pragma mark -

- (HWAlertMenu *)showView:(UIView *)view animation:(BOOL)animated{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (![self superview]) {

        //self.backgroundColor = [UIColor clearColor];
        [window addSubview:self];
    }
    
    view.frame = CGRectMake(0, 0, window.bounds.size.width, window.bounds.size.height);
    
    UIView * menu = [[HWAlertMenu alloc] initWithAlertView:view andMainView: nil andHeight: 275 ];
    
    HWAlertMenu *topMenu = (HWAlertMenu *)menu;
    
    [self.menus makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.menus addObject:topMenu];
    

    [self addSubview:topMenu];
    [topMenu layoutIfNeeded];
    topMenu.frame = (CGRect){CGPointMake(0, self.bounds.size.height - topMenu.bounds.size.height), topMenu.bounds.size};
    
 
    
    if (animated && self.menus.count == 1) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.2];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        
        [self.layer addAnimation:self.dimingAnimation forKey:@"diming"];
        [topMenu.layer addAnimation:self.showMenuAnimation forKey:@"showMenu"];
        [CATransaction commit];
    }
    return menu;
}

- (void)dismissView:(HWAlertMenu *)menu Animated:(BOOL)animated
{
    if ([self superview]) {
        [self.menus removeObject:menu];
        if (animated && self.menus.count == 0) {
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.3];
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
            [CATransaction setCompletionBlock:^{
                [self removeFromSuperview];
                [menu removeFromSuperview];
            }];
            //[self.layer addAnimation:self.lightingAnimation forKey:@"lighting"];
            [menu.layer addAnimation:self.dismissMenuAnimation forKey:@"dismissMenu"];
            [CATransaction commit];
        }else{
            
            [menu removeFromSuperview];
            [menu.layer removeFromSuperlayer];

            HWAlertMenu *topMenu = self.menus.lastObject;
 
            [self addSubview:topMenu];
            [topMenu layoutIfNeeded];
            topMenu.frame = (CGRect){CGPointMake(0, self.bounds.size.height - topMenu.bounds.size.height), topMenu.bounds.size};
        }
    }
}

#pragma mark -背景灰色
- (CAAnimation *)dimingAnimation
{
    if (_dimingAnimation == nil) {
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        opacityAnimation.fromValue = (id)[[UIColor colorWithWhite:0.0 alpha:0.0] CGColor];
        opacityAnimation.toValue = (id)[[UIColor colorWithWhite:0.0 alpha:0.4] CGColor];
        [opacityAnimation setRemovedOnCompletion:NO];
        [opacityAnimation setFillMode:kCAFillModeBoth];
        _dimingAnimation = opacityAnimation;
    }
    return _dimingAnimation;
}
#pragma mark -背景灰色
- (CAAnimation *)lightingAnimation
{
    if (_lightingAnimation == nil ) {
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        opacityAnimation.fromValue = (id)[[UIColor colorWithWhite:0.0 alpha:0.4] CGColor];
        opacityAnimation.toValue = (id)[[UIColor colorWithWhite:0.0 alpha:0.0] CGColor];
        [opacityAnimation setRemovedOnCompletion:NO];
        [opacityAnimation setFillMode:kCAFillModeBoth];
        _lightingAnimation = opacityAnimation;
    }
    return _lightingAnimation;
}

#pragma mark -显示动画
- (CAAnimation *)showMenuAnimation
{
    if (_showMenuAnimation == nil) {
        
        
        CATransition *animation = [CATransition animation];

        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.fillMode = kCAFillModeForwards;
        
        animation.type = kCATransitionPush;
        
        animation.subtype = kCATransitionFromTop;

        _showMenuAnimation = animation;
    }
    return _showMenuAnimation;
}

#pragma mark -隐藏动画
- (CAAnimation *)dismissMenuAnimation
{
    if (_dismissMenuAnimation == nil) {
        
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        [positionAnimation setFromValue:[NSNumber numberWithFloat:0.0]];
        [positionAnimation setToValue:[NSNumber numberWithFloat:300.0]];

        _dismissMenuAnimation = positionAnimation;

    }
    return _dismissMenuAnimation;
}


@end
