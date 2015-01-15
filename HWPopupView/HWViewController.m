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
    

    
    BBJShareAlertView * shareAlertView = [BBJShareAlertView initWithTitle:@"aa" andProfielPublicOption:YES andReferView:nil];
        

        

    self.sgAlertShareView = [[HWActionView sharedActionView] showView:shareAlertView animation:YES];
    
    
    [shareAlertView.bbjswitchView addTarget:self action:@selector(onProfilePublicValueChange:) forControlEvents:UIControlEventValueChanged];
    
    [shareAlertView.cancelBtn addTarget:self action:@selector(onCancelAlertView:) forControlEvents:UIControlEventTouchUpInside];
    [shareAlertView.doneBtn addTarget:self action:@selector(onDoneAlertView:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (IBAction)onDoneAlertView:(UISwitch *)sender {
    [[HWActionView sharedActionView] dismissView:self.sgAlertShareView Animated:YES];
}
- (IBAction)onCancelAlertView:(UISwitch *)sender {
    [[HWActionView sharedActionView] dismissView:self.sgAlertShareView Animated:YES];
}


- (IBAction)onProfilePublicValueChange:(UISwitch *)sender {
    
    if([sender isOn]) {
        
        //[[HWActionView sharedActionView] dismissView:self.sgAlertShareView Animated:YES];
        //todo
        NSLog(@"====== onProfilePublicValueChange");
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
