//
//  AEVenue.h
//  UITableViewCellDatSourceSample
//
//  Created by Amos Elmaliah on 9/2/11.
//  Copyright (c) 2011 UIMUI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AECategory;

@interface AEVenue : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSManagedObject *location;
@property (nonatomic, retain) NSSet *categories;
@end

@interface AEVenue (CoreDataGeneratedAccessors)

- (void)addCategoriesObject:(AECategory *)value;
- (void)removeCategoriesObject:(AECategory *)value;
- (void)addCategories:(NSSet *)values;
- (void)removeCategories:(NSSet *)values;

@end
