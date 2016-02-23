//
//  searchView.m
//  GitHub API
//
//  Created by Vaghula krishnan on 22/02/16.
//  Copyright © 2016 Vaghula krishnan. All rights reserved.
//

#import "searchView.h"
#import "searchViewController.h"
#import "AppMacros.h"
@interface searchView()<UITextFieldDelegate>
{
        UIButton *buttonGetStarted;
    UIButton *buttonLoad;
    UITextField *githuburl;
}

@end



@implementation searchView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createViews];
    }
    return self;
}


-(void) createViews
{
    
    self.backgroundColor=[UIColor whiteColor];
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-ImageWidth)/2,ImageTop, ImageWidth ,ImageHeight)];
    bgImageView.image =[UIImage imageNamed:@"codercat"];
    [self addSubview:bgImageView];
    githuburl=[[UITextField alloc]initWithFrame:CGRectMake(MarginLeft,self.frame.size.height/2, self.frame.size.width-(2*MarginLeft), TextFeildHeight)];
    [githuburl setCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)];
    githuburl.textAlignment=NSTextAlignmentCenter;
    githuburl.textColor=[UIColor whiteColor];
    githuburl.borderStyle = UITextBorderStyleRoundedRect;
    githuburl.autocorrectionType = UITextAutocorrectionTypeNo;
    githuburl.keyboardType = UIKeyboardTypeDefault;
    githuburl.returnKeyType = UIReturnKeyDone;
    githuburl.clearButtonMode = UITextFieldViewModeWhileEditing;
    githuburl.delegate=self;
    githuburl.backgroundColor=[UIColor grayColor];
    githuburl.placeholder=@"Enter the GitHub URL";
    
    buttonGetStarted=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonGetStarted setFrame:CGRectMake((self.frame.size.width - BtnWidth)/2, githuburl.frame.origin.y+githuburl.frame.size.height+Spacing,BtnWidth, BtnHeight)];
    [buttonGetStarted addTarget:self action:@selector(onclickFetch) forControlEvents:UIControlEventTouchUpInside];
    [buttonGetStarted setTitle:@"Fetch Issues" forState:UIControlStateNormal];
    [buttonGetStarted setExclusiveTouch:YES];
    [buttonGetStarted setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    buttonGetStarted.layer.cornerRadius = 2;
    buttonGetStarted.layer.borderWidth = 1;
    buttonGetStarted.layer.borderColor = buttonGetStarted.tintColor.CGColor;
   
    buttonLoad=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buttonLoad setFrame:CGRectMake((self.frame.size.width - BtnWidth150)/2, buttonGetStarted.frame.origin.y+buttonGetStarted.frame.size.height+Spacing,BtnWidth150, BtnHeight)];
    [buttonLoad addTarget:self action:@selector(onclickLoad) forControlEvents:UIControlEventTouchUpInside];
    [buttonLoad setTitle:@"Load Sample URL" forState:UIControlStateNormal];
    [buttonLoad setExclusiveTouch:YES];
    [buttonLoad setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [self setUserInteractionEnabled:YES];
    [self addGestureRecognizer:singleTap];
    [self addSubview:githuburl];
    [self addSubview:buttonGetStarted];
    [self addSubview:buttonLoad];
}

-(void) onclickFetch{
    [self.delegate onclickFetchWithUrl:githuburl.text];
}
-(void)onclickLoad{
   githuburl.text=@"https://github.com/Shippable/support/issues";
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}
-(void)tapDetected{
   
    [self endEditing:YES];
   
}
@end