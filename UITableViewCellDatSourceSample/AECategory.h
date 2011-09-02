//
//  AECategory.h
//  UITableViewCellDatSourceSample
//
//  Created by Amos Elmaliah on 9/2/11.
//  Copyright (c) 2011 UIMUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AECategory : NSManagedObject

@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * shortName;

@end
