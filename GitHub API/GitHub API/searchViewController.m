//
//  searchViewController.m
//  GitHub API
//
//  Created by Vaghula krishnan on 22/02/16.
//  Copyright © 2016 Vaghula krishnan. All rights reserved.
//

#import "searchViewController.h"
#import "searchView.h"
#import "ListViewController.h"
@interface searchViewController ()
{
    NSInteger TotalOpenIssues;
    NSInteger TotalOneDayIssues;
    NSInteger TotalSevenDayIssues;
    int completeFlag;
    int errorcode;
     UIAlertController *alertView;
    
}
@end

@implementation searchViewController

-(id) init
{
    self=[super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    searchView *search=[[searchView alloc]initWithFrame:self.view.frame];
    search.delegate=self;
    self.view=search;
    self.title=@"GitHub API";
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma  mark - Custom Delegates

-(void)onclickFetchWithUrl:(NSString *)url
{
    if([url containsString:@"github.com"])
    {
        NSArray * temp=[url componentsSeparatedByString:@"github.com"];
        NSString * urlvalue=[self checkLastObject:[temp objectAtIndex:1] with:@"issues"];  // check if last values is issues else append issues
        NSUInteger numberOfOccurrences = [[urlvalue componentsSeparatedByString:@"/"] count] - 1; //check if the url formation is complete
       if(numberOfOccurrences !=3)
       {
           [self alertmessage:@"please provide a correct format" withtitle:@"Invalid format"];

       }
       else{
           completeFlag=0;
           errorcode=0;
           [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
           alertView = [UIAlertController alertControllerWithTitle:@""
                                                           message: @""
                                                    preferredStyle:UIAlertControllerStyleAlert];
           [self presentViewController:alertView animated:YES completion:nil];
        
           // Constructing total issues api
           NSString *targetURLString =[NSString stringWithFormat:@"https://api.github.com/repos%@?state=open&per_page=100",urlvalue];
           alertView.title=@"Fetching issues from GitHub!";
           //excuting in thread
           [self hitServerWithRecursion:YES forUrl:targetURLString];
    
           // Constructing one day issues api
           NSString *sincedate=[self getdate:@"One"];
           targetURLString=[NSString stringWithFormat:@"%@&since=%@",targetURLString,sincedate];
           //excuting thread
           [self getOneDayWithRecur:YES forUrl:targetURLString];

           // Constructing seven day issues api
           sincedate=[self getdate:@"Seven"];
           targetURLString=[NSString stringWithFormat:@"%@&since=%@",targetURLString,sincedate];
           //executing thread
           [self getSevenDayWithRecur:YES forUrl:targetURLString];
    
        }
    }    // end of check github
    else
    {
        [self alertmessage:@"please provide a GitHub Link" withtitle:@"Invalid Link"];
    }
}

#pragma mark - Get Total Issues Thread 1

-(void)hitServerWithRecursion:(BOOL) isrecur forUrl:(NSString *)targetURLString
{
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:targetURLString]];
    request.HTTPMethod=@"GET";
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request
                                          completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                              
                                              if(!error){
                                                  NSHTTPURLResponse *httpresp=(NSHTTPURLResponse *)response;
                                                  if(httpresp.statusCode==200)
                                                  {
                                                      NSString *finalTarget;
                                                      if (isrecur)
                                                      {
                                                          NSDictionary *header= [httpresp allHeaderFields];
                                                          NSArray *linkarray=[[header objectForKey:@"Link"] componentsSeparatedByString:@","];   // fetching the Link values from the http responce header
                                                          NSMutableDictionary *linkdictonary= [[NSMutableDictionary alloc]initWithCapacity:10];
                                                          for (int i=0; i<linkarray.count; i++)
                                                          {
                                                              NSArray *temparray=[[linkarray objectAtIndex:i] componentsSeparatedByString:@";"];
                                                              [linkdictonary setObject:[temparray objectAtIndex:0] forKey:[NSString stringWithFormat:@"link%d",i]];   // creating a dictionary of Links in header
                                                          }
                                                          finalTarget=[linkdictonary objectForKey:[NSString stringWithFormat:@"link%d",(int)linkarray.count-1]];  // generating the final page api link
                                                          finalTarget=[finalTarget substringWithRange:NSMakeRange(2, [finalTarget length]-3)];
                                                      }
                                                      NSInteger prevCount;
                                                      NSDictionary *dataDictionary =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]; // extracting the JSON data from the responce
                                                      if(!isrecur) // checking if the link is the last page
                                                      {
                                                          NSArray *targetArray=[targetURLString componentsSeparatedByString:@"="]; //splitng the page number value
                                                          prevCount =[[targetArray objectAtIndex:targetArray.count-1]integerValue];
                                                          prevCount=(prevCount-1)*100;
                                                          TotalOpenIssues=dataDictionary.count+prevCount;
                                                      }
                                                      else{
                                                          prevCount=0;
                                                          TotalOpenIssues=dataDictionary.count+prevCount;
                                                      }
                                                      if (finalTarget)  //if there is a last page link
                                                      {
                                                          [self hitServerWithRecursion:NO forUrl:finalTarget];
                                                      }
                                                      else
                                                      {
                                                          completeFlag++;
                                                          [self checkOperationComplete]; // check for thread completion operation.
                                                      }
                                                  }
                                                  else  // if there is a error
                                                  {
                                                      errorcode=(int)httpresp.statusCode;
                                                      [self checkOperationComplete];
                                                  }
                                              }
                                          }];
    
    [task resume];

}
#pragma mark - Get day Issues Thread 2

