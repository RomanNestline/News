//
//  NewsTableController_iPad.m
//  News
//
//  Created by FirstMac on 27.11.13.
//  Copyright (c) 2013 Nestline. All rights reserved.
//

#import "ArticlesTableController_iPad.h"
#import "Article.h"
#import "ArticleViewController_iPad.h"
#import "ArticlesTypePopoverViewController_iPad.h"
#import "ArticleCell.h"

@interface ArticlesTableController_iPad ()

@end

@implementation ArticlesTableController_iPad

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    [self populateArticles];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [self selectArticleAtRow:0];
}

- (void)populateArticles
{
    articles = [NSMutableArray new];
    
    NSString* dataPath = [[NSBundle mainBundle] pathForResource:@"News" ofType:@"json"];
    NSData* data = [NSData dataWithContentsOfFile:dataPath];
    NSArray* cardioData = [NSJSONSerialization JSONObjectWithData:data
                                                          options:kNilOptions
                                                            error:nil];
    
    [cardioData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         Article* article = [Article new];
         article.title = [obj objectForKey:@"title"];
         article.text = [obj objectForKey:@"text"];
         NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
         [formatter setDateFormat:@"dd.MM.yyyy"];
         
         //Optionally for time zone converstions
         [formatter setTimeZone:[NSTimeZone localTimeZone]];
         
         article.date = [formatter dateFromString:[obj objectForKey:@"date"]];
         [articles addObject:article];
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Article* article = [articles objectAtIndex:indexPath.row];
    cell.titleLabel.text = article.title;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.yyyy"];
    
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    
    cell.dateLabel.text = [formatter stringFromDate:article.date];
    cell.introductionLabel.text = [[article.text stringByReplacingOccurrencesOfString:@"<p>" withString:@""]stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self selectArticleAtRow:indexPath.row];
}

- (void)selectArticleAtRow:(NSInteger)row
{
    Article* article = [articles objectAtIndex:row];
    UISplitViewController* splitViewController = [self splitViewController];
    UINavigationController* navigationController = (UINavigationController*)splitViewController.viewControllers[1];
    ArticleViewController_iPad* articleViewController = (ArticleViewController_iPad*)navigationController.topViewController;
    [articleViewController setArticle:article];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.typeButton.enabled = NO;
    typePopover = [(UIStoryboardPopoverSegue *)segue popoverController];
    typePopover.delegate = self;
    ArticlesTypePopoverViewController_iPad* typeController = (ArticlesTypePopoverViewController_iPad*)segue.destinationViewController;
    typeController.delegate = self;
}

- (void)didSelectType:(NSString *)type
{
    filter = type;
    [typePopover dismissPopoverAnimated:YES];
    self.typeButton.enabled = YES;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.typeButton.enabled = YES;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
