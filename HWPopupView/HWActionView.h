

#import <UIKit/UIKit.h>

@class HWAlertMenu;


@interface HWActionView : UIView


/**
 *  获取单例
 */
+ (HWActionView *)sharedActionView;

//显示
- (HWAlertMenu *) showView:(UIView *)menu animation:(BOOL)animated;

//移除
- (void)dismissView:(HWAlertMenu *)menu Animated:(BOOL)animated;


@end
