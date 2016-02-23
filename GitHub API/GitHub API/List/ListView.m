//
//  ListView.m
//  GitHub API
//
//  Created by Vaghula krishnan on 22/02/16.
//  Copyright © 2016 Vaghula krishnan. All rights reserved.
//

#import "ListView.h"
#import "ListViewController.h"
#import "AppMacros.h"
@interface ListView()


@end



@implementation ListView

@synthesize valueTotalOneDayOpen,ValueTotalOpen,valueTotalRestDayOpen,valueTotalSevenDayOpen;
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
    
    UILabel *titleTotalOpen=[[UILabel alloc]initWithFrame:CGRectMake(MarginLeftPadding, MarginTop, self.frame.size.width/2, LabelHeight)];
    titleTotalOpen.textAlignment=NSTextAlignmentJustified;
    titleTotalOpen.text=@"Total Open Issues";
    titleTotalOpen.numberOfLines=0;
    titleTotalOpen.lineBreakMode = NSLineBreakByCharWrapping;
    
    ValueTotalOpen=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2+MarginLeftFeildPadding, MarginTop, self.frame.size.width/2, LabelHeight)];
    ValueTotalOpen.textAlignment=NSTextAlignmentJustified;
    ValueTotalOpen.numberOfLines=0;
    ValueTotalOpen.lineBreakMode = NSLineBreakByCharWrapping;
    
    
    UILabel *titleTotalOneDayOpen=[[UILabel alloc]initWithFrame:CGRectMake(MarginLeftPadding, titleTotalOpen.frame.origin.y+titleTotalOpen.frame.size.height+MarginTopPadding,self.frame.size.width/2, LabelHeight)];
    titleTotalOneDayOpen.textAlignment=NSTextAlignmentJustified;
    titleTotalOneDayOpen.text=@"Total Open Issues in Last 24 Hours";
    titleTotalOneDayOpen.numberOfLines=0;
    titleTotalOneDayOpen.lineBreakMode = NSLineBreakByCharWrapping;
    
    valueTotalOneDayOpen=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2+MarginLeftFeildPadding, titleTotalOpen.frame.origin.y+titleTotalOpen.frame.size.height+MarginTopPadding,self.frame.size.width/2, LabelHeight)];
    valueTotalOneDayOpen.textAlignment=NSTextAlignmentJustified;
    valueTotalOneDayOpen.numberOfLines=0;
    valueTotalOneDayOpen.lineBreakMode = NSLineBreakByCharWrapping;

    
    UILabel *titleTotalSevenDayOpen=[[UILabel alloc]initWithFrame:CGRectMake(MarginLeftPadding, titleTotalOneDayOpen.frame.origin.y+titleTotalOneDayOpen.frame.size.height+MarginTopPadding,self.frame.size.width/2, LabelHeight)];
    titleTotalSevenDayOpen.textAlignment=NSTextAlignmentJustified;
    titleTotalSevenDayOpen.text=@"Total Open Issues More than 24 Hours Less Than 7 days";
    titleTotalSevenDayOpen.numberOfLines=0;
    titleTotalSevenDayOpen.lineBreakMode = NSLineBreakByWordWrapping;

    valueTotalSevenDayOpen=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2+MarginLeftFeildPadding, titleTotalOneDayOpen.frame.origin.y+titleTotalOneDayOpen.frame.size.height+MarginTopPadding,self.frame.size.width/2, LabelHeight)];
    valueTotalSevenDayOpen.textAlignment=NSTextAlignmentJustified;
    valueTotalSevenDayOpen.numberOfLines=0;
    valueTotalSevenDayOpen.lineBreakMode = NSLineBreakByWordWrapping;

    
    UILabel *titleTotalRestDayOpen=[[UILabel alloc]initWithFrame:CGRectMake(MarginLeftPadding, titleTotalSevenDayOpen.frame.origin.y+titleTotalSevenDayOpen.frame.size.height+MarginTopPadding,self.frame.size.width/2, LabelHeight)];
    titleTotalRestDayOpen.textAlignment=NSTextAlignmentJustified;
    titleTotalRestDayOpen.text=@"Total Open Issues before 7 days";
    titleTotalRestDayOpen.numberOfLines=0;
    titleTotalRestDayOpen.lineBreakMode = NSLineBreakByWordWrapping;

    valueTotalRestDayOpen=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2+MarginLeftFeildPadding, titleTotalSevenDayOpen.frame.origin.y+titleTotalSevenDayOpen.frame.size.height+MarginTopPadding,self.frame.size.width/2, LabelHeight)];
    valueTotalRestDayOpen.textAlignment=NSTextAlignmentJustified;
    valueTotalRestDayOpen.numberOfLines=0;
    valueTotalRestDayOpen.lineBreakMode = NSLineBreakByWordWrapping;
    
    
        [self addSubview:titleTotalOpen];
        [self addSubview:titleTotalOneDayOpen];
        [self addSubview:titleTotalSevenDayOpen];
        [self addSubview:titleTotalRestDayOpen];
    [self addSubview:ValueTotalOpen];
    [self addSubview:valueTotalOneDayOpen];
    [self addSubview:valueTotalSevenDayOpen];
    [self addSubview:valueTotalRestDayOpen];

}

@end