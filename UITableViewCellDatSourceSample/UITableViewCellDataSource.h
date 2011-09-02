//
//  UITableViewCellDataSource.h
//  RKCleanPlates
//
//  Created by Amos Elmaliah on 8/17/11.
//  Copyright (c) 2011 UIMUI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UITableViewCellDataSource <NSObject>
-(void)tableViewCell:(UITableViewCell*)cell didChangeItem:(id)anyItem;
@end
