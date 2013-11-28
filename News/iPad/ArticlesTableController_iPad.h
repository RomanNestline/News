//
//  NewsTableController_iPad.h
//  News
//
//  Created by FirstMac on 27.11.13.
//  Copyright (c) 2013 Nestline. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticlesTypePopoverViewController_iPad.h"

@interface ArticlesTableController_iPad : UITableViewController<ArticlesTypeDelegate, UIPopoverControllerDelegate>
{
    NSMutableArray* articles;
    UIPopoverController* typePopover;
    NSString* filter;
}
@property (nonatomic, weak) IBOutlet UIBarButtonItem* typeButton;
@end