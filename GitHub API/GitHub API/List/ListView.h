//
//  ListView.h
//  GitHub API
//
//  Created by Vaghula krishnan on 22/02/16.
//  Copyright © 2016 Vaghula krishnan. All rights reserved.
//

#import"GithubApiBaseView.h"

@interface ListView : GithubApiBaseView

@property (nonatomic,strong) UILabel *ValueTotalOpen;
@property (nonatomic,strong) UILabel *valueTotalOneDayOpen;
@property (nonatomic,strong) UILabel *valueTotalSevenDayOpen;
@property (nonatomic,strong) UILabel *valueTotalRestDayOpen;

@end