//
//  searchView.h
//  GitHub API
//
//  Created by Vaghula krishnan on 22/02/16.
//  Copyright © 2016 Vaghula krishnan. All rights reserved.
//

#import "GithubApiBaseView.h"

@class GithubSearchClass;

// define the protocol for the delegate
@protocol GithubSearchClassDelegate

// define protocol functions that can be used in any class using this delegate
-(void) onclickFetchWithUrl:(NSString *)url;


@end
@interface searchView : GithubApiBaseView

@property (nonatomic, assign) id<GithubSearchClassDelegate> delegate;


@end