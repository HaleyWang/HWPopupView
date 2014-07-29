

#import <UIKit/UIKit.h>

@class HWAlertMenu;


@interface HWActionView : UIView


/**
 *  获取单例
 */
+ (HWActionView *)sharedActionView;

//显示
- (void)setMenu:(UIView *)menu animation:(BOOL)animated;

//移除
- (void)dismissMenu:(HWAlertMenu *)menu Animated:(BOOL)animated;


@end
