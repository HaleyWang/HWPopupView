

#import <QuartzCore/QuartzCore.h>

#import "HWAlertMenu.h"

#import "HWActionView.h"

#define kMAX_ALERT_MESSAGE_HEIGHT   300

@interface HWAlertMenu (){
    CGRect _sgAlertViewRect;
}

@end


@implementation HWAlertMenu


-(id)initWithAlertView:(UIView *) alertView andMainView: (UIView *) mainView andHeight:(int) height
{
    self = [self initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (self) {

        [self setupView:alertView andMainView:mainView andHeight: height];
    }
    return self;
}

- (void)setupView:(UIView *) alertView andMainView: (UIView *) mainView andHeight: (int) height
{

    _height = height;

    [self addSubview:alertView];
    
    [self setBackgroundColor:[UIColor clearColor]];

    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
    
    [self addGestureRecognizer:pan];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bounds = (CGRect){CGPointZero, CGSizeMake(self.bounds.size.width, _height)};
}

#pragma mark -
- (void)panHandle:(UIPanGestureRecognizer *)gesture
{
    static float startPoint_Y; //记录开始滑动时的 触控位置Y坐标
    float endPoint_Y;   //记录结束滑动时的 触控位置Y坐标
    static float viewPoint_Y;  //记录开始滑动时的 视图位置Y坐标
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            _sgAlertViewRect = self.frame;
            
            if(self.cancelBtn) {
                [self.cancelBtn setImage:[UIImage imageNamed:@"photoDetailNoteH"] forState:UIControlStateNormal];
            }
            
            startPoint_Y = [gesture locationInView:window].y;
            viewPoint_Y  = self.frame.origin.y;
            
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            endPoint_Y   = [gesture locationInView:window].y;
            float gPoint = viewPoint_Y + (endPoint_Y - startPoint_Y);
            self.frame = CGRectMake(0, gPoint, self.frame.size.width, self.frame.size.height);// gPoint;
            [gesture setTranslation:CGPointZero inView:window];

        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGRect rect = self.frame;
            
            BOOL hide = NO;
            if(self.cancelBtn) {
                [self.cancelBtn setImage:[UIImage imageNamed:@"photoDetailNoteDown"] forState:UIControlStateNormal];
            }
            
            if (rect.origin.y >= _sgAlertViewRect.origin.y) //处理 视图 在屏幕上边沿滑动时的情况
            {
                if (rect.origin.y >= (window.frame.size.height -(_height - 50)))
                {
                    rect.origin.y = window.frame.size.height ;
                    hide = YES;
                }
                else
                {
                    rect = _sgAlertViewRect;
                }
            }
            else                    //处理 视图 在屏幕下边沿滑动时的情况
            {
                rect = _sgAlertViewRect;
            }
            
            if(hide){
                [[HWActionView sharedActionView] dismissMenu:self Animated:YES];
            }else {

                //简单的过度动画
                [UIView animateWithDuration:.3f animations:^{
                    [self setFrame:rect];
                } completion:^(BOOL finished) {
                    //视图位置自动校正后，如果其位于 上边沿 屏幕外 置其于下
                }];
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
        {
            NSLog(@"====oh NO===滑动被取消了");
            
            /*********************************************
             * 不排除有，pan事件被中断的可能，处理同stateEnded *
             *********************************************/
            [UIView animateWithDuration:.3f animations:^{
                [self setFrame:_sgAlertViewRect];
            } completion:^(BOOL finished) {
                //视图位置自动校正后，如果其位于 上边沿 屏幕外 置其于下
            }];
        }
            break;
        default:
            break;
    }
    
}


@end
