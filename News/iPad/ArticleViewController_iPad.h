//
//  SingleNewsViewController_iPad.h
//  News
//
//  Created by FirstMac on 27.11.13.
//  Copyright (c) 2013 Nestline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface ArticleViewController_iPad : UIViewController
@property (nonatomic, weak) IBOutlet UIWebView* webView;
- (void)setArticle:(Article *)article;
@end
