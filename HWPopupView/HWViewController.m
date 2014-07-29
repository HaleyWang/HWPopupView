//
//  HWViewController.m
//  HWPopupView
//
//  Created by Haley on 14-7-29.
//  Copyright (c) 2014年 haley. All rights reserved.
//

#import "HWViewController.h"

#import "BBJShareAlertView.h"

#import "HWActionView.h"
#import "HWAlertMenu.h"



@interface HWViewController ()


//弹出层
@property (nonatomic, strong) HWAlertMenu * sgAlertShareView;

@end

@implementation HWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}
- (IBAction)onclickPopupBtn:(id)sender {
    
    //if(self.sgAlertShareView == nil) {
    
        BBJShareAlertView * shareAlertView = [BBJShareAlertView initWithTitle:@"aa" andProfielPublicOption:YES andReferView:nil];
        
        shareAlertView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        
        
        self.sgAlertShareView = [[HWAlertMenu alloc] initWithAlertView:shareAlertView andMainView: nil andHeight: 275 ];
        self.sgAlertShareView.cancelBtn = shareAlertView.cancelBtn;
        
        
        NSString * titleStr = [NSString stringWithFormat:shareAlertView.bbjtitleLabel.text, @"jim"];
        
        shareAlertView.bbjtitleLabel.text = titleStr;
        //[shareAlertView.bbjtitleLabel setFont:FontFZYXJ(14)];
        [shareAlertView.bbjtitleLabel setFont:[UIFont systemFontOfSize:14]];
        [shareAlertView.bbjsubTitleLabel setFont:[UIFont systemFontOfSize:14]];
        [shareAlertView.bbjitemTitleLabel setFont:[UIFont systemFontOfSize:14]];
        
        [shareAlertView.bbjswitchView addTarget:self action:@selector(onProfilePublicValueChange:) forControlEvents:UIControlEventValueChanged];
        
        [shareAlertView.cancelBtn addTarget:self action:@selector(onCancelShareAlertView:) forControlEvents:UIControlEventTouchUpInside];

    //}


    [[HWActionView sharedActionView] setMenu:self.sgAlertShareView animation:YES];
    
}

- (IBAction)onCancelShareAlertView:(UISwitch *)sender {
    [[HWActionView sharedActionView] dismissMenu:self.sgAlertShareView Animated:YES];
}


- (IBAction)onProfilePublicValueChange:(UISwitch *)sender {
    
    if([sender isOn]) {
        
        [[HWActionView sharedActionView] dismissMenu:self.sgAlertShareView Animated:YES];
        //todo
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