-(void) getOneDayWithRecur:(BOOL) isrecur forUrl:(NSString *)targetURLString
{
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:targetURLString]];
    request.HTTPMethod=@"GET";
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request
                                          completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                              
                                              if(!error){
                                                  NSHTTPURLResponse *httpresp=(NSHTTPURLResponse *)response;
                                                  if(httpresp.statusCode==200)
                                                  {
                                                      NSString *finalTarget;
                                                      if (isrecur)
                                                      {
                                                          NSDictionary *header= [httpresp allHeaderFields];
                                                          NSArray *linkarray=[[header objectForKey:@"Link"] componentsSeparatedByString:@","]; // fetching the Link values from the http responce header
                                                          NSMutableDictionary *linkdictonary= [[NSMutableDictionary alloc]initWithCapacity:10];
                                                          for (int i=0; i<linkarray.count; i++)
                                                          {
                                                              NSArray *temparray=[[linkarray objectAtIndex:i] componentsSeparatedByString:@";"];
                                                              [linkdictonary setObject:[temparray objectAtIndex:0] forKey:[NSString stringWithFormat:@"link%d",i]]; // creating a dictionary of Links in header
                                                          }
                                                         finalTarget =[linkdictonary objectForKey:[NSString stringWithFormat:@"link%d",(int)linkarray.count-1]]; // generating the final page api link
                                                         finalTarget=[finalTarget substringWithRange:NSMakeRange(2, [finalTarget length]-3)];
                                                      }
                                                      NSInteger prevCount;
                                                      NSDictionary *dataDictionary =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];// extracting the JSON data from the responce

                                                      if(!isrecur)// checking if the link is the last page
                                                      {
                                                          NSArray *targetArray=[targetURLString componentsSeparatedByString:@"="];//splitng the page number value
                                                          prevCount =[[targetArray objectAtIndex:targetArray.count-1]integerValue];
                                                          prevCount=(prevCount-1)*100;
                                                          TotalOneDayIssues=dataDictionary.count+prevCount;
                                                      }
                                                      else{
                                                            prevCount=0;
                                                            TotalOneDayIssues=dataDictionary.count+prevCount;
                                                          }
                                                          if (finalTarget)//if there is a last page link
                                                          {
                                                              [self getOneDayWithRecur:NO forUrl:finalTarget];
                                                          }
                                                          else{
                                                              completeFlag++;
                                                              [self checkOperationComplete]; // check for thread completion operation.
                                                          }
                                                      
                                                  }
                                              }
                                          }];
    
    [task resume];

}

