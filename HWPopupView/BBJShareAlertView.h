//
//  BBJShareAlertView.h
//  Test
//
//  Created by Haley on 14-7-24.
//  Copyright (c) 2014年 crte. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BBJShareAlertView : UIView

@property (strong, nonatomic) IBOutlet UIButton *cancelBtn;
@property (strong, nonatomic) IBOutlet UIButton *doneBtn;

@property (strong, nonatomic) IBOutlet UILabel *bbjtitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bbjsubTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *bbjitemTitleLabel;



@property (strong, nonatomic) IBOutlet UISwitch *bbjswitchView;

//将要显示在该视图上
@property (nonatomic, weak) UIView *referView;


//是否正在显示
@property (nonatomic, getter = isShowing) BOOL show;


+ (id)initWithTitle:(NSString *)title andReferView:(UIView *)referView;



@end
