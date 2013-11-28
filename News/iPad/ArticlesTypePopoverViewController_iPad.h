//
//  NewsTypePopoverViewController_iPad.h
//  News
//
//  Created by FirstMac on 27.11.13.
//  Copyright (c) 2013 Nestline. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ArticlesTypeDelegate <NSObject>
@required
- (void)didSelectType:(NSString*)type;
@end

@interface ArticlesTypePopoverViewController_iPad : UITableViewController
{
    NSArray* types;
}
@property (nonatomic, weak) id<ArticlesTypeDelegate> delegate;
@end