#pragma mark - Get seven day issues Thread 3
-(void) getSevenDayWithRecur:(BOOL) isrecur forUrl:(NSString *)targetURLString
{
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:targetURLString]];
    request.HTTPMethod=@"GET";
    NSURLSession *session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request
                                          completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                              
                                              if(!error){
                                                  NSHTTPURLResponse *httpresp=(NSHTTPURLResponse *)response;
                                                  if(httpresp.statusCode==200)
                                                  {
                                                      NSString *finalTarget;
                                                      if (isrecur)
                                                      {
                                                          NSDictionary *header= [httpresp allHeaderFields];
                                                          NSArray *linkarray=[[header objectForKey:@"Link"] componentsSeparatedByString:@","];  // fetching the Link values from the http responce header
                                                          NSMutableDictionary *linkdictonary= [[NSMutableDictionary alloc]initWithCapacity:10];
                                                          for (int i=0; i<linkarray.count; i++)
                                                          {
                                                              NSArray *temparray=[[linkarray objectAtIndex:i] componentsSeparatedByString:@";"];
                                                              [linkdictonary setObject:[temparray objectAtIndex:0] forKey:[NSString stringWithFormat:@"link%d",i]];// creating a dictionary of Links in header
                                                          }
                                                      
                                                          finalTarget =[linkdictonary objectForKey:[NSString stringWithFormat:@"link%d",(int)linkarray.count-1]];// generating the final page api link
                                                          finalTarget=[finalTarget substringWithRange:NSMakeRange(2, [finalTarget length]-3)];
                                                      }
                                                      NSInteger prevCount;
                                                      NSDictionary *dataDictionary =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];// extracting the JSON data from the responce

                                                      if(!isrecur)// checking if the link is the last page
                                                      {
                                                          NSArray *targetArray=[targetURLString componentsSeparatedByString:@"="];//splitng the page number value
                                                          prevCount =[[targetArray objectAtIndex:targetArray.count-1]integerValue];
                                                          prevCount=(prevCount-1)*100;
                                                          TotalSevenDayIssues=dataDictionary.count+prevCount;
                                                        }else
                                                        {
                                                          prevCount=0;
                                                          TotalSevenDayIssues=dataDictionary.count+prevCount;

                                                        }
                                                        if(finalTarget)//if there is a last page link
                                                        {
                                                              [self getSevenDayWithRecur:NO forUrl:finalTarget];
                                                        }else
                                                        {
                                                            completeFlag++;
                                                            [self checkOperationComplete];// check for thread completion operation.
                                                      }
                                                    }
                                              }
                                          }];
    
    [task resume];
    
}

#pragma mark - Custom Methods

-(NSString *)checkLastObject:(NSString *) object with:(NSString *) value  // check if the last formatted value matches "issues"
{
    if([object  hasSuffix:@"/"])
        object=[object substringToIndex:[object length]-1];
    NSArray *temp=[object componentsSeparatedByString:@"/"];
    if([temp.lastObject isEqualToString:value])
        return object;
    else
        return[NSString stringWithFormat:@"%@/%@",object,value];
    
}

-(void)checkOperationComplete   // check for completion of thread
{
    if(completeFlag==3) //thread completed
    {
        dispatch_async(dispatch_get_main_queue(), ^{
        [alertView dismissViewControllerAnimated:YES completion:nil];
         });
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        NSLog(@"completed");
        ListViewController *nextPage=[[ListViewController alloc]init];
        nextPage.TotalOneDayIssues=TotalOneDayIssues;
        nextPage.TotalOpenIssues=TotalOpenIssues;
        nextPage.TotalSevenDayIssues=TotalSevenDayIssues-TotalOneDayIssues;
        nextPage.TotalOtherDayIssues=TotalOpenIssues-TotalOneDayIssues-TotalSevenDayIssues;
        NSLog(@"total open issues %ld",TotalOpenIssues);
        NSLog(@"total one day issues %ld",TotalOneDayIssues);
        NSLog(@"total seven day issues %ld",TotalSevenDayIssues-TotalOneDayIssues);
        NSLog(@"total more than seven day issues %ld",TotalOpenIssues-TotalOneDayIssues-TotalSevenDayIssues);
         [self.navigationController pushViewController:nextPage animated:YES];
    }
    if(errorcode==404) // error int the link
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertView dismissViewControllerAnimated:YES completion:nil];
        });
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        [self alertmessage:@"The Repo Doesnt not exist" withtitle:@"Repo Not Found"];
    }
    else if(errorcode!=0)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [alertView dismissViewControllerAnimated:YES completion:nil];
        });
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        [self alertmessage:[NSString stringWithFormat:@"Error occured with error code %d",errorcode] withtitle:@"Error"];
    }
    
}
-(NSString *) getdate:(NSString *)time  // get the iso 8601 based time stamp

{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    NSDate *now = [NSDate date];
    
   
    if([time isEqualToString:@"One"])
    {
        NSDate *DaysAgo = [now dateByAddingTimeInterval:-1*24*60*60];
      NSString  *iso8601String = [dateFormatter stringFromDate:DaysAgo];
        return iso8601String;
    }
    else{
        
        NSDate *sevenDaysAgo = [now dateByAddingTimeInterval:-7*24*60*60];
        NSString  *iso8601String = [dateFormatter stringFromDate:sevenDaysAgo];
        return iso8601String;
    }



}

-(void) alertmessage:(NSString *) message withtitle:(NSString *)title  // custom method for  message alert
{
    
    UIAlertController *myAlertController = [UIAlertController alertControllerWithTitle:title
                                                                               message: message
                                                                        preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Ok"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [myAlertController dismissViewControllerAnimated:YES completion:nil];
                         }];
    
    [myAlertController addAction: ok];
    
    [self presentViewController:myAlertController animated:YES completion:nil];
}



@end