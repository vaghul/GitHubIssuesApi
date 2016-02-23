//
//  ListViewController.m
//  GitHub API
//
//  Created by Vaghula krishnan on 22/02/16.
//  Copyright © 2016 Vaghula krishnan. All rights reserved.
//

#import "ListViewController.h"
#import "ListView.h"

@interface ListViewController ()

@end

@implementation ListViewController

-(id) init
{
    self=[super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ListView *list=[[ListView alloc]initWithFrame:self.view.frame];
    list.ValueTotalOpen.text=[NSString stringWithFormat:@": %d",(int)self.TotalOpenIssues];
    list.valueTotalOneDayOpen.text=[NSString stringWithFormat:@": %d",(int)self.TotalOneDayIssues];
    list.valueTotalSevenDayOpen.text=[NSString stringWithFormat:@": %d",(int)self.TotalSevenDayIssues];
    list.valueTotalRestDayOpen.text=[NSString stringWithFormat:@": %d",(int)self.TotalOtherDayIssues];
    self.view=list;
    self.title=@"Issues List";
    
    // Do any additional setup after loading the view, typically from a nib.
}
@end