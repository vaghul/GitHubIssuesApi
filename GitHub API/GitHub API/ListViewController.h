//
//  ListViewController.h
//  GitHub API
//
//  Created by Vaghula krishnan on 22/02/16.
//  Copyright © 2016 Vaghula krishnan. All rights reserved.
//


#import "ListView.h"
#import "ListModel.h"
#import"GithubApiBaseViewController.h"

@interface ListViewController : GithubApiBaseViewController

@property (nonatomic) NSInteger TotalOpenIssues;
@property (nonatomic) NSInteger TotalOneDayIssues;
@property (nonatomic) NSInteger TotalSevenDayIssues;
@property (nonatomic) NSInteger TotalOtherDayIssues;
@end