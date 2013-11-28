//
//  SingleNewsViewController_iPad.m
//  News
//
//  Created by FirstMac on 27.11.13.
//  Copyright (c) 2013 Nestline. All rights reserved.
//

#import "ArticleViewController_iPad.h"

@interface ArticleViewController_iPad ()
{
    NSString* templateString;
}

@end

@implementation ArticleViewController_iPad

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString* filePath = [[NSBundle mainBundle]pathForResource:@"Template" ofType:@"html"];
    templateString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setArticle:(Article *)article
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSString* htmlString = [NSString stringWithFormat:templateString, article.title, [formatter stringFromDate:article.date], article.text];
    [self.webView loadHTMLString:htmlString baseURL:nil];
}

@end
