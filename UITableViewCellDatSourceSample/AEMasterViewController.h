//
//  AEMasterViewController.h
//  UITableViewCellDatSourceSample
//
//  Created by Amos Elmaliah on 9/2/11.
//  Copyright (c) 2011 UIMUI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AEDetailViewController;

#import <CoreData/CoreData.h>

@interface AEMasterViewController : UITableViewController
{
    NSArray*_items;
}
@property (strong, nonatomic) AEDetailViewController *detailViewController;
@property (strong, nonatomic) NSArray*items;
@end
