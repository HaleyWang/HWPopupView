//
//  BBJShareAlertView.m
//  Test
//
//  Created by Haley on 14-7-24.
//  Copyright (c) 2014年 crte. All rights reserved.
//

#import "BBJShareAlertView.h"


@implementation BBJShareAlertView


+ (id)initWithTitle:(NSString *)title andReferView:(UIView *)referView {
    
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"BBJShareAlertView" owner:nil options:nil];
    
    BBJShareAlertView* view = [nibView objectAtIndex:0];
    view.referView = referView;
    
    return view;
}


@end
